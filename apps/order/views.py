from django.shortcuts import render, redirect
from django_redis import get_redis_connection
from django.views.generic import View
from django.http import JsonResponse
from django.db import transaction
from django.conf import settings
from django.urls import reverse

from alipay.aop.api.response.AlipayOfflineMaterialImageUploadResponse import AlipayOfflineMaterialImageUploadResponse
from alipay.aop.api.request.AlipayOfflineMaterialImageUploadRequest import AlipayOfflineMaterialImageUploadRequest
from alipay.aop.api.request.AlipayTradePagePayRequest import AlipayTradePagePayRequest
from alipay.aop.api.request.AlipayTradeQueryRequest import AlipayTradeQueryRequest
from alipay.aop.api.request.AlipayTradeAppPayRequest import AlipayTradeAppPayRequest
from alipay.aop.api.domain.AlipayTradePagePayModel import AlipayTradePagePayModel
from alipay.aop.api.response.AlipayTradePayResponse import AlipayTradePayResponse
from alipay.aop.api.domain.AlipayTradeAppPayModel import AlipayTradeAppPayModel
from alipay.aop.api.request.AlipayTradePayRequest import AlipayTradePayRequest
from alipay.aop.api.domain.AlipayTradePayModel import AlipayTradePayModel
from alipay.aop.api.domain.AlipayTradeQueryModel import AlipayTradeQueryModel
from alipay.aop.api.domain.SettleDetailInfo import SettleDetailInfo
from alipay.aop.api.DefaultAlipayClient import DefaultAlipayClient
from alipay.aop.api.AlipayClientConfig import AlipayClientConfig
from alipay.aop.api.domain.GoodsDetail import GoodsDetail
from alipay.aop.api.domain.SubMerchant import SubMerchant
from alipay.aop.api.domain.SettleInfo import SettleInfo
from apps.order.models import OrderInfo, OrderGoods
from alipay.aop.api.FileItem import FileItem
from utils.mixin import LoginRequiredMixin
from apps.goods.models import GoodsSKU
from apps.user.models import Address
from datetime import datetime
import traceback
import logging
import time
import os
# Create your views here.


# /order/place
class OrderPlaceView(LoginRequiredMixin, View):
    """提交订单页面显示"""
    def post(self, request):
        """提交订单页面显示"""
        # 获取登录的用户
        user = request.user

        # 获取参数sku_ids
        sku_ids = request.POST.getlist('sku_ids')

        # 校验参数
        if not sku_ids:
            # 跳转到购物车页面
            return redirect(reverse('cart:show'))

        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id

        skus = []
        # 保存商品的总件数和总价格
        total_count = 0
        total_price = 0
        # 遍历sku_ids获取用户要购买的商品的信息
        for sku_id in sku_ids:
            # 根据商品的id获取商品的信息
            sku = GoodsSKU.objects.get(id=sku_id)
            # 获取用户所要购买的数量的数量
            count = conn.hget(cart_key, sku_id).decode()
            # 计算商品的小计
            amount = sku.price * int(count)
            # 动态给sku增加属性count，保存购买商品的数量
            sku.count = count
            # 动态给sku增加属性amount，保存购买商品的小计
            sku.amount = amount
            skus.append(sku)
            # 累加计算商品的总件数和总价格
            total_count += int(count)
            total_price += amount

        # 运费：实际开发的时候，属于一个子系统
        transit_price = 10 # 写死

        # 实付款
        total_pay = total_price + transit_price

        # 获取用户的收件地址
        addrs = Address.objects.filter(user=user)

        # 要购买的商品订单id字符串 1.5.3.4
        sku_ids = '.'.join(sku_ids)

        # 组织上下文
        context = {
            'skus':skus,
            'total_count':total_count,
            'total_price':total_price,
            'transit_price':transit_price,
            'total_pay':total_pay,
            'addrs':addrs,
            'sku_ids':sku_ids
        }

        # 使用模板
        return render(request, 'place_order.html', context)


# 前端传递的参数：地址id(addr_id) 支付方式(pay_nethod) 用户要购买的商品id字符串(sku_ids)
class OrderCommitView(View):
    """订单创建"""
    @transaction.atomic
    def post(self, request):
        """订单创建"""
        user = request.user
        if not user.is_authenticated:
            # 用户未登录
            return JsonResponse({'res': 0, 'errmsg': '请先登录'})

        # 接收参数
        addr_id = request.POST.get('addr_id')
        pay_method = request.POST.get('pay_method')
        sku_ids = request.POST.get('sku_ids')

        # 校验参数
        if not all([addr_id, pay_method, sku_ids]):
            return JsonResponse({'res': 1, 'errmsg': '参数不完整'})

        # 校验支付方式
        if pay_method not in OrderInfo.PAY_METHODS.keys():
            return JsonResponse({'res': 2, 'errmsg': '非法的支付方式'})

        # 校验地址
        try:
            addr = Address.objects.get(id=addr_id)
        except Address.DoesNotExist:
            return JsonResponse({'res': 3, 'errmsg': '地址非法'})

        # todo: 创建订单核心业务

        # 组织参数
        # 订单id 当前时间+用户id
        order_id = datetime.now().strftime('%Y%m%d%H%M%S') + str(user.id)

        # 运费 写死
        transit_price = 10

        # 总数目和总金额
        total_count = 0
        total_price = 0

        # 设置事务保存点
        save_id = transaction.savepoint()

        try:
            # todo: 向 df_order_info 表添加一条记录
            order = OrderInfo.objects.create(order_id=order_id,
                                             user=user,
                                             addr=addr,
                                             pay_method=pay_method,
                                             total_count=total_count,
                                             total_price=total_price,
                                             transit_price=transit_price)

            # todo: 用户的订单中有几个商品，需要向 df_order_goods 表中加入几条记录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            sku_ids = sku_ids.split('.')  # [1, 2, 3, 4]
            for sku_id in sku_ids:
                # 循环3次 添加数据 避免失败
                for i in range(3):
                    # 获取商品信息
                    try:
                        # 悲观锁  等价于 select * from df_goods_sku where id=sku_id for update;
                        # sku = GoodsSKU.objects.select_for_update().get(id=sku_id)
                        sku = GoodsSKU.objects.get(id=sku_id)
                    except GoodsSKU.DoesNotExist:
                        # 商品不存在
                        transaction.savepoint_rollback(save_id)
                        return JsonResponse({'res': 4, 'errmsg': '商品不存在'})
                    # 从redis中获取用户所要购买的商品的数量
                    count = conn.hget(cart_key, sku_id)

                    # todo: 判断商品的库存
                    if int(count) > sku.stock:
                        transaction.savepoint_rollback(save_id)
                        return JsonResponse({'res': 6, 'errmsg': '商品库存不足'})

                    # todo: 更新商品的库存和销量
                    # sku.stock -= int(count)
                    # sku.sales += int(count)
                    # sku.save()
                    # 乐观锁
                    orgin_stock = sku.stock
                    new_stock = orgin_stock - int(count)
                    new_sales = sku.sales - int(count)

                    # print('user:%s正在第%d次购买库存量stock:%d的商品%s' % (user.username, i, sku.stock, sku.name))
                    # import time
                    # time.sleep(5)
                    # update df_goods_sku set stock=new_stock, sales=new_sales
                    # where id=sku_id and stock=orgin_stock
                    # 返回受影响的行数
                    res = GoodsSKU.objects.filter(id=sku_id, stock=orgin_stock).update(stock=new_stock, sales=new_sales)
                    if res == 0:
                        if i == 2:
                            # 尝试的第三次
                            transaction.savepoint_rollback(save_id)
                            return  JsonResponse({'res': 7, 'errmsg': '下单失败2'})
                        continue

                    # todo: 向 df_order_goods 表中加入一条记录
                    OrderGoods.objects.create(order=order,
                                              sku=sku,
                                              count=count,
                                              price=sku.price)

                    # todo: 累加计算订单薄品的总数量和总价格
                    amount = sku.price * int(count)
                    total_count += int(count)
                    total_price += amount

                    # 跳出循环
                    break

            # todo: 更新订单信息表中的商品总数量和总价格
            order.total_count = total_count
            order.total_price = total_price
            order.save()
        except Exception as e:
            transaction.savepoint_rollback(save_id)
            return JsonResponse({{'res': 7, 'errmsg': '下单失败'}})

        # 提交事务
        transaction.savepoint_commit(save_id)

        # todo: 清楚用户购物车中的记录 [1, 3]
        conn.hdel(cart_key, *sku_ids)

        # 返回应答
        return JsonResponse({'res': 5, 'errmsg': '创建成功'})


# ajax post
# 前端传递的参数:订单id(order_id)
# /order/pay
class OrderPayView(View):
    """订单支付"""
    def post(self, request):
        """订单支付"""
        # 校验用户是否登录'
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'res': 0, 'errmsg': '用户未登录'})

        # 接收参数
        order_id = request.POST.get('order_id')

        # 校验参数
        if not order_id:
            return JsonResponse({'res': 1, 'errmsg': '无效的订单id'})

        try:
            order = OrderInfo.objects.get(order_id=order_id,
                                          user=user,
                                          pay_method=3,
                                          order_status=1)
        except OrderInfo.DoesNotExist:
            return JsonResponse({'res': 2, 'errmsg': '订单错误'})

        # todo: 业务处理 使用python的SDK 调用支付宝的支付接口
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s %(levelname)s %(message)s',
            filemode='a', )
        logger = logging.getLogger('')

        """
            设置配置，包括支付宝网关地址、app_id、应用私钥、支付宝公钥等，其他配置值可以查看AlipayClientConfig的定义。
        """
        alipay_client_config = AlipayClientConfig(sandbox_debug=True)
        alipay_client_config.server_url = 'https://openapi.alipaydev.com/gateway.do'
        alipay_client_config.app_id = '2016101900724693'  # 应用id 这里是沙箱id
        alipay_client_config.charset = 'utf-8'

        with open(os.path.join(settings.BASE_DIR, 'apps/order/app_private_key.txt')) as f:
            alipay_client_config.app_private_key = f.read()

        with open(os.path.join(settings.BASE_DIR, 'apps/order/alipay_public_key.txt')) as f:
            alipay_client_config.alipay_public_key = f.read()

        alipay_client_config.sign_type = 'RSA2'  # RSA或RSA2

        """
            得到客户端对象。
            注意，一个alipay_client_config对象对应一个DefaultAlipayClient，定义DefaultAlipayClient对象后，
            alipay_client_config不得修改，如果想使用不同的配置，请定义不同的DefaultAlipayClient。
            logger参数用于打印日志，不传则不打印，建议传递。
            """
        client = DefaultAlipayClient(alipay_client_config=alipay_client_config, logger=logger)

        # 计算商品金额
        total_pay = order.total_price + order.transit_price  # Decimal类型
        # 订单内容:商品信息
        alipay_body = ''
        goods = OrderGoods.objects.filter(order=order)
        for good in goods:
            alipay_body = alipay_body + good.sku.desc + ';'

        # 对照接口文档，构造请求对象
        model = AlipayTradePayModel()
        model.out_trade_no = order_id  # 订单id
        model.total_amount = str(total_pay)  # 支付总金额
        model.subject = '天天生鲜用户:%s，您正在支付[天天生鲜网站]订单号为%s' % (user.username, order_id)  # 订单标题
        model.body = alipay_body
        model.product_code = 'FAST_INSTANT_TRADE_PAY'  # 与支付宝签约的产品码名称，目前只支持这一种
        model.timeout_express = '30m'  # 订单过期关闭时长（分钟）

        pay_request = AlipayTradePagePayRequest(biz_model=model)  # 通过模型创建请求对象
        # get请求 用户支付成功后返回的页面请求地址
        pay_request.return_url = ''
        # post请求 用户支付成功后返回的页面请求地址
        pay_request.notify_url = ''
        # 利用阿里支付对象发一个获取页面的请求 参数为order_string
        pay_url = client.page_execute(pay_request, http_method='GET')

        # 返回应答
        return JsonResponse({'res': 3, 'pay_url': pay_url})


# ajax post
# 前端传递的参数:订单id(order_id)
# /order/check
class CheckPayView(View):
    """查看订单支付结果"""
    def post(self, request):
        """查询支付结果"""
        # 校验用户是否登录'
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'res': 0, 'errmsg': '用户未登录'})

        # 接收参数
        order_id = request.POST.get('order_id')

        # 校验参数
        if not order_id:
            return JsonResponse({'res': 1, 'errmsg': '无效的订单id'})

        try:
            order = OrderInfo.objects.get(order_id=order_id,
                                          user=user,
                                          pay_method=3,
                                          order_status=1)
        except OrderInfo.DoesNotExist:
            return JsonResponse({'res': 2, 'errmsg': '订单错误'})

        # todo: 业务处理 使用python的SDK 调用支付宝的支付接口
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s %(levelname)s %(message)s',
            filemode='a', )
        logger = logging.getLogger('')

        """
            设置配置，包括支付宝网关地址、app_id、应用私钥、支付宝公钥等，其他配置值可以查看AlipayClientConfig的定义。
        """
        alipay_client_config = AlipayClientConfig(sandbox_debug=True)
        alipay_client_config.server_url = 'https://openapi.alipaydev.com/gateway.do'
        alipay_client_config.app_id = '2016101900724693'  # 应用id 这里是沙箱id
        alipay_client_config.charset = 'utf-8'

        with open(os.path.join(settings.BASE_DIR, 'apps/order/app_private_key.txt')) as f:
            alipay_client_config.app_private_key = f.read()

        with open(os.path.join(settings.BASE_DIR, 'apps/order/alipay_public_key.txt')) as f:
            alipay_client_config.alipay_public_key = f.read()

        alipay_client_config.sign_type = 'RSA2'  # RSA或RSA2

        """
            得到客户端对象。
            注意，一个alipay_client_config对象对应一个DefaultAlipayClient，定义DefaultAlipayClient对象后，
            alipay_client_config不得修改，如果想使用不同的配置，请定义不同的DefaultAlipayClient。
            logger参数用于打印日志，不传则不打印，建议传递。
            """
        client = DefaultAlipayClient(alipay_client_config=alipay_client_config, logger=logger)

        while True:
            # 对照接口文档，构造请求对象
            model = AlipayTradeQueryModel()
            model.out_trade_no = order_id

            query_request = AlipayTradeQueryRequest(biz_model=model)
            response = self.str_to_dict(client.execute(query_request))
            """
                response:
                {
                    "code":"10000",  # 接口调用是否成功
                    "msg":"Success",
                    "buyer_logon_id":"mnd***@sandbox.com",
                    "buyer_pay_amount":"0.00",
                    "buyer_user_id":"2088102180300991",
                    "buyer_user_type":"PRIVATE",
                    "invoice_amount":"0.00",
                    "out_trade_no":"2020010122413118",
                    "point_amount":"0.00",
                    "receipt_amount":"0.00",
                    "total_amount":"39.90",
                    "trade_no":"2020010422001400991000047401",  # 支付宝交易号
                    "trade_status":"WAIT_BUYER_PAY" # 支付结果
                }
            """

            code = response.get('code')
            if code == '10000' and response.get('trade_status') == 'TRADE_SUCCESS':
                # 支付成功
                # 获取支付宝交易号
                trade_no = response.get('trade_no')
                # 更新订单状态
                order.trade_no = trade_no
                order.order_status = 4 # 待评价
                order.save()
                # 返回结果
                return JsonResponse({'res': 3, 'message': '支付成功'})
            elif code == '40004' or code == '10000' and response.get('trade_status') == 'WAIT_BUYER_PAY':
                # 等待买家付款
                # 业务处理失败 可能一会会成功
                time.sleep(5)
                continue
            else:
                # 支付出错
                return JsonResponse({'res': 4, 'errmsg': '支付失败'})

    def str_to_dict(self, res):
        """将支付宝返回的str转换成dict"""
        # 去除前后的分号 以逗号隔开
        rs = res[1:-1].split(",")

        ret = dict()
        # 循环数组
        for r in rs:
            # 将一对属性拆成2个 分别为key 和 value
            new_r = r.split(":")
            # 添加到字典里
            ret[new_r[0][1:-1]] = new_r[1][1:-1]

        return ret


# /order/comment/order_id
class CommentView(LoginRequiredMixin, View):
    """订单评论"""
    def get(self, request, order_id):
        """提供评论页面"""
        user = request.user

        # 校验数据
        if not order_id:
            return redirect(reverse('user:order'))

        try:
            order = OrderInfo.objects.get(order_id=order_id, user=user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse("user:order"))

        # 根据订单的状态获取订单的状态标题
        order.status_name = OrderInfo.ORDER_STATUS[order.order_status]

        # 获取订单商品信息
        order_skus = OrderGoods.objects.filter(order_id=order_id)
        for order_sku in order_skus:
            # 计算商品的小计
            amount = order_sku.count*order_sku.price
            # 动态给order_sku增加属性amount,保存商品小计
            order_sku.amount = amount
        # 动态给order增加属性order_skus, 保存订单商品信息
        order.order_skus = order_skus

        # 使用模板
        return render(request, "order_comment.html", {"order": order})

    def post(self, request, order_id):
        """处理评论内容"""
        user = request.user
        # 校验数据
        if not order_id:
            return redirect(reverse('user:order'))

        try:
            order = OrderInfo.objects.get(order_id=order_id, user=user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse("user:order"))

        # 获取评论条数
        total_count = request.POST.get("total_count")
        total_count = int(total_count)

        # 循环获取订单中商品的评论内容
        for i in range(1, total_count + 1):
            # 获取评论的商品的id
            sku_id = request.POST.get("sku_%d" % i)  # sku_1 sku_2
            # 获取评论的商品的内容
            content = request.POST.get('content_%d' % i, '')  # cotent_1 content_2 content_3
            try:
                order_goods = OrderGoods.objects.get(order=order, sku_id=sku_id)
            except OrderGoods.DoesNotExist:
                continue

            order_goods.comment = content
            order_goods.save()

        order.order_status = 5 # 已完成
        order.save()

        return redirect(reverse("user:order", kwargs={"page": 1}))




from django.contrib.auth import authenticate, login, logout
from django_redis import get_redis_connection
from django.shortcuts import render,redirect
from django.core.paginator import Paginator
from django.core.mail import send_mail
from django.views.generic import View
from django.http import HttpResponse
from django.conf import settings
from django.urls import reverse

from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from celery_tasks.tasks import send_register_active_email
from apps.order.models import OrderInfo, OrderGoods
from apps.user.models import User, Address
from utils.mixin import LoginRequiredMixin
from itsdangerous import SignatureExpired
from apps.goods.models import GoodsSKU
from redis import StrictRedis


import re
# Create your views here.


# /user/register
def register(request):
    """注册"""
    if request.method == "GET":
        """显示注册页面"""
        return render(request, 'register.html')
    else:
        """进行注册处理"""
        # 接受数据
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        email = request.POST.get('email')
        allow = request.POST.get('allow')

        # 进行数据校验
        if not all([username, password, email]):
            # 数据不完整
            return render(request, 'register.html', {'errmsg': '数据不完整'})

        # 校验邮箱
        if not re.match(r'^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            # 邮箱格式不正确
            return render(request, 'register.html', {'errmsg': '邮箱格式不正确'})

        # 校验是否同意协议
        if allow != 'on':
            # 未同意相关协议
            return render(request, 'register.html', {'errmsg': '请同意协议'})

        # 校验用户名是否重复
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            # 说明用户名不存在
            user = None

        if user:
            # 用户名已存在
            return render(request, 'register.html', {'errmsg': '用户名已存在'})

        # 进行业务处理:进行用户注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()

        # 返回应答,跳转到首页
        return redirect(reverse('goods:index'))


# /user/register_handle
def register_handle(request):
    """进行注册处理"""
    # 接受数据
    username = request.POST.get('user_name')
    password = request.POST.get('pwd')
    email = request.POST.get('email')
    allow = request.POST.get('allow')

    # 进行数据校验
    if not all([username, password, email]):
        # 数据不完整
        return render(request, 'register.html', {'errmsg': '数据不完整'})

    # 校验邮箱
    if not re.match(r'^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
        # 邮箱格式不正确
        return render(request, 'register.html', {'errmsg': '邮箱格式不正确'})

    # 校验是否同意协议
    if allow != 'on':
        # 未同意相关协议
        return render(request, 'register.html', {'errmsg': '请同意协议'})

    # 校验用户名是否重复
    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        # 说明用户名不存在
        user = None

    if user:
        # 用户名已存在
        return render(request, 'register.html', {'errmsg': '用户名已存在'})

    # 进行业务处理:进行用户注册
    user = User.objects.create_user(username, email, password)
    user.is_active = 0
    user.save()

    # 返回应答,跳转到首页
    return redirect(reverse('goods:index'))


# /user/register
class RegisterView(View):
    """注册类"""
    def get(self, request):
        """显示注册页面"""
        return render(request, 'register.html')

    def post(self, request):
        """进行注册处理"""
        # 接受数据
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        email = request.POST.get('email')
        allow = request.POST.get('allow')

        # 进行数据校验
        if not all([username, password, email]):
            # 数据不完整
            return render(request, 'register.html', {'errmsg': '数据不完整'})

        # 校验邮箱
        if not re.match(r'^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            # 邮箱格式不正确
            return render(request, 'register.html', {'errmsg': '邮箱格式不正确'})

        # 校验是否同意协议
        if allow != 'on':
            # 未同意相关协议
            return render(request, 'register.html', {'errmsg': '请同意协议'})

        # 校验用户名是否重复
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            # 说明用户名不存在
            user = None

        if user:
            # 用户名已存在
            return render(request, 'register.html', {'errmsg': '用户名已存在'})

        # 进行业务处理:进行用户注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()

        # 发送激活邮件，包含激活链接： /user/active/1
        # 激活链接中需要包含用户的身份信息,并且要把身份信息进行加密
        # 加密用户的身份信息，生成激活token, 有效期 1个小时
        serializer = Serializer(settings.SECRET_KEY, 3600)
        info = {'confirm':user.id}
        token = serializer.dumps(info)  # bytes
        token = token.decode()

        # 发邮件
        send_register_active_email.delay(email, username, token)
        # 返回应答,跳转到首页
        return redirect(reverse('goods:index'))


class ActiveView(View):
    """用户激活"""
    def get(self, request, token):
        """进行用户激活"""
        # 进行解密 获取要激活的信息
        serializer = Serializer(settings.SECRET_KEY, 3600)
        try:
            info = serializer.loads(token)
            # 获取待激活用户的id
            user_id = info['confirm']
            # 根据id获取用户信息
            user = User.objects.get(id=user_id)
            user.is_active = 1
            user.save()

            # 激活后跳转到登录页面
            return redirect(reverse('user:login'))
        except SignatureExpired as e:
            # 说明激活链接已过期
            return HttpResponse('激活链接已过期！')


# /user/login
class LoginView(View):
    """登录"""
    def get(self, request):
        """显示登录页面"""
        # 判断是否记住了用户名
        if 'username' in request.COOKIES:
            username = request.COOKIES.get('username')
            checked = 'checked'
        else:
            username = ''
            checked = ''
        return render(request, 'login.html', {'username':username, 'checked':checked})

    def post(self, request):
        """登录校验"""
        # 接受数据
        username = request.POST.get('username')
        password = request.POST.get('pwd')

        # 校验数据
        if not all([username, password]):
            return render(request, 'login.html', {'errmsg': '数据不完整'})

        # 业务处理:登录校验
        user = authenticate(username=username, password=password)
        if user is not None:
            # 用户名或密码正确并且激活
            # 记录登录状态
            login(request, user)

            # 获取登录后所要跳转到的地址
            # 默认跳转到首页
            next_url = request.GET.get('next', reverse('goods:index'))
            # 跳转到首页
            response =  redirect(next_url)  # HttpResponseRedirect

            # 判断是否需要记住用户名
            remember = request.POST.get('remember')

            if remember == 'on':
                # 记住用户名
                response.set_cookie('username', username, max_age=7*24*3600)
            else:
                response.delete_cookie('username')

            # 返回response
            return response
        else:
            try:
                # 用户名或密码错误
                user_second = User.objects.get(username=username)
                # 用户是否激活
                if user_second.is_active:
                    return render(request, 'login.html', {'errmsg': '密码错误'})
                else:
                    return render(request, 'login.html', {'errmsg': '账户未激活'})
            except Exception:
                return render(request, 'login.html', {'errmsg': '用户名不存在'})


# /user/logout
class LogoutView(View):
    """退出登录"""
    def get(self, request):
        """退出登录"""
        # 清除用户的session信息
        logout(request)

        # 跳转到首页
        return redirect(reverse('goods:index'))


# /user
class UserInfoView(LoginRequiredMixin, View):
    """用户中心-信息页"""
    def get(self, request):
        """显示"""
        # page = 'user'
        # request.user
        # 如果用户未登录 -> AnonymousUser 类的一个实例 返回一个 false
        # 如果用户已登录 -> Userd 类的一个实例 返回一个 true
        # request.user.is_authenticated() 判断是否登录

        # 获取用户的个人信息
        user = request.user
        address = Address.objects.get_default_user(user)

        # 获取用户的历史浏览记录
        # sr = StrictRedis(host='127.0.0.1', port=6379, db=9)
        con = get_redis_connection('default')
        history_key = 'history_%d' % user.id

        # 获取用户最新浏览的5个商品id
        sku_id = con.lrange(history_key, 0, 4)

        # 从数据库中查看用户浏览的商品的具体信息
        # goods_li = GoodsSKU.objects.filter(id__in=sku_id)

        # 因为查询数据库的时候 查询的顺序是按id 所以还需要重新排序 方法一
        # goods_res = []
        # for a_id in sku_id:
        #     for goods in goods_li:
        #         if a_id == goods.id:
        #             goods_res.append(goods)

        # 遍历获取用户浏览的商品信息 方法二
        goods_li = []
        for id in sku_id:
            goods = GoodsSKU.objects.get(id=id)
            goods_li.append(goods)

        # 组织上下文
        context = {'page': 'user',
                   'address': address,
                   'goods_li': goods_li}

        # 除了你给模板文件传递的模板变量之外 django框架会把request.user也传给模板文件
        return render(request, 'user_center_info.html', context)


# /user/order
class UserOrderView(LoginRequiredMixin, View):
    """用户中心-订单页"""
    def get(self, request, page):
        """显示"""
        # page = 'order'
        # 获取用户的订单信息
        user = request.user
        orders = OrderInfo.objects.filter(user=user).order_by('-create_time')

        # 遍历获取订单商品的信息
        for order in orders:
            # 根据order_id查询订单商品信息
            order_skus = OrderGoods.objects.filter(order_id=order.order_id)

            # 遍历order_skus计算商品的小计
            for order_sku in order_skus:
                # 计算小计
                amount = order_sku.count * order_sku.price
                # 动态给order_sku添加属性 amount 保存订单商品的小计
                order_sku.amount = amount

            # 动态给order增加属性，保存订单状态标题
            order.status_name = OrderInfo.ORDER_STATUS[order.order_status]
            # 动态给order增加属性，保存订单商品的信息
            order.order_skus = order_skus

        # 分页
        paginator = Paginator(orders, 2)

        # 处理页码
        # 获取第page页的内容
        try:
            page = int(page)
        except Exception as e:
            page = 1

        if page > paginator.num_pages:
            page = 1

        # 获取第page页的Page实例对象
        orders_page = paginator.page(page)

        # todo：进行页码的控制，页面上最多显示5个页码
        num_pages = paginator.num_pages
        if num_pages < 5:
            # 1.总页数小于5页，页面上显示所有页码
            pages = range(1, num_pages + 1)
        elif page <= 3:
            # 2.如果当前页是前3页，显示1-5页
            pages = range(1, 6)
        elif num_pages - page <= 2:
            # 3.如果当前页是后3页，显示后5页 10页里 8 9 10
            pages = range(num_pages - 4, num_pages + 1)
        else:
            # 4.其他情况，显示当前页的前2页，当前页，当前页的后2页
            pages = range(page - 2, page + 3)

        # 组织上下文
        context = {
            'order_page': orders_page,
            'pages': pages,
            'page': 'order'
        }

        # 使用模板
        return render(request, 'user_center_order.html', context)


# /user/address
class UserAddressView(LoginRequiredMixin, View):
    """用户中心-地址页"""
    def get(self, request):
        """显示"""
        # page = 'address'
        # 获取登录用户的user对象
        user = request.user

        # 获取用户的默认收货地址
        # try:
        #     address = Address.objects.get(user=user, is_default=True)
        # except Address.DoesNotExist:
        #     # 不存在默认收货地址
        #     address = None
        all_address = Address.objects.filter(user=user)
        default_address = Address.objects.get_default_user(user)

        return render(request, 'user_center_site.html', {'page': 'address', 'default_address': default_address,
                                                         'all_address': all_address})

    def post(self, request):
        """地址的添加"""
        # 接受数据
        receiver = request.POST.get('receiver')
        addr = request.POST.get('addr')
        zip_code = request.POST.get('zip_code')
        phone = request.POST.get('phone')

        user = request.user
        all_address = Address.objects.filter(user=user)
        default_address = Address.objects.get_default_user(user)

        # 校验数据
        if not all([receiver, addr, phone]):
            # return redirect(reverse('user:order'))
            return render(request, 'user_center_site.html', {'errmsg': '数据不完整', 'page': 'address',
                                                             'default_address': default_address,
                                                             'all_address': all_address})

        # 校验手机号
        if not re.match(r'^1[34578]\d{9}$', phone):
            # return redirect(reverse('user:order'))
            return render(request, 'user_center_site.html', {'errmsg': '手机格式不正确', 'page': 'address',
                                                             'default_address': default_address,
                                                             'all_address': all_address})

        # 业务处理：地址添加
        # 如果用户已存在默认收货地址，添加的地址不作为默认收货地址，否则作为默认收货地址
        # 获取登录用户的user对象
        user = request.user

        # 判断有无默认收货地址
        # try:
        #     address = Address.objects.get(user=user, is_default=True)
        # except Address.DoesNotExist:
        #     # 不存在默认收货地址
        #     address = None
        address = Address.objects.get_default_user(user)

        if address:
            is_default = False
        else:
            is_default = True

        # 添加地址
        Address.objects.create(user=user,
                               receiver=receiver,
                               addr=addr,
                               zip_code=zip_code,
                               phone=phone,
                               is_default=is_default)

        # 返回应答,刷新地址页面
        return redirect(reverse('user:address'))  # get请求方式


# /user/set_default_address/1
class SetDefaultAddress(View):
    """修改默认收货地址"""
    def get(self, request, address_id):
        """修改默认地址"""
        # 获取原默认地址 设置is_default为0
        user = request.user
        add1 = Address.objects.get_default_user(user)
        add1.is_default = 0
        add1.save()

        # 获取修改的地址的对象 设置is_default为1
        add2 = Address.objects.get(id=address_id)
        add2.is_default = 1
        add2.save()

        # 返回应答 跳转回地址页
        return redirect(reverse('user:address'))

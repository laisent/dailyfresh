from celery import Celery
from django.conf import settings
from django.core.mail import send_mail
from django.template import loader, RequestContext
import django
import time
import os

# 使用celery
# 加再任务处理者一端 Django环境初始化
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dailyfresh.settings')
django.setup()

from apps.goods.models import *

# 创建一个Celery类的实例对象
app = Celery('celery_tasks.tasks', broker='redis://47.98.34.63/8')


# 定义任务函数
@app.task
def send_register_active_email(to_email, username, token):
    """发送激活邮件"""
    # 组织邮件信息
    subject = '天天生鲜欢迎信息'  # 主题
    message = ''  # 正文
    sender = settings.EMAIL_FROM  # 发件人
    receiver = [to_email]  # 收件人列表
    html_message = '<h1>%s, 欢迎您成为天天生鲜注册会员</h1>' \
                   '请点击以下链接激活您的账户<br />' \
                   '<a href="http://47.98.34.63/dailyfresh/user/active/%s">' \
                   'http://47.98.34.63/dailyfresh/user/active/%s' \
                   '</a>' % (username, token, token)  # html文本
    print(html_message)

    send_mail(subject, message, sender, receiver, html_message=html_message)


@app.task
def generate_static_index_html():
    """产生首页静态页面"""
    """显示首页"""
    # 获取商品的种类信息
    types = GoodsType.objects.all()

    # 获取首页轮播商品信息
    # 小数字在前 0 1 2 3 order by 默认升序 降序前面加 -
    goods_banners = IndexGoodsBanner.objects.all().order_by('index')

    # 获取首页促销活动信息
    promotion_banner = IndexPromotionBanner.objects.all().order_by('index')

    # 获取首页分类商品展示信息
    for type in types:  # GoodsType
        # 获取type种类首页分类商品的图片展示信息
        image_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=1).order_by('index')
        # 获取type种类首页分类商品的文字展示信息
        title_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=0).order_by('index')

        # 动态给type增加属性，分别保存首页分类商品的图片展示信息和文字展示信息
        type.image_banners = image_banners
        type.title_banners = title_banners

    # 组织模板上下文
    context = {'types': types,
               'goods_banner': goods_banners,
               'promotion_banner': promotion_banner
               }

    # 使用模板
    # 1.加载模板文件, 返回模板文件
    temp = loader.get_template('static_index.html')
    # 2.模板渲染
    static_index_index = temp.render(context)

    # 生成首页对应静态文件
    save_path = os.path.join(settings.BASE_DIR, 'static/index.html')
    with open(save_path, 'wb') as f:
        f.write(static_index_index.encode('utf-8'))

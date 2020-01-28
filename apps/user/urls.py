from django.contrib.auth.decorators import login_required
from django.urls import path, re_path
from apps.user.views import *

app_name = 'user'

urlpatterns = [
    # path('register', views.register, name='register'),  #注册
    # path('register_handle', views.register_handle, name='register_handle'),  # 注册处理
    path('register', RegisterView.as_view(), name='register'),  # 注册
    re_path('active/(?P<token>.*)$', ActiveView.as_view(), name='active'),  # 用户激活

    path('login', LoginView.as_view(), name='login'),  # 登录
    path('logout', LogoutView.as_view(), name='logout'),  # 注销登录

    # path('', login_required(UserInfoView.as_view()), name='user'),  # 用户中心-信息页
    # path('order', login_required(UserOrderView.as_view()), name='order'),  # 用户中心-订单页
    # path('address', login_required(UserAddressView.as_view()), name='address'),  # 用户中心-地址页

    path('', UserInfoView.as_view(), name='user'),  # 用户中心-信息页
    # path('order/<int:page>', UserOrderView.as_view(), name='order'),  # 用户中心-订单页
    path('order/<int:page>', UserOrderView.as_view(), name='order'),  # 用户中心-订单页
    path('address', UserAddressView.as_view(), name='address'),  # 用户中心-地址页

    path('set_default_address/<int:address_id>', SetDefaultAddress.as_view(), name='set_default_address'),  # 设置默认地址
]

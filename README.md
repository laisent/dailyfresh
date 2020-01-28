## DailyFresh

**天天生鲜**：

小型电商购物网站，基于<code>Python3.x</code>和<code>Django2.x</code>

项目尽量使用Django内部提供的API，后台管理为Django自带的管理系统django-admin。

适合Django的小型实战项目。

## 功能简介：

- 商品浏览：商品的图片，售价，种类，简介以及新品推荐等信息。
- 浏览历史：商品的浏览历史(保存近期浏览的五个商品)
- 全文检索：支持对商品种类以及商品名称，简介的检索。
- 登录注册：用户的登录与注册(邮箱激活)。
- 用户中心：支持用户个人信息，收货地址等信息的更新，商品加入购物车，订单生成，订单评论。
- 商品下单：调用支付宝沙箱支付接口完成商品的下单功能，按照原子事务处理，下单异常则终止此次下单过程，使用乐观锁机制。
- 后台管理：支持后台管理功能，商品及增加，更新与删除，主页页面的幻灯片内容以及优先级，主页促销页面的内容以及优先级，分类展示的商品类型以及内容。
- 任务机制：应用Celery架构处理异步任务(发送邮件以及主页内容数据有变时产生新静态页面)


## 在线样例：

### 在线地址

 http://47.98.34.63/dailyfresh/index 

账号： *test_user* 

密码：123456789

### 管理人员入口

 http://47.98.34.63/dailyfresh/admin

账号：admin

密码：admin


## 预览：
### 首页
![](http://47.98.34.63:8888/group1//M00/00/00/rBCZiV4u5U6AGYm8AAqtrjzwvto048.png)

### 登录
![](http://47.98.34.63:8888/group1//M00/00/00/rBCZiV4u5k2AHXgSAANyIe9htYc092.png)

### 商品详情
![](http://47.98.34.63:8888/group1//M00/00/00/rBCZiV4u5sCAfX6uAAOK3aZ0OXE978.png)

### 购物车
![](http://47.98.34.63:8888/group1//M00/00/00/rBCZiV4u56CALun-AAE325cwrDM647.png)

### 订单确认界面

![](http://47.98.34.63:8888/group1\\M00/00/00/rBCZiV4vtmOAJcDIAAFhRVM17jU795.png)

### 支付界面

![](http://47.98.34.63:8888/group1\\M00/00/00/rBCZiV4vuCiAMPuAAAGF4k_ZyUA431.png)

## 安装：

### 依赖包安装

下载文件进入项目目录之后，使用pip安装依赖包

<code>pip install -Ur requirements.txt</code>

### 数据库配置

存储数据库使用MySQL，缓存，浏览历史记录以及celery的broker使用redis

### 创建超级用户

终端下执行:

<code>python3 manage.py createsuperuser</code>

然后输入相应的超级用户名以及密码，邮箱即可。

### 开始运行

#### 测试使用:

启动服务:

<code>python3 manage.py runserver</code>

启动celery:

<code>celery -A celery_tasks.tasks worker -l info</code>

#### 部署环境 Nginx + uwsgi + Django + Supervisord

启动Nginx:

<code>sudo /usr/local/nginx/sbin/nginx</code>

启动uwsgi :

<code>uwsgi --ini uwsgi.ini</code>

启动Supervisord监听celery服务:

<code>supervisord</code>



浏览器打开:  http://47.98.34.63/dailyfresh/index  即可进入普通用户入口

浏览器打开:  http://47.98.34.63/dailyfresh/admin 即可进入超级用户入口

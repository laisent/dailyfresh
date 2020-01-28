/*
 Navicat MySQL Data Transfer

 Source Server         : windows_localhost
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : dailyfresh

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 16/01/2020 20:58:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add 用户', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change 用户', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete 用户', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view 用户', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add 地址', 7, 'add_address');
INSERT INTO `auth_permission` VALUES (26, 'Can change 地址', 7, 'change_address');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 地址', 7, 'delete_address');
INSERT INTO `auth_permission` VALUES (28, 'Can view 地址', 7, 'view_address');
INSERT INTO `auth_permission` VALUES (29, 'Can add 商品SPU', 8, 'add_goods');
INSERT INTO `auth_permission` VALUES (30, 'Can change 商品SPU', 8, 'change_goods');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 商品SPU', 8, 'delete_goods');
INSERT INTO `auth_permission` VALUES (32, 'Can view 商品SPU', 8, 'view_goods');
INSERT INTO `auth_permission` VALUES (33, 'Can add 商品', 9, 'add_goodssku');
INSERT INTO `auth_permission` VALUES (34, 'Can change 商品', 9, 'change_goodssku');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 商品', 9, 'delete_goodssku');
INSERT INTO `auth_permission` VALUES (36, 'Can view 商品', 9, 'view_goodssku');
INSERT INTO `auth_permission` VALUES (37, 'Can add 商品种类', 10, 'add_goodstype');
INSERT INTO `auth_permission` VALUES (38, 'Can change 商品种类', 10, 'change_goodstype');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 商品种类', 10, 'delete_goodstype');
INSERT INTO `auth_permission` VALUES (40, 'Can view 商品种类', 10, 'view_goodstype');
INSERT INTO `auth_permission` VALUES (41, 'Can add 主页促销活动', 11, 'add_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (42, 'Can change 主页促销活动', 11, 'change_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 主页促销活动', 11, 'delete_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (44, 'Can view 主页促销活动', 11, 'view_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (45, 'Can add 主页分类展示商品', 12, 'add_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (46, 'Can change 主页分类展示商品', 12, 'change_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 主页分类展示商品', 12, 'delete_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (48, 'Can view 主页分类展示商品', 12, 'view_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (49, 'Can add 首页轮播商品', 13, 'add_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (50, 'Can change 首页轮播商品', 13, 'change_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 首页轮播商品', 13, 'delete_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (52, 'Can view 首页轮播商品', 13, 'view_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (53, 'Can add 商品图片', 14, 'add_goodsimage');
INSERT INTO `auth_permission` VALUES (54, 'Can change 商品图片', 14, 'change_goodsimage');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 商品图片', 14, 'delete_goodsimage');
INSERT INTO `auth_permission` VALUES (56, 'Can view 商品图片', 14, 'view_goodsimage');
INSERT INTO `auth_permission` VALUES (57, 'Can add 订单商品', 15, 'add_ordergoods');
INSERT INTO `auth_permission` VALUES (58, 'Can change 订单商品', 15, 'change_ordergoods');
INSERT INTO `auth_permission` VALUES (59, 'Can delete 订单商品', 15, 'delete_ordergoods');
INSERT INTO `auth_permission` VALUES (60, 'Can view 订单商品', 15, 'view_ordergoods');
INSERT INTO `auth_permission` VALUES (61, 'Can add 订单', 16, 'add_orderinfo');
INSERT INTO `auth_permission` VALUES (62, 'Can change 订单', 16, 'change_orderinfo');
INSERT INTO `auth_permission` VALUES (63, 'Can delete 订单', 16, 'delete_orderinfo');
INSERT INTO `auth_permission` VALUES (64, 'Can view 订单', 16, 'view_orderinfo');

-- ----------------------------
-- Table structure for df_address
-- ----------------------------
DROP TABLE IF EXISTS `df_address`;
CREATE TABLE `df_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `receiver` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `addr` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `zip_code` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_address_user_id_5e6a5c8a_fk_df_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `df_address_user_id_5e6a5c8a_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_address
-- ----------------------------
INSERT INTO `df_address` VALUES (1, '2019-12-22 16:08:54.313018', '2020-01-16 14:20:37.372869', 0, 'lai', '深圳市宝安区', '518102', '18072489272', 0, 18);
INSERT INTO `df_address` VALUES (2, '2019-12-22 16:33:20.979243', '2020-01-16 14:20:37.463018', 0, 'Mr.Lai', '深圳市宝安区西乡', '518102', '18072489272', 1, 18);
INSERT INTO `df_address` VALUES (3, '2019-12-23 03:14:50.711478', '2019-12-28 08:50:41.790946', 0, 'Miss.Li', '深圳市宝安区西乡', '518102', '18072489272', 0, 18);
INSERT INTO `df_address` VALUES (4, '2019-12-23 03:36:12.373135', '2019-12-28 08:50:39.787271', 0, 'hjy', '广州市 增城区朱村街朱村大道 最香松田学院', '', '18072489272', 0, 18);
INSERT INTO `df_address` VALUES (5, '2019-12-31 08:04:37.330078', '2019-12-31 08:04:37.330078', 0, 'lalala', '广东省深圳市宝安区', '518102', '18072489272', 1, 19);
INSERT INTO `df_address` VALUES (6, '2020-01-04 11:01:01.682312', '2020-01-04 11:01:01.682312', 0, 'Mr.Lai', '广东省深圳市', '518102', '18072489272', 1, 24);
INSERT INTO `df_address` VALUES (7, '2020-01-08 14:35:01.773182', '2020-01-08 14:35:01.773746', 0, 'hjy', 'sdf ', '518102', '18072489272', 1, 25);
INSERT INTO `df_address` VALUES (8, '2020-01-12 18:04:41.435823', '2020-01-12 18:04:41.435823', 0, 'lai', '广东省深圳市', '518102', '13798227639', 1, 26);
INSERT INTO `df_address` VALUES (9, '2020-01-16 14:20:49.541219', '2020-01-16 14:20:49.541219', 0, 'lai', '宿舍', '518102', '13798227639', 0, 18);

-- ----------------------------
-- Table structure for df_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_goods`;
CREATE TABLE `df_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_goods
-- ----------------------------
INSERT INTO `df_goods` VALUES (1, '2019-12-26 01:43:44.278085', '2019-12-26 01:43:44.278085', 0, '草莓', '草莓（英文学名：strawberry、拉丁学名：Fragaria × ananassa Duch.），多年生草本植物。高10-40厘米，茎低于叶或近相等，密被开展黄色柔毛。叶三出，小叶具短柄，质地较厚，倒卵形或菱形，上面深绿色，几无毛，下面淡白绿色，疏生毛，沿脉较密；叶柄密被开展黄色柔毛。聚伞花序，花序下面具一短柄的小叶；花两性；萼片卵形，比副萼片稍长；花瓣白色，近圆形或倒卵椭圆形。聚合果大，宿存萼片直立，紧贴于果实；瘦果尖卵形，光滑。花期4-5月，果期6-7月   。\r\n原产南美，中国各地及欧洲等地广为栽培。草莓营养价值高，含有多种营养物质 ，且有保健功效。');
INSERT INTO `df_goods` VALUES (2, '2019-12-26 01:58:41.826104', '2019-12-26 01:58:41.826104', 0, '葡萄', '葡萄（学名：Vitis vinifera L.）为葡萄科葡萄属木质藤本植物，小枝圆柱形，有纵棱纹，无毛或被稀疏柔毛，叶卵圆形，圆锥花序密集或疏散，基部分枝发达，果实球形或椭圆形，花期4-5月，果期8-9月。\r\n葡萄是世界最古老的果树树种之一，葡萄的植物化石发现于第三纪地层中，说明当时已遍布于欧、亚及格陵兰。 葡萄原产亚洲西部，世界各地均有栽培， 世界各地的葡萄约95%集中分布在北半球。');
INSERT INTO `df_goods` VALUES (3, '2019-12-26 01:59:32.909847', '2019-12-26 01:59:32.909847', 0, '柠檬', '柠檬（学名：Citrus limon (L.) Burm. f.），为双子叶植物纲芸香科柑橘属植物，柠檬又称柠果、洋柠檬、益母果等。小乔木，枝少刺或近于无刺，嫩叶及花芽暗紫红色，叶片厚纸质，卵形或椭圆形。单花腋生或少花簇生。果椭圆形或卵形，果皮厚，通常粗糙，柠檬黄色，果汁酸至甚酸，种子小，卵形，端尖；种皮平滑，子叶乳白色，通常单或兼有多胚。花期4-5月，果期9-11月。');
INSERT INTO `df_goods` VALUES (4, '2019-12-26 02:00:08.377251', '2019-12-26 02:00:08.377251', 0, '奇异果', '猕猴桃（学名：Actinidia chinensis Planch），也称奇异果（奇异果是猕猴桃的一个人工选育品种，因使用广泛而成为了猕猴桃的代称）。中国是猕猴桃的原产地，20世纪早期被引入新西兰。2008年11月6日，在新西兰举行的国际猕猴桃大会上，世界19个国家200多位专家一致认定：中国是猕猴桃的原产地，世界猕猴桃原产地在湖北宜昌市夷陵区雾渡河镇。');
INSERT INTO `df_goods` VALUES (5, '2019-12-26 04:25:41.417338', '2019-12-26 04:25:41.417338', 0, '芒果', '芒果是杧果（中国植物志）的通俗名（拉丁学名：Mangifera indica L.），芒果是一种原产印度的漆树科常绿大乔木，叶革质，互生；花小，杂性，黄色或淡黄色，成顶生的圆锥花序。核果大，压扁，长5-10厘米，宽3-4.5厘米，成熟时黄色，味甜，果核坚硬。\r\n芒果为著名热带水果之一，芒果果实含有糖、蛋白质、粗纤维，芒果所含有的维生素A的前体胡萝卜素成分特别高，是所有水果中少见的。其次维生素C含量也不低。矿物质、蛋白质、脂肪、糖类等，也是其主要营养成分。可制果汁、果酱、罐头、腌渍、酸辣泡菜及芒果奶粉、蜜饯等。');
INSERT INTO `df_goods` VALUES (6, '2019-12-26 04:33:27.605045', '2019-12-26 04:33:27.605045', 0, '猪肉', '猪肉，又名豚肉，是猪科动物家猪的肉。其性味甘咸平，含有丰富的蛋白质及脂肪、碳水化合物、钙、铁、磷等营养成分。猪肉是日常生活的主要副食品，具有补虚强身，滋阴润燥、丰肌泽肤的作用。凡病后体弱、产后血虚、面黄肌瘦者，皆可用之作营养滋补之品。');
INSERT INTO `df_goods` VALUES (7, '2019-12-26 04:39:21.902246', '2019-12-26 04:39:21.902246', 0, '龙虾', '龙虾（学名：Palinuridae）是节肢动物门软甲纲十足目龙虾科下物种的通称。又名大虾、龙头虾、虾魁、海虾等。它头胸部较粗大，外壳坚硬，色彩斑斓，腹部短小，体长一般在20～40厘米之间，重0.5公斤上下，部分无螯，腹肢可后天演变成螯。最重的能达到5公斤以上，人称龙虾虎。体呈粗圆筒状，背腹稍平扁，头胸甲发达，坚厚多棘，前缘中央有一对强大的眼上棘，具封闭的鳃室。主要分布于热带海域，是名贵海产品。');
INSERT INTO `df_goods` VALUES (8, '2019-12-26 04:56:48.325319', '2019-12-26 04:56:48.325319', 0, '牛油果', '牛油果（学名：Butyrospermum parkii Kotschy）又名乳木果，落叶乔木，高10-15米，胸径达1-1.5米；树冠开展，分枝多而密，茎枝粗壮，多节瘤，常有弯曲现象；树皮厚，不规则开裂，具乳汁。叶长圆形，先端圆或钝，基部圆或钝，幼时上面被锈色柔毛，后两面均无毛，中脉在上面呈凹槽，下面浑圆且十分凸起，侧脉30对以上，相互平行，两面稍凸起，网脉细；叶柄圆形。花梗被锈色柔毛；花萼裂片披针形，外面被毛；花有香甜味，花冠裂片卵形，全缘。浆果球形，直径3-4厘米，可食，味如柿子；种子卵圆形，黄褐色，具光泽，疤痕侧生，长圆形。花期6月，果期10月。');
INSERT INTO `df_goods` VALUES (9, '2019-12-26 06:37:42.874912', '2019-12-26 06:37:42.874912', 0, '虾', '虾（Shrimp），是一种生活在水中的节肢动物，属节肢动物甲壳类，种类很多   ，包括南极红虾、青虾、河虾、草虾、对虾、明虾、龙虾等。 虾具有很高的食疗营养价值，可以有蒸、炸等做法，并可以用做于中药材。');
INSERT INTO `df_goods` VALUES (10, '2019-12-26 06:44:33.422376', '2019-12-26 06:44:33.422376', 0, '扇贝', '扇贝属于软体动物门，扇贝科，是我国重要的贝类养殖品种。 扇贝可食部分的主要营养成分为蛋白质，与鱼类、虾类相似，是一种集食、药、滋补为一体的重要水产食物。 扇贝广泛分布于世界各海域。  扇贝柱的干制品称为“干贝”，为名贵海珍品。');
INSERT INTO `df_goods` VALUES (11, '2019-12-26 06:55:08.936570', '2019-12-26 06:55:08.936570', 0, '鱼', '鱼类是以鳃呼吸、通过尾部和躯干部的摆动以及鳍的协调作用游泳和凭上下颌摄食的变温水生脊椎动物，属于脊索动物门中的脊椎动物亚门，一般人们把脊椎动物分为鱼类（53%）、鸟类（18%）、爬行类（12%）、哺乳类（9%）、两栖类（8%）五大类。根据已故加拿大学者“Nelson”1994年统计，全球现生种鱼类共有24618种，占已命名脊椎动物一半以上，且新种鱼类不断被发现，平均每年已约150种计，十多年应已增加超过1500种，目前全球已命名的鱼种约在32100种。');

-- ----------------------------
-- Table structure for df_goods_image
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_image`;
CREATE TABLE `df_goods_image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_sku`;
CREATE TABLE `df_goods_sku`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `unite` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_goods_sku_goods_id_31622280_fk_df_goods_id`(`goods_id`) USING BTREE,
  INDEX `df_goods_sku_type_id_576de3b4_fk_df_goods_type_id`(`type_id`) USING BTREE,
  CONSTRAINT `df_goods_sku_goods_id_31622280_fk_df_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `df_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_goods_sku_type_id_576de3b4_fk_df_goods_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_goods_sku
-- ----------------------------
INSERT INTO `df_goods_sku` VALUES (1, '2019-12-26 01:48:33.682854', '2020-01-10 15:55:53.542451', 0, '大兴大棚草莓', '草莓浆果柔软多汁，味美爽口，适合速冻保鲜贮藏。草莓速冻后，可以保持原有的色、香、味，既便于贮藏，又便于外销。', 16.80, '500g', 'group1\\M00/00/00/rBCZiV4YLgmAQI7GAADhpU9_Ylo1772289', 83, 49, 1, 1, 2);
INSERT INTO `df_goods_sku` VALUES (2, '2019-12-26 04:29:26.890751', '2020-01-10 16:06:37.695714', 0, '广西高乐蜜芒果', '4个装 单果250g以上', 29.60, '2kg', 'group1\\M00/00/00/rBCZiV4YMI2ANgvpAAB-YYq-_3s5776205', 98, 47, 1, 5, 2);
INSERT INTO `df_goods_sku` VALUES (3, '2019-12-26 04:35:01.165967', '2020-01-10 16:06:50.002170', 0, '生鲜土猪肉', '密云农家 五花肉', 45.00, '500g', 'group1\\M00/00/00/rBCZiV4YMJqAF6jkAAAwHTbOE-Y6214532', 150, 100, 1, 6, 4);
INSERT INTO `df_goods_sku` VALUES (4, '2019-12-26 04:40:44.407278', '2020-01-10 16:07:03.022787', 0, '加拿大波士顿龙虾', '进口海鲜水产', 139.00, '550g', 'group1\\M00/00/00/rBCZiV4YMKeAemP8AAC5J_d3L_o6774038', 50, 23, 1, 7, 3);
INSERT INTO `df_goods_sku` VALUES (5, '2019-12-26 04:55:07.984519', '2020-01-10 16:07:16.005572', 0, '加州提子', '美国Sun-Maid阳光少女美国加州无籽核提子', 39.00, '400g', 'group1\\M00/00/00/rBCZiV4YMLSAS3dHAABqMGyLCLU6454174', 46, 20, 1, 2, 2);
INSERT INTO `df_goods_sku` VALUES (6, '2019-12-26 04:59:42.297338', '2020-01-10 16:07:50.784006', 0, '亚马逊牛油果', '进口牛油果', 48.50, '300g', 'group1\\M00/00/00/rBCZiV4YMNaAdwqRAAAXO0JSZ5Y0971335', 60, 20, 1, 8, 2);
INSERT INTO `df_goods_sku` VALUES (7, '2019-12-26 05:03:25.772334', '2020-01-10 16:09:04.277072', 0, '草莓', '草莓浆果柔软多汁，味美爽口，适合速冻保鲜贮藏。草莓速冻后，可以保持原有的色、香、味，既便于贮藏，又便于外销。', 32.00, '25g', 'group1\\M00/00/00/rBCZiV4YMSCAZxYXAAAljHPuXJg1428922', 27, 22, 1, 1, 2);
INSERT INTO `df_goods_sku` VALUES (8, '2019-12-26 05:05:03.472928', '2020-01-10 16:09:11.927506', 0, '葡萄', '进口葡萄', 29.90, '1kg', 'group1\\M00/00/00/rBCZiV4YMSeAYMVJAAAjjiYTEkw5860378', 38, 24, 1, 2, 2);
INSERT INTO `df_goods_sku` VALUES (9, '2019-12-26 05:06:43.773938', '2020-01-10 16:09:18.963657', 0, '柠檬', '四川柠檬', 23.90, '100g', 'group1\\M00/00/00/rBCZiV4YMS6AR2iFAAAgnaeGwNQ2500733', 49, 22, 1, 3, 2);
INSERT INTO `df_goods_sku` VALUES (10, '2019-12-26 05:08:33.544525', '2020-01-10 16:09:29.681174', 0, '奇异果', '新西兰阳光金奇异果 6个装', 39.90, '80g', 'group1\\M00/00/00/rBCZiV4YMTmARDESAAAeuLYy0pU7169062', 147, 127, 1, 4, 2);
INSERT INTO `df_goods_sku` VALUES (11, '2019-12-26 06:39:55.107525', '2020-01-10 15:56:58.539145', 0, '河虾', '野生小河虾干货小干虾淡水虾干无盐河虾干虾米小虾干补钙即食干虾', 29.60, '0.25kg', 'group1\\M00/00/00/rBCZiV4YLkqAULQqAAGM_N3Yy248182639', 1596, 1002, 1, 9, 3);
INSERT INTO `df_goods_sku` VALUES (12, '2019-12-26 06:46:43.557987', '2020-01-10 16:10:09.871769', 0, '扇贝干', '新货瑶柱干贝干货 海鲜扇贝肉干货大扇贝柱野生元贝海产品贝柱', 44.50, '500g', 'group1\\M00/00/00/rBCZiV4YMWGAfS6_AABuYSFxGZM4930068', 600, 340, 1, 10, 3);
INSERT INTO `df_goods_sku` VALUES (13, '2019-12-26 06:50:20.790262', '2020-01-10 16:11:52.218819', 0, '青岛野生海捕大青虾', '青岛大虾鲜活海鲜冷冻虾海鲜水产基围虾新鲜青虾野生海捕大对虾', 158.00, '1550g', 'group1\\M00/00/00/rBCZiV4YMciAL4cfAAA5OS4Kl4c7036292', 485, 405, 1, 9, 3);
INSERT INTO `df_goods_sku` VALUES (14, '2019-12-26 06:53:45.880852', '2020-01-10 16:10:38.867726', 0, '扇贝', '扇贝鲜活青岛新鲜现捕大红扇贝3斤包邮贝类海鲜水产蒜蓉粉丝扇贝', 59.50, '1500g', 'group1\\M00/00/00/rBCZiV4YMX6AYCFnAAAk8WCqqmI2678574', 1994, 898, 1, 10, 3);
INSERT INTO `df_goods_sku` VALUES (15, '2019-12-26 06:56:39.062449', '2020-01-10 16:10:48.361865', 0, '冷冻秋刀鱼', '新鲜深海秋刀鱼12条装 鲜活冷冻深海鱼海鲜日式烧烤食材水产包邮', 46.00, '1180', 'group1\\M00/00/00/rBCZiV4YMYiAWdkqAAAkaP_7_182495502', 900, 605, 1, 11, 3);
INSERT INTO `df_goods_sku` VALUES (16, '2019-12-26 06:58:59.370326', '2020-01-10 16:13:09.909744', 0, '基围虾', '大虾鲜活海鲜水产新鲜青岛超大冷冻基围虾海虾鲜虾速冻特大对虾青', 79.00, '1600g', 'group1\\M00/00/00/rBCZiV4YMhWAIBTVAAAk0DN4-yE3270027', 0, 460, 1, 9, 3);

-- ----------------------------
-- Table structure for df_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_type`;
CREATE TABLE `df_goods_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `logo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_goods_type
-- ----------------------------
INSERT INTO `df_goods_type` VALUES (2, '2019-12-25 16:04:56.933791', '2020-01-10 16:21:29.157641', 0, '新鲜水果', 'fruit', 'group1\\M00/00/00/rBCZiV4YNAmAZctLAAAmv27pX4k7441090');
INSERT INTO `df_goods_type` VALUES (3, '2019-12-25 16:06:57.473891', '2020-01-10 16:21:38.408649', 0, '海鲜水产', 'seafood', 'group1\\M00/00/00/rBCZiV4YNBKAMQdBAABHr3RQqFs0625038');
INSERT INTO `df_goods_type` VALUES (4, '2019-12-25 16:07:49.108470', '2020-01-10 16:22:06.218048', 0, '猪牛羊肉', 'meet', 'group1\\M00/00/00/rBCZiV4YNC6AB_4sAAAy1Tlm9So0207595');
INSERT INTO `df_goods_type` VALUES (5, '2019-12-25 16:08:22.210873', '2020-01-10 16:24:01.129633', 0, '禽类蛋品', 'egg', 'group1\\M00/00/00/rBCZiV4YNKGAIyXsAAAqR4DoSUg1846046');
INSERT INTO `df_goods_type` VALUES (6, '2019-12-25 16:08:50.066685', '2020-01-10 16:24:07.177040', 0, '新鲜蔬菜', 'vegetables', 'group1\\M00/00/00/rBCZiV4YNKeAAOTvAAA-0ZoYkpM8701204');
INSERT INTO `df_goods_type` VALUES (7, '2019-12-25 16:09:21.129353', '2020-01-10 16:24:14.914866', 0, '速冻食品', 'ice', 'group1\\M00/00/00/rBCZiV4YNK6ACFqHAAA3sZPrVzQ9019768');

-- ----------------------------
-- Table structure for df_index_banner
-- ----------------------------
DROP TABLE IF EXISTS `df_index_banner`;
CREATE TABLE `df_index_banner`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_index_banner
-- ----------------------------
INSERT INTO `df_index_banner` VALUES (1, '2019-12-26 01:50:41.171415', '2020-01-10 16:16:51.472332', 0, 'group1\\M00/00/00/rBCZiV4YMvOADZ8UAACpB-LsCdE5324974', 0, 1);
INSERT INTO `df_index_banner` VALUES (3, '2019-12-26 04:29:51.169085', '2020-01-10 16:16:59.423495', 0, 'group1\\M00/00/00/rBCZiV4YMvuAFesYAAC3B-z8J2c8841571', 1, 2);
INSERT INTO `df_index_banner` VALUES (4, '2019-12-26 04:35:25.890586', '2020-01-10 16:17:06.686735', 0, 'group1\\M00/00/00/rBCZiV4YMwKAVL7wAAETwXb_pso8745858', 2, 3);
INSERT INTO `df_index_banner` VALUES (5, '2019-12-26 04:42:19.484327', '2020-01-10 16:17:16.264639', 0, 'group1\\M00/00/00/rBCZiV4YMwyAEraxAAD0akkXmFo3635123', 3, 4);

-- ----------------------------
-- Table structure for df_index_promotion
-- ----------------------------
DROP TABLE IF EXISTS `df_index_promotion`;
CREATE TABLE `df_index_promotion`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `index` smallint(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_index_promotion
-- ----------------------------
INSERT INTO `df_index_promotion` VALUES (1, '2019-12-26 04:44:24.749383', '2020-01-12 18:07:40.752857', 0, '吃货暑假趴', '#', 'group1\\M00/00/00/rBCZiV4YM1GASH7dAAA2pLUeB600345592', 2);
INSERT INTO `df_index_promotion` VALUES (2, '2019-12-26 04:45:57.209242', '2020-01-10 16:20:14.793643', 0, '盛夏尝鲜季', '#', 'group1\\M00/00/00/rBCZiV4YM76ACYn0AAA98yvCs1I9262885', 1);

-- ----------------------------
-- Table structure for df_index_type_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_index_type_goods`;
CREATE TABLE `df_index_type_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `display_type` smallint(6) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  INDEX `df_index_type_goods_type_id_35192ffd_fk_df_goods_type_id`(`type_id`) USING BTREE,
  CONSTRAINT `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_index_type_goods_type_id_35192ffd_fk_df_goods_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_index_type_goods
-- ----------------------------
INSERT INTO `df_index_type_goods` VALUES (1, '2019-12-26 04:49:24.643921', '2019-12-26 04:49:24.643921', 0, 0, 0, 2, 2);
INSERT INTO `df_index_type_goods` VALUES (2, '2019-12-26 04:55:26.889964', '2019-12-26 05:01:03.566161', 0, 0, 1, 5, 2);
INSERT INTO `df_index_type_goods` VALUES (3, '2019-12-26 05:00:10.894972', '2019-12-26 05:00:10.894972', 0, 0, 2, 6, 2);
INSERT INTO `df_index_type_goods` VALUES (4, '2019-12-26 05:03:38.930773', '2019-12-26 05:03:38.930773', 0, 1, 0, 7, 2);
INSERT INTO `df_index_type_goods` VALUES (5, '2019-12-26 05:05:15.229530', '2019-12-26 05:05:15.229530', 0, 1, 1, 8, 2);
INSERT INTO `df_index_type_goods` VALUES (6, '2019-12-26 05:06:54.034070', '2019-12-26 05:06:54.034070', 0, 1, 2, 9, 2);
INSERT INTO `df_index_type_goods` VALUES (7, '2019-12-26 05:08:47.782620', '2019-12-26 05:08:47.782620', 0, 1, 3, 10, 2);
INSERT INTO `df_index_type_goods` VALUES (8, '2019-12-26 06:40:14.378920', '2019-12-26 06:40:19.944303', 0, 0, 0, 11, 3);
INSERT INTO `df_index_type_goods` VALUES (9, '2019-12-26 06:47:43.051715', '2019-12-26 06:47:43.052216', 0, 0, 1, 12, 3);
INSERT INTO `df_index_type_goods` VALUES (10, '2019-12-26 06:50:35.180400', '2019-12-26 06:50:35.180400', 0, 1, 0, 13, 3);
INSERT INTO `df_index_type_goods` VALUES (11, '2019-12-26 06:53:58.674088', '2019-12-26 06:53:58.674088', 0, 1, 1, 14, 3);
INSERT INTO `df_index_type_goods` VALUES (12, '2019-12-26 06:56:54.299369', '2019-12-26 06:56:54.299369', 0, 1, 2, 15, 3);
INSERT INTO `df_index_type_goods` VALUES (13, '2019-12-26 06:59:12.326338', '2019-12-26 06:59:12.326867', 0, 1, 3, 16, 3);
INSERT INTO `df_index_type_goods` VALUES (14, '2019-12-26 07:00:46.932212', '2019-12-26 07:00:46.932212', 0, 0, 0, 15, 4);
INSERT INTO `df_index_type_goods` VALUES (15, '2019-12-26 07:01:14.258051', '2019-12-26 07:01:14.258051', 0, 1, 0, 11, 4);
INSERT INTO `df_index_type_goods` VALUES (16, '2019-12-26 07:01:28.185975', '2019-12-26 07:01:28.186490', 0, 1, 1, 11, 4);
INSERT INTO `df_index_type_goods` VALUES (17, '2019-12-26 07:02:55.408831', '2019-12-26 07:02:55.408831', 0, 1, 2, 11, 4);
INSERT INTO `df_index_type_goods` VALUES (19, '2019-12-26 07:04:26.738794', '2019-12-26 07:04:26.738794', 0, 1, 3, 11, 4);
INSERT INTO `df_index_type_goods` VALUES (20, '2019-12-26 07:05:13.426651', '2019-12-26 07:05:13.426651', 0, 0, 0, 15, 5);
INSERT INTO `df_index_type_goods` VALUES (21, '2019-12-26 07:06:02.257362', '2019-12-26 07:06:02.257362', 0, 1, 0, 11, 5);
INSERT INTO `df_index_type_goods` VALUES (22, '2019-12-26 07:06:13.755175', '2019-12-26 07:06:13.755175', 0, 1, 1, 11, 5);
INSERT INTO `df_index_type_goods` VALUES (23, '2019-12-26 07:06:25.585282', '2019-12-26 07:06:25.585282', 0, 1, 2, 11, 5);
INSERT INTO `df_index_type_goods` VALUES (24, '2019-12-26 07:06:34.909052', '2019-12-26 07:06:34.909052', 0, 1, 3, 11, 5);
INSERT INTO `df_index_type_goods` VALUES (25, '2019-12-26 07:08:09.641612', '2019-12-26 07:53:12.383097', 0, 0, 0, 15, 6);
INSERT INTO `df_index_type_goods` VALUES (26, '2019-12-26 07:53:27.135694', '2019-12-26 07:53:27.135694', 0, 1, 0, 11, 6);
INSERT INTO `df_index_type_goods` VALUES (27, '2019-12-26 07:53:38.489447', '2019-12-26 07:53:38.489447', 0, 1, 1, 11, 6);
INSERT INTO `df_index_type_goods` VALUES (28, '2019-12-26 07:53:48.860636', '2019-12-26 07:53:48.860636', 0, 1, 2, 11, 6);
INSERT INTO `df_index_type_goods` VALUES (29, '2019-12-26 07:54:02.570684', '2019-12-26 07:54:02.570684', 0, 1, 3, 11, 6);
INSERT INTO `df_index_type_goods` VALUES (30, '2019-12-26 07:55:28.924292', '2019-12-26 07:55:28.924292', 0, 0, 0, 15, 7);
INSERT INTO `df_index_type_goods` VALUES (31, '2019-12-26 07:56:07.038276', '2019-12-26 07:56:07.038276', 0, 1, 0, 11, 7);
INSERT INTO `df_index_type_goods` VALUES (32, '2019-12-26 07:56:20.072631', '2019-12-26 07:56:20.072631', 0, 1, 1, 11, 7);
INSERT INTO `df_index_type_goods` VALUES (33, '2019-12-26 07:56:29.653341', '2019-12-26 07:56:29.653341', 0, 1, 2, 11, 7);
INSERT INTO `df_index_type_goods` VALUES (34, '2019-12-26 07:56:49.888145', '2019-12-26 07:56:49.888145', 0, 1, 3, 11, 7);

-- ----------------------------
-- Table structure for df_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_order_goods`;
CREATE TABLE `df_order_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `comment` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id`(`order_id`) USING BTREE,
  INDEX `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `df_order_info` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_order_goods
-- ----------------------------
INSERT INTO `df_order_goods` VALUES (18, '2020-01-07 00:45:07.426022', '2020-01-07 00:45:07.426022', 0, 1, 59.50, '', '2020010700450718', 14);
INSERT INTO `df_order_goods` VALUES (19, '2020-01-07 00:57:23.426249', '2020-01-08 00:19:52.304153', 0, 1, 32.00, '质量非常好,与卖家描述的完全一致, 真的很喜欢,完全超出期望值,发货速 度非常快,包装非常仔细、严实,物流公司服务态度很好,运送速度很快,很满意的一次购物质量很好, 希望更多的朋友信赖. 店主态度特好, 我会再次光顾的好卖家 赞，发货迅速，态度很好，很满意！很好很好！网上购物这么激烈，没想到店家的服务这么好，商品质量好而价低廉， 很热情的卖家，下次还来希望下次还有机会合作祝你生意兴隆质量非常好，出乎我的意料包装非常仔细。', '2020010700572318', 7);
INSERT INTO `df_order_goods` VALUES (20, '2020-01-07 23:42:19.440683', '2020-01-08 00:25:05.012882', 0, 3, 59.50, '扇贝很新鲜', '2020010723421818', 14);
INSERT INTO `df_order_goods` VALUES (21, '2020-01-07 23:42:19.476414', '2020-01-08 00:25:05.085124', 0, 3, 158.00, '真的是青岛野生海捕大青虾诶!', '2020010723421818', 13);
INSERT INTO `df_order_goods` VALUES (22, '2020-01-08 14:35:16.921860', '2020-01-08 14:36:07.000627', 0, 9, 16.80, 'cvbfvc b', '2020010814351625', 1);
INSERT INTO `df_order_goods` VALUES (23, '2020-01-08 14:35:16.926896', '2020-01-08 14:36:07.120877', 0, 4, 158.00, 'fgfd gdfsg df', '2020010814351625', 13);
INSERT INTO `df_order_goods` VALUES (24, '2020-01-12 18:04:54.999742', '2020-01-12 18:05:58.117273', 0, 8, 16.80, '到此一游\r\n', '2020011218045426', 1);
INSERT INTO `df_order_goods` VALUES (25, '2020-01-16 14:21:09.753778', '2020-01-16 14:21:09.753778', 0, 1, 23.90, '', '2020011614210918', 9);
INSERT INTO `df_order_goods` VALUES (26, '2020-01-16 14:22:27.381308', '2020-01-16 14:22:27.381308', 0, 1, 39.90, '', '2020011614222718', 10);

-- ----------------------------
-- Table structure for df_order_info
-- ----------------------------
DROP TABLE IF EXISTS `df_order_info`;
CREATE TABLE `df_order_info`  (
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `order_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pay_method` smallint(6) NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_price` decimal(10, 2) NOT NULL,
  `transit_price` decimal(10, 2) NOT NULL,
  `order_status` smallint(6) NOT NULL,
  `trade_no` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `addr_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `df_order_info_addr_id_70c3726e_fk_df_address_id`(`addr_id`) USING BTREE,
  INDEX `df_order_info_user_id_ac1e5bf5_fk_df_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `df_order_info_addr_id_70c3726e_fk_df_address_id` FOREIGN KEY (`addr_id`) REFERENCES `df_address` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_order_info_user_id_ac1e5bf5_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_order_info
-- ----------------------------
INSERT INTO `df_order_info` VALUES ('2020-01-07 00:45:07.421805', '2020-01-07 00:45:35.495537', 0, '2020010700450718', 3, 1, 59.50, 10.00, 4, '2020010722001400991000051160', 1, 18);
INSERT INTO `df_order_info` VALUES ('2020-01-07 00:57:23.323905', '2020-01-08 00:19:52.376621', 0, '2020010700572318', 3, 1, 32.00, 10.00, 5, '2020010722001400991000048780', 4, 18);
INSERT INTO `df_order_info` VALUES ('2020-01-07 23:42:18.962430', '2020-01-08 00:25:05.116353', 0, '2020010723421818', 3, 6, 652.50, 10.00, 5, '2020010722001400991000048781', 1, 18);
INSERT INTO `df_order_info` VALUES ('2020-01-08 14:35:16.914842', '2020-01-08 14:36:07.166578', 0, '2020010814351625', 3, 13, 783.20, 10.00, 5, '2020010822001400991000052361', 7, 25);
INSERT INTO `df_order_info` VALUES ('2020-01-12 18:04:54.980084', '2020-01-12 18:05:58.165375', 0, '2020011218045426', 3, 8, 134.40, 10.00, 5, '2020011222001400991000053536', 8, 26);
INSERT INTO `df_order_info` VALUES ('2020-01-16 14:21:09.628641', '2020-01-16 14:25:24.826566', 0, '2020011614210918', 3, 1, 23.90, 10.00, 4, '2020011622001400991000056753', 2, 18);
INSERT INTO `df_order_info` VALUES ('2020-01-16 14:22:27.376294', '2020-01-16 14:24:49.428093', 0, '2020011614222718', 3, 1, 39.90, 10.00, 4, '2020011622001400991000055322', 2, 18);

-- ----------------------------
-- Table structure for df_user
-- ----------------------------
DROP TABLE IF EXISTS `df_user`;
CREATE TABLE `df_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_user
-- ----------------------------
INSERT INTO `df_user` VALUES (1, 'pbkdf2_sha256$150000$7P9n7NLxbryW$gAV69rx5qsYbi9olzU1obGqzZFSTMJ+WriD4nF9fZUM=', '2019-12-25 16:41:29.893279', 0, 'laisent', '', '', 'laisentwy@163.com', 0, 1, '2019-12-21 06:51:32.439523', '2019-12-21 06:51:32.732326', '2019-12-21 06:51:32.732326', 0);
INSERT INTO `df_user` VALUES (2, 'pbkdf2_sha256$150000$spDSEqKs4eAS$d+Dly/M2WiGKTjngUF7QrkKMvXYcziHxzXsV3G2oMYU=', NULL, 0, 'laisent1', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 07:00:40.631408', '2019-12-21 07:00:40.781839', '2019-12-21 07:00:40.885734', 0);
INSERT INTO `df_user` VALUES (3, 'pbkdf2_sha256$150000$Oy5IT5WYtVMH$tF+8y7SNhUU6677IvfrvdRZhbsh1ld8GXi89eTtHDqc=', NULL, 0, 'laisent2', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 07:11:29.129227', '2019-12-21 07:11:29.264593', '2019-12-21 07:11:29.327351', 0);
INSERT INTO `df_user` VALUES (4, 'pbkdf2_sha256$150000$kS7ksNBvDHg9$i5XcFXBiAKMoXeY7IZ6zAw5+C65YPASX8PjI4bRmSSw=', NULL, 0, 'laisent3', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 07:38:07.389673', '2019-12-21 07:38:07.526538', '2019-12-21 07:38:07.589706', 0);
INSERT INTO `df_user` VALUES (5, 'pbkdf2_sha256$150000$wbkOWUBi0FRs$cc1YZL8Qr4ElFCOTodZ0nq+12pqE2KfBolpZo2uQctg=', NULL, 0, 'laisent4', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 09:31:37.806184', '2019-12-21 09:31:37.936097', '2019-12-21 09:31:38.000239', 0);
INSERT INTO `df_user` VALUES (6, 'pbkdf2_sha256$150000$eFFuagG8R9gm$LzJxuuxVMPc4tFvIJIkm8plU4nLqs+SPMYRSmlsvG+k=', NULL, 0, 'laisent5', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 09:33:43.166495', '2019-12-21 09:33:43.294872', '2019-12-21 09:33:43.352024', 0);
INSERT INTO `df_user` VALUES (7, 'pbkdf2_sha256$150000$o5af2LDnpyVm$T7iZQKw/lywYkJDkEUqMXbnv+3+wIK9a7k2W3Obuv+U=', NULL, 0, 'laisent6', '', '', 'laisentwy@163.com', 0, 1, '2019-12-21 09:35:17.305026', '2019-12-21 09:35:17.432365', '2019-12-21 09:36:38.693824', 0);
INSERT INTO `df_user` VALUES (8, 'pbkdf2_sha256$150000$K6zEzMu86dWI$pfhh4liKquA0iKC12g30T7ZxjuuMDa3xZpywCqJLFtk=', NULL, 0, 'laisent7', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 13:27:03.092409', '2019-12-21 13:27:03.224964', '2019-12-21 13:27:03.336263', 0);
INSERT INTO `df_user` VALUES (9, 'pbkdf2_sha256$150000$AY9QcwTWuOVK$urfKpDc/ZKExc7I+IgFjwTFSPiN/BA1c8RJ6jW8genE=', NULL, 0, 'laisent8', '', '', 'laisentwy@163.com', 0, 1, '2019-12-21 13:39:30.158658', '2019-12-21 13:39:30.290984', '2019-12-21 13:40:21.888164', 0);
INSERT INTO `df_user` VALUES (10, 'pbkdf2_sha256$150000$tUp6YBeNR9yk$rr+5vf+EmNkDUxh6YEPjmzEE+ocSQRtyzJ19qF40m04=', NULL, 0, 'laisent9', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 13:40:52.907089', '2019-12-21 13:40:53.039469', '2019-12-21 13:40:53.079498', 0);
INSERT INTO `df_user` VALUES (11, 'pbkdf2_sha256$150000$johJnwA1YnyP$qk1dubQVi3E72FbRjHUK4GObULOmWwHAQZTxw3bXiAY=', NULL, 0, 'laisent10', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 14:24:00.148114', '2019-12-21 14:24:00.283534', '2019-12-21 14:24:00.349748', 0);
INSERT INTO `df_user` VALUES (12, 'pbkdf2_sha256$150000$sFzahu0AvvPd$M5IDTnuv3Bpl6YS48wRX3D0XS49+2Mtgt+vkOASPu1o=', NULL, 0, 'laisent11', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 14:36:52.888413', '2019-12-21 14:36:53.022798', '2019-12-21 14:36:53.072550', 0);
INSERT INTO `df_user` VALUES (13, 'pbkdf2_sha256$150000$1UbGp0nmAeAU$UDzS8UuSLZMjhWxGlezWtTYsCd8IWRBUF5wJ9StlDA4=', '2019-12-21 17:03:08.582425', 0, 'laisent12', '', '', 'laisentwy@163.com', 0, 1, '2019-12-21 14:39:12.155135', '2019-12-21 14:39:12.287032', '2019-12-21 14:39:30.226647', 0);
INSERT INTO `df_user` VALUES (14, 'pbkdf2_sha256$150000$C4LLReQzN1Bc$dEGA01k4/6GHFc87cG4GmNdTWGcq538UGo0wKeCFr7k=', NULL, 0, 'laisent13', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 16:45:21.875481', '2019-12-21 16:45:22.086098', '2019-12-21 16:45:22.198730', 0);
INSERT INTO `df_user` VALUES (15, 'pbkdf2_sha256$150000$5uiyGXg2uyew$JBk1HZsQiCKjz4trvicKjPs3wMkeviumYE32ID+HsG8=', NULL, 0, 'laisent14', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 16:50:45.198119', '2019-12-21 16:50:45.400279', '2019-12-21 16:50:45.516942', 0);
INSERT INTO `df_user` VALUES (16, 'pbkdf2_sha256$150000$oE6bOjYObsm6$peDqEX0bFZbk8KWQ5ZE4cR70kVN8SlSuLh9EtwwYf7Y=', NULL, 0, 'laisent15', '', '', 'laisentwy@163.com', 0, 0, '2019-12-21 16:56:46.133985', '2019-12-21 16:56:46.325454', '2019-12-21 16:56:46.383608', 0);
INSERT INTO `df_user` VALUES (17, 'pbkdf2_sha256$150000$UeOC15iZjasz$a1T6QdsNcA+wJ4lPqqasTI9J5G3M7ndHu7o3EroPwvo=', '2019-12-22 14:56:33.152731', 0, 'laisent16', '', '', 'laisentwy@163.com', 0, 1, '2019-12-22 14:53:41.252760', '2019-12-22 14:53:41.381118', '2019-12-22 14:56:21.631571', 0);
INSERT INTO `df_user` VALUES (18, 'pbkdf2_sha256$150000$NDKPUr0Pqi8p$1LBbuqbrtZEwIAtJdPngKYroe78W1eZfMERdZDJCeXo=', '2020-01-16 14:11:41.799791', 0, 'laisent66', '', '', 'laisentwy@163.com', 0, 1, '2019-12-22 14:56:58.860352', '2019-12-22 14:56:58.993732', '2019-12-22 14:58:12.203557', 0);
INSERT INTO `df_user` VALUES (19, 'pbkdf2_sha256$150000$4AYCONJpShcA$xzQ0D7p8IjDcmiMVP65Pjh5MA2xGXvoIgEjFT1fbJbU=', '2020-01-10 15:08:41.836933', 1, 'admin', '', '', 'admin@163.com', 1, 1, '2019-12-25 08:48:01.152025', '2019-12-25 08:48:01.307196', '2019-12-25 08:48:01.307196', 0);
INSERT INTO `df_user` VALUES (20, 'pbkdf2_sha256$150000$htSfAncX5LA3$eSKl33X6wTvPcbVQBthiCjZiaX4P6SgvAjutk/c83EU=', NULL, 0, 'test66', '', '', 'laisentwy@163.com', 0, 0, '2019-12-26 16:25:39.750953', '2019-12-26 16:25:40.014644', '2019-12-26 16:25:40.265055', 0);
INSERT INTO `df_user` VALUES (21, 'pbkdf2_sha256$150000$pli9Ks40nygh$JMubKNe7mFl6NGzKC/eLfudLelXuUODisuMIABr8JGs=', NULL, 0, 'test5', '', '', 'laisentwy@163.com', 0, 0, '2019-12-27 03:38:07.802469', '2019-12-27 03:38:08.110133', '2019-12-27 03:38:08.271184', 0);
INSERT INTO `df_user` VALUES (22, 'pbkdf2_sha256$150000$7hOTBofg044D$Uc9249orepebtYarqZMwKsBMvIVFOB+SVotk5/4t6oI=', NULL, 0, 'test8', '', '', 'laisentwy@163.com', 0, 0, '2019-12-27 03:41:06.067125', '2019-12-27 03:41:06.256806', '2019-12-27 03:41:06.334980', 0);
INSERT INTO `df_user` VALUES (23, 'pbkdf2_sha256$150000$4yo20GOxhe9O$LRPInhhVRikQyV95NqbroBrydIgWbqZrq47xSA0+EuQ=', NULL, 0, 'test6', '', '', 'laisentwy@163.com', 0, 0, '2019-12-27 03:42:53.895701', '2019-12-27 03:42:54.090327', '2019-12-27 03:42:54.138377', 0);
INSERT INTO `df_user` VALUES (24, 'pbkdf2_sha256$150000$bgg2Et3iZEEu$yISmxGPoQf1OESxDe8YbR7vngfqfkrCmVQ8WicvxV6o=', '2020-01-04 11:00:06.491859', 0, 'laisentao', '', '', 'laisentwy@163.com', 0, 1, '2020-01-04 10:57:34.098764', '2020-01-04 10:57:34.351650', '2020-01-04 10:59:54.600009', 0);
INSERT INTO `df_user` VALUES (25, 'pbkdf2_sha256$150000$YKo9pSsjainq$lrteGS3Ngty9ewcCUHhUN1pQws1medfgMD4pVw9RKOY=', '2020-01-08 14:32:39.049836', 0, 'www.nb.com', '', '', 'laisentwy@163.com', 0, 1, '2020-01-08 14:30:43.806555', '2020-01-08 14:30:43.979515', '2020-01-08 14:32:18.525397', 0);
INSERT INTO `df_user` VALUES (26, 'pbkdf2_sha256$150000$amDEHLcitEoO$Ksxqw4VnjCqFwTaB6F1N7VEBndoojHM+8fySA+j0+oI=', '2020-01-12 18:03:32.574525', 0, 'chenguoan', '', '', 'laisentwy@163.com', 0, 1, '2020-01-12 18:01:29.532865', '2020-01-12 18:01:29.807048', '2020-01-12 18:03:23.286185', 0);

-- ----------------------------
-- Table structure for df_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `df_user_groups`;
CREATE TABLE `df_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `df_user_groups_user_id_group_id_80e5ab91_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `df_user_groups_group_id_36f24e94_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `df_user_groups_group_id_36f24e94_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_user_groups_user_id_a816b098_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `df_user_user_permissions`;
CREATE TABLE `df_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `df_user_user_permissions_user_id_permission_id_b22997de_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_user_user_permissions_user_id_b5f6551b_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_df_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 127 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2019-12-25 10:28:41.259675', '1', '猪牛羊肉', 1, '[{\"added\": {}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (2, '2019-12-25 16:04:57.260956', '2', '新鲜水果', 1, '[{\"added\": {}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (3, '2019-12-25 16:05:20.575292', '1', '猪牛羊肉', 3, '', 10, 19);
INSERT INTO `django_admin_log` VALUES (4, '2019-12-25 16:06:57.965238', '3', '海鲜水产', 1, '[{\"added\": {}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (5, '2019-12-25 16:07:49.411505', '4', '猪牛羊肉', 1, '[{\"added\": {}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (6, '2019-12-25 16:08:22.572351', '5', '禽类蛋品', 1, '[{\"added\": {}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (7, '2019-12-25 16:08:50.497609', '6', '新鲜蔬菜', 1, '[{\"added\": {}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (8, '2019-12-25 16:09:21.475097', '7', '速冻食品', 1, '[{\"added\": {}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (9, '2019-12-26 01:43:44.278893', '1', 'Goods object (1)', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (10, '2019-12-26 01:48:34.411758', '1', '大兴大棚草莓', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (11, '2019-12-26 01:50:41.681907', '1', 'IndexGoodsBanner object (1)', 1, '[{\"added\": {}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (12, '2019-12-26 01:57:03.344076', '2', '大兴大棚草莓', 1, '[{\"added\": {}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (13, '2019-12-26 01:58:41.826668', '2', '葡萄', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (14, '2019-12-26 01:59:32.910983', '3', '柠檬', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (15, '2019-12-26 02:00:08.378843', '4', '奇异果', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (16, '2019-12-26 04:25:41.436378', '5', '芒果', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (17, '2019-12-26 04:29:27.194073', '2', '广西高乐蜜芒果', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (18, '2019-12-26 04:29:51.435329', '3', '广西高乐蜜芒果', 1, '[{\"added\": {}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (19, '2019-12-26 04:30:00.399136', '2', '大兴大棚草莓', 3, '', 13, 19);
INSERT INTO `django_admin_log` VALUES (20, '2019-12-26 04:33:27.605045', '6', '猪肉', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (21, '2019-12-26 04:35:01.375339', '3', '生鲜土猪肉', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (22, '2019-12-26 04:35:26.179756', '4', '生鲜土猪肉', 1, '[{\"added\": {}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (23, '2019-12-26 04:39:21.903221', '7', '龙虾', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (24, '2019-12-26 04:40:44.717147', '4', '加拿大波士顿龙虾', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (25, '2019-12-26 04:41:09.427613', '3', '生鲜土猪肉', 2, '[]', 9, 19);
INSERT INTO `django_admin_log` VALUES (26, '2019-12-26 04:42:02.426835', '4', '加拿大波士顿龙虾', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (27, '2019-12-26 04:42:19.766952', '5', '加拿大波士顿龙虾', 1, '[{\"added\": {}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (28, '2019-12-26 04:44:25.075937', '1', 'IndexPromotionBanner object (1)', 1, '[{\"added\": {}}]', 11, 19);
INSERT INTO `django_admin_log` VALUES (29, '2019-12-26 04:45:57.555412', '2', '盛夏尝鲜季', 1, '[{\"added\": {}}]', 11, 19);
INSERT INTO `django_admin_log` VALUES (30, '2019-12-26 04:49:24.644936', '1', '广西高乐蜜芒果', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (31, '2019-12-26 04:55:08.211068', '5', '加州提子', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (32, '2019-12-26 04:55:26.890997', '2', '加州提子', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (33, '2019-12-26 04:55:55.221042', '2', '加州提子', 2, '[{\"changed\": {\"fields\": [\"display_type\"]}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (34, '2019-12-26 04:56:48.326351', '8', '牛油果', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (35, '2019-12-26 04:59:42.472383', '6', '亚马逊牛油果', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (36, '2019-12-26 05:00:10.894972', '3', '亚马逊牛油果', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (37, '2019-12-26 05:00:23.493596', '2', '加州提子', 2, '[{\"changed\": {\"fields\": [\"index\"]}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (38, '2019-12-26 05:00:40.022514', '2', '加州提子', 2, '[{\"changed\": {\"fields\": [\"index\"]}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (39, '2019-12-26 05:01:03.568152', '2', '加州提子', 2, '[{\"changed\": {\"fields\": [\"index\"]}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (40, '2019-12-26 05:03:25.963369', '7', '草莓', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (41, '2019-12-26 05:03:38.931768', '4', '草莓', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (42, '2019-12-26 05:05:03.654652', '8', '葡萄', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (43, '2019-12-26 05:05:15.230533', '5', '葡萄', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (44, '2019-12-26 05:06:43.955551', '9', '柠檬', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (45, '2019-12-26 05:06:54.035073', '6', '柠檬', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (46, '2019-12-26 05:08:33.730145', '10', '奇异果', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (47, '2019-12-26 05:08:47.783622', '7', '奇异果', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (48, '2019-12-26 06:37:42.875414', '9', '虾', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (49, '2019-12-26 06:39:55.371531', '11', '河虾', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (50, '2019-12-26 06:40:14.379923', '8', '河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (51, '2019-12-26 06:40:19.946303', '8', '河虾', 2, '[{\"changed\": {\"fields\": [\"display_type\"]}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (52, '2019-12-26 06:44:33.422853', '10', '扇贝', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (53, '2019-12-26 06:46:43.778713', '12', '新货瑶柱干贝干货', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (54, '2019-12-26 06:47:29.345959', '12', '扇贝', 2, '[{\"changed\": {\"fields\": [\"name\", \"desc\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (55, '2019-12-26 06:47:43.053720', '9', '扇贝', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (56, '2019-12-26 06:50:20.933829', '13', '青岛野生海捕大青虾', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (57, '2019-12-26 06:50:35.180910', '10', '青岛野生海捕大青虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (58, '2019-12-26 06:51:38.888923', '12', '扇贝干', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (59, '2019-12-26 06:53:46.041187', '14', '扇贝', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (60, '2019-12-26 06:53:58.715618', '11', '扇贝', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (61, '2019-12-26 06:55:08.937539', '11', '鱼', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (62, '2019-12-26 06:56:39.223309', '15', '冷冻秋刀鱼', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (63, '2019-12-26 06:56:54.299872', '12', '冷冻秋刀鱼', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (64, '2019-12-26 06:58:59.524332', '16', '基围虾', 1, '[{\"added\": {}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (65, '2019-12-26 06:59:12.327341', '13', '基围虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (66, '2019-12-26 07:00:46.933229', '14', '冷冻秋刀鱼', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (67, '2019-12-26 07:01:14.258553', '15', '河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (68, '2019-12-26 07:01:28.187017', '16', '河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (69, '2019-12-26 07:02:55.409335', '17', '猪牛羊肉：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (70, '2019-12-26 07:03:05.357166', '18', '海鲜水产：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (71, '2019-12-26 07:03:41.299642', '18', '海鲜水产：河虾', 3, '', 12, 19);
INSERT INTO `django_admin_log` VALUES (72, '2019-12-26 07:04:26.739791', '19', '猪牛羊肉：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (73, '2019-12-26 07:05:13.427654', '20', '禽类蛋品：冷冻秋刀鱼', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (74, '2019-12-26 07:06:02.257858', '21', '禽类蛋品：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (75, '2019-12-26 07:06:13.756178', '22', '禽类蛋品：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (76, '2019-12-26 07:06:25.586285', '23', '禽类蛋品：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (77, '2019-12-26 07:06:34.909553', '24', '禽类蛋品：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (78, '2019-12-26 07:08:09.642615', '25', '新鲜蔬菜：冷冻秋刀鱼', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (79, '2019-12-26 07:53:12.384101', '25', '新鲜蔬菜：冷冻秋刀鱼', 2, '[{\"changed\": {\"fields\": [\"display_type\"]}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (80, '2019-12-26 07:53:27.136705', '26', '新鲜蔬菜：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (81, '2019-12-26 07:53:38.489949', '27', '新鲜蔬菜：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (82, '2019-12-26 07:53:48.861091', '28', '新鲜蔬菜：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (83, '2019-12-26 07:54:02.571696', '29', '新鲜蔬菜：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (84, '2019-12-26 07:55:28.924849', '30', '速冻食品：冷冻秋刀鱼', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (85, '2019-12-26 07:56:07.039279', '31', '速冻食品：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (86, '2019-12-26 07:56:20.073634', '32', '速冻食品：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (87, '2019-12-26 07:56:29.653842', '33', '速冻食品：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (88, '2019-12-26 07:56:49.889144', '34', '速冻食品：河虾', 1, '[{\"added\": {}}]', 12, 19);
INSERT INTO `django_admin_log` VALUES (89, '2019-12-26 16:20:22.267175', '7', '草莓', 2, '[{\"changed\": {\"fields\": [\"price\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (90, '2019-12-26 16:21:49.877025', '14', '扇贝', 2, '[{\"changed\": {\"fields\": [\"price\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (91, '2019-12-26 16:23:05.425415', '12', '扇贝干', 2, '[{\"changed\": {\"fields\": [\"price\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (92, '2019-12-28 08:55:35.365699', '1', '吃货暑假趴', 2, '[{\"changed\": {\"fields\": [\"index\"]}}]', 11, 19);
INSERT INTO `django_admin_log` VALUES (93, '2019-12-29 16:37:06.254115', '9', '柠檬', 2, '[{\"changed\": {\"fields\": [\"unite\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (94, '2020-01-10 13:46:28.291709', '1', '大兴大棚草莓', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (95, '2020-01-10 15:55:53.888136', '1', '大兴大棚草莓', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (96, '2020-01-10 15:56:58.880560', '11', '河虾', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (97, '2020-01-10 16:06:38.394589', '2', '广西高乐蜜芒果', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (98, '2020-01-10 16:06:50.255153', '3', '生鲜土猪肉', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (99, '2020-01-10 16:07:03.411255', '4', '加拿大波士顿龙虾', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (100, '2020-01-10 16:07:16.379444', '5', '加州提子', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (101, '2020-01-10 16:07:51.133506', '6', '亚马逊牛油果', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (102, '2020-01-10 16:09:04.803207', '7', '草莓', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (103, '2020-01-10 16:09:12.220918', '8', '葡萄', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (104, '2020-01-10 16:09:19.348281', '9', '柠檬', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (105, '2020-01-10 16:09:29.976488', '10', '奇异果', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (106, '2020-01-10 16:10:10.158433', '12', '扇贝干', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (107, '2020-01-10 16:10:21.790839', '13', '青岛野生海捕大青虾', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (108, '2020-01-10 16:10:39.172326', '14', '扇贝', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (109, '2020-01-10 16:10:48.741521', '15', '冷冻秋刀鱼', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (110, '2020-01-10 16:11:52.547454', '13', '青岛野生海捕大青虾', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (111, '2020-01-10 16:13:10.201987', '16', '基围虾', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 9, 19);
INSERT INTO `django_admin_log` VALUES (112, '2020-01-10 16:16:51.766613', '1', '大兴大棚草莓', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (113, '2020-01-10 16:16:59.726418', '3', '广西高乐蜜芒果', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (114, '2020-01-10 16:17:07.001578', '4', '生鲜土猪肉', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (115, '2020-01-10 16:17:16.536605', '5', '加拿大波士顿龙虾', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (116, '2020-01-10 16:18:25.598467', '1', '吃货暑假趴', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 11, 19);
INSERT INTO `django_admin_log` VALUES (117, '2020-01-10 16:18:35.627868', '2', '盛夏尝鲜季', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 11, 19);
INSERT INTO `django_admin_log` VALUES (118, '2020-01-10 16:20:15.041792', '2', '盛夏尝鲜季', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 11, 19);
INSERT INTO `django_admin_log` VALUES (119, '2020-01-10 16:20:27.149887', '1', '吃货暑假趴', 2, '[{\"changed\": {\"fields\": [\"index\"]}}]', 11, 19);
INSERT INTO `django_admin_log` VALUES (120, '2020-01-10 16:21:29.390393', '2', '新鲜水果', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (121, '2020-01-10 16:21:38.663110', '3', '海鲜水产', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (122, '2020-01-10 16:22:06.441200', '4', '猪牛羊肉', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (123, '2020-01-10 16:24:01.375477', '5', '禽类蛋品', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (124, '2020-01-10 16:24:07.448324', '6', '新鲜蔬菜', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (125, '2020-01-10 16:24:15.190599', '7', '速冻食品', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (126, '2020-01-12 18:07:40.910261', '1', '吃货暑假趴', 2, '[{\"changed\": {\"fields\": [\"index\"]}}]', 11, 19);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (8, 'goods', 'goods');
INSERT INTO `django_content_type` VALUES (14, 'goods', 'goodsimage');
INSERT INTO `django_content_type` VALUES (9, 'goods', 'goodssku');
INSERT INTO `django_content_type` VALUES (10, 'goods', 'goodstype');
INSERT INTO `django_content_type` VALUES (13, 'goods', 'indexgoodsbanner');
INSERT INTO `django_content_type` VALUES (11, 'goods', 'indexpromotionbanner');
INSERT INTO `django_content_type` VALUES (12, 'goods', 'indextypegoodsbanner');
INSERT INTO `django_content_type` VALUES (15, 'order', 'ordergoods');
INSERT INTO `django_content_type` VALUES (16, 'order', 'orderinfo');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (7, 'user', 'address');
INSERT INTO `django_content_type` VALUES (6, 'user', 'user');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('amveqy4ozqtnclrlrd58y5r03fk41xob', 'MDUyOTJkYTc1N2U0ZjNjZWY1Y2VjNTIxODJkMTAzNWYwODQ3OTZiZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNWJiMGI4NzI2ZDkzY2VhZWMwMGZlYjBmMzc1NzRjMmUyNjI1YzBkIn0=', '2020-01-04 17:08:30.304449');

SET FOREIGN_KEY_CHECKS = 1;

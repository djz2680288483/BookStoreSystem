/*
 Navicat Premium Data Transfer

 Source Server         : trip
 Source Server Type    : MySQL
 Source Server Version : 50519
 Source Host           : localhost:3306
 Source Schema         : trip

 Target Server Type    : MySQL
 Target Server Version : 50519
 File Encoding         : 65001

 Date: 24/03/2021 09:04:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book_type
-- ----------------------------
DROP TABLE IF EXISTS `book_type`;
CREATE TABLE `book_type`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `numbers` int(10) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `autoid`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of book_type
-- ----------------------------
INSERT INTO `book_type` VALUES (1, '0272E9F0A7D0475', '传记', 156);
INSERT INTO `book_type` VALUES (2, '06389D176B62435', '古籍', 156);
INSERT INTO `book_type` VALUES (3, '22465EAB8678415', '计算机教材', 119);
INSERT INTO `book_type` VALUES (4, '44234276A0A34FA', '悬疑推理', 208);
INSERT INTO `book_type` VALUES (5, '4B35F4C1FA69473B', '校园', 208);
INSERT INTO `book_type` VALUES (6, '5E7FEADA12534742', '玄幻', 208);
INSERT INTO `book_type` VALUES (7, '6A2AF5D555824697', '科幻', 180);
INSERT INTO `book_type` VALUES (8, '6C439761542D4DC0', '法律', 111);
INSERT INTO `book_type` VALUES (9, 'BC328D40BD9C4C8E', '名著', 208);
INSERT INTO `book_type` VALUES (10, 'ACE83CC438B14C2C', '文学', 12);

SET FOREIGN_KEY_CHECKS = 1;

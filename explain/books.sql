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

 Date: 24/03/2021 09:04:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `book_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `book_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `book_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `book_price` decimal(10, 2) NOT NULL,
  `book_pic` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `book_discount` decimal(10, 2) NOT NULL,
  `book_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sales` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Bid`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1575 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES (1573, '398AC93EED054AD38408', '文学', '路遥', 23.43, 'A3s6962405.jpg', 9.00, '平凡的世界', 'test', 0);
INSERT INTO `books` VALUES (1574, '9307928835554E9A84F1', '文学', '路遥', 23.43, 'A3s7385291.jpg', 9.00, '平凡的世界', 'test', 0);

SET FOREIGN_KEY_CHECKS = 1;

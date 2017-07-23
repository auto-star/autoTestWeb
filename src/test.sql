/*
Navicat MySQL Data Transfer

Source Server         : autoTest
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2017-05-11 17:07:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_action`
-- ----------------------------
DROP TABLE IF EXISTS `t_action`;
CREATE TABLE `t_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `actionCategory` int(11) DEFAULT NULL,
  `commandCategory` int(1) DEFAULT NULL,
  `commandName` varchar(255) DEFAULT NULL,
  `elementName` varchar(255) DEFAULT NULL,
  `elementXpath` varchar(3000) DEFAULT NULL,
  `contextKey` varchar(255) DEFAULT NULL,
  `valueCategory` int(11) DEFAULT NULL,
  `defaultValue` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `parentActionId` int(11) DEFAULT NULL,
  `pageId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_action_ibfk_1` (`pageId`),
  CONSTRAINT `t_action_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `t_page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_action
-- ----------------------------
INSERT INTO `t_action` VALUES ('313', '等待搜索框出现', '4', '1', 'html.waitDisplay', '', '//*[@id=\"kw\"]', '', '1', '', '1', '0', '25');
INSERT INTO `t_action` VALUES ('314', '输入搜索值', '1', '1', 'html.sendKeys', '搜索值', '//*[@id=\"kw\"]', '', '1', '', '2', '0', '25');
INSERT INTO `t_action` VALUES ('315', '等待元素出现', '4', '1', 'html.waitDisplay', '', '//*[@id=\"su\"]', '', '1', '', '3', '0', '25');
INSERT INTO `t_action` VALUES ('316', '点击搜索', '4', '1', 'html.click', '', '//*[@id=\"su\"]', '', '1', '', '4', '0', '25');
INSERT INTO `t_action` VALUES ('317', '截图', '4', '1', 'html.screenShot', '', '', '', '1', '', '6', '0', '25');
INSERT INTO `t_action` VALUES ('318', '等待元素出现', '4', '1', 'html.waitDisplay', '', '//*[@id=\"su\"]', '', '1', '', '5', '0', '25');

-- ----------------------------
-- Table structure for `t_basecase`
-- ----------------------------
DROP TABLE IF EXISTS `t_basecase`;
CREATE TABLE `t_basecase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `groupId` int(11) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `caseId` int(11) DEFAULT NULL COMMENT '为0则为基础case',
  `kind` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_basecase
-- ----------------------------
INSERT INTO `t_basecase` VALUES ('29', 'test', 'test', '111', '5', '104', '2', '16', '1', '1');

-- ----------------------------
-- Table structure for `t_case`
-- ----------------------------
DROP TABLE IF EXISTS `t_case`;
CREATE TABLE `t_case` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL COMMENT '相当于case文件夹',
  `userId` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `insertTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_case
-- ----------------------------
INSERT INTO `t_case` VALUES ('16', '测试百度搜索', '测试百度搜索', '5', '0', '104', null, '2017-05-11 17:01:08', '2017-05-11 17:01:08');

-- ----------------------------
-- Table structure for `t_casedata`
-- ----------------------------
DROP TABLE IF EXISTS `t_casedata`;
CREATE TABLE `t_casedata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` int(11) DEFAULT NULL,
  `dataValue` text,
  `dataMapId` int(11) DEFAULT NULL,
  `casePageId` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `casePageId` (`casePageId`),
  CONSTRAINT `t_casedata_ibfk_1` FOREIGN KEY (`casePageId`) REFERENCES `t_casepage` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=474 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_casedata
-- ----------------------------
INSERT INTO `t_casedata` VALUES ('473', '1', 'test', '149', '162', '1');

-- ----------------------------
-- Table structure for `t_casepage`
-- ----------------------------
DROP TABLE IF EXISTS `t_casepage`;
CREATE TABLE `t_casepage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pageId` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `baseCaseId` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `t_casepage_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `t_page` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_casepage
-- ----------------------------
INSERT INTO `t_casepage` VALUES ('162', '25', '测试百度', '测试百度', '29', '1', '104', '0');

-- ----------------------------
-- Table structure for `t_category`
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `insertUser` int(11) DEFAULT NULL,
  `updateUser` int(11) DEFAULT NULL,
  `insertTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_category
-- ----------------------------

-- ----------------------------
-- Table structure for `t_client`
-- ----------------------------
DROP TABLE IF EXISTS `t_client`;
CREATE TABLE `t_client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_client
-- ----------------------------
INSERT INTO `t_client` VALUES ('5', '本机', '127.0.0.1', '104');

-- ----------------------------
-- Table structure for `t_context`
-- ----------------------------
DROP TABLE IF EXISTS `t_context`;
CREATE TABLE `t_context` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `contextKey` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_context
-- ----------------------------

-- ----------------------------
-- Table structure for `t_datamap`
-- ----------------------------
DROP TABLE IF EXISTS `t_datamap`;
CREATE TABLE `t_datamap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `category` int(11) DEFAULT NULL COMMENT '1,input,2,select',
  `actionId` int(11) DEFAULT NULL,
  `pageId` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `refPageId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_datamap_ibfk_1` (`pageId`),
  CONSTRAINT `t_datamap_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `t_page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_datamap
-- ----------------------------
INSERT INTO `t_datamap` VALUES ('149', null, '1', '314', '25', '1', '0');

-- ----------------------------
-- Table structure for `t_datamapcollection`
-- ----------------------------
DROP TABLE IF EXISTS `t_datamapcollection`;
CREATE TABLE `t_datamapcollection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dataMapId` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dataMapId` (`dataMapId`),
  CONSTRAINT `t_datamapcollection_ibfk_1` FOREIGN KEY (`dataMapId`) REFERENCES `t_datamap` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_datamapcollection
-- ----------------------------

-- ----------------------------
-- Table structure for `t_degrade`
-- ----------------------------
DROP TABLE IF EXISTS `t_degrade`;
CREATE TABLE `t_degrade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caseId` int(11) DEFAULT NULL,
  `runCaseResultId` int(11) DEFAULT NULL,
  `environmentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=333 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_degrade
-- ----------------------------

-- ----------------------------
-- Table structure for `t_degradedata`
-- ----------------------------
DROP TABLE IF EXISTS `t_degradedata`;
CREATE TABLE `t_degradedata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `degradeId` int(11) DEFAULT NULL,
  `elementId` int(11) DEFAULT NULL,
  `value` varchar(3000) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_degradedata
-- ----------------------------

-- ----------------------------
-- Table structure for `t_element`
-- ----------------------------
DROP TABLE IF EXISTS `t_element`;
CREATE TABLE `t_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name1` varchar(255) DEFAULT NULL,
  `actionCategory` int(11) DEFAULT NULL,
  `commandCategory` int(1) DEFAULT NULL,
  `commandName` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `xpath` varchar(3000) DEFAULT NULL,
  `contextKey` varchar(255) DEFAULT NULL,
  `valueCategory` int(11) DEFAULT NULL,
  `defaultValue` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `parentActionId` int(11) DEFAULT NULL,
  `pageId` int(11) DEFAULT NULL,
  `isCompare` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_action_ibfk_1` (`pageId`)
) ENGINE=InnoDB AUTO_INCREMENT=10919 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_element
-- ----------------------------
INSERT INTO `t_element` VALUES ('8198', '输入预占位天', '1', '1', 'html.sendKeys', '预占位天', '//*[@id=\'remainDays_advance\']', '', '1', '', '32', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8199', '输入预占位小时', '1', '1', 'html.sendKeys', '预占位小时', '//*[@id=\'remainDays_advance_hour\']', '', '1', '', '33', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8200', '输入预占位分钟', '1', '1', 'html.sendKeys', '预占位分钟', '//*[@id=\'remainDays_advance_fen\']', '', '1', '', '34', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8210', '输入成人同行价', '1', '1', 'html.sendKeys', '成人同行价', '//*[@id=\'settlementAdultPriceDefine\']', '', '1', '', '44', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8214', '输入儿童同行价', '1', '1', 'html.sendKeys', '儿童同行价', '//*[@id=\'settlementcChildPriceDefine\']', '', '1', '', '48', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8218', '输入特殊人群同行价', '1', '1', 'html.sendKeys', '特殊人群同行价', '//*[@id=\'settlementSpecialPriceDefine\']', '', '1', '', '52', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8219', '输入特殊人群最高人数', '1', '1', 'html.sendKeys', '特殊人群最高人数', '//*[@id=\'maxPeopleCountDefine\']', '', '1', '', '53', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8220', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\'specialRemark\']', '', '1', '', '54', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8224', '输入需交订金', '1', '1', 'html.sendKeys', '需交订金', '//*[@id=\'payDepositDefine\']', '', '1', '', '58', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8228', '输入单房差', '1', '1', 'html.sendKeys', '单房差', '//*[@id=\'singleDiffDefine\']', '', '1', '', '62', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8233', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\'groupCode0\']', '', '3', '1_NO_0', '68', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8234', '获取团号并放入内存', '4', '1', 'html.getTextOrValue', '团号', '//*[@id=\'groupCode0\']', 'groupCode', '1', '', '69', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8236', '收集出团日期', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'groupOpenDate0\']', 'groupDate', '1', '', '71', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8237', '输入预收', '1', '1', 'html.sendKeys', '预收', '//*[@id=\'planPosition0\']', '', '1', '', '72', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8238', '输入余位', '1', '1', 'html.sendKeys', '余位', '//*[@id=\'freePosition0\']', '', '1', '', '73', '0', '567', '0');
INSERT INTO `t_element` VALUES ('8262', '输入费用名称', '1', '1', 'html.sendKeys', '费用名称', '//*[@id=\"jbox-content\"]/div/table/tbody/tr[?]/td[1]/input', 'OtherExpenseFlag', '1', '', '4', '0', '568', '0');
INSERT INTO `t_element` VALUES ('8264', '输入数量', '1', '1', 'html.sendKeys', '数量', '//*[@id=\"jbox-content\"]/div/table/tbody/tr[?]/td[3]/input', 'OtherExpenseFlag', '1', '', '6', '0', '568', '0');
INSERT INTO `t_element` VALUES ('8265', '输入单价', '1', '1', 'html.sendKeys', '单价', '//*[@id=\"jbox-content\"]/div/table/tbody/tr[?]/td[4]/input', 'OtherExpenseFlag', '1', '', '7', '0', '568', '0');
INSERT INTO `t_element` VALUES ('8283', '输入搜索内容', '1', '1', 'html.sendKeys', '搜索：', '//*[contains(text(),\"搜索\")]/following::input[1]', '', '2', 'groupCode', '1', '0', '569', '0');
INSERT INTO `t_element` VALUES ('8291', '输入渠道', '1', '1', 'html.sendKeys', '渠道', '//label[contains(text(),\'渠道选择\')]/following-sibling::span[1]/input[1]', '', '1', '', '4', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8297', '输入成人人数', '1', '1', 'html.sendKeys', '成人人数', '//*[@id=\'orderPersonNumAdult\']', '', '1', '', '12', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8298', '输入儿童人数', '1', '1', 'html.sendKeys', '儿童人数', '//*[@id=\'orderPersonNumChild\']', '', '1', '', '14', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8299', '输入特殊人群人数', '1', '1', 'html.sendKeys', '特殊人群人数', '//*[@id=\'orderPersonNumSpecial\']', '', '1', '', '16', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8300', '输入非签约渠道名称', '1', '1', 'html.sendKeys', '非签约渠道名称', '//*[@id=\'orderCompanyNameShow\']', '', '1', '', '17', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8301', '输入渠道联系人', '1', '1', 'html.sendKeys', '渠道联系人', '//*[@id=\'orderpersonMes\']/li[1]/input', '', '1', '', '18', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8302', '输入渠道联系人电话', '1', '1', 'html.sendKeys', '渠道联系人电话', '//*[@id=\'orderpersonMes\']/li[2]/input', '', '1', '', '19', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8305', '输入特殊需求', '1', '1', 'html.sendKeys', '特殊需求', '//*[@id=\'specialDemand\']', '', '1', '', '22', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8338', '输入团队返佣金额', '1', '1', 'html.sendKeys', '团队返佣金额', '//*[@id=\'rebatesMoney\']', '', '1', '', '27', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8345', '输入费用名称', '1', '1', 'html.sendKeys', '其他费用币种', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[1]/input', 'travelerFlag', '1', '', '14', '0', '558', '0');
INSERT INTO `t_element` VALUES ('8346', '输入成人单价', '1', '1', 'html.sendKeys', '成人单价', '//*[@id=\"price-detaill-dl-all-id\"]/ul[1]/li[2]/input[4]', '', '1', '', '3', '0', '572', '0');
INSERT INTO `t_element` VALUES ('8348', '输入儿童单价', '1', '1', 'html.sendKeys', '儿童单价', '//*[@id=\"price-detaill-dl-all-id\"]/ul[2]/li[2]/input[4]', '', '1', '', '5', '0', '572', '0');
INSERT INTO `t_element` VALUES ('8350', '输入其他费用单价', '1', '1', 'html.sendKeys', '其他费用单价', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[4]/input', 'travelerFlag', '1', '', '18', '0', '558', '0');
INSERT INTO `t_element` VALUES ('8351', '输入特殊人群单价', '1', '1', 'html.sendKeys', '儿童单价', '//*[@id=\"price-detaill-dl-all-id\"]/ul[3]/li[2]/input[4]', '', '1', '', '7', '0', '572', '0');
INSERT INTO `t_element` VALUES ('8357', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//input[@name=\"payerName\" and @id=\"payerNameID_3\"]', '', '1', '', '36', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8362', '收集订单号', '4', '1', 'html.getTextOrValue', '收集订单号', '//td[text()=\"现金支付\"]/preceding::td[1]', 'orderCode', '1', '', '39', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8369', '输入儿童最高人数', '1', '1', 'html.sendKeys', '儿童最高人数', '//*[contains(text(),\"儿童最高人数：\")]/following::input[1]', '', '1', '', '56', '0', '556', '0');
INSERT INTO `t_element` VALUES ('8370', '输入特殊人群最高人数', '1', '1', 'html.sendKeys', '特殊人群最高人数', '//*[contains(text(),\"特殊人群最高人数：\")]/following::input[1]', '', '1', '', '57', '0', '556', '0');
INSERT INTO `t_element` VALUES ('8371', '收集订单总同行价', '1', '1', 'html.gatherData', '收集订单总同行价', '//*[contains(text(),\"订单总结算价：\")]/preceding::span[1]', '', '1', '', '31', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8372', '收集订单总结算价', '1', '1', 'html.gatherData', '收集订单总结算价', '//*[contains(text(),\"订单总结算价：\")]/following::span[1]', '', '1', '', '32', '0', '570', '0');
INSERT INTO `t_element` VALUES ('8385', '输入费用名称', '1', '1', 'html.sendKeys', '费用名称', '//*[@id=\"jbox-content\"]/div/table/tbody/tr[?]/td[1]/input', 'OtherExpenseFlag', '1', '', '4', '0', '575', '0');
INSERT INTO `t_element` VALUES ('8387', '输入数量', '1', '1', 'html.sendKeys', '数量', '//*[@id=\"jbox-content\"]/div/table/tbody/tr[?]/td[3]/input', 'OtherExpenseFlag', '1', '', '6', '0', '575', '0');
INSERT INTO `t_element` VALUES ('8388', '输入单价', '1', '1', 'html.sendKeys', '单价', '//*[@id=\"jbox-content\"]/div/table/tbody/tr[?]/td[4]/input', 'OtherExpenseFlag', '1', '', '7', '0', '575', '0');
INSERT INTO `t_element` VALUES ('8395', '输入名称', '1', '1', 'html.sendKeys', '名称', '//*[@id=\"label\"]', '', '1', '', '3', '0', '577', '0');
INSERT INTO `t_element` VALUES ('8397', '搜索', '1', '1', 'html.sendKeys', '搜索', '//*[@id=\"wholeSalerKey\"]', '', '1', '', '1', '0', '578', '0');
INSERT INTO `t_element` VALUES ('8400', '搜索', '1', '1', 'html.sendKeys', '搜索', '//*[@id=\"wholeSalerKey\"]', '', '1', '', '1', '0', '579', '0');
INSERT INTO `t_element` VALUES ('8405', '搜索', '1', '1', 'html.sendKeys', '搜索', '//*[@id=\"wholeSalerKey\"]', '', '1', '', '1', '0', '595', '0');
INSERT INTO `t_element` VALUES ('8412', '输入中文名称', '1', '1', 'html.sendKeys', '中文名称', '//*[@id=\"name\"]', '', '1', '', '5', '0', '596', '0');
INSERT INTO `t_element` VALUES ('8413', '输入部门编码', '1', '1', 'html.sendKeys', '', '//*[@id=\"code\"]', '', '1', '', '6', '0', '596', '0');
INSERT INTO `t_element` VALUES ('8431', '输入发票抬头', '1', '1', 'html.sendKeys', '发票抬头', '//p[text()=\"发票抬头：\"]//following-sibling::p/input', '', '1', '', '6', '0', '598', '0');
INSERT INTO `t_element` VALUES ('8433', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//p[text()=\"来款单位：\"]//following-sibling::p/input', '', '1', '', '8', '0', '598', '0');
INSERT INTO `t_element` VALUES ('8434', '输入本次开票金额', '1', '1', 'html.sendKeys', '本次开票金额', '//*[@id=\"sea\"]/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '9', '0', '598', '0');
INSERT INTO `t_element` VALUES ('8435', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div[6]/p[2]/textarea', '', '1', '', '10', '0', '598', '0');
INSERT INTO `t_element` VALUES ('8449', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"orderNum\"]', '', '2', 'orderCode', '1', '0', '599', '0');
INSERT INTO `t_element` VALUES ('8458', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//*[@id=\"contentTable\"]/tbody/tr/td[3]', '', '2', 'orderCode', '3', '0', '601', '0');
INSERT INTO `t_element` VALUES ('8459', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"contentTable\"]/tbody/tr/td[4]', '', '2', 'groupCode', '4', '0', '601', '0');
INSERT INTO `t_element` VALUES ('8461', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"searchForm\"]/div[2]/ul/li[12]/textarea', '', '1', '', '3', '0', '602', '0');
INSERT INTO `t_element` VALUES ('8463', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//*[@id=\"contentTable\"]/tbody/tr/td[3]', '', '2', 'orderCode', '5', '0', '602', '0');
INSERT INTO `t_element` VALUES ('8464', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"contentTable\"]/tbody/tr/td[4]', '', '2', 'groupCode', '6', '0', '602', '0');
INSERT INTO `t_element` VALUES ('8466', '获取第一行第一列内容', '4', '1', 'html.getTextOrValue', '', '//*[@id=\"contentTable\"]/tbody/tr[1]/td[1]', 'invoiceFlag', '1', '', '2', '0', '597', '0');
INSERT INTO `t_element` VALUES ('8470', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '4', '0', '603', '0');
INSERT INTO `t_element` VALUES ('8477', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '5', '0', '604', '0');
INSERT INTO `t_element` VALUES ('8483', '输入发票号', '1', '1', 'html.sendKeys', '发票号', '//*[@id=\"searchForm\"]/div[2]/ul/li[12]/input', '', '3', '1_FP_0', '3', '0', '605', '0');
INSERT INTO `t_element` VALUES ('8485', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"searchForm\"]/div[2]/ul/li[14]/textarea', '', '1', '', '5', '0', '605', '0');
INSERT INTO `t_element` VALUES ('8487', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//*[@id=\"contentTable\"]/tbody/tr/td[3]', '', '2', 'orderCode', '7', '0', '605', '0');
INSERT INTO `t_element` VALUES ('8499', '输入开收据抬头', '1', '1', 'html.sendKeys', '开收据抬头', '//p[contains(text(),\"开收据抬头\")]/following-sibling::p/input', '', '1', '', '6', '0', '607', '0');
INSERT INTO `t_element` VALUES ('8500', '输入开收据客户', '1', '1', 'html.sendKeys', '开收据客户', '//p[contains(text(),\"开收据客户\")]/following-sibling::p/span/input', '', '1', '', '7', '0', '607', '0');
INSERT INTO `t_element` VALUES ('8502', '输入本次开收据金额', '1', '1', 'html.sendKeys', '本次开收据金额', '//*[@id=\"sea\"]/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '10', '0', '607', '0');
INSERT INTO `t_element` VALUES ('8503', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div[6]/p[2]/textarea', '', '1', '', '11', '0', '607', '0');
INSERT INTO `t_element` VALUES ('8511', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"orderNum\"]', '', '2', 'orderCode', '4', '0', '609', '0');
INSERT INTO `t_element` VALUES ('8517', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//*[@id=\"contentTable\"]/tbody/tr/td[2]', '', '2', 'orderCode', '2', '0', '610', '0');
INSERT INTO `t_element` VALUES ('8518', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"contentTable\"]/tbody/tr/td[3]', '', '2', 'groupCode', '3', '0', '610', '0');
INSERT INTO `t_element` VALUES ('8521', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//*[@id=\"contentTable\"]/tbody/tr/td[2]', '', '2', 'orderCode', '2', '0', '611', '0');
INSERT INTO `t_element` VALUES ('8522', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"contentTable\"]/tbody/tr/td[3]', '', '2', 'groupCode', '3', '0', '611', '0');
INSERT INTO `t_element` VALUES ('8525', '获取订单收据记录', '4', '1', 'html.getTextOrValue', '', '//*[@id=\"contentTable\"]/tbody/tr[1]/td[1]', 'receipt', '1', '', '2', '0', '606', '0');
INSERT INTO `t_element` VALUES ('8531', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '4', '0', '612', '0');
INSERT INTO `t_element` VALUES ('8541', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '4', '0', '614', '0');
INSERT INTO `t_element` VALUES ('8547', '输入收据号', '1', '1', 'html.sendKeys', '收据号', '//*[@id=\"searchForm\"]/div[1]/ul/li[10]/input', '', '3', '1_SJ_0', '3', '0', '615', '0');
INSERT INTO `t_element` VALUES ('8551', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"orderNum\"]', '', '2', 'orderCode', '3', '0', '617', '0');
INSERT INTO `t_element` VALUES ('8557', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"printDiv\"]/table/tbody/tr[1]/td[2]', '', '2', 'groupCode', '3', '0', '618', '0');
INSERT INTO `t_element` VALUES ('8559', '关闭页面', '4', '1', 'html.closeTab', '', '客人报名收款单(签证收款)', '', '1', '', '5', '0', '618', '0');
INSERT INTO `t_element` VALUES ('8562', '输入银行到账日期', '1', '1', 'html.sendKeys', '银行到账日期', '//*[@id=\"accountDate\"]', '', '3', '2_1_0', '3', '0', '619', '0');
INSERT INTO `t_element` VALUES ('8563', '输入备注信息', '1', '1', 'html.sendKeys', '备注信息', '//*[@id=\"remarks\"]', '', '1', '', '4', '0', '619', '0');
INSERT INTO `t_element` VALUES ('8573', '输入付款金额', '1', '1', 'html.sendKeys', '付款金额', '//*[@id=\"offlineform_3\"]/div/table/tbody/tr/td[1]/table/tbody/tr[1]/td[2]/input', '', '1', '', '4', '0', '621', '0');
INSERT INTO `t_element` VALUES ('8574', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//*[@id=\"offlineform_3\"]/div/table/tbody/tr/td[1]/table/tbody/tr[2]/td[2]/input', '', '1', '', '5', '0', '621', '0');
INSERT INTO `t_element` VALUES ('8578', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '3', '0', '622', '0');
INSERT INTO `t_element` VALUES ('8583', '收集团号', '1', '1', 'html.sendKeys', '团号', '//td[contains(text(),\"团号\")]/following::td[1]', '', '2', 'groupCode', '2', '0', '623', '0');
INSERT INTO `t_element` VALUES ('8586', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"printDiv\"]/table/tbody/tr[1]/td[2]', '', '2', 'groupCode', '3', '0', '624', '0');
INSERT INTO `t_element` VALUES ('8591', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//*[@id=\"payerName\"]', '', '1', '', '3', '0', '625', '0');
INSERT INTO `t_element` VALUES ('8592', '输入银行到账日期', '1', '1', 'html.sendKeys', '银行到账日期', '//*[@id=\"accountDate\"]', '', '1', '', '4', '0', '625', '0');
INSERT INTO `t_element` VALUES ('8593', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"remarks\"]', '', '1', '', '5', '0', '625', '0');
INSERT INTO `t_element` VALUES ('8600', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '3', '0', '626', '0');
INSERT INTO `t_element` VALUES ('8610', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"reason\"]', '', '1', '', '6', '0', '627', '0');
INSERT INTO `t_element` VALUES ('8622', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"wholeSalerKey\"]', '', '2', 'groupCode', '3', '0', '629', '0');
INSERT INTO `t_element` VALUES ('8630', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"jbox-content\"]/div/textarea', '', '1', '', '5', '0', '630', '0');
INSERT INTO `t_element` VALUES ('8635', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '3', '0', '631', '0');
INSERT INTO `t_element` VALUES ('8642', '输入人民币金额', '1', '1', 'html.sendKeys', '人民币金额', '//*[@id=\"offlineform_3\"]/div/table/tbody/tr/td[1]/table/tbody/tr[1]/td[2]/input', '', '1', '', '4', '0', '633', '0');
INSERT INTO `t_element` VALUES ('8643', '输入收款单位', '1', '1', 'html.sendKeys', '收款单位', '//*[@id=\"offlineform_3\"]/div/table/tbody/tr/td[1]/table/tbody/tr[2]/td[2]/input', '', '1', '', '5', '0', '633', '0');
INSERT INTO `t_element` VALUES ('8647', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"wholeSalerKey\"]', '', '2', 'orderCode', '3', '0', '634', '0');
INSERT INTO `t_element` VALUES ('8655', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"jbox-content\"]/div/textarea', '', '1', '', '5', '0', '635', '0');
INSERT INTO `t_element` VALUES ('8659', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '2', '0', '636', '0');
INSERT INTO `t_element` VALUES ('8669', '输入金额', '1', '1', 'html.sendKeys', '金额', '//*[@id=\"offlineform_3\"]/div/table/tbody/tr/td[1]/table/tbody/tr[1]/td[2]/input', '', '1', '', '3', '0', '637', '0');
INSERT INTO `t_element` VALUES ('8670', '输入收款单位', '1', '1', 'html.sendKeys', '收款单位', '//*[@id=\"offlineform_3\"]/div/table/tbody/tr/td[1]/table/tbody/tr[2]/td[2]/input', '', '1', '', '4', '0', '637', '0');
INSERT INTO `t_element` VALUES ('8674', '输入费用名称', '1', '1', 'html.sendKeys', '费用名称', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[1]/input', '', '1', '', '5', '0', '539', '0');
INSERT INTO `t_element` VALUES ('8676', '输入数量', '1', '1', 'html.sendKeys', '数量', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[3]/input', '', '1', '', '7', '0', '539', '0');
INSERT INTO `t_element` VALUES ('8677', '输入单价', '1', '1', 'html.sendKeys', '单价', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[4]/input', '', '1', '', '8', '0', '539', '0');
INSERT INTO `t_element` VALUES ('8686', '输入产品名称', '1', '1', 'html.sendKeys', '产品名称', '//*[@id=\"acitivityName\"]', 'productName', '3', '1_Y-autoTest-单团_0', '3', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8687', '选择出发城市', '1', '1', 'html.sendKeys', '出发城市', '//label[contains(text(),\"出发城市：\")]/following::input[1]', 'cfcs', '1', '', '4', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8691', '输入目的地关键字', '1', '1', 'html.sendKeys', '目的地关键字', '//*[@id=\'key\']', '', '1', '', '8', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8706', '输入行程天数', '1', '1', 'html.sendKeys', '行程天数', '//*[@id=\'activityDuration\']', '', '1', '', '23', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8714', '输入成人同行价', '1', '1', 'html.sendKeys', '成人同行价', '//*[@id=\'settlementAdultPriceDefine\']', '', '1', '', '31', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8718', '输入儿童同行价', '1', '1', 'html.sendKeys', '儿童同行价', '//*[@id=\'settlementcChildPriceDefine\']', '', '1', '', '35', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8722', '输入特殊人群同行价', '1', '1', 'html.sendKeys', '特殊人群同行价', '//*[@id=\'settlementSpecialPriceDefine\']', '', '1', '', '39', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8726', '输入成人直客价', '1', '1', 'html.sendKeys', '成人直客价', '//*[@id=\'suggestAdultPriceDefine\']', '', '1', '', '43', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8730', '输入儿童直客价', '1', '1', 'html.sendKeys', '儿童直客价', '//*[@id=\'suggestChildPriceDefine\']', '', '1', '', '47', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8734', '输入特殊人群直客价', '1', '1', 'html.sendKeys', '特殊人群直客价', '//*[@id=\'suggestSpecialPriceDefine\']', '', '1', '', '51', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8735', '输入儿童最高人数', '1', '1', 'html.sendKeys', '儿童最高人数', '//*[contains(text(),\"儿童最高人数：\")]/following::input[1]', '', '1', '', '52', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8736', '输入特殊人群最高人数', '1', '1', 'html.sendKeys', '特殊人群最高人数', '//*[contains(text(),\"特殊人群最高人数：\")]/following::input[1]', '', '1', '', '53', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8740', '输入需交定金', '1', '1', 'html.sendKeys', '需交定金', '//*[@id=\'payDepositDefine\']', '', '1', '', '57', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8744', '输入单房差', '1', '1', 'html.sendKeys', '单房差', '//*[@id=\'singleDiffDefine\']', '', '1', '', '61', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8747', '获取出团日期并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'groupOpenDate0\']', 'groupDate', '1', '', '64', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8750', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode0\"]', 'groupCode', '3', '1_Y-test_0', '67', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8751', '获取团号', '4', '1', 'html.getTextOrValue', '团号', '//*[@id=\"groupCode0\"]', 'groupCode', '1', '', '68', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8752', '输入预收人数', '1', '1', 'html.sendKeys', '预收', '//*[@id=\'planPosition0\']', '', '1', '', '69', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8753', '输入余位', '1', '1', 'html.sendKeys', '余位', '//*[@id=\'freePosition0\']', '', '1', '', '71', '0', '639', '0');
INSERT INTO `t_element` VALUES ('8771', '输入费用名称', '1', '1', 'html.sendKeys', '费用名称', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[1]/input', '', '1', '', '5', '0', '327', '0');
INSERT INTO `t_element` VALUES ('8773', '输入数量', '1', '1', 'html.sendKeys', '数量', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[3]/input', '', '1', '', '7', '0', '327', '0');
INSERT INTO `t_element` VALUES ('8774', '输入单价', '1', '1', 'html.sendKeys', '单价', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[4]/input', '', '1', '', '8', '0', '327', '0');
INSERT INTO `t_element` VALUES ('8777', '输入产品名称', '1', '1', 'html.sendKeys', '产品名称', '//*[@id=\'acitivityName\']', 'productName', '3', '1_Autotest-自由行_0', '2', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8778', '输入出发城市', '1', '1', 'html.sendKeys', '出发城市', '//*[@id=\"oneStepContent\"]/div[3]/span/input', 'DepartureCity', '1', '', '4', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8782', '检索目的地城市', '1', '1', 'html.sendKeys', '目的地城市', '//*[@id=\'key\']', '', '1', '', '8', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8791', '输入行程天数', '1', '1', 'html.sendKeys', '行程天数', '//*[@id=\'activityDuration\']', '', '1', '', '17', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8792', '输入领队', '1', '1', 'html.sendKeys', '领队', '//*[@id=\'groupLead\']', '', '1', '', '18', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8794', '输入订金占位天数', '1', '1', 'html.sendKeys', '订金占位天数', '//*[@id=\'remainDays_deposit\']', '', '1', '', '25', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8795', '输入订金占位小时', '1', '1', 'html.sendKeys', '订金占位小时', '//*[@id=\'remainDays_deposit_hour\']', '', '1', '', '26', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8796', '输入订金占位分钟', '1', '1', 'html.sendKeys', '订金占位分钟', '//*[@id=\'remainDays_deposit_fen\']', '', '1', '', '27', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8798', '输入预占位天', '1', '1', 'html.sendKeys', '预占位天', '//*[@id=\'remainDays_advance\']', '', '1', '', '29', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8799', '输入预占位小时', '1', '1', 'html.sendKeys', '预占位小时', '//*[@id=\'remainDays_advance_hour\']', '', '1', '', '30', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8800', '输入预占位分钟', '1', '1', 'html.sendKeys', '预占位分钟', '//*[@id=\'remainDays_advance_fen\']', '', '1', '', '31', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8810', '输入成人同行价', '1', '1', 'html.sendKeys', '成人同行价', '//*[@id=\'settlementAdultPriceDefine\']', '', '1', '', '41', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8814', '输入儿童同行价', '1', '1', 'html.sendKeys', '儿童同行价', '//*[@id=\'settlementcChildPriceDefine\']', '', '1', '', '45', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8818', '输入特殊人群同行价', '1', '1', 'html.sendKeys', '特殊人群同行价', '//*[@id=\'settlementSpecialPriceDefine\']', '', '1', '', '49', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8819', '输入特殊人群最高人数', '1', '1', 'html.sendKeys', '特殊人群最高人数', '//*[@id=\'maxPeopleCountDefine\']', '', '1', '', '50', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8820', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\'specialRemark\']', '', '1', '', '51', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8824', '输入需交订金', '1', '1', 'html.sendKeys', '需交订金', '//*[@id=\'payDepositDefine\']', '', '1', '', '55', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8828', '输入单房差', '1', '1', 'html.sendKeys', '单房差', '//*[@id=\'singleDiffDefine\']', '', '1', '', '59', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8833', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\'groupCode0\']', '', '3', '1_NO_0', '65', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8834', '获取团号并放入内存', '4', '1', 'html.getTextOrValue', '团号', '//*[@id=\'groupCode0\']', 'groupCode', '1', '', '66', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8836', '收集出团日期', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'groupOpenDate0\']', 'groupDate', '1', '', '68', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8837', '输入预收', '1', '1', 'html.sendKeys', '预收', '//*[@id=\'planPosition0\']', '', '1', '', '69', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8838', '输入余位', '1', '1', 'html.sendKeys', '余位', '//*[@id=\'freePosition0\']', '', '1', '', '70', '0', '640', '0');
INSERT INTO `t_element` VALUES ('8854', '输入产品名称', '1', '1', 'html.sendKeys', '产品名称', '//*[@id=\'acitivityName\']', '', '3', '1_Autotest-游学_0', '2', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8855', '获取产品名称并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'acitivityName\']', 'productName', '1', '', '3', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8856', '输入出发城市', '1', '1', 'html.sendKeys', '出发城市', '//*[@id=\'oneStepContent\']/div[3]/span/input', 'DepartureCity', '1', '', '5', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8860', '检索目的地城市', '1', '1', 'html.sendKeys', '目的地城市', '//*[@id=\'key\']', '', '1', '', '9', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8869', '输入行程天数', '1', '1', 'html.sendKeys', '行程天数', '//*[@id=\'activityDuration\']', '', '1', '', '18', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8870', '输入领队', '1', '1', 'html.sendKeys', '领队', '//*[@id=\'groupLead\']', '', '1', '', '19', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8872', '输入订金占位天数', '1', '1', 'html.sendKeys', '订金占位天数', '//*[@id=\'remainDays_deposit\']', '', '1', '', '26', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8873', '输入订金占位小时', '1', '1', 'html.sendKeys', '订金占位小时', '//*[@id=\'remainDays_deposit_hour\']', '', '1', '', '27', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8874', '输入订金占位分钟', '1', '1', 'html.sendKeys', '订金占位分钟', '//*[@id=\'remainDays_deposit_fen\']', '', '1', '', '28', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8876', '输入预占位天', '1', '1', 'html.sendKeys', '预占位天', '//*[@id=\'remainDays_advance\']', '', '1', '', '30', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8877', '输入预占位小时', '1', '1', 'html.sendKeys', '预占位小时', '//*[@id=\'remainDays_advance_hour\']', '', '1', '', '31', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8878', '输入预占位分钟', '1', '1', 'html.sendKeys', '预占位分钟', '//*[@id=\'remainDays_advance_fen\']', '', '1', '', '32', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8888', '输入成人同行价', '1', '1', 'html.sendKeys', '成人同行价', '//*[@id=\'settlementAdultPriceDefine\']', '', '1', '', '42', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8892', '输入儿童同行价', '1', '1', 'html.sendKeys', '儿童同行价', '//*[@id=\'settlementcChildPriceDefine\']', '', '1', '', '46', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8896', '输入特殊人群同行价', '1', '1', 'html.sendKeys', '特殊人群同行价', '//*[@id=\'settlementSpecialPriceDefine\']', '', '1', '', '50', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8897', '输入特殊人群最高人数', '1', '1', 'html.sendKeys', '特殊人群最高人数', '//*[@id=\'maxPeopleCountDefine\']', '', '1', '', '51', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8898', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\'specialRemark\']', '', '1', '', '52', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8902', '输入需交订金', '1', '1', 'html.sendKeys', '需交订金', '//*[@id=\'payDepositDefine\']', '', '1', '', '56', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8906', '输入单房差', '1', '1', 'html.sendKeys', '单房差', '//*[@id=\'singleDiffDefine\']', '', '1', '', '60', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8911', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\'groupCode0\']', '', '3', '1_NO_0', '66', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8912', '获取团号并放入内存', '4', '1', 'html.getTextOrValue', '团号', '//*[@id=\'groupCode0\']', 'groupCode', '1', '', '67', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8914', '收集出团日期', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'groupOpenDate0\']', 'groupDate', '1', '', '69', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8915', '输入预收', '1', '1', 'html.sendKeys', '预收', '//*[@id=\'planPosition0\']', '', '1', '', '70', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8916', '输入余位', '1', '1', 'html.sendKeys', '余位', '//*[@id=\'freePosition0\']', '', '1', '', '71', '0', '641', '0');
INSERT INTO `t_element` VALUES ('8932', '输入产品名称', '1', '1', 'html.sendKeys', '产品名称', '//*[@id=\'acitivityName\']', '', '3', '1_Autotest-大客户_0', '2', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8933', '获取产品名称并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'acitivityName\']', 'productName', '1', '', '3', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8934', '输入出发城市', '1', '1', 'html.sendKeys', '出发城市', '//*[@id=\'oneStepContent\']/div[3]/span/input', 'DepartureCity', '1', '', '5', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8938', '检索目的地城市', '1', '1', 'html.sendKeys', '目的地城市', '//*[@id=\'key\']', '', '1', '', '9', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8947', '输入行程天数', '1', '1', 'html.sendKeys', '行程天数', '//*[@id=\'activityDuration\']', '', '1', '', '18', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8948', '输入领队', '1', '1', 'html.sendKeys', '领队', '//*[@id=\'groupLead\']', '', '1', '', '19', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8950', '输入订金占位天数', '1', '1', 'html.sendKeys', '订金占位天数', '//*[@id=\'remainDays_deposit\']', '', '1', '', '26', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8951', '输入订金占位小时', '1', '1', 'html.sendKeys', '订金占位小时', '//*[@id=\'remainDays_deposit_hour\']', '', '1', '', '27', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8952', '输入订金占位分钟', '1', '1', 'html.sendKeys', '订金占位分钟', '//*[@id=\'remainDays_deposit_fen\']', '', '1', '', '28', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8954', '输入预占位天', '1', '1', 'html.sendKeys', '预占位天', '//*[@id=\'remainDays_advance\']', '', '1', '', '30', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8955', '输入预占位小时', '1', '1', 'html.sendKeys', '预占位小时', '//*[@id=\'remainDays_advance_hour\']', '', '1', '', '31', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8956', '输入预占位分钟', '1', '1', 'html.sendKeys', '预占位分钟', '//*[@id=\'remainDays_advance_fen\']', '', '1', '', '32', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8966', '输入成人同行价', '1', '1', 'html.sendKeys', '成人同行价', '//*[@id=\'settlementAdultPriceDefine\']', '', '1', '', '42', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8970', '输入儿童同行价', '1', '1', 'html.sendKeys', '儿童同行价', '//*[@id=\'settlementcChildPriceDefine\']', '', '1', '', '46', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8974', '输入特殊人群同行价', '1', '1', 'html.sendKeys', '特殊人群同行价', '//*[@id=\'settlementSpecialPriceDefine\']', '', '1', '', '50', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8975', '输入特殊人群最高人数', '1', '1', 'html.sendKeys', '特殊人群最高人数', '//*[@id=\'maxPeopleCountDefine\']', '', '1', '', '51', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8976', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\'specialRemark\']', '', '1', '', '52', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8980', '输入需交订金', '1', '1', 'html.sendKeys', '需交订金', '//*[@id=\'payDepositDefine\']', '', '1', '', '56', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8984', '输入单房差', '1', '1', 'html.sendKeys', '单房差', '//*[@id=\'singleDiffDefine\']', '', '1', '', '60', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8989', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\'groupCode0\']', '', '3', '1_NO_0', '66', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8990', '获取团号并放入内存', '4', '1', 'html.getTextOrValue', '团号', '//*[@id=\'groupCode0\']', 'groupCode', '1', '', '67', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8991', '收集出团日期', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'groupOpenDate0\']', 'groupDate', '1', '', '68', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8992', '输入预收', '1', '1', 'html.sendKeys', '预收', '//*[@id=\'planPosition0\']', '', '1', '', '69', '0', '642', '0');
INSERT INTO `t_element` VALUES ('8993', '输入余位', '1', '1', 'html.sendKeys', '余位', '//*[@id=\'freePosition0\']', '', '1', '', '70', '0', '642', '0');
INSERT INTO `t_element` VALUES ('9031', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\'sea\']/div[2]/div[2]/div/div[2]/ul/li[1]/em', '', '2', 'groupCode', '9', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9032', '输入成人人数', '1', '1', 'html.sendKeys', '成人人数', '//*[@id=\'orderPersonNumAdult\']', '', '1', '', '11', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9033', '输入儿童人数', '1', '1', 'html.sendKeys', '儿童人数', '//*[@id=\'orderPersonNumChild\']', '', '1', '', '13', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9034', '输入特殊人群人数', '1', '1', 'html.sendKeys', '特殊人群人数', '//*[@id=\'orderPersonNumSpecial\']', '', '1', '', '15', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9035', '输入非签约渠道名称', '1', '1', 'html.sendKeys', '非签约渠道名称', '//*[@id=\'orderCompanyNameShow\']', '', '1', '', '16', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9036', '输入渠道联系人', '1', '1', 'html.sendKeys', '渠道联系人', '//*[@id=\'orderpersonMes\']/li[1]/input', '', '1', '', '17', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9037', '输入渠道联系人电话', '1', '1', 'html.sendKeys', '渠道联系人电话', '//*[@id=\'orderpersonMes\']/li[2]/input', '', '1', '', '18', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9041', '收集订单总同行价', '1', '1', 'html.gatherData', '订单总同行价', '//*[@id=\'travelerSumPrice\']', '', '1', '', '22', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9042', '收集订单总结算价', '1', '1', 'html.gatherData', '订单总结算价', '//*[@id=\'travelerSumClearPrice\']', '', '1', '', '23', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9043', '输入特殊需求', '1', '1', 'html.sendKeys', '特殊需求', '//*[@id=\'specialDemand\']', '', '1', '', '24', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9047', '输入游客姓名', '1', '1', 'html.sendKeys', '游客姓名', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[1]/ul[1]/li[1]/input', 'travelerFlag', '1', '', '3', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9048', '输入英文姓名', '1', '1', 'html.sendKeys', '英文姓名', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[1]/ul[1]/li[2]/input', 'travelerFlag', '1', '', '4', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9051', '输入出生日期', '1', '1', 'html.sendKeys', '出生日期', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[1]/ul[1]/li[5]/input', 'travelerFlag', '1', '', '7', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9052', '输入联系电话', '1', '1', 'html.sendKeys', '联系电话', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[1]/ul[1]/li[6]/input', 'travelerFlag', '1', '', '8', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9054', '输入住几晚', '1', '1', 'html.sendKeys', '住几晚', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[2]/div[1]/div[2]/ul/li[2]/input[2]', 'travelerFlag', '1', '', '10', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9055', '收集单人同行价', '1', '1', 'html.gatherData', '单人同行价', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[2]/div[4]/div[1]/span', 'travelerFlag', '1', '', '11', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9056', '收集单人结算价', '1', '1', 'html.gatherData', '单人结算价', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[2]/div[4]/div[3]/span/span/input[2]', 'travelerFlag', '1', '', '12', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9057', '收集订单总同行价', '1', '1', 'html.gatherData', '订单总同行价', '//*[@id=\'travelerSumPrice\']', '', '1', '', '13', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9058', '收集订单总结算价', '1', '1', 'html.gatherData', '订单总结算价', '//*[@id=\'travelerSumClearPrice\']', '', '1', '', '14', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9060', '输入个人返佣', '1', '1', 'html.sendKeys', '个人返佣', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[2]/div[1]/div[4]/div/input', 'travelerFlag', '1', '', '16', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9063', '输入其他费用名称', '1', '1', 'html.sendKeys', '其他费用名称', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[2]/div[1]/div[6]/div/div/input[2]', 'travelerFlag', '1', '', '19', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9064', '输入其他费用金额', '1', '1', 'html.sendKeys', '其他费用金额', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[2]/div[1]/div[6]/div/div/input[3]', 'travelerFlag', '1', '', '20', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9065', '收集单人同行价', '1', '1', 'html.gatherData', '其他费用后单人同行价', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[2]/div[4]/div[1]/span', 'travelerFlag', '1', '', '21', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9066', '收集单人结算价', '1', '1', 'html.gatherData', '其他费用后单人结算价', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[2]/div[4]/div[3]/span/span/input[2]', 'travelerFlag', '1', '', '22', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9067', '收集订单总同行价', '1', '1', 'html.gatherData', '其他费用用后订单总同行价', '//*[@id=\'travelerSumPrice\']', '', '1', '', '23', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9068', '收集订单总结算价', '1', '1', 'html.gatherData', '其他费用后订单总结算价', '//*[@id=\'travelerSumClearPrice\']', '', '1', '', '24', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9069', '输入单人结算价', '1', '1', 'html.sendKeys', '单人结算价', '//*[@id=\'traveler\']/form[?]/div/div[2]/div/div[2]/div[4]/div[3]/span/span/input[2]', 'travelerFlag', '1', '', '25', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9070', '收集订单总同行价', '1', '1', 'html.gatherData', '结算价后订单总同行价', '//*[@id=\'travelerSumPrice\']', '', '1', '', '26', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9071', '收集订单总结算价', '1', '1', 'html.gatherData', '结算价后订单总结算价', '//*[@id=\'travelerSumClearPrice\']', '', '1', '', '27', '0', '644', '0');
INSERT INTO `t_element` VALUES ('9076', '输入团队返佣金额', '1', '1', 'html.sendKeys', '团队返佣金额', '//*[@id=\'rebatesMoney\']', '', '1', '', '29', '0', '643', '0');
INSERT INTO `t_element` VALUES ('9082', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"orderNumOrGroupCode\"]', '', '2', 'orderCode', '4', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9083', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[1]/td[1]/span', '', '2', 'groupCode', '10', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9084', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[1]/td[2]/a', '', '2', 'productName', '11', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9085', '收集出团日期', '1', '1', 'html.gatherData', '出团日期', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[1]/td[4]/div[1]', '', '2', 'groupDate', '12', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9086', '收集余位', '1', '1', 'html.gatherData', '余位', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[1]/td[5]/div[1]', '', '1', '', '13', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9087', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[2]', '', '2', 'orderCode', '14', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9088', '收集人数并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[5]', 'amount', '1', '', '16', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9089', '收集订单总额', '1', '1', 'html.gatherData', '订单总额', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[9]/span/span', '', '1', '', '17', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9090', '收集已付金额', '1', '1', 'html.gatherData', '已付金额', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[10]/div[1]/span', '', '1', '', '18', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9091', '收集人数', '1', '1', 'html.gatherData', '人数', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[5]', '', '1', '', '15', '0', '259', '0');
INSERT INTO `t_element` VALUES ('9097', '输入费用名称', '1', '1', 'html.sendKeys', '费用名称', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[1]/input', '', '1', '', '6', '0', '272', '0');
INSERT INTO `t_element` VALUES ('9099', '输入数量', '1', '1', 'html.sendKeys', '数量', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[3]/input', '', '1', '', '8', '0', '272', '0');
INSERT INTO `t_element` VALUES ('9100', '输入单价', '1', '1', 'html.sendKeys', '单价', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[4]/input', '', '1', '', '9', '0', '272', '0');
INSERT INTO `t_element` VALUES ('9104', '输入费用名称', '1', '1', 'html.sendKeys', '费用名称', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[1]/input', '', '1', '', '6', '0', '351', '0');
INSERT INTO `t_element` VALUES ('9106', '输入数量', '1', '1', 'html.sendKeys', '数量', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[3]/input', '', '1', '', '8', '0', '351', '0');
INSERT INTO `t_element` VALUES ('9107', '输入单价', '1', '1', 'html.sendKeys', '单价', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[4]/input', '', '1', '', '9', '0', '351', '0');
INSERT INTO `t_element` VALUES ('9111', '输入费用名称', '1', '1', 'html.sendKeys', '费用名称', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[1]/input', '', '1', '', '6', '0', '365', '0');
INSERT INTO `t_element` VALUES ('9113', '输入数量', '1', '1', 'html.sendKeys', '数量', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[3]/input', '', '1', '', '8', '0', '365', '0');
INSERT INTO `t_element` VALUES ('9114', '输入单价', '1', '1', 'html.sendKeys', '单价', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[4]/input', '', '1', '', '9', '0', '365', '0');
INSERT INTO `t_element` VALUES ('9118', '输入费用名称', '1', '1', 'html.sendKeys', '费用名称', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[1]/input', '', '1', '', '6', '0', '393', '0');
INSERT INTO `t_element` VALUES ('9120', '输入数量', '1', '1', 'html.sendKeys', '数量', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[3]/input', '', '1', '', '8', '0', '393', '0');
INSERT INTO `t_element` VALUES ('9121', '输入单价', '1', '1', 'html.sendKeys', '单价', '//*[@id=\"jbox-content\"]/div/table/tbody/tr/td[4]/input', '', '1', '', '9', '0', '393', '0');
INSERT INTO `t_element` VALUES ('9125', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"groupCode\"]', '', '2', 'orderCode', '3', '0', '645', '0');
INSERT INTO `t_element` VALUES ('9133', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"denyReason\"]', '', '1', '', '5', '0', '646', '0');
INSERT INTO `t_element` VALUES ('9146', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"wholeSalerKey\"]', '', '2', 'orderCode', '3', '0', '649', '0');
INSERT INTO `t_element` VALUES ('9154', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"denyReason\"]', '', '1', '', '5', '0', '650', '0');
INSERT INTO `t_element` VALUES ('9163', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"denyReason\"]', '', '1', '', '7', '0', '527', '0');
INSERT INTO `t_element` VALUES ('9173', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//td[text()=\'订单编号：\']/following-sibling::td[1]', '', '2', 'orderCode', '3', '0', '654', '0');
INSERT INTO `t_element` VALUES ('9174', '收集团号', '1', '1', 'html.gatherData', '团号', '//td[text()=\'订单团号：\']/following-sibling::td[1]', '', '2', 'groupCode', '4', '0', '654', '0');
INSERT INTO `t_element` VALUES ('9175', '收集订单总额', '1', '1', 'html.gatherData', '订单总额', '//td[text()=\'订单总额：\']/following-sibling::td[1]', '', '1', '', '5', '0', '654', '0');
INSERT INTO `t_element` VALUES ('9176', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\'sea\']/div[2]/div[2]/div/div[5]/p', '', '2', 'productName', '6', '0', '654', '0');
INSERT INTO `t_element` VALUES ('9177', '第几个人借款', '1', '1', 'html.sendKeys', '第几个人借款', '', '', '1', '', '1', '0', '655', '0');
INSERT INTO `t_element` VALUES ('9179', '输入借款金额', '1', '1', 'html.sendKeys', '借款金额', '//*[@id=\'contentTable\']/tbody/tr[?]/td[4]/dl/dt/input', 'borrowFlag', '1', '', '3', '0', '655', '0');
INSERT INTO `t_element` VALUES ('9180', '输入借款备注', '1', '1', 'html.sendKeys', '借款备注', '//*[@id=\'contentTable\']/tbody/tr[?]/td[5]/input', 'borrowFlag', '1', '', '4', '0', '655', '0');
INSERT INTO `t_element` VALUES ('9182', '输入还款日期', '1', '1', 'html.sendKeys', '还款日期', '//*[@id=\'refundDate\']', '', '3', '2_1_5', '8', '0', '654', '0');
INSERT INTO `t_element` VALUES ('9191', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//td[text()=\'订单编号：\']/following-sibling::td[1]', '', '2', 'orderCode', '3', '0', '657', '0');
INSERT INTO `t_element` VALUES ('9192', '收集团号', '1', '1', 'html.gatherData', '团号', '//td[text()=\'订单团号：\']/following-sibling::td[1]', '', '2', 'groupCode', '4', '0', '657', '0');
INSERT INTO `t_element` VALUES ('9193', '收集订单总额', '1', '1', 'html.gatherData', '订单总额', '//td[text()=\'订单总额：\']/following-sibling::td[1]', '', '1', '', '5', '0', '657', '0');
INSERT INTO `t_element` VALUES ('9194', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\'sea\']/div[2]/div[2]/div/div[5]/p', '', '2', 'productName', '6', '0', '657', '0');
INSERT INTO `t_element` VALUES ('9195', '退款游客姓名', '1', '1', 'html.sendKeys', '退款游客姓名', '', '', '1', '', '1', '0', '658', '0');
INSERT INTO `t_element` VALUES ('9198', '输入退款款项', '1', '1', 'html.sendKeys', '退款款项', '//span[contains(text(),\'?\')]/parent::td/following-sibling::td[1]/table//tr[1]/td[1]/input[1]', 'refundFlag', '1', '', '4', '0', '658', '0');
INSERT INTO `t_element` VALUES ('9199', '输入退款金额', '1', '1', 'html.sendKeys', '退款金额', '//span[contains(text(),\'?\')]/parent::td/following-sibling::td[1]/table//tr[1]/td[4]/input[1]', 'refundFlag', '1', '', '5', '0', '658', '0');
INSERT INTO `t_element` VALUES ('9200', '输入备注', '1', '1', 'html.sendKeys', '备注', '//span[contains(text(),\'?\')]/parent::td/following-sibling::td[1]/table//tr[1]/td[5]/input[1]', 'refundFlag', '1', '', '6', '0', '658', '0');
INSERT INTO `t_element` VALUES ('9207', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCodeOrActSer\"]', '', '2', 'groupCode', '3', '0', '659', '0');
INSERT INTO `t_element` VALUES ('9217', '输入渠道', '1', '1', 'html.sendKeys', '渠道', '//*[@id=\"jbox-content\"]/div/p[1]/span/input', '', '1', '', '3', '0', '660', '0');
INSERT INTO `t_element` VALUES ('9222', '输入成人人数', '1', '1', 'html.sendKeys', '成人人数', '//*[@id=\"orderPersonNumAdult\"]', '', '1', '', '9', '0', '660', '0');
INSERT INTO `t_element` VALUES ('9223', '输入儿童人数', '1', '1', 'html.sendKeys', '儿童人数', '//*[@id=\"orderPersonNumChild\"]', '', '1', '', '10', '0', '660', '0');
INSERT INTO `t_element` VALUES ('9224', '输入特殊人群人数', '1', '1', 'html.sendKeys', '特殊人群人数', '//*[@id=\"orderPersonNumSpecial\"]', '', '1', '', '11', '0', '660', '0');
INSERT INTO `t_element` VALUES ('9227', '输入特殊需求', '1', '1', 'html.sendKeys', '特殊需求', '//*[@id=\"specialDemand\"]', '', '1', '', '15', '0', '660', '0');
INSERT INTO `t_element` VALUES ('9231', '输入姓名', '1', '1', 'html.sendKeys', '姓名', '//*[@id=\"traveler\"]/form[?]/div/div[2]/div[1]/ul/li[1]/input', 'travelerFlag', '1', '', '4', '0', '661', '0');
INSERT INTO `t_element` VALUES ('9235', '输入预计团队返佣', '1', '1', 'html.sendKeys', '预计团队返佣', '//*[@id=\"manageOrder_new\"]/div[5]/form/input', '', '1', '', '17', '0', '660', '0');
INSERT INTO `t_element` VALUES ('9244', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"orderNumOrOrderGroupCode\"]', '', '2', 'orderCode', '2', '0', '662', '0');
INSERT INTO `t_element` VALUES ('9251', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//*[@id=\"sea\"]/div[2]/div[2]/div/div[1]/div[2]/div[2]/table[1]/tbody/tr[2]/td[2]', '', '2', 'orderCode', '3', '0', '664', '0');
INSERT INTO `t_element` VALUES ('9253', '修改成人人数', '1', '1', 'html.sendKeys', '成人人数', '//*[@id=\"orderPersonNumAdult\"]', '', '1', '', '3', '0', '665', '0');
INSERT INTO `t_element` VALUES ('9254', '修改儿童人数', '1', '1', 'html.sendKeys', '儿童人数', '//*[@id=\"orderPersonNumChild\"]', '', '1', '', '4', '0', '665', '0');
INSERT INTO `t_element` VALUES ('9255', '修改特殊人群人数', '1', '1', 'html.sendKeys', '特殊人群人数', '//*[@id=\"orderPersonNumSpecial\"]', '', '1', '', '5', '0', '665', '0');
INSERT INTO `t_element` VALUES ('9256', '添加第几个游客', '1', '1', 'html.sendKeys', '第几个游客', '', '', '1', '', '2', '0', '661', '0');
INSERT INTO `t_element` VALUES ('9259', '修改第几个游客', '1', '1', 'html.sendKeys', '第几个游客', '', '', '1', '', '1', '0', '666', '0');
INSERT INTO `t_element` VALUES ('9262', '修改姓名', '1', '1', 'html.sendKeys', '姓名', '//*[@id=\"traveler\"]/form[?]/div/div[2]/div[1]/ul/li[1]/input', 'editFlag', '1', '', '4', '0', '666', '0');
INSERT INTO `t_element` VALUES ('9266', '修改预计团队返佣', '1', '1', 'html.sendKeys', '预计团队返佣', '//*[@id=\"manageOrder_new\"]/div[5]/form/input', '', '1', '', '8', '0', '665', '0');
INSERT INTO `t_element` VALUES ('9276', '第几个游客改价', '1', '1', 'html.sendKeys', '第几个游客', '', '', '1', '', '1', '0', '669', '0');
INSERT INTO `t_element` VALUES ('9279', '输入改后应收价', '1', '1', 'html.sendKeys', '改后应收价', '//tr[?]/td[6]//input[1]', 'changePriceFlag', '1', '', '4', '0', '669', '0');
INSERT INTO `t_element` VALUES ('9280', '输入备注', '1', '1', 'html.sendKeys', '备注', '//tr[?]/td[7]/textarea', 'changePriceFlag', '1', '', '5', '0', '669', '0');
INSERT INTO `t_element` VALUES ('9294', '第几个游客退票', '1', '1', 'html.sendKeys', '第几个游客', '', '', '1', '', '1', '0', '672', '0');
INSERT INTO `t_element` VALUES ('9297', '输入退票原因', '1', '1', 'html.sendKeys', '退票原因', '//tr[?]/td[5]/input', 'quitFlag', '1', '', '4', '0', '672', '0');
INSERT INTO `t_element` VALUES ('9309', '第几个游客返佣', '1', '1', 'html.sendKeys', '第几个游客', '', '', '1', '', '1', '0', '675', '0');
INSERT INTO `t_element` VALUES ('9312', '输入款项', '1', '1', 'html.sendKeys', '款项', '//tr[?]/td[3]/input', 'fanyongFlag', '1', '', '4', '0', '675', '0');
INSERT INTO `t_element` VALUES ('9313', '输入返佣金额', '1', '1', 'html.sendKeys', '返佣金额', '//tr[?]/td[6]/dl/dt/input', 'fanyongFlag', '1', '', '5', '0', '675', '0');
INSERT INTO `t_element` VALUES ('9315', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"remarks\"]', '', '1', '', '5', '0', '674', '0');
INSERT INTO `t_element` VALUES ('9324', '第几个游客借款', '1', '1', 'html.sendKeys', '第几个游客', '', '', '1', '', '1', '0', '678', '0');
INSERT INTO `t_element` VALUES ('9327', '输入借款金额', '1', '1', 'html.sendKeys', '借款金额', '//tr[?]/td[4]/dl/dt/input', 'borrowFlag', '1', '', '4', '0', '678', '0');
INSERT INTO `t_element` VALUES ('9328', '输入备注', '1', '1', 'html.sendKeys', '备注', '//tr[?]/td[5]/input', 'borrowFlag', '1', '', '5', '0', '678', '0');
INSERT INTO `t_element` VALUES ('9330', '输入还款日期', '1', '1', 'html.sendKeys', '还款日期', '//*[@id=\"refundDate\"]', '', '3', '2_1_10', '4', '0', '677', '0');
INSERT INTO `t_element` VALUES ('9331', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"borrowRemark\"]', '', '1', '', '5', '0', '677', '0');
INSERT INTO `t_element` VALUES ('9335', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"orderNumOrOrderGroupCode\"]', '', '2', 'orderCode', '2', '0', '679', '0');
INSERT INTO `t_element` VALUES ('9375', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"orderNumOrGroupCode\"]', '', '2', 'orderCode', '5', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9380', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[1]/td[1]/span', '', '2', 'groupCode', '8', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9381', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[1]/td[2]/a', '', '2', 'productName', '9', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9382', '收集出团日期', '1', '1', 'html.gatherData', '出团日期', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[1]/td[4]/div[1]', '', '2', 'groupDate', '10', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9383', '收集余位', '1', '1', 'html.gatherData', '余位', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[1]/td[5]/div[1]', '', '1', '', '11', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9384', '收集订单号', '1', '1', 'html.gatherData', '订单号', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[2]', '', '2', 'orderCode', '12', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9385', '收集人数', '1', '1', 'html.gatherData', '人数', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[5]', '', '1', '', '13', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9386', '收集人数并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[5]', 'amount', '1', '', '14', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9387', '收集订单总额', '1', '1', 'html.gatherData', '订单总额', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[9]/span/span', '', '1', '', '15', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9388', '收集已付金额', '1', '1', 'html.gatherData', '已付金额', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[10]/div[1]/span', '', '1', '', '16', '0', '691', '0');
INSERT INTO `t_element` VALUES ('9425', '输入开收据抬头', '1', '1', 'html.sendKeys', '开收据抬头', '//p[contains(text(),\"开收据抬头\")]/following-sibling::p/input', '', '1', '', '5', '0', '701', '0');
INSERT INTO `t_element` VALUES ('9426', '输入开收据客户', '1', '1', 'html.sendKeys', '开收据客户', '//p[contains(text(),\"开收据客户\")]/following-sibling::p/span/input', '', '1', '', '6', '0', '701', '0');
INSERT INTO `t_element` VALUES ('9429', '输入本次开收据金额', '1', '1', 'html.sendKeys', '本次开收据金额', '//*[@id=\"sea\"]/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '9', '0', '701', '0');
INSERT INTO `t_element` VALUES ('9430', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div[6]/p[2]/textarea', '', '1', '', '10', '0', '701', '0');
INSERT INTO `t_element` VALUES ('9443', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '3', '0', '704', '0');
INSERT INTO `t_element` VALUES ('9450', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '3', '0', '705', '0');
INSERT INTO `t_element` VALUES ('9636', '输入开收据抬头', '1', '1', 'html.sendKeys', '开收据抬头', '//p[contains(text(),\"开收据抬头\")]/following-sibling::p/input', '', '1', '', '6', '0', '709', '0');
INSERT INTO `t_element` VALUES ('9637', '输入开收据客户', '1', '1', 'html.sendKeys', '开收据客户', '//p[contains(text(),\"开收据客户\")]/following-sibling::p/span/input', '', '1', '', '7', '0', '709', '0');
INSERT INTO `t_element` VALUES ('9640', '输入本次开收据金额', '1', '1', 'html.sendKeys', '本次开收据金额', '//*[@id=\"sea\"]/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '10', '0', '709', '0');
INSERT INTO `t_element` VALUES ('9641', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div[6]/p[2]/textarea', '', '1', '', '11', '0', '709', '0');
INSERT INTO `t_element` VALUES ('9663', '第几个游客退款', '1', '1', 'html.sendKeys', '第几个游客', '', '', '1', '', '1', '0', '714', '0');
INSERT INTO `t_element` VALUES ('9665', '输入退款款项', '1', '1', 'html.sendKeys', '退款款项', '//tr[?]//table//tr/td[1]/input', 'refundFlag', '1', '', '3', '0', '714', '0');
INSERT INTO `t_element` VALUES ('9667', '输入金额', '1', '1', 'html.sendKeys', '金额', '//tr[?]//table//tr/td[4]/input', 'refundFlag', '1', '', '5', '0', '714', '0');
INSERT INTO `t_element` VALUES ('9668', '输入备注', '1', '1', 'html.sendKeys', '备注', '//tr[?]//table//tr/td[5]/input', 'refundFlag', '1', '', '6', '0', '714', '0');
INSERT INTO `t_element` VALUES ('9676', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '3', '0', '715', '0');
INSERT INTO `t_element` VALUES ('9685', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"reason\"]', '', '1', '', '5', '0', '716', '0');
INSERT INTO `t_element` VALUES ('9705', '输入出发时刻', '1', '1', 'html.sendKeys', '出发时刻', '//*[@id=\'frm1\']/div/div[1]/div[?]/div[5]/p[2]/input', 'moreFlag2', '3', '2_2_3', '19', '0', '717', '0');
INSERT INTO `t_element` VALUES ('9707', '输入到达时刻', '1', '1', 'html.sendKeys', '到达时刻', '//*[@id=\'frm1\']/div/div[1]/div[?]/div[6]/p[2]/input', 'moreFlag2', '3', '2_2_4', '21', '0', '717', '0');
INSERT INTO `t_element` VALUES ('9720', '第几个游客退款', '1', '1', 'html.sendKeys', '第几个游客', '', '', '1', '', '1', '0', '720', '0');
INSERT INTO `t_element` VALUES ('9723', '输入退款款项', '1', '1', 'html.sendKeys', '退款款项', '//tr[?]/td[3]/table//tr/td[1]/input', 'quitFlag', '1', '', '4', '0', '720', '0');
INSERT INTO `t_element` VALUES ('9725', '输入退款金额', '1', '1', 'html.sendKeys', '退款金额', '//tr[?]/td[3]/table//tr/td[4]/input', 'quitFlag', '1', '', '6', '0', '720', '0');
INSERT INTO `t_element` VALUES ('9726', '输入备注', '1', '1', 'html.sendKeys', '备注', '//tr[?]/td[3]/table//tr/td[5]/input', 'quitFlag', '1', '', '7', '0', '720', '0');
INSERT INTO `t_element` VALUES ('10002', '输入成人同行价', '1', '1', 'html.sendKeys', '成人同行价', '//*[@id=\'settlementAdultPriceDefine\']', '', '1', '', '9', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10006', '输入儿童同行价', '1', '1', 'html.sendKeys', '儿童同行价', '//*[@id=\'settlementcChildPriceDefine\']', '', '1', '', '13', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10010', '输入特殊人群同行价', '1', '1', 'html.sendKeys', '特殊人群同行价', '//*[@id=\'settlementSpecialPriceDefine\']', '', '1', '', '17', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10011', '输入特殊人群最高人数', '1', '1', 'html.sendKeys', '特殊人群最高人数', '//*[@id=\'maxPeopleCountDefine\']', '', '1', '', '18', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10012', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\'specialRemark\']', '', '1', '', '19', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10016', '输入需交订金', '1', '1', 'html.sendKeys', '需交订金', '//*[@id=\'payDepositDefine\']', '', '1', '', '23', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10020', '输入单房差', '1', '1', 'html.sendKeys', '单房差', '//*[@id=\'singleDiffDefine\']', '', '1', '', '27', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10025', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode?\"]', 'groupDateFlag', '3', '1_NO_0', '33', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10026', '获取团号并放入内存', '4', '1', 'html.getTextOrValue', '团号', '//*[@id=\'groupCode0\']', 'groupCode', '1', '', '34', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10028', '收集出团日期', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'groupOpenDate0\']', 'groupDate', '1', '', '35', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10029', '输入预收', '1', '1', 'html.sendKeys', '预收', '//*[@id=\"planPosition?\"]', 'groupDateFlag', '1', '', '36', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10030', '输入余位', '1', '1', 'html.sendKeys', '余位', '//*[@id=\"freePosition?\"]', 'groupDateFlag', '1', '', '37', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10046', '添加第几个团期', '1', '1', 'html.sendKeys', '第几个团期', '', '', '1', '', '3', '0', '724', '0');
INSERT INTO `t_element` VALUES ('10050', '输入产品名称', '1', '1', 'html.sendKeys', '产品名称', '//*[@id=\'acitivityName\']', '', '3', '1_Autotest-单团_0', '2', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10051', '获取产品名称并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'acitivityName\']', 'productName', '1', '', '3', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10052', '输入出发城市', '1', '1', 'html.sendKeys', '出发城市', '//*[@id=\'oneStepContent\']/div[3]/span/input', 'DepartureCity', '1', '', '5', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10056', '检索目的地城市', '1', '1', 'html.sendKeys', '目的地城市', '//*[@id=\'key\']', '', '1', '', '9', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10065', '输入行程天数', '1', '1', 'html.sendKeys', '行程天数', '//*[@id=\'activityDuration\']', '', '1', '', '18', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10066', '输入领队', '1', '1', 'html.sendKeys', '领队', '//*[@id=\'groupLead\']', '', '1', '', '19', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10068', '输入订金占位天数', '1', '1', 'html.sendKeys', '订金占位天数', '//*[@id=\'remainDays_deposit\']', '', '1', '', '21', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10069', '输入订金占位小时', '1', '1', 'html.sendKeys', '订金占位小时', '//*[@id=\'remainDays_deposit_hour\']', '', '1', '', '22', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10070', '输入订金占位分钟', '1', '1', 'html.sendKeys', '订金占位分钟', '//*[@id=\'remainDays_deposit_fen\']', '', '1', '', '23', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10072', '输入预占位天', '1', '1', 'html.sendKeys', '预占位天', '//*[@id=\'remainDays_advance\']', '', '1', '', '25', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10073', '输入预占位小时', '1', '1', 'html.sendKeys', '预占位小时', '//*[@id=\'remainDays_advance_hour\']', '', '1', '', '26', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10074', '输入预占位分钟', '1', '1', 'html.sendKeys', '预占位分钟', '//*[@id=\'remainDays_advance_fen\']', '', '1', '', '27', '0', '725', '0');
INSERT INTO `t_element` VALUES ('10142', '输入产品名称', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"wholeSalerKey\"]', '', '2', 'productName', '1', '10141', '22', '0');
INSERT INTO `t_element` VALUES ('10145', '收集订单号并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\"orderNumOrGroupCode\"]', 'orderCode', '1', '', '3', '0', '726', '0');
INSERT INTO `t_element` VALUES ('10148', '收集订单状态', '1', '1', 'html.gatherData', '订单状态', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[8]', '', '1', '', '7', '0', '726', '0');
INSERT INTO `t_element` VALUES ('10161', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"jbox-content\"]/div/textarea', '', '1', '', '5', '0', '728', '0');
INSERT INTO `t_element` VALUES ('10208', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '3', '1_NO_0', '2', '0', '197', '0');
INSERT INTO `t_element` VALUES ('10302', '输入产品名称', '1', '1', 'html.sendKeys', '产品名称', '//*[@id=\"acitivityName\"]', 'productName', '3', '1_AutoTest-散拼_0', '3', '0', '740', '0');
INSERT INTO `t_element` VALUES ('10303', '选择出发城市', '1', '1', 'html.sendKeys', '出发城市', '//*[@id=\'oneStepContent\']/div[3]/span/input', 'cfcs', '1', '', '5', '0', '740', '0');
INSERT INTO `t_element` VALUES ('10307', '输入目的地关键字', '1', '1', 'html.sendKeys', '目的地关键字', '//*[@id=\'key\']', '', '1', '', '9', '0', '740', '0');
INSERT INTO `t_element` VALUES ('10316', '输入行程天数', '1', '1', 'html.sendKeys', '行程天数', '//*[@id=\'activityDuration\']', '', '1', '', '18', '0', '740', '0');
INSERT INTO `t_element` VALUES ('10401', '输入成人同行价', '1', '1', 'html.sendKeys', '成人同行价', '//*[@id=\'settlementAdultPriceDefine\']', '', '1', '', '7', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10405', '输入儿童同行价', '1', '1', 'html.sendKeys', '儿童同行价', '//*[@id=\'settlementcChildPriceDefine\']', '', '1', '', '11', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10409', '输入特殊人群同行价', '1', '1', 'html.sendKeys', '特殊人群同行价', '//*[@id=\'settlementSpecialPriceDefine\']', '', '1', '', '15', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10410', '输入特殊人群人数', '1', '1', 'html.sendKeys', '特殊人群人数', '//*[@id=\'maxPeopleCountDefine\']', '', '1', '', '16', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10414', '输入成人直客价', '1', '1', 'html.sendKeys', '成人直客价', '//*[@id=\'suggestAdultPriceDefine\']', '', '1', '', '20', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10418', '输入儿童直客价', '1', '1', 'html.sendKeys', '儿童直客价', '//*[@id=\'suggestChildPriceDefine\']', '', '1', '', '24', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10422', '输入特殊人群直客价', '1', '1', 'html.sendKeys', '特殊人群直客价', '//*[@id=\'suggestSpecialPriceDefine\']', '', '1', '', '28', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10426', '输入需交定金', '1', '1', 'html.sendKeys', '需交定金', '//*[@id=\'payDepositDefine\']', '', '1', '', '32', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10430', '输入单房差', '1', '1', 'html.sendKeys', '单房差', '//*[@id=\'singleDiffDefine\']', '', '1', '', '36', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10433', '获取出团日期并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\'groupOpenDate0\']', 'groupDate', '1', '', '39', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10436', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode?\"]', 'groupDateFlag', '3', '1_peggy_0', '42', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10437', '获取团号', '4', '1', 'html.getTextOrValue', '团号', '//*[@id=\"groupCode0\"]', 'groupCode', '1', '', '43', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10438', '输入预收人数', '1', '1', 'html.sendKeys', '预收', '//*[@id=\"planPosition?\"]', 'groupDateFlag', '1', '', '44', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10439', '输入余位', '1', '1', 'html.sendKeys', '余位', '//*[@id=\"freePosition?\"]', 'groupDateFlag', '1', '', '46', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10458', '添加第几个团期', '1', '1', 'html.sendKeys', '第几个团期', '', '', '1', '', '1', '0', '741', '0');
INSERT INTO `t_element` VALUES ('10460', '搜索内输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"wholeSalerKey\"]', '', '2', 'groupCode', '2', '0', '36', '0');
INSERT INTO `t_element` VALUES ('10463', '输入产品名称', '1', '1', 'html.sendKeys', '产品名称', '//*[@id=\"wholeSalerKey\"]', '', '2', 'productName', '1', '10462', '36', '0');
INSERT INTO `t_element` VALUES ('10476', '获取产品名称并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\"acitivityName\"]', 'productName', '1', '', '4', '0', '740', '0');
INSERT INTO `t_element` VALUES ('10490', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"nameCode\"]', '', '2', 'groupCode', '3', '0', '742', '0');
INSERT INTO `t_element` VALUES ('10499', '输入成人策略数', '1', '1', 'html.sendKeys', '成人策略数', '//*[@id=\"adultPricingStrategy\"]/div/input', '', '1', '', '5', '0', '743', '0');
INSERT INTO `t_element` VALUES ('10503', '输入儿童策略数', '1', '1', 'html.sendKeys', '儿童策略数', '//*[@id=\"childPricingStrategy\"]/div/input', '', '1', '', '7', '0', '743', '0');
INSERT INTO `t_element` VALUES ('10506', '输入特殊人群策略数', '1', '1', 'html.sendKeys', '特殊人群策略数', '//*[@id=\"specialPricingStrategy\"]/div/input', '', '1', '', '9', '0', '743', '0');
INSERT INTO `t_element` VALUES ('10514', '输入cd渠道', '1', '1', 'html.sendKeys', 'cd渠道', '//label[contains(text(),\"渠道选择\")]/following-sibling::span[2]/input[1]', '', '1', '', '1', '10513', '45', '0');
INSERT INTO `t_element` VALUES ('10526', '收集订单号并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\"orderNumOrGroupCode\"]', 'orderCode', '1', '', '3', '0', '744', '0');
INSERT INTO `t_element` VALUES ('10530', '收集订单状态', '1', '1', 'html.gatherData', '订单状态', '//*[@id=\"orderOrGroup_group_tbody\"]/tr[2]/td/table/tbody/tr[1]/td[9]', '', '1', '', '7', '0', '744', '0');
INSERT INTO `t_element` VALUES ('10533', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"wholeSalerKey\"]', '', '2', 'groupCode', '5', '0', '745', '0');
INSERT INTO `t_element` VALUES ('10541', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\"sea\"]/div[1]/div[2]/div/div[2]/div[2]/div/span', '', '2', 'productName', '2', '0', '746', '0');
INSERT INTO `t_element` VALUES ('10545', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\"sea\"]/div[1]/div[2]/div/div[2]/div[2]/div/span', '', '2', 'productName', '2', '0', '747', '0');
INSERT INTO `t_element` VALUES ('10548', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\"sea\"]/div[1]/div[2]/div/div[2]/div[2]/div/span', '', '2', 'productName', '2', '0', '748', '0');
INSERT INTO `t_element` VALUES ('10551', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\"sea\"]/div[1]/div[2]/div/div[2]/div[2]/div/span', '', '2', 'productName', '2', '0', '749', '0');
INSERT INTO `t_element` VALUES ('10554', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\"sea\"]/div[1]/div[2]/div/div[2]/div[2]/div/span', '', '2', 'productName', '2', '0', '750', '0');
INSERT INTO `t_element` VALUES ('10558', '收集产品名称', '1', '1', 'html.gatherData', '产品名称', '//*[@id=\"sea\"]/div[1]/div[2]/div/div[2]/div[2]/div/span', '', '2', 'productName', '2', '0', '751', '0');
INSERT INTO `t_element` VALUES ('10568', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '7', '0', '752', '0');
INSERT INTO `t_element` VALUES ('10587', '输入发票抬头', '1', '1', 'html.sendKeys', '发票抬头', '//p[text()=\"发票抬头：\"]//following-sibling::p/input', '', '1', '', '6', '0', '755', '0');
INSERT INTO `t_element` VALUES ('10589', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//p[text()=\"来款单位：\"]//following-sibling::p/input', '', '1', '', '8', '0', '755', '0');
INSERT INTO `t_element` VALUES ('10590', '输入本次开票金额', '1', '1', 'html.sendKeys', '本次开票金额', '//*[@id=\"sea\"]/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '9', '0', '755', '0');
INSERT INTO `t_element` VALUES ('10591', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div[6]/p[2]/textarea', '', '1', '', '10', '0', '755', '0');
INSERT INTO `t_element` VALUES ('10610', '输入发票抬头', '1', '1', 'html.sendKeys', '发票抬头', '//p[text()=\"发票抬头：\"]//following-sibling::p/input', '', '1', '', '6', '0', '757', '0');
INSERT INTO `t_element` VALUES ('10612', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//p[text()=\"来款单位：\"]//following-sibling::p/input', '', '1', '', '8', '0', '757', '0');
INSERT INTO `t_element` VALUES ('10613', '输入本次开票金额', '1', '1', 'html.sendKeys', '本次开票金额', '//*[@id=\"sea\"]/div/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '9', '0', '757', '0');
INSERT INTO `t_element` VALUES ('10614', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div/div[5]/p[2]/textarea', '', '1', '', '10', '0', '757', '0');
INSERT INTO `t_element` VALUES ('10621', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"nameCode\"]', '', '2', 'groupCode', '3', '0', '758', '0');
INSERT INTO `t_element` VALUES ('10624', '输入成人直减', '1', '1', 'html.sendKeys', '成人直减', '//*[@id=\"adultPricingStrategy\"]/div/input', '', '1', '100', '9', '0', '758', '0');
INSERT INTO `t_element` VALUES ('10636', '首页输入搜索', '1', '1', 'html.sendKeys', '搜索输入框', '//*[@id=\"keywords\"]', '', '2', 'groupCode', '2', '0', '759', '0');
INSERT INTO `t_element` VALUES ('10642', '利润计算输入成人实际结算价', '1', '1', 'html.sendKeys', '成人实际结算价', '//*[@id=\"adult_money\"]', '', '1', '1009', '9', '0', '759', '0');
INSERT INTO `t_element` VALUES ('10643', '利润计算输入成人人数', '1', '1', 'html.sendKeys', '成人人数', '//*[@id=\"adult\"]', '', '1', '1', '10', '0', '759', '0');
INSERT INTO `t_element` VALUES ('10651', '搜索输入框', '1', '1', 'html.sendKeys', '搜索输入框', '//input[@id=\"fuzzySearch\"]', '', '2', 'acitivityName', '23', '0', '759', '0');
INSERT INTO `t_element` VALUES ('10652', '收集数据', '1', '1', 'html.gatherData', '收集数据', '//a[text()=\"详情\"]/preceding::span[1]', '', '1', '待处理', '26', '0', '759', '0');
INSERT INTO `t_element` VALUES ('10660', '获取产品名称', '4', '1', 'html.getTextOrValue', '', '//input[@id=\"acitivityName\"]', 'acitivityName', '1', '', '4', '0', '556', '0');
INSERT INTO `t_element` VALUES ('10664', '搜索输入框', '1', '1', 'html.sendKeys', '搜索输入框', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '3', '0', '761', '0');
INSERT INTO `t_element` VALUES ('10670', '收款总额', '1', '1', 'html.gatherData', '收款总额', '//*[text()=\"收款总额：\"]/following::span[1]', '', '1', '人民币1,009.00', '12', '0', '761', '0');
INSERT INTO `t_element` VALUES ('10698', '输入发票抬头', '1', '1', 'html.sendKeys', '发票抬头', '//p[text()=\"发票抬头：\"]//following-sibling::p/input', '', '1', '', '6', '0', '763', '0');
INSERT INTO `t_element` VALUES ('10700', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//p[text()=\"来款单位：\"]//following-sibling::p/input', '', '1', '', '8', '0', '763', '0');
INSERT INTO `t_element` VALUES ('10701', '输入本次开票金额', '1', '1', 'html.sendKeys', '本次开票金额', '//*[@id=\"sea\"]/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '9', '0', '763', '0');
INSERT INTO `t_element` VALUES ('10702', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div[6]/p[2]/textarea', '', '1', '', '10', '0', '763', '0');
INSERT INTO `t_element` VALUES ('10720', '输入发票抬头', '1', '1', 'html.sendKeys', '发票抬头', '//p[text()=\"发票抬头：\"]//following-sibling::p/input', '', '1', '', '6', '0', '765', '0');
INSERT INTO `t_element` VALUES ('10722', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//p[text()=\"来款单位：\"]//following-sibling::p/input', '', '1', '', '8', '0', '765', '0');
INSERT INTO `t_element` VALUES ('10723', '输入本次开票金额', '1', '1', 'html.sendKeys', '本次开票金额', '//*[@id=\"sea\"]/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '9', '0', '765', '0');
INSERT INTO `t_element` VALUES ('10724', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div[6]/p[2]/textarea', '', '1', '', '10', '0', '765', '0');
INSERT INTO `t_element` VALUES ('10742', '输入发票抬头', '1', '1', 'html.sendKeys', '发票抬头', '//p[text()=\"发票抬头：\"]//following-sibling::p/input', '', '1', '', '6', '0', '767', '0');
INSERT INTO `t_element` VALUES ('10744', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//p[text()=\"来款单位：\"]//following-sibling::p/input', '', '1', '', '8', '0', '767', '0');
INSERT INTO `t_element` VALUES ('10745', '输入本次开票金额', '1', '1', 'html.sendKeys', '本次开票金额', '//*[@id=\"sea\"]/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '9', '0', '767', '0');
INSERT INTO `t_element` VALUES ('10746', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div[6]/p[2]/textarea', '', '1', '', '10', '0', '767', '0');
INSERT INTO `t_element` VALUES ('10767', '输入发票抬头', '1', '1', 'html.sendKeys', '发票抬头', '//p[text()=\"发票抬头：\"]//following-sibling::p/input', '', '1', '', '6', '0', '769', '0');
INSERT INTO `t_element` VALUES ('10769', '输入来款单位', '1', '1', 'html.sendKeys', '来款单位', '//p[text()=\"来款单位：\"]//following-sibling::p/input', '', '1', '', '8', '0', '769', '0');
INSERT INTO `t_element` VALUES ('10770', '输入本次开票金额', '1', '1', 'html.sendKeys', '本次开票金额', '//*[@id=\"sea\"]/div[3]/div/table[2]/tbody/tr/td[6]/input', '', '1', '', '9', '0', '769', '0');
INSERT INTO `t_element` VALUES ('10771', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"sea\"]/div[6]/p[2]/textarea', '', '1', '', '10', '0', '769', '0');
INSERT INTO `t_element` VALUES ('10778', '收集总金额', '1', '1', 'html.gatherData', '总金额', '//td[text()=\"现金支付\"]/following::span[2]', '', '1', '909.00', '25', '0', '761', '0');
INSERT INTO `t_element` VALUES ('10781', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"groupCode\"]', '', '2', 'groupCode', '3', '0', '770', '0');
INSERT INTO `t_element` VALUES ('10795', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"textfield\"]', '', '1', '', '5', '0', '771', '0');
INSERT INTO `t_element` VALUES ('10804', '收集团号', '1', '1', 'html.gatherData', '团号', '//td[contains(text(),\"团号\")]//following-sibling::td[1]', '', '2', 'groupCode', '2', '0', '772', '0');
INSERT INTO `t_element` VALUES ('10815', '关闭Tab', '4', '1', 'html.closeTab', '', '', '', '1', '', '5', '0', '624', '0');
INSERT INTO `t_element` VALUES ('10823', '输入备注', '1', '1', 'html.sendKeys', '备注', '备注信息', '', '1', '', '6', '0', '775', '0');
INSERT INTO `t_element` VALUES ('10832', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"groupCodeEle\"]', '', '2', 'groupCode', '2', '0', '776', '0');
INSERT INTO `t_element` VALUES ('10854', '输入团号', '1', '1', 'html.sendKeys', '团号', '//*[@id=\"keywords\"]', '', '2', 'groupCode', '3', '0', '778', '0');
INSERT INTO `t_element` VALUES ('10867', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"threeSerch\"]', '', '2', 'orderCode', '4', '0', '780', '0');
INSERT INTO `t_element` VALUES ('10875', '获取产品名称并放入内存', '4', '1', 'html.getTextOrValue', '', '//*[@id=\"acitivityName\"]', 'productName', '1', '', '4', '0', '35', '0');
INSERT INTO `t_element` VALUES ('10880', '输入备注', '1', '1', 'html.sendKeys', '备注', '//*[@id=\"textfield\"]', '', '1', '', '5', '0', '782', '0');
INSERT INTO `t_element` VALUES ('10889', '收集团号', '1', '1', 'html.gatherData', '团号', '//*[@id=\"groupCodeEle\"]', '', '2', 'groupCode', '2', '0', '783', '0');
INSERT INTO `t_element` VALUES ('10891', '部门', '1', '1', 'html.sendKeys', '部门', '', '', '1', '', '15', '0', '556', '0');
INSERT INTO `t_element` VALUES ('10900', '输入订单号', '1', '1', 'html.sendKeys', '订单号', '//*[@id=\"orderNum\"]', '', '2', 'orderCode', '2', '0', '785', '1');
INSERT INTO `t_element` VALUES ('10913', null, null, null, null, '数据', '//*[@id=\"1\"]/h3/a[1]', null, null, null, null, null, '786', '1');
INSERT INTO `t_element` VALUES ('10918', null, null, null, null, '数据', '//*[@id=\"1\"]/h3/a[1]', null, null, null, null, null, '787', '1');

-- ----------------------------
-- Table structure for `t_environment`
-- ----------------------------
DROP TABLE IF EXISTS `t_environment`;
CREATE TABLE `t_environment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `frontUrl` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `backUrl` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `insertTime` datetime DEFAULT NULL,
  `insertUser` int(11) DEFAULT NULL,
  `updateUser` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_environment
-- ----------------------------
INSERT INTO `t_environment` VALUES ('15', '体彩项目184', 'http://192.168.71.184/static/htmls/login.html', 'http://192.168.71.184/static/htmls/control_panel_login.html', '4', null, null, null, null);
INSERT INTO `t_environment` VALUES ('16', '百度', 'https://www.baidu.com/', 'https://www.baidu.com/', '5', null, null, null, null);

-- ----------------------------
-- Table structure for `t_group`
-- ----------------------------
DROP TABLE IF EXISTS `t_group`;
CREATE TABLE `t_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL,
  `parentGroupId` int(11) DEFAULT NULL,
  `insertUser` int(11) DEFAULT NULL,
  `updateUser` int(11) DEFAULT NULL,
  `insertTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customerId` (`projectId`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_group
-- ----------------------------
INSERT INTO `t_group` VALUES ('110', '测试顶级组', 'Top', '5', '-1', null, null, null, null);
INSERT INTO `t_group` VALUES ('111', '测试子组', 'Second', '5', '110', null, null, null, null);

-- ----------------------------
-- Table structure for `t_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `action` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `parentMenuId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES ('1', 'Case管理', '无', '1', '-1');
INSERT INTO `t_menu` VALUES ('2', '测试Case管理', 'case/initCase', '2', '1');
INSERT INTO `t_menu` VALUES ('3', '基础Case管理', 'case/initBaseCase?caseId=0', '2', '1');
INSERT INTO `t_menu` VALUES ('4', '页面管理', '无', '1', '-1');
INSERT INTO `t_menu` VALUES ('5', '页面管理', 'page/initPage', '2', '4');
INSERT INTO `t_menu` VALUES ('6', 'Case执行策略', 'case/initStrategy', '2', '1');
INSERT INTO `t_menu` VALUES ('7', 'Case执行结果', 'case/initRunCaseResult', '2', '1');
INSERT INTO `t_menu` VALUES ('8', '系统管理', '无', '1', '-1');
INSERT INTO `t_menu` VALUES ('9', '用户管理', 'user/initUser', '2', '8');
INSERT INTO `t_menu` VALUES ('10', '用户组管理', 'user/initUserGroup', '2', '8');
INSERT INTO `t_menu` VALUES ('12', 'Case文件夹管理', 'manage/initCategory', '2', '8');
INSERT INTO `t_menu` VALUES ('14', '权限管理', '无', '1', '-1');
INSERT INTO `t_menu` VALUES ('15', '角色管理', 'authority/initRole', '2', '14');
INSERT INTO `t_menu` VALUES ('16', '菜单管理', 'authority/initMenu', '2', '14');
INSERT INTO `t_menu` VALUES ('17', '客户端管理', 'manage/initClient', '2', '8');
INSERT INTO `t_menu` VALUES ('18', '内存管理', 'page/initContext', '2', '4');
INSERT INTO `t_menu` VALUES ('19', '数据迭代', 'case/initDegrade', '2', '1');
INSERT INTO `t_menu` VALUES ('20', '项目管理', 'manage/initProject', '2', '8');
INSERT INTO `t_menu` VALUES ('21', '脚本管理', '', '1', '-1');

-- ----------------------------
-- Table structure for `t_page`
-- ----------------------------
DROP TABLE IF EXISTS `t_page`;
CREATE TABLE `t_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `groupId` int(11) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL COMMENT '过程or收集数据',
  `isVisible` int(11) DEFAULT NULL,
  `insertTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `insertUser` int(11) DEFAULT NULL,
  `updateUser` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `groupId` (`groupId`),
  KEY `t_page_ibfk_2` (`projectId`),
  CONSTRAINT `t_page_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `t_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_page
-- ----------------------------
INSERT INTO `t_page` VALUES ('25', '测试百度', '测试百度', 'test_Top_Second_25', '111', '5', null, '1', '2017-05-11 16:53:36', '2017-05-11 16:53:36', '104', '104');

-- ----------------------------
-- Table structure for `t_project`
-- ----------------------------
DROP TABLE IF EXISTS `t_project`;
CREATE TABLE `t_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `insertUser` int(11) DEFAULT NULL,
  `updateUser` int(11) DEFAULT NULL,
  `insertTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_project
-- ----------------------------
INSERT INTO `t_project` VALUES ('5', 'test', 'test', '104', '104', '2017-05-11 16:48:28', '2017-05-11 16:48:28');

-- ----------------------------
-- Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `isAdmin` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '一级权限', '超级管理员', '2');
INSERT INTO `t_role` VALUES ('2', '二级权限', '差不多跟组长一个级别吧', '2');
INSERT INTO `t_role` VALUES ('3', '三级权限', '普通人儿', '1');

-- ----------------------------
-- Table structure for `t_rolemenu`
-- ----------------------------
DROP TABLE IF EXISTS `t_rolemenu`;
CREATE TABLE `t_rolemenu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_rolemenu
-- ----------------------------
INSERT INTO `t_rolemenu` VALUES ('175', '1', '3');
INSERT INTO `t_rolemenu` VALUES ('176', '2', '3');
INSERT INTO `t_rolemenu` VALUES ('177', '3', '3');
INSERT INTO `t_rolemenu` VALUES ('178', '6', '3');
INSERT INTO `t_rolemenu` VALUES ('179', '7', '3');
INSERT INTO `t_rolemenu` VALUES ('180', '19', '3');
INSERT INTO `t_rolemenu` VALUES ('181', '4', '3');
INSERT INTO `t_rolemenu` VALUES ('182', '5', '3');
INSERT INTO `t_rolemenu` VALUES ('183', '18', '3');
INSERT INTO `t_rolemenu` VALUES ('184', '8', '3');
INSERT INTO `t_rolemenu` VALUES ('185', '11', '3');
INSERT INTO `t_rolemenu` VALUES ('186', '12', '3');
INSERT INTO `t_rolemenu` VALUES ('263', '1', '1');
INSERT INTO `t_rolemenu` VALUES ('264', '2', '1');
INSERT INTO `t_rolemenu` VALUES ('265', '3', '1');
INSERT INTO `t_rolemenu` VALUES ('266', '6', '1');
INSERT INTO `t_rolemenu` VALUES ('267', '7', '1');
INSERT INTO `t_rolemenu` VALUES ('268', '19', '1');
INSERT INTO `t_rolemenu` VALUES ('269', '4', '1');
INSERT INTO `t_rolemenu` VALUES ('270', '5', '1');
INSERT INTO `t_rolemenu` VALUES ('271', '18', '1');
INSERT INTO `t_rolemenu` VALUES ('272', '8', '1');
INSERT INTO `t_rolemenu` VALUES ('273', '9', '1');
INSERT INTO `t_rolemenu` VALUES ('274', '10', '1');
INSERT INTO `t_rolemenu` VALUES ('275', '12', '1');
INSERT INTO `t_rolemenu` VALUES ('276', '17', '1');
INSERT INTO `t_rolemenu` VALUES ('277', '20', '1');
INSERT INTO `t_rolemenu` VALUES ('278', '14', '1');
INSERT INTO `t_rolemenu` VALUES ('279', '15', '1');
INSERT INTO `t_rolemenu` VALUES ('280', '16', '1');
INSERT INTO `t_rolemenu` VALUES ('281', '1', '2');
INSERT INTO `t_rolemenu` VALUES ('282', '2', '2');
INSERT INTO `t_rolemenu` VALUES ('283', '3', '2');
INSERT INTO `t_rolemenu` VALUES ('284', '6', '2');
INSERT INTO `t_rolemenu` VALUES ('285', '7', '2');
INSERT INTO `t_rolemenu` VALUES ('286', '19', '2');
INSERT INTO `t_rolemenu` VALUES ('287', '4', '2');
INSERT INTO `t_rolemenu` VALUES ('288', '5', '2');
INSERT INTO `t_rolemenu` VALUES ('289', '18', '2');
INSERT INTO `t_rolemenu` VALUES ('290', '8', '2');
INSERT INTO `t_rolemenu` VALUES ('291', '9', '2');
INSERT INTO `t_rolemenu` VALUES ('292', '10', '2');
INSERT INTO `t_rolemenu` VALUES ('293', '12', '2');
INSERT INTO `t_rolemenu` VALUES ('294', '17', '2');
INSERT INTO `t_rolemenu` VALUES ('295', '20', '2');
INSERT INTO `t_rolemenu` VALUES ('296', '14', '2');
INSERT INTO `t_rolemenu` VALUES ('297', '15', '2');

-- ----------------------------
-- Table structure for `t_runcaseresult`
-- ----------------------------
DROP TABLE IF EXISTS `t_runcaseresult`;
CREATE TABLE `t_runcaseresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caseId` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `resultFile` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `logFile` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `environmentId` int(11) DEFAULT NULL,
  `screenShot` int(11) DEFAULT NULL,
  `degrade` tinyint(4) DEFAULT NULL,
  `updateUser` int(11) DEFAULT NULL,
  `insertUser` int(11) DEFAULT NULL,
  `insertTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_runcaseresult
-- ----------------------------
INSERT INTO `t_runcaseresult` VALUES ('168', '16', '4', '\\\\192.168.71.70\\autoTest\\report\\2017-05-11\\测试百度搜索-2017-05-11-17-03-24.xlsx', '\\\\192.168.71.70\\autoTest\\logs\\\\测试百度搜索-2017-05-11-17-03-24.log', '172.27.35.1', '16', '1', null, '104', '104', '2017-05-11 17:02:19', '2017-05-11 17:03:32');
INSERT INTO `t_runcaseresult` VALUES ('169', '16', '6', '\\\\192.168.71.70\\autoTest\\report\\2017-05-11\\测试百度搜索-2017-05-11-17-04-08.xlsx', '\\\\192.168.71.70\\autoTest\\logs\\\\测试百度搜索-2017-05-11-17-04-08.log', '172.27.35.1', '16', '1', null, '104', '104', '2017-05-11 17:04:04', '2017-05-11 17:04:15');
INSERT INTO `t_runcaseresult` VALUES ('170', '16', '6', '\\\\192.168.71.70\\autoTest\\report\\2017-05-11\\测试百度搜索-2017-05-11-17-05-39.xlsx', '\\\\192.168.71.70\\autoTest\\logs\\\\测试百度搜索-2017-05-11-17-05-39.log', '172.27.35.1', '16', '1', null, '104', '104', '2017-05-11 17:05:02', '2017-05-11 17:05:48');

-- ----------------------------
-- Table structure for `t_runcaseresultdata`
-- ----------------------------
DROP TABLE IF EXISTS `t_runcaseresultdata`;
CREATE TABLE `t_runcaseresultdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `runCaseResultId` int(11) DEFAULT NULL,
  `baseCaseName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `casePageId` int(11) DEFAULT NULL,
  `casePageName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `itemName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `pageValue` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `expectValue` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `isCompare` tinyint(4) DEFAULT NULL,
  `insertTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_runcaseresultdata
-- ----------------------------

-- ----------------------------
-- Table structure for `t_script`
-- ----------------------------
DROP TABLE IF EXISTS `t_script`;
CREATE TABLE `t_script` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `insertUser` int(11) DEFAULT NULL,
  `updateUser` int(11) DEFAULT NULL,
  `insertTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_script
-- ----------------------------

-- ----------------------------
-- Table structure for `t_strategy`
-- ----------------------------
DROP TABLE IF EXISTS `t_strategy`;
CREATE TABLE `t_strategy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caseId` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL COMMENT '1,定时，2每天',
  `executeTime` varchar(255) DEFAULT NULL,
  `environmentId` int(11) DEFAULT NULL,
  `screenShot` int(11) DEFAULT NULL,
  `degrade` tinyint(4) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_strategy
-- ----------------------------

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(240) DEFAULT NULL,
  `password` varchar(240) DEFAULT NULL,
  `userGroupId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `logintime` timestamp NULL DEFAULT NULL,
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` int(11) DEFAULT NULL,
  `updateuser` int(11) DEFAULT NULL,
  `adduser` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userGroupId` (`userGroupId`),
  CONSTRAINT `t_user_ibfk_1` FOREIGN KEY (`userGroupId`) REFERENCES `t_usergroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('104', 'admin', '123456', '1', '2', null, '2016-03-30 20:01:34', null, null, null);
INSERT INTO `t_user` VALUES ('119', 'superadmin', '123456', '1', '1', null, '2016-06-20 09:45:54', null, null, null);

-- ----------------------------
-- Table structure for `t_usergroup`
-- ----------------------------
DROP TABLE IF EXISTS `t_usergroup`;
CREATE TABLE `t_usergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_usergroup
-- ----------------------------
INSERT INTO `t_usergroup` VALUES ('1', '测试组');
INSERT INTO `t_usergroup` VALUES ('2', '自动化组');
INSERT INTO `t_usergroup` VALUES ('3', '其他');

-- ----------------------------
-- Procedure structure for `mergePage`
-- ----------------------------
DROP PROCEDURE IF EXISTS `mergePage`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `mergePage`(`formerPageId` int,`backerPageId` int)
BEGIN
	#Routine body goes here...
	SELECT * from t_page t where t.id=formerPageId;
	select * from t_action t where t.pageId=formerPageId;
END
;;
DELIMITER ;

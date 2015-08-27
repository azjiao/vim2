-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2015-08-20 16:05:32
-- 服务器版本： 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dev`
--
--  DROP DATABASE `dev`if exists `dev`;
CREATE DATABASE IF NOT EXISTS `dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `dev`;

-- --------------------------------------------------------

--
-- 表的结构 `brand`
--

DROP TABLE IF EXISTS `brand`;
CREATE TABLE IF NOT EXISTS `brand` (
`brand_ID` int(11) NOT NULL COMMENT '品牌ID',
  `brand_name` varchar(255) DEFAULT NULL COMMENT '品牌名称'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='品牌表' AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `brand`
--

INSERT INTO `brand` (`brand_ID`, `brand_name`) VALUES
(1, 'shuanke'),
(2, '欧姆龙'),
(3, '优派诺'),
(4, '优品'),
(5, '正泰'),
(6, '集成厂'),
(7, '双科');

-- --------------------------------------------------------

--
-- 表的结构 `component`
--

DROP TABLE IF EXISTS `component`;
CREATE TABLE IF NOT EXISTS `component` (
`compt_ID` int(11) NOT NULL COMMENT '元件ID',
  `brand_ID` int(11) DEFAULT NULL COMMENT '品牌ID',
  `name` varchar(255) DEFAULT NULL COMMENT '元件名称',
  `type` varchar(255) DEFAULT NULL COMMENT '元件型号规格',
  `list_price` float(10,3) DEFAULT NULL COMMENT '元件的列表价格',
  `discount` float(3,3) DEFAULT NULL COMMENT '元件折扣点数',
  `price1` float(10,3) DEFAULT NULL COMMENT '计算进价',
  `price2` float(10,3) DEFAULT NULL COMMENT '元件实际进价',
  `deal_ID` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='元件数据表' AUTO_INCREMENT=24 ;

--
-- 转存表中的数据 `component`
--

INSERT INTO `component` (`compt_ID`, `brand_ID`, `name`, `type`, `list_price`, `discount`, `price1`, `price2`, `deal_ID`, `comment`) VALUES
(11, 1, '塑壳', 'RMM1-63H/4200-50A', 480.000, 0.700, 336.000, 336.000, 1, NULL),
(15, 3, 'ATSE', 'YCQ1-63A', 2880.000, 0.300, 864.000, 914.000, 3, NULL),
(16, 4, '电气火灾报警器', 'UPTR2-S1 Y45', NULL, 0.999, NULL, 570.000, 3, NULL),
(17, 1, '微断', 'RMC1-63/C16 1P', 21.000, 0.999, 14.700, 14.700, 1, NULL),
(18, 6, '箱体1', '箱体1', 500.000, 0.999, 500.000, 500.000, NULL, NULL),
(19, 6, '人工辅材1', '人工辅材1', 550.000, 0.999, 550.000, 550.000, NULL, NULL),
(20, 6, '人工辅材1', '人工辅材1', 550.000, 0.999, 550.000, 550.000, NULL, NULL),
(21, NULL, '人工辅材1', '人工辅材1', 550.000, 0.999, 550.000, 550.000, 2, NULL),
(22, NULL, '人工辅材1', '人工辅材1', 550.000, 0.999, 550.000, 550.000, NULL, NULL),
(23, NULL, '人工辅材1', '人工辅材1', 550.000, 0.999, 550.000, 550.000, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `constitution`
--

DROP TABLE IF EXISTS `constitution`;
CREATE TABLE IF NOT EXISTS `constitution` (
`const_ID` int(11) NOT NULL COMMENT '构成ID',
  `prod_ID` int(11) DEFAULT NULL COMMENT '所属产品ID',
  `const_price` float(10,3) DEFAULT NULL COMMENT '价格构成的出库金额',
  `const_cost` float(10,3) DEFAULT NULL COMMENT '价格构成的成本金额',
  `const_flag` int(5) DEFAULT NULL COMMENT '构成表记录属性标志'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='价格构成表' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `constitution`
--

INSERT INTO `constitution` (`const_ID`, `prod_ID`, `const_price`, `const_cost`, `const_flag`) VALUES
(1, 1, 7371.000, 5460.000, 1),
(2, 2, 79.380, 58.800, 1),
(3, 3, 5670.000, 4200.000, 1),
(4, 4, 2970.000, 2200.000, 1),
(5, 2, 200.000, 200.000, 2);

--
-- 触发器 `constitution`
--
DROP TRIGGER IF EXISTS `trig_const_delete`;
DELIMITER //
CREATE TRIGGER `trig_const_delete` AFTER DELETE ON `constitution`
 FOR EACH ROW BEGIN
	SET @new_prod_ID := OLD.prod_ID;
	
	UPDATE ((product AS t1
	JOIN
	(SELECT 
		prod_ID,
		sum(const_cost) AS cost,
		sum(const_price) AS price
	FROM
		constitution
	WHERE
		prod_ID = @new_Prod_ID
	) AS t2
	ON
	t1.prod_ID = t2.prod_ID)
	JOIN
	factor ON factor.fact_ID = t1.fact_ID)	
	SET
	t1.cost = t2.cost,
	t1.price = t2.price,
	t1.offer = (t2.price) * factor.fact,
	t1.GOP = (( t2.price * factor.fact - t2.cost ) / (t2.price * factor.fact ));
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `trig_const_insert`;
DELIMITER //
CREATE TRIGGER `trig_const_insert` AFTER INSERT ON `constitution`
 FOR EACH ROW BEGIN
	SET @new_prod_ID := NEW.prod_ID;
	
	UPDATE ((product AS t1
	JOIN
	(SELECT 
		prod_ID,
		sum(const_cost) AS cost,
		sum(const_price) AS price
	FROM
		constitution
	WHERE
		prod_ID = @new_Prod_ID
	) AS t2
	ON
	t1.prod_ID = t2.prod_ID)
	JOIN
	factor ON factor.fact_ID = t1.fact_ID)	
	SET
	t1.cost = t2.cost,
	t1.price = t2.price,
	t1.offer = (t2.price) * factor.fact,
	t1.GOP = (( t2.price * factor.fact - t2.cost ) / (t2.price * factor.fact ));
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `trig_const_update`;
DELIMITER //
CREATE TRIGGER `trig_const_update` AFTER UPDATE ON `constitution`
 FOR EACH ROW BEGIN
	SET @new_prod_ID := New.prod_ID;
	
	UPDATE ((product AS t1
	JOIN
	(SELECT 
		prod_ID,
		sum(const_cost) AS cost,
		sum(const_price) AS price
	FROM
		constitution
	WHERE
		prod_ID = @new_Prod_ID
	) AS t2
	ON
	t1.prod_ID = t2.prod_ID)
	JOIN
	factor ON factor.fact_ID = t1.fact_ID)	
	SET
	t1.cost = t2.cost,
	t1.price = t2.price,
	t1.offer = (t2.price) * factor.fact,
	t1.GOP = (( t2.price * factor.fact - t2.cost ) / (t2.price * factor.fact ));
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `dealer`
--

DROP TABLE IF EXISTS `dealer`;
CREATE TABLE IF NOT EXISTS `dealer` (
`deal_ID` int(11) NOT NULL COMMENT '经销商ID',
  `name` varchar(255) DEFAULT NULL COMMENT '经销商名称',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `fax` varchar(255) DEFAULT NULL COMMENT '传真'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='经销商表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `dealer`
--

INSERT INTO `dealer` (`deal_ID`, `name`, `address`, `phone`, `fax`) VALUES
(1, '众业达2', NULL, NULL, NULL),
(2, '新潮', NULL, NULL, NULL),
(3, '一向立创', NULL, NULL, NULL),
(4, '正泰', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `factor`
--

DROP TABLE IF EXISTS `factor`;
CREATE TABLE IF NOT EXISTS `factor` (
`fact_ID` int(11) NOT NULL COMMENT '系数ID',
  `fact_name` varchar(255) DEFAULT NULL COMMENT '系数名称',
  `fact` float(5,3) DEFAULT NULL COMMENT '系数',
  `comment` varchar(255) DEFAULT NULL COMMENT '说明',
  `date` datetime DEFAULT NULL COMMENT '系数修改日期'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系数表' AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `factor`
--

INSERT INTO `factor` (`fact_ID`, `fact_name`, `fact`, `comment`, `date`) VALUES
(1, '一般部件系数', 1.350, '普通部件系数', '2014-09-26 21:36:00'),
(2, '箱柜系数', 1.000, '普通箱柜系数', '2014-09-26 00:00:00'),
(3, '人工辅材系数', 1.350, '人工辅材系数', '2014-09-26 00:00:00'),
(4, 'ATSE系数', 1.900, '双电源开关系数', '2014-09-26 00:00:00'),
(5, '整体系数', 1.200, '整体系数', '2014-09-26 00:00:00'),
(6, 'temp', 1.000, NULL, NULL),
(7, '一般部件系数2', 1.200, NULL, '2014-12-01 00:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `parter1`
--

DROP TABLE IF EXISTS `parter1`;
CREATE TABLE IF NOT EXISTS `parter1` (
`part1_ID` int(11) NOT NULL COMMENT '部件ID',
  `const_ID` int(11) DEFAULT NULL COMMENT '价格构成ID',
  `no` int(11) DEFAULT NULL COMMENT '序号',
  `comp_name` varchar(255) DEFAULT NULL COMMENT '部件名称',
  `type1` varchar(255) DEFAULT NULL COMMENT '图上型号',
  `compt_ID` int(11) DEFAULT NULL COMMENT '部件ID',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `fact_ID` int(11) DEFAULT NULL COMMENT '部件出库系数',
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='主要部件构成表' AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `parter1`
--

INSERT INTO `parter1` (`part1_ID`, `const_ID`, `no`, `comp_name`, `type1`, `compt_ID`, `quantity`, `fact_ID`, `comment`) VALUES
(1, 1, 1, '微断', 'RMCl-63/C16 1P', 11, 3, 1, NULL),
(2, 1, 2, '微断', 'RMCl-63/C16 2P', 15, 3, 1, NULL),
(3, 1, 3, '双电源', 'RMCl-63/C16 1P', 16, 3, 1, NULL),
(4, 2, 4, '临时', 'RMCl-63/C16 1P', 17, 4, 1, NULL),
(5, 3, 4, '临时', 'RMCl-63/C16 1P', 19, 4, 1, NULL),
(6, 3, 5, '临时', 'RMCl-63/C16 1P', 18, 4, 1, NULL),
(8, 4, 4, '临时', 'RMC1-63/C16 1P', 19, 4, 1, NULL);

--
-- 触发器 `parter1`
--
DROP TRIGGER IF EXISTS `trig_part1_delete`;
DELIMITER //
CREATE TRIGGER `trig_part1_delete` AFTER DELETE ON `parter1`
 FOR EACH ROW BEGIN
SET @new_const_ID := OLD.const_ID;

UPDATE constitution AS t1 
JOIN
view_parter1_totalprice3 AS t2 
ON
t1.const_ID = t2.const_ID
SET 
t1.const_cost = t2.total_cost,
t1.const_price = t2.total_price
WHERE 
t1.const_ID = @new_const_ID;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `trig_part1_insert`;
DELIMITER //
CREATE TRIGGER `trig_part1_insert` AFTER INSERT ON `parter1`
 FOR EACH ROW BEGIN
SET @new_const_ID:= NEW.const_ID;

UPDATE constitution AS t1 
JOIN
view_parter1_totalprice3 AS t2
ON
t1.const_ID = t2.const_ID
SET 
t1.const_cost = t2.total_cost,
t1.const_price = t2.total_price 
WHERE 
t1.const_ID = @new_const_ID;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `trig_part1_update`;
DELIMITER //
CREATE TRIGGER `trig_part1_update` AFTER UPDATE ON `parter1`
 FOR EACH ROW BEGIN
SET @new_const_ID:= NEW.const_ID;

UPDATE constitution AS t1 
JOIN
view_parter1_totalprice3 AS t2
ON
t1.const_ID = t2.const_ID
SET 
t1.const_cost = t2.total_cost,
t1.const_price = t2.total_price 
WHERE 
t1.const_ID = @new_const_ID;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
`prod_ID` int(11) NOT NULL COMMENT '产品ID',
  `proj_ID` int(11) DEFAULT NULL COMMENT '项目ID',
  `map_flag` varchar(255) DEFAULT NULL COMMENT '系统图号',
  `nameplate` varchar(255) DEFAULT NULL COMMENT '铭牌',
  `dimension` varchar(255) DEFAULT NULL COMMENT '尺寸',
  `color` varchar(255) DEFAULT NULL COMMENT '外壳颜色',
  `mounting` varchar(255) DEFAULT NULL COMMENT '设备安装方式',
  `cost` float(10,3) DEFAULT NULL COMMENT '产品成本',
  `price` float(10,3) DEFAULT NULL COMMENT '产品出库价',
  `fact_ID` int(11) DEFAULT NULL COMMENT '出库系数',
  `offer` float(10,3) DEFAULT NULL COMMENT '产品报价',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `comment` varchar(255) DEFAULT NULL COMMENT '说明',
  `GOP` float DEFAULT NULL COMMENT '产品毛利润'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='产品表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `product`
--

INSERT INTO `product` (`prod_ID`, `proj_ID`, `map_flag`, `nameplate`, `dimension`, `color`, `mounting`, `cost`, `price`, `fact_ID`, `offer`, `quantity`, `unit`, `comment`, `GOP`) VALUES
(1, 4, 'Map20150101', 'Map2015', NULL, NULL, NULL, 5460.000, 7371.000, 2, 7371.000, 1, '台', NULL, 0.259259),
(2, 4, 'Map20150102', 'Map2015', NULL, NULL, NULL, 258.800, 279.380, 2, 279.380, 2, '台', NULL, 0.0736631),
(3, 1, 'Map20150103', 'Map2015', NULL, NULL, NULL, 4200.000, 5670.000, 2, 5670.000, 1, '台', NULL, 0.259259),
(4, 2, 'Map20150105', 'Map2015', NULL, NULL, NULL, 2200.000, 2970.000, 2, 2970.000, 1, '台', NULL, 0.259259);

-- --------------------------------------------------------

--
-- 表的结构 `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE IF NOT EXISTS `project` (
`proj_ID` int(11) NOT NULL COMMENT '项目ID',
  `proj_name` varchar(255) DEFAULT NULL COMMENT '项目名称',
  `proj_desc1` varchar(255) DEFAULT NULL COMMENT '项目描述1',
  `proj_desc2` varchar(255) DEFAULT NULL COMMENT '项目描述2',
  `proj_desc3` varchar(255) DEFAULT NULL COMMENT '项目描述3'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='项目表' AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `project`
--

INSERT INTO `project` (`proj_ID`, `proj_name`, `proj_desc1`, `proj_desc2`, `proj_desc3`) VALUES
(1, '插座箱项目', NULL, NULL, NULL),
(2, '临时照片', NULL, NULL, NULL),
(3, '林业技术学院', NULL, NULL, NULL),
(4, '禄丰自来水厂', NULL, NULL, NULL),
(5, 'tom', NULL, NULL, NULL),
(6, '某厂', NULL, NULL, NULL),
(7, '某水厂', NULL, NULL, NULL),
(8, 'xxx', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `view_parter1_totalprice3`
--
DROP VIEW IF EXISTS `view_parter1_totalprice3`;
CREATE TABLE IF NOT EXISTS `view_parter1_totalprice3` (
`const_ID` int(11)
,`total_cost` double(20,3)
,`total_price` double(20,3)
);
-- --------------------------------------------------------

--
-- 替换视图以便查看 `view_product`
--
DROP VIEW IF EXISTS `view_product`;
CREATE TABLE IF NOT EXISTS `view_product` (
`prod_ID` int(11)
,`proj_name` varchar(255)
,`map_flag` varchar(255)
,`cost` float(10,3)
,`price` float(10,3)
,`fact` float(5,3)
,`offer` float(10,3)
,`quantity` int(11)
,`unit` varchar(255)
,`GOP` float
);
-- --------------------------------------------------------

--
-- 替换视图以便查看 `view_product2`
--
DROP VIEW IF EXISTS `view_product2`;
CREATE TABLE IF NOT EXISTS `view_product2` (
`proj_name` varchar(255)
,`prod_ID` int(11)
,`cost` float(10,3)
,`price` float(10,3)
,`fact` float(5,3)
,`offer` float(10,3)
,`prod_quan` int(11)
,`GOP` float
,`const_ID` int(11)
,`const_cost` float(10,3)
,`const_price` float(10,3)
,`flag` int(5)
,`part1_ID` int(11)
,`name` varchar(255)
,`type` varchar(255)
,`part1_quan` int(11)
);
-- --------------------------------------------------------

--
-- 替换视图以便查看 `view_proj_report`
--
DROP VIEW IF EXISTS `view_proj_report`;
CREATE TABLE IF NOT EXISTS `view_proj_report` (
`proj_ID` int(11)
,`proj_name` varchar(255)
,`prod_quantity` decimal(32,0)
,`proj_cost` double(20,3)
,`proj_offer` double(20,3)
,`proj_GOP` double(24,7)
);
-- --------------------------------------------------------

--
-- 视图结构 `view_parter1_totalprice3`
--
DROP TABLE IF EXISTS `view_parter1_totalprice3`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_parter1_totalprice3` AS select `c`.`const_ID` AS `const_ID`,sum((`e`.`price2` * `d`.`quantity`)) AS `total_cost`,sum(((`e`.`price2` * `f`.`fact`) * `d`.`quantity`)) AS `total_price` from (((`constitution` `c` join `parter1` `d` on((`d`.`const_ID` = `c`.`const_ID`))) join `component` `e` on((`d`.`compt_ID` = `e`.`compt_ID`))) join `factor` `f` on((`d`.`fact_ID` = `f`.`fact_ID`))) where (`c`.`const_flag` = 1) group by `c`.`const_ID`;

-- --------------------------------------------------------

--
-- 视图结构 `view_product`
--
DROP TABLE IF EXISTS `view_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_product` AS select `b`.`prod_ID` AS `prod_ID`,`a`.`proj_name` AS `proj_name`,`b`.`map_flag` AS `map_flag`,`b`.`cost` AS `cost`,`b`.`price` AS `price`,`c`.`fact` AS `fact`,`b`.`offer` AS `offer`,`b`.`quantity` AS `quantity`,`b`.`unit` AS `unit`,`b`.`GOP` AS `GOP` from ((`project` `a` join `product` `b`) join `factor` `c`) where ((`b`.`proj_ID` = `a`.`proj_ID`) and (`b`.`fact_ID` = `c`.`fact_ID`));

-- --------------------------------------------------------

--
-- 视图结构 `view_product2`
--
DROP TABLE IF EXISTS `view_product2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_product2` AS select `proj`.`proj_name` AS `proj_name`,`prod`.`prod_ID` AS `prod_ID`,`prod`.`cost` AS `cost`,`prod`.`price` AS `price`,`f`.`fact` AS `fact`,`prod`.`offer` AS `offer`,`prod`.`quantity` AS `prod_quan`,`prod`.`GOP` AS `GOP`,`const`.`const_ID` AS `const_ID`,`const`.`const_cost` AS `const_cost`,`const`.`const_price` AS `const_price`,`const`.`const_flag` AS `flag`,`part1`.`part1_ID` AS `part1_ID`,`compt`.`name` AS `name`,`compt`.`type` AS `type`,`part1`.`quantity` AS `part1_quan` from (((((`project` `proj` left join `product` `prod` on((`proj`.`proj_ID` = `prod`.`proj_ID`))) left join `factor` `f` on((`prod`.`fact_ID` = `f`.`fact_ID`))) left join `constitution` `const` on((`prod`.`prod_ID` = `const`.`prod_ID`))) left join `parter1` `part1` on((`const`.`const_ID` = `part1`.`const_ID`))) left join `component` `compt` on((`part1`.`compt_ID` = `compt`.`compt_ID`)));

-- --------------------------------------------------------

--
-- 视图结构 `view_proj_report`
--
DROP TABLE IF EXISTS `view_proj_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_proj_report` AS select `proj`.`proj_ID` AS `proj_ID`,`proj`.`proj_name` AS `proj_name`,sum(`prod`.`quantity`) AS `prod_quantity`,sum((`prod`.`cost` * `prod`.`quantity`)) AS `proj_cost`,sum((`prod`.`offer` * `prod`.`quantity`)) AS `proj_offer`,((sum((`prod`.`offer` * `prod`.`quantity`)) - sum((`prod`.`cost` * `prod`.`quantity`))) / sum((`prod`.`offer` * `prod`.`quantity`))) AS `proj_GOP` from (`project` `proj` left join `product` `prod` on((`proj`.`proj_ID` = `prod`.`proj_ID`))) group by `prod`.`proj_ID`;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
 ADD PRIMARY KEY (`brand_ID`);

--
-- Indexes for table `component`
--
ALTER TABLE `component`
 ADD PRIMARY KEY (`compt_ID`), ADD KEY `brand_ID` (`brand_ID`,`type`), ADD KEY `deal_ID` (`deal_ID`);

--
-- Indexes for table `constitution`
--
ALTER TABLE `constitution`
 ADD PRIMARY KEY (`const_ID`), ADD UNIQUE KEY `prod_flag` (`prod_ID`,`const_flag`), ADD KEY `prod_ID` (`prod_ID`);

--
-- Indexes for table `dealer`
--
ALTER TABLE `dealer`
 ADD PRIMARY KEY (`deal_ID`);

--
-- Indexes for table `factor`
--
ALTER TABLE `factor`
 ADD PRIMARY KEY (`fact_ID`);

--
-- Indexes for table `parter1`
--
ALTER TABLE `parter1`
 ADD PRIMARY KEY (`part1_ID`), ADD KEY `const_ID` (`const_ID`,`no`), ADD KEY `compt_ID` (`compt_ID`), ADD KEY `fact_ID` (`fact_ID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
 ADD PRIMARY KEY (`prod_ID`), ADD KEY `proj_ID` (`proj_ID`), ADD KEY `fack_ID` (`fact_ID`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
 ADD PRIMARY KEY (`proj_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
MODIFY `brand_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '品牌ID',AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `component`
--
ALTER TABLE `component`
MODIFY `compt_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '元件ID',AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `constitution`
--
ALTER TABLE `constitution`
MODIFY `const_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '构成ID',AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `dealer`
--
ALTER TABLE `dealer`
MODIFY `deal_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '经销商ID',AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `factor`
--
ALTER TABLE `factor`
MODIFY `fact_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '系数ID',AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `parter1`
--
ALTER TABLE `parter1`
MODIFY `part1_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '部件ID',AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
MODIFY `prod_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品ID',AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
MODIFY `proj_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '项目ID',AUTO_INCREMENT=9;
--
-- 限制导出的表
--

--
-- 限制表 `component`
--
ALTER TABLE `component`
ADD CONSTRAINT `fk_component_brand1` FOREIGN KEY (`brand_ID`) REFERENCES `brand` (`brand_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_component_dealer1` FOREIGN KEY (`deal_ID`) REFERENCES `dealer` (`deal_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `constitution`
--
ALTER TABLE `constitution`
ADD CONSTRAINT `fk_constitution_1` FOREIGN KEY (`prod_ID`) REFERENCES `product` (`prod_ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `parter1`
--
ALTER TABLE `parter1`
ADD CONSTRAINT `fk_parter1_1` FOREIGN KEY (`compt_ID`) REFERENCES `component` (`compt_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_parter1_constitution1` FOREIGN KEY (`const_ID`) REFERENCES `constitution` (`const_ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_parter1_factor1` FOREIGN KEY (`fact_ID`) REFERENCES `factor` (`fact_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `product`
--
ALTER TABLE `product`
ADD CONSTRAINT `fk_product_factor1` FOREIGN KEY (`fact_ID`) REFERENCES `factor` (`fact_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_product_project1` FOREIGN KEY (`proj_ID`) REFERENCES `project` (`proj_ID`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

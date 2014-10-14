CREATE TABLE `classes` (
  `idClass` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idClass`),
  UNIQUE KEY `idClass_UNIQUE` (`idClass`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE `config` (
  `idConfig` int(11) NOT NULL AUTO_INCREMENT,
  `setting` varchar(255) DEFAULT NULL,
  `value` text,
  `descriptiveName` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idConfig`),
  UNIQUE KEY `setting_UNIQUE` (`setting`),
  UNIQUE KEY `descriptiveName_UNIQUE` (`descriptiveName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `dinnerchoice` (
  `idDinnerChoice` int(11) NOT NULL AUTO_INCREMENT,
  `menuId` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idDinnerChoice`),
  UNIQUE KEY `idDinnerChoice_UNIQUE` (`idDinnerChoice`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `dinnermenu` (
  `idDinnerMenu` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idDinnerMenu`),
  UNIQUE KEY `idDinnerMenu_UNIQUE` (`idDinnerMenu`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `dinnermenuassignment` (
  `idDinnerMenuAssignment` int(11) NOT NULL AUTO_INCREMENT,
  `menuId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`idDinnerMenuAssignment`),
  UNIQUE KEY `idDinnerMenuAssignment_UNIQUE` (`idDinnerMenuAssignment`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `pupils` (
  `idPupils` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `classId` int(11) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `UPN` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPupils`),
  UNIQUE KEY `idPupils_UNIQUE` (`idPupils`),
  UNIQUE KEY `UPN_UNIQUE` (`UPN`)
) ENGINE=InnoDB AUTO_INCREMENT=712 DEFAULT CHARSET=utf8;

CREATE TABLE `register` (
  `idRegister` int(11) NOT NULL AUTO_INCREMENT,
  `classId` int(11) DEFAULT NULL,
  `sessionId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`idRegister`),
  UNIQUE KEY `idRegister_UNIQUE` (`idRegister`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE `registerentry` (
  `idRegisterEntry` int(11) NOT NULL AUTO_INCREMENT,
  `registerId` int(11) DEFAULT NULL,
  `pupilId` int(11) DEFAULT NULL,
  `present` tinyint(4) DEFAULT NULL,
  `choiceId` int(11) DEFAULT NULL,
  PRIMARY KEY (`idRegisterEntry`),
  UNIQUE KEY `idRegisterEntry_UNIQUE` (`idRegisterEntry`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8;

CREATE TABLE `sessions` (
  `idSessions` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  PRIMARY KEY (`idSessions`),
  UNIQUE KEY `idSessions_UNIQUE` (`idSessions`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- *****************************************************************
--
-- Licensed Materials - Property of IBM
--                                      
-- 5724-U69                             
--                                      
-- Copyright IBM Corp. 2001, 2006  All Rights Reserved.
--
-- US Government Users Restricted Rights - Use, duplication or
-- disclosure restricted by GSA ADP Schedule Contract with
-- IBM Corp.
--
-- *****************************************************************

-- Mashup Oracle Script for creating tables, keys, indexes

-- *****************************************************************
--
-- SET SCHEMA
--
-- *****************************************************************
ALTER SESSION SET CURRENT_SCHEMA = cmndb_owner;

-- *****************************************************************
--
-- SCHEMA VERSION (100)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.VERSION_INFO(
    OID             VARCHAR2(64) NOT NULL,
    VERSION_MAJOR   NUMBER(10,0),
    VERSION_MINOR   NUMBER(10,0),
    VERSION_RELEASE NUMBER(10,0),
    VERSION_DEV     NUMBER(10,0),
    VERSION_TIME    NUMBER(19,0),
    DESCRIPTION     VARCHAR2(254),
    CONSTRAINT PK100 PRIMARY KEY (OID)
);

-- *****************************************************************
--
-- ACCOUNT (200)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.ACCOUNT (
    OID         VARCHAR2(64)            NOT NULL,
    EXTERNAL_ID VARCHAR2(1024)          NOT NULL,
    CREATED     NUMBER(19,0)            NOT NULL,
    MODIFIED    NUMBER(19,0)            NOT NULL,
    STATE       NUMBER(10,0) DEFAULT 1  NOT NULL,
    CONSTRAINT PK200 PRIMARY KEY (OID)
);

-- *****************************************************************
--
-- CATALOG (300)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.CATALOG (
    OID         VARCHAR2(64)           NOT NULL,
    ACCOUNT_OID VARCHAR2(1024)         NOT NULL,
    UNIQUE_NAME VARCHAR2(255)          NOT NULL,
    CREATED     NUMBER(19,0)           NOT NULL,
    MODIFIED    NUMBER(19,0)           NOT NULL,
    STATE       NUMBER(10,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK300 PRIMARY KEY (OID)
);

CREATE TABLE cmndb_owner.CATALOG_LOD (
    RESOURCE_OID VARCHAR2(64)   NOT NULL,
    LOCALE       VARCHAR2(64)   NOT NULL,
    TITLE        VARCHAR2(255)  NOT NULL,
    DESCRIPTION  VARCHAR2(1024) ,
    CONSTRAINT PK301 PRIMARY KEY (RESOURCE_OID, LOCALE),
    CONSTRAINT FK302 FOREIGN KEY (RESOURCE_OID) REFERENCES cmndb_owner.CATALOG (OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- CATALOG ENTRY (310)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.CATALOG_ENTRY (
    OID            			VARCHAR2(64)           NOT NULL,
    CATALOG_OID    			VARCHAR2(64)           NOT NULL,
    CATEGORY_OID   			VARCHAR2(64)           NOT NULL,
    DEFINITION_URL 			VARCHAR2(2500)         NOT NULL,
    CONTENT_URL    			VARCHAR2(2500)         ,
    PREVIEW_URL    			VARCHAR2(2500)         ,
    PREVIEW_THUMBNAIL_URL	VARCHAR2(2500)         ,
    HELP_URL       			VARCHAR2(2500)         ,    
    ICON_URL       			VARCHAR2(2500)         ,
    HUB_ENTRY_URL  			VARCHAR2(2500)         ,
    DEF_URL_TYPE   			NUMBER(10,0)           ,
    ICON_URL_TYPE  			NUMBER(10,0)           ,
    CREATED        			NUMBER(19,0)           NOT NULL,
    MODIFIED       			NUMBER(19,0)           NOT NULL,
    STATE          			NUMBER(10,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK310 PRIMARY KEY (OID)
);

CREATE TABLE cmndb_owner.CATALOG_ENTRY_LOD (
    RESOURCE_OID  		VARCHAR2(64)   NOT NULL,
    LOCALE        		VARCHAR2(64)   NOT NULL,
    TITLE         		VARCHAR2(255)  NOT NULL,
    DESCRIPTION   		VARCHAR2(1024) ,
    SHORT_DESCRIPTION   VARCHAR2(255)  ,    
    CONSTRAINT PK311 PRIMARY KEY (RESOURCE_OID, LOCALE),
    CONSTRAINT FK311 FOREIGN KEY (RESOURCE_OID) REFERENCES cmndb_owner.CATALOG_ENTRY (OID) ON DELETE CASCADE
);

CREATE TABLE cmndb_owner.CATALOG_ENTRY_DD (
    RESOURCE_OID  VARCHAR2(64)   NOT NULL,
    NAME          VARCHAR2(255)  NOT NULL,
    VALUE         VARCHAR2(3000) NOT NULL,
    CONSTRAINT PK312 PRIMARY KEY (RESOURCE_OID, NAME),
    CONSTRAINT FK312 FOREIGN KEY (RESOURCE_OID) REFERENCES cmndb_owner.CATALOG_ENTRY (OID) ON DELETE CASCADE
);


-- *****************************************************************
--
-- CATALOG CATEGORY (320)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.CATALOG_CATEGORY (
    OID         VARCHAR2(64)            NOT NULL,
    CATALOG_OID VARCHAR2(64)            NOT NULL,
    NAME        VARCHAR2(255)           ,
    CREATED     NUMBER(19,0)            NOT NULL,
    MODIFIED    NUMBER(19,0)            NOT NULL,
    STATE       NUMBER(10,0) DEFAULT 1  NOT NULL,
    CONSTRAINT PK320 PRIMARY KEY (OID),
    CONSTRAINT FK320 FOREIGN KEY (CATALOG_OID) REFERENCES cmndb_owner.CATALOG (OID) ON DELETE CASCADE
);

CREATE TABLE cmndb_owner.CATALOG_CATEGORY_LOD (
    RESOURCE_OID VARCHAR2(64)   NOT NULL,
    LOCALE       VARCHAR2(64)   NOT NULL,
    TITLE        VARCHAR2(255)  NOT NULL,
    DESCRIPTION  VARCHAR2(1024) ,
    CONSTRAINT PK321 PRIMARY KEY (RESOURCE_OID, LOCALE),
    CONSTRAINT FK321 FOREIGN KEY (RESOURCE_OID) REFERENCES cmndb_owner.CATALOG_CATEGORY (OID) ON DELETE CASCADE
);


-- *****************************************************************
--
-- CATALOG CATEGORY INCLUDES (330)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.CATALOG_CATEGORY_INC (
    OID          		VARCHAR2(64)    NOT NULL,
    CATALOG_OID  		VARCHAR2(64)    NOT NULL,
    CATEGORY_OID 		VARCHAR2(64)    NOT NULL,
    INCLUDE_CAT  		VARCHAR2(255)   NOT NULL,
    INCLUDE_CATEGORY	VARCHAR2(255)   NOT NULL,
    CONSTRAINT PK330 PRIMARY KEY (OID)
);

-- *****************************************************************
--
-- CATALOG INCLUDES (340)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.CATALOG_INC (
    OID          		VARCHAR2(64)      NOT NULL,
    CATALOG_OID  		VARCHAR2(64)      NOT NULL,
    INCLUDE_CAT  		VARCHAR2(255)  	NOT NULL,
    CONSTRAINT PK340 PRIMARY KEY (OID)
);

-- *****************************************************************
--
-- NAVIGATION NODE (500)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.NAVNODE (
    OID            VARCHAR2(64)           NOT NULL,
    OWNER_OID      VARCHAR2(64)           NOT NULL,
    THEME_ID       VARCHAR2(255)          NOT NULL,
    THEME_NAME     VARCHAR2(255)          NOT NULL,
    CONTENT        BLOB                   ,
    BYTE_COUNT     NUMBER(10,0)           ,
    IS_ZIPPED      NUMBER(10,0) DEFAULT 0 NOT NULL,
    COMMUNITY_OID  VARCHAR2(64)           ,
    SPACE_OID      VARCHAR2(64)           ,
    CREATED        NUMBER(19,0)           NOT NULL,
    MODIFIED       NUMBER(19,0)           NOT NULL,
    STATE          NUMBER(10,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK500 PRIMARY KEY (OID, OWNER_OID)
);

CREATE TABLE cmndb_owner.NAVNODE_LOD (
    RESOURCE_OID  VARCHAR2(64)   NOT NULL,
    OWNER_OID     VARCHAR2(64)   NOT NULL,
    LOCALE        VARCHAR2(64)   NOT NULL,
    TITLE         VARCHAR2(255)  NOT NULL,
    DESCRIPTION   VARCHAR2(1024) ,
    CONSTRAINT FK500 FOREIGN KEY (RESOURCE_OID,OWNER_OID) REFERENCES cmndb_owner.NAVNODE (OID,OWNER_OID) ON DELETE CASCADE
);

CREATE TABLE cmndb_owner.NAVNODE_DD (
    RESOURCE_OID  VARCHAR2(64)    NOT NULL,
    OWNER_OID     VARCHAR2(64)    NOT NULL,
    NAME          VARCHAR2(255)   NOT NULL,
    VALUE         VARCHAR2(3000)  NOT NULL,
    CONSTRAINT PK502 PRIMARY KEY (RESOURCE_OID,OWNER_OID,NAME),
    CONSTRAINT FK502 FOREIGN KEY (RESOURCE_OID,OWNER_OID) REFERENCES cmndb_owner.NAVNODE (OID,OWNER_OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- NAVIGATION TREE (510)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.NAV_TREE (
    OWNER_OID    VARCHAR2(64)           NOT NULL,
    PAGE_OID     VARCHAR2(64)           NOT NULL,
    PARENT_OID   VARCHAR2(64)           NOT NULL,
    ORDINAL      NUMBER(10,0) DEFAULT 1 ,
    IS_VIRTUAL   NUMBER(10,0) DEFAULT 0 ,
    CONSTRAINT PK510 PRIMARY KEY (OWNER_OID, PAGE_OID)
);

-- *****************************************************************
--
-- ACCESS CONTROL (600)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.COMMUNITY_DEF (
    OID            VARCHAR2(64)           NOT NULL,
    OWNER_UID      VARCHAR2(64)           NOT NULL,
    RESOURCE_OID   VARCHAR2(64)           NOT NULL,
    RESOURCE_TYPE  VARCHAR2(32)           NOT NULL,
    CREATED        NUMBER(19,0)           NOT NULL,
    MODIFIED       NUMBER(19,0)           NOT NULL,
    STATE          NUMBER(10,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK600 PRIMARY KEY( OID )
);
-- UNIQUE CONSTRAINT
ALTER TABLE cmndb_owner.COMMUNITY_DEF ADD CONSTRAINT UQ600 UNIQUE (OID,RESOURCE_OID);

CREATE TABLE cmndb_owner.ACL (
    COMMUNITY_OID     VARCHAR2(64)           NOT NULL,
    PARTICIPANT_UID   VARCHAR2(64)           NOT NULL,
    PARTICIPANT_TYPE  NUMBER(10,0)           NOT NULL,
    PERMISSIONS       VARCHAR2(255)          NOT NULL,
    CREATED           NUMBER(19,0)           NOT NULL,
    MODIFIED          NUMBER(19,0)           NOT NULL,
    STATE             NUMBER(10,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK610 PRIMARY KEY (COMMUNITY_OID,PARTICIPANT_UID),
    CONSTRAINT FK611 FOREIGN KEY (COMMUNITY_OID) REFERENCES cmndb_owner.COMMUNITY_DEF (OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- SPACES (700)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.SPACENODE (
    OID            VARCHAR2(64)           NOT NULL,
    OWNER_OID      VARCHAR2(64)           NOT NULL,
    ROOTNAV_OID    VARCHAR2(64)           ,
    TEMPLATE_OID   VARCHAR2(64)           ,
    CREATED        NUMBER(19,0)           NOT NULL,
    MODIFIED       NUMBER(19,0)           NOT NULL,
    STATE          NUMBER(10,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK700 PRIMARY KEY (OID, OWNER_OID)
);

CREATE TABLE cmndb_owner.SPACENODE_LOD (
    RESOURCE_OID  VARCHAR2(64)    NOT NULL,
    OWNER_OID     VARCHAR2(64)    NOT NULL,
    LOCALE        VARCHAR2(64)    NOT NULL,
    TITLE         VARCHAR2(255)   NOT NULL,
    DESCRIPTION   VARCHAR2(1024)          ,
    CONSTRAINT PK701 PRIMARY KEY (RESOURCE_OID,OWNER_OID,LOCALE),
    CONSTRAINT FK701 FOREIGN KEY (RESOURCE_OID,OWNER_OID) REFERENCES cmndb_owner.SPACENODE (OID,OWNER_OID) ON DELETE CASCADE
);

CREATE TABLE cmndb_owner.SPACENODE_DD (
    RESOURCE_OID  VARCHAR2(64)    NOT NULL,
    OWNER_OID     VARCHAR2(64)    NOT NULL,
    NAME          VARCHAR2(255)   NOT NULL,
    VALUE         VARCHAR2(3000)  NOT NULL,
    CONSTRAINT PK702 PRIMARY KEY (RESOURCE_OID,OWNER_OID,NAME),
    CONSTRAINT FK702 FOREIGN KEY (RESOURCE_OID,OWNER_OID) REFERENCES cmndb_owner.SPACENODE (OID,OWNER_OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- TEMPLATES (800)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.TEMPLATENODE (
    OID            VARCHAR2(64)           NOT NULL,
    OWNER_OID      VARCHAR2(1024)         ,
    CONTENT        BLOB                   ,
    BYTE_COUNT     NUMBER(10,0)           ,
    TEMPLATE_TYPE  VARCHAR2(64)           ,
    CREATED        NUMBER(19,0)           NOT NULL,
    MODIFIED       NUMBER(19,0)           NOT NULL,
    STATE          NUMBER(10,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK800 PRIMARY KEY (OID)
);

CREATE TABLE cmndb_owner.TEMPLATENODE_LOD (
    RESOURCE_OID  VARCHAR2(64)    NOT NULL,
    LOCALE        VARCHAR2(64)    NOT NULL,
    TITLE         VARCHAR2(255)   NOT NULL,
    DESCRIPTION   VARCHAR2(1024)          ,
    CONSTRAINT PK801 PRIMARY KEY (RESOURCE_OID,LOCALE),
    CONSTRAINT FK801 FOREIGN KEY (RESOURCE_OID) REFERENCES cmndb_owner.TEMPLATENODE (OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- ACCESS CONTROL RESOURCES (900)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.AC_RESOURCE (
    OID            VARCHAR2(64)           NOT NULL,
    OWNER_UID      VARCHAR2(64)           NOT NULL,
    RESOURCE_OID   VARCHAR2(64)           NOT NULL,
    RESOURCE_TYPE  VARCHAR2(32)           NOT NULL,
    ROLE_BLOCKS    VARCHAR2(1024)         ,
    CREATED        NUMBER(19,0)           NOT NULL,
    MODIFIED       NUMBER(19,0)           NOT NULL,
    STATE          NUMBER(10,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK900 PRIMARY KEY( RESOURCE_OID )
);

CREATE TABLE cmndb_owner.AC_ROLE (
    AC_RESOURCE_OID   VARCHAR2(64)       NOT NULL,
    ROLE_OID          VARCHAR2(64)       NOT NULL,
    ROLE_NAME         VARCHAR2(1024)     NOT NULL,
    ROLE_TYPE         VARCHAR2(1024)             ,
    CREATED           NUMBER(19,0)       NOT NULL,
    MODIFIED          NUMBER(19,0)       NOT NULL,
    STATE             NUMBER(10,0)       DEFAULT 1 NOT NULL,
    CONSTRAINT PK910 PRIMARY KEY( ROLE_OID ),
    CONSTRAINT FK911 FOREIGN KEY (AC_RESOURCE_OID) REFERENCES cmndb_owner.AC_RESOURCE (RESOURCE_OID) ON DELETE CASCADE
);

CREATE TABLE cmndb_owner.AC_MEMBER (
    ROLE_OID          VARCHAR2(64)       NOT NULL,
    MEMBER_UID        VARCHAR2(64)       NOT NULL,
    MEMBER_TYPE       NUMBER(10,0)       NOT NULL,
    CONSTRAINT PK920 PRIMARY KEY (ROLE_OID,MEMBER_UID),
    CONSTRAINT FK921 FOREIGN KEY (ROLE_OID) REFERENCES cmndb_owner.AC_ROLE (ROLE_OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- FILESTORE (1000)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.FILESTORE_PATH (
    OID         VARCHAR2(64)           NOT NULL,
    PARENT_OID  VARCHAR2(64)           NOT NULL,
    NAME        VARCHAR2(255)          NOT NULL,
    PATH        VARCHAR2(255)          NOT NULL,
    LOCKED      VARCHAR2(64)           , 
    OWNER       VARCHAR2(64)           ,             
    CREATED     NUMBER(19,0)           NOT NULL,
    MODIFIED    NUMBER(19,0)           NOT NULL,
    COLL_TYPE   NUMBER(10,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK1010 PRIMARY KEY (OID)
);

CREATE TABLE cmndb_owner.FILESTORE_FILE (
    OID         VARCHAR2(64)           NOT NULL,
    F_SIZE      NUMBER(19,0)           NOT NULL,
    CONTENT     BLOB                   ,
    CONSTRAINT PK1000 PRIMARY KEY (OID),
    CONSTRAINT FK1001 FOREIGN KEY (OID) REFERENCES cmndb_owner.FILESTORE_PATH (OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- LAYOUT NODE (1200)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.LAYOUTNODE (
    OID            VARCHAR2(64)            NOT NULL,
    PAGE_OID       VARCHAR2(64)            NOT NULL,
    SKIN_OID       VARCHAR2(255)                   ,
    NODE_TYPE      NUMBER(10,0) DEFAULT 1  NOT NULL,
    CREATED        NUMBER(19,0)            NOT NULL,
    MODIFIED       NUMBER(19,0)            NOT NULL,
    CONSTRAINT PK1200 PRIMARY KEY (OID, PAGE_OID)
);

CREATE TABLE cmndb_owner.LAYOUTNODE_DD (
    PAGE_OID      VARCHAR2(64)    NOT NULL,
    RESOURCE_OID  VARCHAR2(64)    NOT NULL,
    NAME          VARCHAR2(255)   NOT NULL,
    VALUE         VARCHAR2(3000)  NOT NULL,
    CONSTRAINT PK1202 PRIMARY KEY (RESOURCE_OID,PAGE_OID,NAME),
    CONSTRAINT FK1202 FOREIGN KEY (RESOURCE_OID,PAGE_OID) REFERENCES cmndb_owner.LAYOUTNODE (OID,PAGE_OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- LAYOUT TREE (1210)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.LAYOUT_TREE (
    LAYOUTNODE_OID VARCHAR2(64)            NOT NULL,
    PAGE_OID       VARCHAR2(64)            NOT NULL,
    PARENT_OID     VARCHAR2(64)            NOT NULL,
    ORDINAL        NUMBER(10,0) DEFAULT 1  ,
    CONSTRAINT PK1210 PRIMARY KEY (LAYOUTNODE_OID,PAGE_OID),
    CONSTRAINT FK1210 FOREIGN KEY (LAYOUTNODE_OID,PAGE_OID) REFERENCES cmndb_owner.LAYOUTNODE (OID,PAGE_OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- WIDGET RELATION (1300)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.WIDGET_RELATION (
  OID             VARCHAR2(64)          NOT NULL,
  CONSTRAINT PK1300 PRIMARY KEY (OID)
);

-- *****************************************************************
--
-- WIDGET DEFINITION (1310)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.WIDGET_DEFINITION (
  OID             VARCHAR2(64)              NOT NULL,
  DEFINITION_URL  VARCHAR2(2048)            NOT NULL,
  WIDGET_ID       VARCHAR2(255)             NOT NULL,
  WIDGET_TYPE     VARCHAR2(20)              NOT NULL,
  CREATED         NUMBER(19,0)              NOT NULL,
  MODIFIED        NUMBER(19,0)              NOT NULL,
  CONSTRAINT PK1310 PRIMARY KEY (OID),
  CONSTRAINT FK1310 FOREIGN KEY (OID) REFERENCES cmndb_owner.WIDGET_RELATION (OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- WIDGET INSTANCE (1320)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.WIDGET_INSTANCE (
  OID        VARCHAR2(64)            NOT NULL,
  OWNER_OID  VARCHAR2(64)            ,
  PARENT_OID VARCHAR2(64)            ,
  SANDBOX    NUMBER(10,0) DEFAULT 0  NOT NULL,
  CREATED    NUMBER(19,0)            NOT NULL,
  MODIFIED   NUMBER(19,0)            NOT NULL,
  CONSTRAINT PK1320 PRIMARY KEY (OID),
  CONSTRAINT FK1320 FOREIGN KEY (PARENT_OID) REFERENCES cmndb_owner.WIDGET_INSTANCE (OID) ON DELETE CASCADE,
  CONSTRAINT FK1321 FOREIGN KEY (OID) REFERENCES cmndb_owner.WIDGET_RELATION (OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- WIDGET WINDOW (1330)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.WIDGET_WINDOW (
  OID            VARCHAR2(64)           NOT NULL,
  PAGE_OID       VARCHAR2(64)           NOT NULL,
  DEFINITION_OID VARCHAR2(64)           NOT NULL,
  INSTANCE_OID   VARCHAR2(64)           NOT NULL,
  CREATED        NUMBER(19,0)           NOT NULL,
  MODIFIED       NUMBER(19,0)           NOT NULL,
  CONSTRAINT PK1330 PRIMARY KEY (OID),
  CONSTRAINT FK1330 FOREIGN KEY (OID, PAGE_OID) REFERENCES cmndb_owner.LAYOUTNODE (OID, PAGE_OID) ON DELETE CASCADE,
  CONSTRAINT FK1331 FOREIGN KEY (DEFINITION_OID) REFERENCES cmndb_owner.WIDGET_DEFINITION (OID) ON DELETE CASCADE,
  CONSTRAINT FK1332 FOREIGN KEY (INSTANCE_OID) REFERENCES cmndb_owner.WIDGET_INSTANCE (OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- WIDGET BLOB (1340)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.WIDGET_WIDGETBLOB (
  PARENT_OID       VARCHAR2(64)  NOT NULL,
  CONTENT          BLOB,
  CONSTRAINT PK1340 PRIMARY KEY (PARENT_OID),
  CONSTRAINT FK1340 FOREIGN KEY (PARENT_OID) REFERENCES cmndb_owner.WIDGET_RELATION (OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- WIRE (1400)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.WIREITEM (
    OID         VARCHAR2(64)           NOT NULL,
    PAGE_OID    VARCHAR2(64)           NOT NULL,
    CREATED     NUMBER(19,0)           NOT NULL,
    MODIFIED    NUMBER(19,0)           NOT NULL,
    S_WIDGET    VARCHAR2(64)           NOT NULL,
    S_EVENT     VARCHAR(255)           NOT NULL,
    S_EVENTNAME VARCHAR(255)                   ,
    S_PAGE      VARCHAR2(64)           NOT NULL,
    T_WIDGET    VARCHAR2(64)           NOT NULL,
    T_EVENT     VARCHAR(255)           NOT NULL,
    T_EVENTNAME VARCHAR(255)                   ,
    T_PAGE      VARCHAR2(64)           NOT NULL,
    CONSTRAINT PK1400 PRIMARY KEY (OID),
    CONSTRAINT FK1400 FOREIGN KEY (S_WIDGET,PAGE_OID) REFERENCES cmndb_owner.LAYOUTNODE (OID,PAGE_OID) ON DELETE CASCADE,
    CONSTRAINT FK1401 FOREIGN KEY (T_WIDGET,PAGE_OID) REFERENCES cmndb_owner.LAYOUTNODE (OID,PAGE_OID) ON DELETE CASCADE
);

-- *****************************************************************
--
-- LAYOUT_MARKUP_NODE (1500)
--
-- *****************************************************************
CREATE TABLE cmndb_owner.LAYOUT_MARKUP_NODE (
	PAGE_OID    VARCHAR(64)           NOT NULL,
	CREATED     NUMBER(19,0)          NOT NULL,
	MODIFIED    NUMBER(19,0)          NOT NULL,
	CONTENT     BLOB,
 	CONSTRAINT PK1500 PRIMARY KEY (PAGE_OID)
);

--*****************************************************************
--
-- Indexing
--
--*****************************************************************
-- Catalog
CREATE INDEX cmndb_owner.CATACCT      ON cmndb_owner.CATALOG(ACCOUNT_OID);
CREATE INDEX cmndb_owner.ENTRYCATGOID ON cmndb_owner.CATALOG_ENTRY(CATALOG_OID, CATEGORY_OID);
CREATE INDEX cmndb_owner.CATGCATOID   ON cmndb_owner.CATALOG_CATEGORY(CATALOG_OID);
CREATE INDEX cmndb_owner.CATINTCATOID ON cmndb_owner.CATALOG_INC(CATALOG_OID);

-- Navigation
CREATE INDEX cmndb_owner.PAGECOMM     ON cmndb_owner.NAVNODE(COMMUNITY_OID);
CREATE INDEX cmndb_owner.PAGELODOWNRS ON cmndb_owner.NAVNODE_LOD(OWNER_OID,RESOURCE_OID);
CREATE INDEX cmndb_owner.TREEOWPAR    ON cmndb_owner.NAV_TREE(OWNER_OID,PARENT_OID);

-- Acl
CREATE INDEX cmndb_owner.COMMOWNPAR ON cmndb_owner.COMMUNITY_DEF(OWNER_UID);
CREATE INDEX cmndb_owner.PRTTYUID   ON cmndb_owner.ACL(PARTICIPANT_TYPE,PARTICIPANT_UID);
CREATE INDEX cmndb_owner.PRTUID     ON cmndb_owner.ACL(PARTICIPANT_UID);

-- AC
CREATE INDEX cmndb_owner.AC_ROLE_RESOURCE ON cmndb_owner.AC_ROLE(AC_RESOURCE_OID);
CREATE INDEX cmndb_owner.AC_MEMBER_UID ON cmndb_owner.AC_MEMBER(MEMBER_UID);
CREATE INDEX cmndb_owner.AC_MEMBER_MEMBERTYPE ON cmndb_owner.AC_MEMBER(MEMBER_TYPE ASC);
CREATE INDEX cmndb_owner.AC_RESOURCE_OWNER ON cmndb_owner.AC_RESOURCE(OWNER_UID,RESOURCE_OID);

-- FILESTORE_PATH
CREATE INDEX cmndb_owner.FILESTORE_PATH_1 ON cmndb_owner.FILESTORE_PATH( PATH );
CREATE INDEX cmndb_owner.FILESTORE_PATH_2 ON cmndb_owner.FILESTORE_PATH( PARENT_OID);

-- Layout
CREATE INDEX cmndb_owner.LAYOUT_TREE_1 ON cmndb_owner.LAYOUT_TREE(PAGE_OID ASC, PARENT_OID DESC);

-- Account
CREATE INDEX cmndb_owner.ACCOUNT_1 ON cmndb_owner.ACCOUNT(EXTERNAL_ID);

-- Widget & Wire
CREATE INDEX cmndb_owner.WIREITEM_PAGEOID ON cmndb_owner.WIREITEM(PAGE_OID);
CREATE INDEX cmndb_owner.WIREITEM_SEVENT ON cmndb_owner.WIREITEM(S_EVENT);
CREATE INDEX cmndb_owner.WIREITEM_TEVENT ON cmndb_owner.WIREITEM(T_EVENT);
CREATE INDEX cmndb_owner.WIDGETDEFINITION_DEFINITIONURL ON cmndb_owner.WIDGET_DEFINITION(DEFINITION_URL);
CREATE INDEX cmndb_owner.WIDGETDEFINITION_WIDGETID ON cmndb_owner.WIDGET_DEFINITION(WIDGET_ID);
CREATE INDEX cmndb_owner.WIDGETINSTANCE_PARENTOID ON cmndb_owner.WIDGET_INSTANCE(PARENT_OID);
CREATE INDEX cmndb_owner.WIDGETINSTANCE_OWNEROID ON cmndb_owner.WIDGET_INSTANCE(OWNER_OID);
CREATE INDEX cmndb_owner.WIDGETWINDOW_INSTANCEOID ON cmndb_owner.WIDGET_WINDOW(INSTANCE_OID);

--*****************************************************************
--
-- Initialization
--
--*****************************************************************
-- Schema version (leave this here to faciliate version checking)

INSERT INTO cmndb_owner.VERSION_INFO (OID,VERSION_MAJOR,VERSION_MINOR,VERSION_RELEASE,VERSION_DEV,VERSION_TIME,DESCRIPTION)
VALUES ('458202233263219661970198300000000000',1,0,0,15,0,'Initialization from install script');

-------------------
-- Create tables for business space--
-------------------

	CREATE TABLE cmndb_owner.BSP_USER_DATA_T (
		  USER_DN                 VARCHAR2(1024) NOT NULL ,
		  EXTENSION               BLOB ,
		  PRIMARY KEY ( USER_DN )
		) 
--TABLESPACE BSPBSPACE
		LOGGING;
-- *****************************************************************
--
-- Licensed Materials - Property of IBM
-- 5725-C94, 5725-C95, 5725-C96
-- (C) Copyright IBM Corporation 2006, 2013. All Rights Reserved.
-- US Government Users Restricted Rights- Use, duplication or
-- disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
--
-- *****************************************************************
-- Scriptfile to create schema for Oracle 9i, 10g, 11g
----------------------------------------------------------------------


-------------------
-- Create tables --
-------------------

CREATE TABLE cmndb_owner.SCHEMA_VERSION
(
  SCHEMA_VERSION                     NUMBER(10,0)         NOT NULL ,
  DATA_MIGRATION                     NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SCHEMA_VERSION ADD(
  PRIMARY KEY ( SCHEMA_VERSION )
);

CREATE TABLE cmndb_owner.PROCESS_TEMPLATE_B_T
(
  PTID                               RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(220)        NOT NULL ,
  DEFINITION_NAME                    VARCHAR2(220)                 ,
  DISPLAY_NAME                       VARCHAR2(64)                  ,
  APPLICATION_NAME                   VARCHAR2(220)                 ,
  DISPLAY_ID                         NUMBER(10,0)         NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  DOCUMENTATION                      CLOB                          ,
  EXECUTION_MODE                     NUMBER(10,0)         NOT NULL ,
  IS_SHARED                          NUMBER(5,0)          NOT NULL ,
  IS_AD_HOC                          NUMBER(5,0)          NOT NULL ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  VALID_FROM                         TIMESTAMP            NOT NULL ,
  TARGET_NAMESPACE                   VARCHAR2(250)                 ,
  CREATED                            TIMESTAMP            NOT NULL ,
  AUTO_DELETE                        NUMBER(5,0)          NOT NULL ,
  EXTENDED_AUTO_DELETE               NUMBER(10,0)         NOT NULL ,
  VERSION                            VARCHAR2(32)                  ,
  SCHEMA_VERSION                     NUMBER(10,0)         NOT NULL ,
  ABSTRACT_BASE_NAME                 VARCHAR2(254)                 ,
  S_BEAN_LOOKUP_NAME                 VARCHAR2(254)                 ,
  S_BEAN60_LOOKUP_NAME               VARCHAR2(254)                 ,
  E_BEAN_LOOKUP_NAME                 VARCHAR2(254)                 ,
  PROCESS_BASE_NAME                  VARCHAR2(254)                 ,
  S_BEAN_HOME_NAME                   VARCHAR2(254)                 ,
  E_BEAN_HOME_NAME                   VARCHAR2(254)                 ,
  BPEWS_UTID                         RAW(16)                       ,
  WPC_UTID                           RAW(16)                       ,
  BPMN_UTID                          RAW(16)                       ,
  BUSINESS_RELEVANCE                 NUMBER(5,0)          NOT NULL ,
  ADMINISTRATOR_QTID                 RAW(16)                       ,
  READER_QTID                        RAW(16)                       ,
  A_TKTID                            RAW(16)                       ,
  A_TKTIDFOR_ACTS                    RAW(16)                       ,
  COMPENSATION_SPHERE                NUMBER(10,0)         NOT NULL ,
  AUTONOMY                           NUMBER(10,0)         NOT NULL ,
  CAN_CALL                           NUMBER(5,0)          NOT NULL ,
  CAN_INITIATE                       NUMBER(5,0)          NOT NULL ,
  CONTINUE_ON_ERROR                  NUMBER(5,0)          NOT NULL ,
  IGNORE_MISSING_DATA                NUMBER(10,0)         NOT NULL ,
  EAR_VERSION                        NUMBER(10,0)         NOT NULL ,
  LANGUAGE_TYPE                      NUMBER(10,0)         NOT NULL ,
  DEPLOY_TYPE                        NUMBER(10,0)         NOT NULL ,
  MESSAGE_DIGEST                     RAW(20)                       ,
  CUSTOM_TEXT1                       VARCHAR2(64)                  ,
  CUSTOM_TEXT2                       VARCHAR2(64)                  ,
  CUSTOM_TEXT3                       VARCHAR2(64)                  ,
  CUSTOM_TEXT4                       VARCHAR2(64)                  ,
  CUSTOM_TEXT5                       VARCHAR2(64)                  ,
  CUSTOM_TEXT6                       VARCHAR2(64)                  ,
  CUSTOM_TEXT7                       VARCHAR2(64)                  ,
  CUSTOM_TEXT8                       VARCHAR2(64)                  
) LOGGING;

ALTER TABLE cmndb_owner.PROCESS_TEMPLATE_B_T ADD(
  PRIMARY KEY ( PTID )
);

CREATE UNIQUE INDEX cmndb_owner.PTB_NAME_VALID ON cmndb_owner.PROCESS_TEMPLATE_B_T
(   
  NAME, VALID_FROM
) LOGGING;

CREATE INDEX cmndb_owner.PTB_NAME_VF_STATE ON cmndb_owner.PROCESS_TEMPLATE_B_T
(   
  NAME, VALID_FROM, STATE, PTID
) LOGGING;

CREATE INDEX cmndb_owner.PTB_TOP_APP ON cmndb_owner.PROCESS_TEMPLATE_B_T
(   
  APPLICATION_NAME
) LOGGING;

CREATE INDEX cmndb_owner.PTB_STATE_PTID ON cmndb_owner.PROCESS_TEMPLATE_B_T
(   
  STATE, PTID
) LOGGING;

CREATE INDEX cmndb_owner.PTB_NAME ON cmndb_owner.PROCESS_TEMPLATE_B_T
(   
  PTID, NAME
) LOGGING;

CREATE INDEX cmndb_owner.PTB_SBLKN ON cmndb_owner.PROCESS_TEMPLATE_B_T
(   
  S_BEAN60_LOOKUP_NAME
) LOGGING;

CREATE TABLE cmndb_owner.PC_VERSION_TEMPLATE_T
(
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  SNAPSHOT_ID                        VARCHAR2(254)        NOT NULL ,
  SNAPSHOT_NAME                      VARCHAR2(254)                 ,
  TOP_LEVEL_TOOLKIT_ACRONYM          VARCHAR2(7)                   ,
  TOP_LEVEL_TOOLKIT_NAME             VARCHAR2(254)                 ,
  TRACK_NAME                         VARCHAR2(254)                 ,
  PROCESS_APP_NAME                   VARCHAR2(254)                 ,
  PROCESS_APP_ACRONYM                VARCHAR2(7)                   ,
  TOOLKIT_SNAPSHOT_ID                VARCHAR2(254)                 ,
  TOOLKIT_SNAPSHOT_NAME              VARCHAR2(254)                 ,
  TOOLKIT_NAME                       VARCHAR2(254)                 ,
  TOOLKIT_ACRONYM                    VARCHAR2(7)                   ,
  IS_TIP                             NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PC_VERSION_TEMPLATE_T ADD(
  PRIMARY KEY ( CONTAINMENT_CONTEXT_ID )
);

CREATE INDEX cmndb_owner.PCV_SPID ON cmndb_owner.PC_VERSION_TEMPLATE_T
(   
  SNAPSHOT_ID
) LOGGING;

CREATE INDEX cmndb_owner.PCV_PAN ON cmndb_owner.PC_VERSION_TEMPLATE_T
(   
  PROCESS_APP_NAME
) LOGGING;

CREATE INDEX cmndb_owner.PCV_PAA ON cmndb_owner.PC_VERSION_TEMPLATE_T
(   
  PROCESS_APP_ACRONYM
) LOGGING;

CREATE INDEX cmndb_owner.PCV_TLTA ON cmndb_owner.PC_VERSION_TEMPLATE_T
(   
  TOP_LEVEL_TOOLKIT_ACRONYM
) LOGGING;

CREATE TABLE cmndb_owner.PROCESS_TEMPLATE_ATTRIBUTE_B_T
(
  PTID                               RAW(16)              NOT NULL ,
  ATTR_KEY                           VARCHAR2(220)        NOT NULL ,
  VALUE                              VARCHAR2(254)                 ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  
) LOGGING;

ALTER TABLE cmndb_owner.PROCESS_TEMPLATE_ATTRIBUTE_B_T ADD(
  PRIMARY KEY ( PTID, ATTR_KEY )
);

CREATE INDEX cmndb_owner.PTAB_PTID ON cmndb_owner.PROCESS_TEMPLATE_ATTRIBUTE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.SCOPE_TEMPLATE_B_T
(
  STID                               RAW(16)              NOT NULL ,
  PARENT_STID                        RAW(16)                       ,
  PTID                               RAW(16)              NOT NULL ,
  COMP_HANDLER_ATID                  RAW(16)                       ,
  IMPLEMENTS_EHTID                   RAW(16)                       ,
  FOR_EACH_ATID                      RAW(16)                       ,
  DISPLAY_ID                         NUMBER(10,0)         NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  ,
  ISOLATED                           NUMBER(5,0)          NOT NULL ,
  IS_COMPENSABLE                     NUMBER(5,0)          NOT NULL ,
  BUSINESS_RELEVANCE                 NUMBER(5,0)          NOT NULL ,
  A_TKTID                            RAW(16)                       ,
  IS_IMPLICIT                        NUMBER(5,0)          NOT NULL ,
  HAS_COMPENSATION_HANDLER           NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SCOPE_TEMPLATE_B_T ADD(
  PRIMARY KEY ( STID )
);

CREATE INDEX cmndb_owner.ST_PTID ON cmndb_owner.SCOPE_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.SERVICE_TEMPLATE_B_T
(
  VTID                               RAW(16)              NOT NULL ,
  PORT_TYPE_NAME                     VARCHAR2(254)        NOT NULL ,
  PORT_TYPE_UTID                     RAW(16)              NOT NULL ,
  OPERATION_NAME                     VARCHAR2(254)        NOT NULL ,
  NAME                               VARCHAR2(254)                 ,
  PTID                               RAW(16)              NOT NULL ,
  TRANSACTION_BEHAVIOR               NUMBER(10,0)         NOT NULL ,
  IS_TWO_WAY                         NUMBER(5,0)          NOT NULL ,
  NUMBER_OF_RECEIVE_ACTS             NUMBER(10,0)         NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SERVICE_TEMPLATE_B_T ADD(
  PRIMARY KEY ( VTID )
);

CREATE INDEX cmndb_owner.VT_VTID_PTUTID ON cmndb_owner.SERVICE_TEMPLATE_B_T
(   
  VTID, PORT_TYPE_UTID
) LOGGING;

CREATE INDEX cmndb_owner.VT_PTID ON cmndb_owner.SERVICE_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.ACTIVITY_SERVICE_TEMPLATE_B_T
(
  ATID                               RAW(16)              NOT NULL ,
  VTID                               RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  PARTNER_LINK_NAME                  VARCHAR2(220)                 ,
  INPUT_CTID                         RAW(16)                       ,
  OUTPUT_CTID                        RAW(16)                       ,
  LINK_ORDER_NUMBER                  NUMBER(10,0)                  ,
  POTENTIAL_OWNER_QTID               RAW(16)                       ,
  READER_QTID                        RAW(16)                       ,
  EDITOR_QTID                        RAW(16)                       ,
  TKTID                              RAW(16)                       ,
  UNDO_MSG_TEMPLATE                  BLOB                          ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  
) LOGGING;

ALTER TABLE cmndb_owner.ACTIVITY_SERVICE_TEMPLATE_B_T ADD(
  PRIMARY KEY ( ATID, VTID, KIND )
);

CREATE INDEX cmndb_owner.AST_PTID ON cmndb_owner.ACTIVITY_SERVICE_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.SERVICE_LOCATION_TEMPLATE_B_T
(
  PTID                               RAW(16)              NOT NULL ,
  VTID                               RAW(16)              NOT NULL ,
  MODULE_NAME                        VARCHAR2(220)        NOT NULL ,
  EXPORT_NAME                        CLOB                          ,
  COMPONENT_NAME                     CLOB                 NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SERVICE_LOCATION_TEMPLATE_B_T ADD(
  PRIMARY KEY ( PTID, VTID )
);

CREATE INDEX cmndb_owner.SLT_PTID ON cmndb_owner.SERVICE_LOCATION_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.SERVICE_FAULT_TEMPLATE_B_T
(
  VTID                               RAW(16)              NOT NULL ,
  FAULT_NAME                         VARCHAR2(220)        NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  MESSAGE_DEFINITION                 BLOB                 NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SERVICE_FAULT_TEMPLATE_B_T ADD(
  PRIMARY KEY ( VTID, FAULT_NAME )
);

CREATE INDEX cmndb_owner.SFT_PTID ON cmndb_owner.SERVICE_FAULT_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.ACTIVITY_TEMPLATE_B_T
(
  ATID                               RAW(16)              NOT NULL ,
  PARENT_STID                        RAW(16)                       ,
  IMPLEMENTS_STID                    RAW(16)                       ,
  PTID                               RAW(16)              NOT NULL ,
  IMPLEMENTS_EHTID                   RAW(16)                       ,
  ENCLOSING_FOR_EACH_ATID            RAW(16)                       ,
  IS_EVENT_HANDLER_END_ACTIVITY      NUMBER(5,0)          NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  NAME                               VARCHAR2(220)                 ,
  DISPLAY_NAME                       VARCHAR2(64)                  ,
  JOIN_CONDITION                     NUMBER(10,0)         NOT NULL ,
  JOIN_CONDITION_NAME                VARCHAR2(254)                 ,
  EXIT_CONDITION                     NUMBER(10,0)         NOT NULL ,
  EXIT_CONDITION_NAME                VARCHAR2(254)                 ,
  EXIT_CONDITION_EXECUTE_AT          NUMBER(10,0)         NOT NULL ,
  NUMBER_OF_LINKS                    NUMBER(10,0)         NOT NULL ,
  SUPPRESS_JOIN_FAILURE              NUMBER(5,0)          NOT NULL ,
  SOURCES_TYPE                       NUMBER(10,0)         NOT NULL ,
  TARGETS_TYPE                       NUMBER(10,0)         NOT NULL ,
  CREATE_INSTANCE                    NUMBER(5,0)                   ,
  IS_END_ACTIVITY                    NUMBER(5,0)          NOT NULL ,
  FAULT_NAME                         VARCHAR2(254)                 ,
  HAS_OWN_FAULT_HANDLER              NUMBER(5,0)          NOT NULL ,
  COMPLEX_BEGIN_ATID                 RAW(16)                       ,
  CORRESPONDING_END_ATID             RAW(16)                       ,
  PARENT_ATID                        RAW(16)                       ,
  HAS_CROSSING_LINK                  NUMBER(5,0)                   ,
  SCRIPT_NAME                        VARCHAR2(254)                 ,
  AFFILIATION                        NUMBER(10,0)         NOT NULL ,
  TRANSACTION_BEHAVIOR               NUMBER(10,0)         NOT NULL ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  DOCUMENTATION                      CLOB                          ,
  BUSINESS_RELEVANCE                 NUMBER(5,0)          NOT NULL ,
  FAULT_NAME_UTID                    RAW(16)                       ,
  FAULT_VARIABLE_CTID                RAW(16)                       ,
  DISPLAY_ID                         NUMBER(10,0)         NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  ,
  IS_TRANSACTIONAL                   NUMBER(5,0)          NOT NULL ,
  CONTINUE_ON_ERROR                  NUMBER(5,0)          NOT NULL ,
  ENCLOSED_FTID                      RAW(16)                       ,
  EXPRESSION                         CLOB                          ,
  EXIT_EXPRESSION                    CLOB                          ,
  HAS_INBOUND_LINK                   NUMBER(5,0)          NOT NULL ,
  COMPENSATION_STID                  RAW(16)                       ,
  COMPENSATION_ATID                  RAW(16)                       ,
  A_TKTID                            RAW(16)                       ,
  IS_IN_GFLOW                        NUMBER(5,0)          NOT NULL ,
  IS_REGION_BEGIN                    NUMBER(5,0)          NOT NULL ,
  CORRESPONDING_IORATID              RAW(16)                       ,
  IS_GFLOW                           NUMBER(5,0)          NOT NULL ,
  CUSTOM_IMPLEMENTATION              BLOB                          ,
  EXPRESSION_MAP                     BLOB                          ,
  EXIT_EXPRESSION_MAP                BLOB                          ,
  GENERATED_BY                       VARCHAR2(220)                 ,
  GATEWAY_DIRECTION                  NUMBER(10,0)         NOT NULL ,
  IS_INTERRUPTING                    NUMBER(5,0)          NOT NULL ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ACTIVITY_TEMPLATE_B_T ADD(
  PRIMARY KEY ( ATID )
);

CREATE INDEX cmndb_owner.ATB_PTID ON cmndb_owner.ACTIVITY_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE INDEX cmndb_owner.ATB_NAME ON cmndb_owner.ACTIVITY_TEMPLATE_B_T
(   
  NAME
) LOGGING;

CREATE INDEX cmndb_owner.ATB_KIND_BR_NAME ON cmndb_owner.ACTIVITY_TEMPLATE_B_T
(   
  KIND, BUSINESS_RELEVANCE, NAME
) LOGGING;

CREATE TABLE cmndb_owner.ALARM_TEMPLATE_B_T
(
  XTID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  EXPRESSION                         BLOB                          ,
  EXPRESSION_NAME                    VARCHAR2(254)                 ,
  DURATION                           VARCHAR2(254)                 ,
  CALENDAR                           VARCHAR2(254)                 ,
  CALENDAR_JNDI_NAME                 VARCHAR2(254)                 ,
  REPEAT_KIND                        NUMBER(10,0)         NOT NULL ,
  REPEAT_EXPRESSION                  BLOB                          ,
  REPEAT_EXP_NAME                    VARCHAR2(254)                 ,
  ON_ALARM_ORDER_NUMBER              NUMBER(10,0)                  ,
  EXPRESSION_MAP                     BLOB                          ,
  REPEAT_EXPRESSION_MAP              BLOB                          ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  
) LOGGING;

ALTER TABLE cmndb_owner.ALARM_TEMPLATE_B_T ADD(
  PRIMARY KEY ( XTID )
);

CREATE INDEX cmndb_owner.XT_PTID ON cmndb_owner.ALARM_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.FAULT_HANDLER_TEMPLATE_B_T
(
  FTID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  FAULT_NAME                         VARCHAR2(254)                 ,
  CTID                               RAW(16)                       ,
  STID                               RAW(16)                       ,
  ATID                               RAW(16)                       ,
  FAULT_LINK_SOURCE_ATID             RAW(16)                       ,
  FAULT_LINK_TARGET_ATID             RAW(16)                       ,
  IMPLEMENTATION_ATID                RAW(16)              NOT NULL ,
  FAULT_NAME_UTID                    RAW(16)                       ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  
) LOGGING;

ALTER TABLE cmndb_owner.FAULT_HANDLER_TEMPLATE_B_T ADD(
  PRIMARY KEY ( FTID )
);

CREATE INDEX cmndb_owner.FT_PTID ON cmndb_owner.FAULT_HANDLER_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.LINK_TEMPLATE_B_T
(
  SOURCE_ATID                        RAW(16)              NOT NULL ,
  TARGET_ATID                        RAW(16)              NOT NULL ,
  FLOW_BEGIN_ATID                    RAW(16)                       ,
  ENCLOSING_FOR_EACH_ATID            RAW(16)                       ,
  DISPLAY_ID                         NUMBER(10,0)         NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  ,
  NAME                               VARCHAR2(254)                 ,
  PTID                               RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  LIFETIME                           NUMBER(10,0)         NOT NULL ,
  TRANSITION_CONDITION               NUMBER(10,0)         NOT NULL ,
  TRANSITION_CONDITION_NAME          VARCHAR2(254)                 ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL ,
  SEQUENCE_NUMBER                    NUMBER(10,0)         NOT NULL ,
  BUSINESS_RELEVANCE                 NUMBER(5,0)          NOT NULL ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  DOCUMENTATION                      CLOB                          ,
  EXPRESSION                         CLOB                          ,
  IS_INBOUND_LINK                    NUMBER(5,0)          NOT NULL ,
  OUTBOUND_ATID                      RAW(16)                       ,
  EXPRESSION_MAP                     BLOB                          ,
  GENERATED_BY                       VARCHAR2(220)                 ,
  RTID                               RAW(16)                       
) LOGGING;

ALTER TABLE cmndb_owner.LINK_TEMPLATE_B_T ADD(
  PRIMARY KEY ( SOURCE_ATID, TARGET_ATID )
);

CREATE INDEX cmndb_owner.LNK_PTID ON cmndb_owner.LINK_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.LINK_BOUNDARY_TEMPLATE_B_T
(
  SOURCE_ATID                        RAW(16)              NOT NULL ,
  TARGET_ATID                        RAW(16)              NOT NULL ,
  BOUNDARY_STID                      RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  IS_OUTMOST_BOUNDARY                NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.LINK_BOUNDARY_TEMPLATE_B_T ADD(
  PRIMARY KEY ( SOURCE_ATID, TARGET_ATID, BOUNDARY_STID )
);

CREATE INDEX cmndb_owner.BND_PTID ON cmndb_owner.LINK_BOUNDARY_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.RESET_TEMPLATE_B_T
(
  LOOP_ENTRY_ATID                    RAW(16)              NOT NULL ,
  LOOP_BODY_ATID                     RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.RESET_TEMPLATE_B_T ADD(
  PRIMARY KEY ( LOOP_ENTRY_ATID, LOOP_BODY_ATID )
);

CREATE INDEX cmndb_owner.RST_PTID ON cmndb_owner.RESET_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.VARIABLE_MAPPING_TEMPLATE_B_T
(
  PTID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  VTID                               RAW(16)              NOT NULL ,
  SOURCE_CTID                        RAW(16)              NOT NULL ,
  TARGET_CTID                        RAW(16)              NOT NULL ,
  PARAMETER                          VARCHAR2(254)        NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.VARIABLE_MAPPING_TEMPLATE_B_T ADD(
  PRIMARY KEY ( PTID, ATID, VTID, SOURCE_CTID, TARGET_CTID )
);

CREATE INDEX cmndb_owner.VMT_TCTID ON cmndb_owner.VARIABLE_MAPPING_TEMPLATE_B_T
(   
  PTID, ATID, VTID, TARGET_CTID
) LOGGING;

CREATE TABLE cmndb_owner.VARIABLE_TEMPLATE_B_T
(
  CTID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  EHTID                              RAW(16)                       ,
  STID                               RAW(16)                       ,
  FTID                               RAW(16)                       ,
  DERIVED                            NUMBER(5,0)          NOT NULL ,
  DISPLAY_ID                         NUMBER(10,0)         NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  ,
  FROM_SPEC                          NUMBER(10,0)         NOT NULL ,
  NAME                               VARCHAR2(254)        NOT NULL ,
  MESSAGE_TEMPLATE                   BLOB                          ,
  IS_QUERYABLE                       NUMBER(5,0)          NOT NULL ,
  BUSINESS_RELEVANCE                 NUMBER(5,0)          NOT NULL ,
  GENERATED_BY                       VARCHAR2(220)                 ,
  SEQUENCE_NUMBER                    NUMBER(10,0)         NOT NULL ,
  FROM_VARIABLE_CTID                 RAW(16)                       ,
  FROM_PARAMETER2                    VARCHAR2(254)                 ,
  FROM_PARAMETER3                    BLOB                          ,
  FROM_PARAMETER3_LANGUAGE           NUMBER(10,0)         NOT NULL ,
  FROM_EXPRESSION_MAP                BLOB                          ,
  ATID                               RAW(16)                       
) LOGGING;

ALTER TABLE cmndb_owner.VARIABLE_TEMPLATE_B_T ADD(
  PRIMARY KEY ( CTID )
);

CREATE INDEX cmndb_owner.CT_PTID ON cmndb_owner.VARIABLE_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.VARIABLE_STACK_TEMPLATE_B_T
(
  VSID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  CTID                               RAW(16)              NOT NULL ,
  STID                               RAW(16)              NOT NULL ,
  FTID                               RAW(16)                       ,
  EHTID                              RAW(16)                       ,
  NAME                               VARCHAR2(255)        NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.VARIABLE_STACK_TEMPLATE_B_T ADD(
  PRIMARY KEY ( VSID )
);

CREATE INDEX cmndb_owner.VS_PTID ON cmndb_owner.VARIABLE_STACK_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.ACTIVITY_FAULT_TEMPLATE_B_T
(
  AFID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  FAULT_NAME                         VARCHAR2(254)        NOT NULL ,
  FAULT_UTID                         RAW(16)                       ,
  MESSAGE                            BLOB                 NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ACTIVITY_FAULT_TEMPLATE_B_T ADD(
  PRIMARY KEY ( AFID )
);

CREATE INDEX cmndb_owner.AF_PTID ON cmndb_owner.ACTIVITY_FAULT_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.PARTNER_LINK_TEMPLATE_B_T
(
  PTID                               RAW(16)              NOT NULL ,
  PARTNER_LINK_NAME                  VARCHAR2(220)        NOT NULL ,
  PROCESS_NAME                       VARCHAR2(220)                 ,
  TARGET_NAMESPACE                   VARCHAR2(250)                 ,
  RESOLUTION_SCOPE                   NUMBER(10,0)         NOT NULL ,
  MY_ROLE                            NUMBER(5,0)          NOT NULL ,
  MY_ROLE_IMPL                       BLOB                          ,
  MY_ROLE_LOCALNAME                  VARCHAR2(220)                 ,
  MY_ROLE_NAMESPACE                  VARCHAR2(220)                 ,
  THEIR_ROLE                         NUMBER(5,0)          NOT NULL ,
  THEIR_ROLE_IMPL                    BLOB                          ,
  THEIR_ROLE_LOCALNAME               VARCHAR2(220)                 ,
  THEIR_ROLE_NAMESPACE               VARCHAR2(220)                 ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  
) LOGGING;

ALTER TABLE cmndb_owner.PARTNER_LINK_TEMPLATE_B_T ADD(
  PRIMARY KEY ( PTID, PARTNER_LINK_NAME )
);

CREATE TABLE cmndb_owner.URI_TEMPLATE_B_T
(
  UTID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  URI                                VARCHAR2(220)                 
) LOGGING;

ALTER TABLE cmndb_owner.URI_TEMPLATE_B_T ADD(
  PRIMARY KEY ( UTID )
);

CREATE UNIQUE INDEX cmndb_owner.UT_PTID_URI ON cmndb_owner.URI_TEMPLATE_B_T
(   
  PTID, URI
) LOGGING;

CREATE INDEX cmndb_owner.UT_UTID_URI ON cmndb_owner.URI_TEMPLATE_B_T
(   
  UTID, URI
) LOGGING;

CREATE TABLE cmndb_owner.CLIENT_SETTING_TEMPLATE_B_T
(
  CSID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)                       ,
  PTID                               RAW(16)              NOT NULL ,
  VTID                               RAW(16)                       ,
  SETTINGS                           BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.CLIENT_SETTING_TEMPLATE_B_T ADD(
  PRIMARY KEY ( CSID )
);

CREATE INDEX cmndb_owner.CS_PTID ON cmndb_owner.CLIENT_SETTING_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.ASSIGN_TEMPLATE_B_T
(
  ATID                               RAW(16)              NOT NULL ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  FROM_SPEC                          NUMBER(10,0)         NOT NULL ,
  FROM_VARIABLE_CTID                 RAW(16)                       ,
  FROM_PARAMETER2                    VARCHAR2(254)                 ,
  FROM_PARAMETER3                    BLOB                          ,
  FROM_PARAMETER3_LANGUAGE           NUMBER(10,0)         NOT NULL ,
  TO_SPEC                            NUMBER(10,0)         NOT NULL ,
  TO_VARIABLE_CTID                   RAW(16)                       ,
  TO_PARAMETER2                      VARCHAR2(254)                 ,
  TO_PARAMETER3                      BLOB                          ,
  TO_PARAMETER3_LANGUAGE             NUMBER(10,0)         NOT NULL ,
  FROM_EXPRESSION_MAP                BLOB                          ,
  TO_EXPRESSION_MAP                  BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.ASSIGN_TEMPLATE_B_T ADD(
  PRIMARY KEY ( ATID, ORDER_NUMBER )
);

CREATE INDEX cmndb_owner.ASTB_PTID ON cmndb_owner.ASSIGN_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.CORRELATION_SET_TEMPLATE_B_T
(
  COID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  STID                               RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(255)        NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  
) LOGGING;

ALTER TABLE cmndb_owner.CORRELATION_SET_TEMPLATE_B_T ADD(
  PRIMARY KEY ( COID )
);

CREATE INDEX cmndb_owner.CSTB_PTID ON cmndb_owner.CORRELATION_SET_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.CORRELATION_TEMPLATE_B_T
(
  ATID                               RAW(16)              NOT NULL ,
  VTID                               RAW(16)              NOT NULL ,
  COID                               RAW(16)              NOT NULL ,
  IS_FOR_EVENT_HANDLER               NUMBER(5,0)          NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  INITIATE                           NUMBER(10,0)         NOT NULL ,
  PATTERN                            NUMBER(10,0)         NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CORRELATION_TEMPLATE_B_T ADD(
  PRIMARY KEY ( ATID, VTID, COID, IS_FOR_EVENT_HANDLER )
);

CREATE INDEX cmndb_owner.COID_PTID ON cmndb_owner.CORRELATION_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.PROPERTY_ALIAS_TEMPLATE_B_T
(
  PAID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  COID                               RAW(16)              NOT NULL ,
  SEQUENCE_NUMBER                    NUMBER(10,0)         NOT NULL ,
  PROPERTY_UTID                      RAW(16)              NOT NULL ,
  PROPERTY_NAME                      VARCHAR2(255)        NOT NULL ,
  JAVA_TYPE                          VARCHAR2(255)        NOT NULL ,
  MSG_TYPE_UTID                      RAW(16)              NOT NULL ,
  MSG_TYPE_NAME                      VARCHAR2(255)        NOT NULL ,
  MSG_TYPE_KIND                      NUMBER(10,0)         NOT NULL ,
  PROPERTY_TYPE_UTID                 RAW(16)                       ,
  PROPERTY_TYPE_NAME                 VARCHAR2(255)                 ,
  PART                               VARCHAR2(255)                 ,
  QUERY                              VARCHAR2(255)                 ,
  QUERY_LANGUAGE                     NUMBER(10,0)         NOT NULL ,
  IS_DEFINED_INLINE                  NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PROPERTY_ALIAS_TEMPLATE_B_T ADD(
  PRIMARY KEY ( PAID )
);

CREATE INDEX cmndb_owner.PATB_COID_UTID ON cmndb_owner.PROPERTY_ALIAS_TEMPLATE_B_T
(   
  COID, MSG_TYPE_UTID
) LOGGING;

CREATE INDEX cmndb_owner.PATB_PTID_UTIDS ON cmndb_owner.PROPERTY_ALIAS_TEMPLATE_B_T
(   
  PTID, MSG_TYPE_UTID, PROPERTY_UTID
) LOGGING;

CREATE TABLE cmndb_owner.EVENT_HANDLER_TEMPLATE_B_T
(
  EHTID                              RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  STID                               RAW(16)              NOT NULL ,
  IMPL_ATID                          RAW(16)              NOT NULL ,
  VTID                               RAW(16)                       ,
  INPUT_CTID                         RAW(16)                       ,
  TKTID                              RAW(16)                       ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  
) LOGGING;

ALTER TABLE cmndb_owner.EVENT_HANDLER_TEMPLATE_B_T ADD(
  PRIMARY KEY ( EHTID )
);

CREATE INDEX cmndb_owner.EHT_PTID ON cmndb_owner.EVENT_HANDLER_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.EHALARM_TEMPLATE_B_T
(
  EHTID                              RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  EXPRESSION                         BLOB                          ,
  EXPRESSION_NAME                    VARCHAR2(254)                 ,
  DURATION                           VARCHAR2(254)                 ,
  CALENDAR                           VARCHAR2(254)                 ,
  CALENDAR_JNDI_NAME                 VARCHAR2(254)                 ,
  REPEAT_KIND                        NUMBER(10,0)         NOT NULL ,
  REPEAT_EXPRESSION                  BLOB                          ,
  REPEAT_EXP_NAME                    VARCHAR2(254)                 ,
  REPEAT_DURATION                    VARCHAR2(254)                 ,
  REPEAT_CALENDAR                    VARCHAR2(254)                 ,
  REPEAT_CALENDAR_JNDI_NAME          VARCHAR2(254)                 ,
  EXPRESSION_MAP                     BLOB                          ,
  REPEAT_EXPRESSION_MAP              BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.EHALARM_TEMPLATE_B_T ADD(
  PRIMARY KEY ( EHTID )
);

CREATE INDEX cmndb_owner.EXT_PTID ON cmndb_owner.EHALARM_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.CUSTOM_EXT_TEMPLATE_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  NAMESPACE                          VARCHAR2(220)        NOT NULL ,
  LOCALNAME                          VARCHAR2(220)        NOT NULL ,
  TEMPLATE_INFO                      BLOB                          ,
  INSTANCE_INFO                      BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.CUSTOM_EXT_TEMPLATE_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.CETB_PTID ON cmndb_owner.CUSTOM_EXT_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.CUSTOM_STMT_TEMPLATE_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  NAMESPACE                          VARCHAR2(220)        NOT NULL ,
  LOCALNAME                          VARCHAR2(220)        NOT NULL ,
  PURPOSE                            VARCHAR2(220)        NOT NULL ,
  STATEMENT                          BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.CUSTOM_STMT_TEMPLATE_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.CST_PTID_NS_LN_P ON cmndb_owner.CUSTOM_STMT_TEMPLATE_B_T
(   
  PTID, NAMESPACE, LOCALNAME, PURPOSE
) LOGGING;

CREATE TABLE cmndb_owner.PROCESS_CELL_MAP_T
(
  PTID                               RAW(16)              NOT NULL ,
  CELL                               VARCHAR2(220)        NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PROCESS_CELL_MAP_T ADD(
  PRIMARY KEY ( PTID, CELL )
);

CREATE TABLE cmndb_owner.ACTIVITY_TEMPLATE_ATTR_B_T
(
  ATID                               RAW(16)              NOT NULL ,
  ATTR_KEY                           VARCHAR2(192)        NOT NULL ,
  ATTR_VALUE                         VARCHAR2(254)                 ,
  PTID                               RAW(16)              NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  
) LOGGING;

ALTER TABLE cmndb_owner.ACTIVITY_TEMPLATE_ATTR_B_T ADD(
  PRIMARY KEY ( ATID, ATTR_KEY )
);

CREATE INDEX cmndb_owner.ATAB_PTID ON cmndb_owner.ACTIVITY_TEMPLATE_ATTR_B_T
(   
  PTID
) LOGGING;

CREATE INDEX cmndb_owner.ATAB_VALUE ON cmndb_owner.ACTIVITY_TEMPLATE_ATTR_B_T
(   
  ATTR_VALUE
) LOGGING;

CREATE TABLE cmndb_owner.FOR_EACH_TEMPLATE_B_T
(
  ATID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  COUNTER_CTID                       RAW(16)              NOT NULL ,
  SUCCESSFUL_BRANCHES_ONLY           NUMBER(5,0)          NOT NULL ,
  START_COUNTER_LANGUAGE             NUMBER(10,0)         NOT NULL ,
  FINAL_COUNTER_LANGUAGE             NUMBER(10,0)         NOT NULL ,
  COMPLETION_CONDITION_LANGUAGE      NUMBER(10,0)         NOT NULL ,
  START_COUNTER_EXPRESSION           BLOB                          ,
  FINAL_COUNTER_EXPRESSION           BLOB                          ,
  COMPLETION_COND_EXPRESSION         BLOB                          ,
  FOR_EACH_METHOD                    VARCHAR2(254)                 ,
  START_COUNTER_EXPRESSION_MAP       BLOB                          ,
  FINAL_COUNTER_EXPRESSION_MAP       BLOB                          ,
  COMPLETION_COND_EXPRESSION_MAP     BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.FOR_EACH_TEMPLATE_B_T ADD(
  PRIMARY KEY ( ATID )
);

CREATE INDEX cmndb_owner.FET_PTID ON cmndb_owner.FOR_EACH_TEMPLATE_B_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.GRAPHICAL_PROCESS_MODEL_T
(
  PTID                               RAW(16)              NOT NULL ,
  SOURCE                             VARCHAR2(100)        NOT NULL ,
  KIND                               VARCHAR2(100)        NOT NULL ,
  GRAPHICAL_DATA                     BLOB                          ,
  ID_MAPPING                         BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.GRAPHICAL_PROCESS_MODEL_T ADD(
  PRIMARY KEY ( PTID, SOURCE, KIND )
);

CREATE TABLE cmndb_owner.QUERYABLE_VARIABLE_TEMPLATE_T
(
  PKID                               RAW(16)              NOT NULL ,
  CTID                               RAW(16)              NOT NULL ,
  PAID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  QUERY_TYPE                         NUMBER(10,0)         NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.QUERYABLE_VARIABLE_TEMPLATE_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.QVT_PTID ON cmndb_owner.QUERYABLE_VARIABLE_TEMPLATE_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.MIGRATION_PLAN_TEMPLATE_T
(
  MPTID                              RAW(16)              NOT NULL ,
  SOURCE_PTID                        RAW(16)              NOT NULL ,
  TARGET_PTID                        RAW(16)              NOT NULL ,
  TYPE                               NUMBER(10,0)         NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.MIGRATION_PLAN_TEMPLATE_T ADD(
  PRIMARY KEY ( MPTID )
);

CREATE UNIQUE INDEX cmndb_owner.MPT_PTIDS ON cmndb_owner.MIGRATION_PLAN_TEMPLATE_T
(   
  SOURCE_PTID, TARGET_PTID
) LOGGING;

CREATE INDEX cmndb_owner.MPT_TPTID ON cmndb_owner.MIGRATION_PLAN_TEMPLATE_T
(   
  TARGET_PTID
) LOGGING;

CREATE TABLE cmndb_owner.IDMAPPING_TEMPLATE_T
(
  MPTID                              RAW(16)              NOT NULL ,
  SOURCE_OID                         RAW(16)              NOT NULL ,
  TARGET_OID                         RAW(16)              NOT NULL ,
  SOURCE_PTID                        RAW(16)              NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.IDMAPPING_TEMPLATE_T ADD(
  PRIMARY KEY ( MPTID, SOURCE_OID )
);

CREATE INDEX cmndb_owner.IDMT_PTID ON cmndb_owner.IDMAPPING_TEMPLATE_T
(   
  SOURCE_PTID
) LOGGING;

CREATE TABLE cmndb_owner.CHANGE_GROUP_TEMPLATE_T
(
  CGTID                              RAW(16)              NOT NULL ,
  MPTID                              RAW(16)              NOT NULL ,
  SOURCE_PTID                        RAW(16)              NOT NULL ,
  MANDATORY                          NUMBER(5,0)          NOT NULL ,
  CHANGES                            CLOB                 NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CHANGE_GROUP_TEMPLATE_T ADD(
  PRIMARY KEY ( CGTID )
);

CREATE INDEX cmndb_owner.CGT_MT ON cmndb_owner.CHANGE_GROUP_TEMPLATE_T
(   
  MPTID
) LOGGING;

CREATE INDEX cmndb_owner.CGT_PT ON cmndb_owner.CHANGE_GROUP_TEMPLATE_T
(   
  SOURCE_PTID
) LOGGING;

CREATE TABLE cmndb_owner.CHANGE_GROUP_IMPACT_TEMPLATE_T
(
  CGTID                              RAW(16)              NOT NULL ,
  SOURCE_ATID                        RAW(16)              NOT NULL ,
  MPTID                              RAW(16)              NOT NULL ,
  SOURCE_PTID                        RAW(16)              NOT NULL ,
  RELATIONSHIP                       NUMBER(10,0)         NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CHANGE_GROUP_IMPACT_TEMPLATE_T ADD(
  PRIMARY KEY ( CGTID, SOURCE_ATID )
);

CREATE INDEX cmndb_owner.CGIT_MT ON cmndb_owner.CHANGE_GROUP_IMPACT_TEMPLATE_T
(   
  MPTID
) LOGGING;

CREATE INDEX cmndb_owner.CGIT_PT ON cmndb_owner.CHANGE_GROUP_IMPACT_TEMPLATE_T
(   
  SOURCE_PTID
) LOGGING;

CREATE TABLE cmndb_owner.MIGRATION_PLAN_VAR_TEMPLATE_T
(
  MPTID                              RAW(16)              NOT NULL ,
  TARGET_CTID                        RAW(16)              NOT NULL ,
  TARGET_STID                        RAW(16)              NOT NULL ,
  SOURCE_PTID                        RAW(16)              NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.MIGRATION_PLAN_VAR_TEMPLATE_T ADD(
  PRIMARY KEY ( MPTID, TARGET_CTID )
);

CREATE INDEX cmndb_owner.MPVT_PT ON cmndb_owner.MIGRATION_PLAN_VAR_TEMPLATE_T
(   
  SOURCE_PTID
) LOGGING;

CREATE TABLE cmndb_owner.REGION_TEMPLATE_T
(
  RTID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  BEGIN_ATID                         RAW(16)                       ,
  END_ATID                           RAW(16)                       ,
  REGION_TYPE                        NUMBER(10,0)         NOT NULL ,
  BEGIN_ORDER_NUMBER                 NUMBER(10,0)         NOT NULL ,
  PARENT_RTID                        RAW(16)                       
) LOGGING;

ALTER TABLE cmndb_owner.REGION_TEMPLATE_T ADD(
  PRIMARY KEY ( RTID )
);

CREATE INDEX cmndb_owner.RGT_PTID ON cmndb_owner.REGION_TEMPLATE_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.REGION_CONTENT_TEMPLATE_T
(
  RTID                               RAW(16)              NOT NULL ,
  CONTAINED_ATID                     RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.REGION_CONTENT_TEMPLATE_T ADD(
  PRIMARY KEY ( RTID, CONTAINED_ATID )
);

CREATE INDEX cmndb_owner.RCT_PTID ON cmndb_owner.REGION_CONTENT_TEMPLATE_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.CHANGE_TEMPLATE_T
(
  PKID                               RAW(16)              NOT NULL ,
  MPTID                              RAW(16)              NOT NULL ,
  PROPERTY                           NUMBER(10,0)         NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR2(32)         NOT NULL ,
  CHANGE_TYPE                        NUMBER(10,0)         NOT NULL ,
  SOURCE_PTID                        RAW(16)              NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CHANGE_TEMPLATE_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE UNIQUE INDEX cmndb_owner.CT_MTPDIS ON cmndb_owner.CHANGE_TEMPLATE_T
(   
  MPTID, PROPERTY, DISPLAY_ID_EXT
) LOGGING;

CREATE INDEX cmndb_owner.CGT_PTID ON cmndb_owner.CHANGE_TEMPLATE_T
(   
  SOURCE_PTID
) LOGGING;

CREATE TABLE cmndb_owner.DATA_ASSIGNMENT_TEMPLATE_T
(
  PKID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  DATA_ASSOCIATION_TYPE              NUMBER(10,0)         NOT NULL ,
  SOURCE_REF_CTID                    RAW(16)                       ,
  TARGET_REF_CTID                    RAW(16)                       ,
  FROM_EXPRESSION                    BLOB                          ,
  FROM_EXPRESSION_MAP                BLOB                          ,
  TO_EXPRESSION                      BLOB                          ,
  TO_EXPRESSION_MAP                  BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.DATA_ASSIGNMENT_TEMPLATE_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.DATB_PTID ON cmndb_owner.DATA_ASSIGNMENT_TEMPLATE_T
(   
  PTID
) LOGGING;

CREATE INDEX cmndb_owner.DATB_ATID_DATA ON cmndb_owner.DATA_ASSIGNMENT_TEMPLATE_T
(   
  ATID, DATA_ASSOCIATION_TYPE
) LOGGING;

CREATE TABLE cmndb_owner.DATA_VISIBILITY_TEMPLATE_T
(
  VSID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  CTID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(255)        NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.DATA_VISIBILITY_TEMPLATE_T ADD(
  PRIMARY KEY ( VSID )
);

CREATE INDEX cmndb_owner.DVT_PTID ON cmndb_owner.DATA_VISIBILITY_TEMPLATE_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.LOOP_CHAR_TEMPLATE_T
(
  ATID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  LOOP_TYPE                          NUMBER(10,0)         NOT NULL ,
  CONDITION                          BLOB                          ,
  CONDITION_PREFIX_MAP               BLOB                          ,
  LOOP_MAXIMUM                       NUMBER(10,0)                  
) LOGGING;

ALTER TABLE cmndb_owner.LOOP_CHAR_TEMPLATE_T ADD(
  PRIMARY KEY ( ATID )
);

CREATE TABLE cmndb_owner.IORCOUNTER_TEMPLATE_T
(
  PKID                               RAW(16)              NOT NULL ,
  SOURCE_ATID                        RAW(16)              NOT NULL ,
  TARGET_ATID                        RAW(16)              NOT NULL ,
  GATEWAY_ATID                       RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  COUNTER_ID                         CLOB                 NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.IORCOUNTER_TEMPLATE_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.IOR_CNT_SRC_TRGT ON cmndb_owner.IORCOUNTER_TEMPLATE_T
(   
  SOURCE_ATID, TARGET_ATID
) LOGGING;

CREATE INDEX cmndb_owner.IOR_CNT_PTID ON cmndb_owner.IORCOUNTER_TEMPLATE_T
(   
  PTID
) LOGGING;

CREATE TABLE cmndb_owner.ERROR_EVENT_TEMPLATE_T
(
  PKID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  ERROR_NAME                         VARCHAR2(254)                 ,
  ERROR_NAME_UTID                    RAW(16)                       ,
  ERROR_MESSAGE_DEFINITION           BLOB                          ,
  CTID                               RAW(16)                       ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ERROR_EVENT_TEMPLATE_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE TABLE cmndb_owner.STAFF_QUERY_TEMPLATE_T
(
  QTID                               RAW(16)              NOT NULL ,
  ASSOCIATED_OBJECT_TYPE             NUMBER(10,0)         NOT NULL ,
  ASSOCIATED_OID                     RAW(16)              NOT NULL ,
  T_QUERY                            VARCHAR2(32)         NOT NULL ,
  QUERY                              BLOB                 NOT NULL ,
  HASH_CODE                          NUMBER(10,0)         NOT NULL ,
  SUBSTITUTION_POLICY                NUMBER(10,0)         NOT NULL ,
  STAFF_VERB                         BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.STAFF_QUERY_TEMPLATE_T ADD(
  PRIMARY KEY ( QTID )
);

CREATE INDEX cmndb_owner.SQT_HASH ON cmndb_owner.STAFF_QUERY_TEMPLATE_T
(   
  ASSOCIATED_OID, HASH_CODE, T_QUERY, ASSOCIATED_OBJECT_TYPE
) LOGGING;

CREATE TABLE cmndb_owner.PROCESS_INSTANCE_B_T
(
  PIID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  SHARED_PC_ID                       RAW(16)                       ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  PENDING_REQUEST                    NUMBER(10,0)         NOT NULL ,
  CREATED                            TIMESTAMP                     ,
  STARTED                            TIMESTAMP                     ,
  COMPLETED                          TIMESTAMP                     ,
  LAST_STATE_CHANGE                  TIMESTAMP                     ,
  LAST_MODIFIED                      TIMESTAMP                     ,
  NAME                               VARCHAR2(220)        NOT NULL ,
  PARENT_NAME                        VARCHAR2(220)                 ,
  TOP_LEVEL_NAME                     VARCHAR2(220)        NOT NULL ,
  COMPENSATION_SPHERE_NAME           VARCHAR2(100)                 ,
  STARTER                            VARCHAR2(128)                 ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  INPUT_SNID                         RAW(16)                       ,
  INPUT_ATID                         RAW(16)                       ,
  INPUT_VTID                         RAW(16)                       ,
  OUTPUT_SNID                        RAW(16)                       ,
  OUTPUT_ATID                        RAW(16)                       ,
  OUTPUT_VTID                        RAW(16)                       ,
  FAULT_NAME                         VARCHAR2(254)                 ,
  TOP_LEVEL_PIID                     RAW(16)              NOT NULL ,
  PARENT_PIID                        RAW(16)                       ,
  PARENT_AIID                        RAW(16)                       ,
  TKIID                              RAW(16)                       ,
  TERMIN_ON_REC                      NUMBER(5,0)          NOT NULL ,
  AWAITED_SUB_PROC                   NUMBER(5,0)          NOT NULL ,
  IS_CREATING                        NUMBER(5,0)          NOT NULL ,
  PREVIOUS_STATE                     NUMBER(10,0)                  ,
  EXECUTING_ISOLATED_SCOPE           NUMBER(5,0)          NOT NULL ,
  SCHEDULER_TASK_ID                  VARCHAR2(254)                 ,
  RESUMES                            TIMESTAMP                     ,
  PENDING_SKIP_REQUEST               NUMBER(5,0)          NOT NULL ,
  IS_MIGRATED                        NUMBER(5,0)          NOT NULL ,
  UNHANDLED_EXCEPTION                BLOB                          ,
  ERROR_EVENT_ATID                   RAW(16)                       ,
  CREATED_WITH_VERSION               NUMBER(10,0)         NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  CUSTOM_TEXT1                       VARCHAR2(64)                  ,
  CUSTOM_TEXT2                       VARCHAR2(64)                  ,
  CUSTOM_TEXT3                       VARCHAR2(64)                  ,
  CUSTOM_TEXT4                       VARCHAR2(64)                  ,
  CUSTOM_TEXT5                       VARCHAR2(64)                  ,
  CUSTOM_TEXT6                       VARCHAR2(64)                  ,
  CUSTOM_TEXT7                       VARCHAR2(64)                  ,
  CUSTOM_TEXT8                       VARCHAR2(64)                  ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PROCESS_INSTANCE_B_T ADD(
  PRIMARY KEY ( PIID )
);

CREATE UNIQUE INDEX cmndb_owner.PIB_NAME ON cmndb_owner.PROCESS_INSTANCE_B_T
(   
  NAME
) LOGGING;

CREATE INDEX cmndb_owner.PIB_TOP ON cmndb_owner.PROCESS_INSTANCE_B_T
(   
  TOP_LEVEL_PIID
) LOGGING;

CREATE INDEX cmndb_owner.PIB_PAP ON cmndb_owner.PROCESS_INSTANCE_B_T
(   
  PARENT_PIID
) LOGGING;

CREATE INDEX cmndb_owner.PIB_PAR ON cmndb_owner.PROCESS_INSTANCE_B_T
(   
  PARENT_AIID
) LOGGING;

CREATE INDEX cmndb_owner.PIB_PTID ON cmndb_owner.PROCESS_INSTANCE_B_T
(   
  PTID
) LOGGING;

CREATE INDEX cmndb_owner.PIB_WSID1 ON cmndb_owner.PROCESS_INSTANCE_B_T
(   
  WSID_1, STATE
) LOGGING;

CREATE INDEX cmndb_owner.PIB_WSID2 ON cmndb_owner.PROCESS_INSTANCE_B_T
(   
  WSID_2, STATE
) LOGGING;

CREATE INDEX cmndb_owner.PIB_STA_PT_ST2_PI ON cmndb_owner.PROCESS_INSTANCE_B_T
(   
  STATE, PTID, STARTER, STARTED, PIID
) LOGGING;

CREATE TABLE cmndb_owner.SCOPE_INSTANCE_B_T
(
  SIID                               RAW(16)              NOT NULL ,
  PARENT_SIID                        RAW(16)                       ,
  STID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  EHIID                              RAW(16)                       ,
  ENCLOSING_FEIID                    RAW(16)                       ,
  ENCLOSING_FOR_EACH_END_AIID        RAW(16)                       ,
  COMPENSATE_AIID                    RAW(16)                       ,
  PARENT_COMP_SIID                   RAW(16)                       ,
  LAST_COMP_SIID                     RAW(16)                       ,
  RUNNING_EVENT_HANDLERS             NUMBER(10,0)         NOT NULL ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  NOTIFY_PARENT                      NUMBER(5,0)          NOT NULL ,
  AWAITED_SCOPES                     NUMBER(10,0)         NOT NULL ,
  AWAITED_SUB_PROCESSES              NUMBER(10,0)         NOT NULL ,
  BPEL_EXCEPTION                     BLOB                          ,
  IS_ACTIVE                          NUMBER(5,0)          NOT NULL ,
  INITIATED_COMP                     NUMBER(5,0)          NOT NULL ,
  IS_TERMINATION_FROM_FOR_EACH       NUMBER(5,0)          NOT NULL ,
  TOTAL_COMPL_NUMBER                 NUMBER(20,0)         NOT NULL ,
  SCOPE_COMPL_NUMBER                 NUMBER(20,0)         NOT NULL ,
  A_TKIID                            RAW(16)                       ,
  HAS_COMPENSATION_WORK              NUMBER(5,0)          NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SCOPE_INSTANCE_B_T ADD(
  PRIMARY KEY ( SIID )
);

CREATE INDEX cmndb_owner.SI_PI_ST_EH_ACT_FE ON cmndb_owner.SCOPE_INSTANCE_B_T
(   
  PIID, STID, IS_ACTIVE, EHIID, ENCLOSING_FEIID
) LOGGING;

CREATE INDEX cmndb_owner.SI_PIID_PARSI ON cmndb_owner.SCOPE_INSTANCE_B_T
(   
  PIID, PARENT_SIID, IS_ACTIVE
) LOGGING;

CREATE INDEX cmndb_owner.SI_PARCOMP_STA_ST ON cmndb_owner.SCOPE_INSTANCE_B_T
(   
  PARENT_COMP_SIID, STATE, STID
) LOGGING;

CREATE INDEX cmndb_owner.SI_PIID_STATE ON cmndb_owner.SCOPE_INSTANCE_B_T
(   
  PIID, STATE
) LOGGING;

CREATE INDEX cmndb_owner.SI_LAST_COMPSIID ON cmndb_owner.SCOPE_INSTANCE_B_T
(   
  LAST_COMP_SIID
) LOGGING;

CREATE INDEX cmndb_owner.SI_PI_ST_EH_FE_STA ON cmndb_owner.SCOPE_INSTANCE_B_T
(   
  PIID, STID, EHIID, ENCLOSING_FEIID, STATE
) LOGGING;

CREATE INDEX cmndb_owner.SI_PARCOMP_STA_SCN ON cmndb_owner.SCOPE_INSTANCE_B_T
(   
  PARENT_COMP_SIID, STATE, SCOPE_COMPL_NUMBER
) LOGGING;

CREATE TABLE cmndb_owner.ACTIVITY_INSTANCE_B_T
(
  AIID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  SIID                               RAW(16)                       ,
  PIID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  EHIID                              RAW(16)                       ,
  ENCLOSING_FEIID                    RAW(16)                       ,
  ICIID                              RAW(16)                       ,
  PARENT_AIID                        RAW(16)                       ,
  ERROR_EVENT_ATID                   RAW(16)                       ,
  P_TKIID                            RAW(16)                       ,
  A_TKIID                            RAW(16)                       ,
  INVOKED_INSTANCE_ID                RAW(16)                       ,
  INVOKED_INSTANCE_TYPE              NUMBER(10,0)         NOT NULL ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  BPMN_STATE                         NUMBER(10,0)         NOT NULL ,
  TRANS_COND_VALUES                  RAW(66)              NOT NULL ,
  NUMBER_LINKS_EVALUATED             NUMBER(10,0)         NOT NULL ,
  FINISHED                           TIMESTAMP                     ,
  ACTIVATED                          TIMESTAMP                     ,
  FIRST_ACTIVATED                    TIMESTAMP                     ,
  STARTED                            TIMESTAMP                     ,
  LAST_MODIFIED                      TIMESTAMP                     ,
  LAST_STATE_CHANGE                  TIMESTAMP                     ,
  OWNER                              VARCHAR2(128)                 ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  LINK_ORDER_NUMBER                  NUMBER(10,0)                  ,
  SCHEDULER_TASK_ID                  VARCHAR2(254)                 ,
  EXPIRES                            TIMESTAMP                     ,
  CONTINUE_ON_ERROR                  NUMBER(5,0)          NOT NULL ,
  UNHANDLED_EXCEPTION                BLOB                          ,
  STOP_REASON                        NUMBER(10,0)         NOT NULL ,
  PREVIOUS_STATE                     NUMBER(10,0)                  ,
  INVOCATION_COUNTER                 NUMBER(10,0)         NOT NULL ,
  FOR_EACH_START_COUNTER_VALUE       NUMBER(20,0)                  ,
  FOR_EACH_FINAL_COUNTER_VALUE       NUMBER(20,0)                  ,
  FOR_EACH_CURRENT_COUNTER_VALUE     NUMBER(20,0)                  ,
  FOR_EACH_COMPLETED_BRANCHES        NUMBER(20,0)                  ,
  FOR_EACH_FAILED_BRANCHES           NUMBER(20,0)                  ,
  FOR_EACH_MAX_COMPL_BRANCHES        NUMBER(20,0)                  ,
  FOR_EACH_AWAITED_BRANCHES          NUMBER(20,0)                  ,
  IS51_ACTIVITY                      NUMBER(5,0)          NOT NULL ,
  MAY_HAVE_SUBPROCESS                NUMBER(5,0)                   ,
  SKIP_REQUESTED                     NUMBER(5,0)          NOT NULL ,
  JUMP_TARGET_ATID                   RAW(16)                       ,
  SUB_STATE                          NUMBER(10,0)         NOT NULL ,
  PENDING_REQUEST_DATA               BLOB                          ,
  XTID                               RAW(16)                       ,
  EXPIRATION_COUNTER                 NUMBER(10,0)                  ,
  PREVIOUS_EXPIRATION_DATE           TIMESTAMP                     ,
  TARGET_IORAIID                     RAW(16)                       ,
  DISPLAY_ID_EXT                     VARCHAR2(32)                  ,
  MAX_COMPENSATION_NUMBER            NUMBER(20,0)                  ,
  HAS_WORK_ITEM                      NUMBER(5,0)                   ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  LOOP_COUNTER                       NUMBER(10,0)                  ,
  AWAITED_ACTIVITIES                 NUMBER(10,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ACTIVITY_INSTANCE_B_T ADD(
  PRIMARY KEY ( AIID )
);

CREATE INDEX cmndb_owner.AIB_PI_EH_FE_AT ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  PIID, EHIID, ENCLOSING_FEIID, ATID
) LOGGING;

CREATE INDEX cmndb_owner.AIB_PI_EH_EF_DIS ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  PIID, EHIID, ENCLOSING_FEIID, DISPLAY_ID_EXT
) LOGGING;

CREATE INDEX cmndb_owner.AIB_IC_PI_AT ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  ICIID, PIID, ATID
) LOGGING;

CREATE INDEX cmndb_owner.AIB_PTID ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  PTID
) LOGGING;

CREATE INDEX cmndb_owner.AIB_PI_STA_AI ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  PIID, STATE, AIID
) LOGGING;

CREATE INDEX cmndb_owner.AIB_SIID ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  SIID
) LOGGING;

CREATE INDEX cmndb_owner.AIB_ATID_STAT ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  ATID, STATE
) LOGGING;

CREATE INDEX cmndb_owner.AIB_PI_AT ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  PIID, ATID
) LOGGING;

CREATE INDEX cmndb_owner.AIB_WSID1 ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  WSID_1, STATE
) LOGGING;

CREATE INDEX cmndb_owner.AIB_WSID2 ON cmndb_owner.ACTIVITY_INSTANCE_B_T
(   
  WSID_2, STATE
) LOGGING;

CREATE TABLE cmndb_owner.VARIABLE_INSTANCE_B_T
(
  CTID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  DATA                               BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.VARIABLE_INSTANCE_B_T ADD(
  PRIMARY KEY ( CTID, PIID )
);

CREATE INDEX cmndb_owner.CI_PIID ON cmndb_owner.VARIABLE_INSTANCE_B_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.SCOPED_VARIABLE_INSTANCE_B_T
(
  SVIID                              RAW(16)              NOT NULL ,
  CTID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  SIID                               RAW(16)              NOT NULL ,
  EHIID                              RAW(16)                       ,
  FEIID                              RAW(16)                       ,
  DATA                               BLOB                          ,
  IS_ACTIVE                          NUMBER(5,0)          NOT NULL ,
  IS_INITIALIZED                     NUMBER(5,0)          NOT NULL ,
  IS_QUERYABLE                       NUMBER(5,0)          NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SCOPED_VARIABLE_INSTANCE_B_T ADD(
  PRIMARY KEY ( SVIID )
);

CREATE INDEX cmndb_owner.SVI_PI_CT_EH_FE ON cmndb_owner.SCOPED_VARIABLE_INSTANCE_B_T
(   
  PIID, CTID, IS_ACTIVE, EHIID, FEIID
) LOGGING;

CREATE INDEX cmndb_owner.SVI_CT_SI_EH_AC ON cmndb_owner.SCOPED_VARIABLE_INSTANCE_B_T
(   
  SIID, CTID, IS_ACTIVE, EHIID
) LOGGING;

CREATE TABLE cmndb_owner.STAFF_MESSAGE_INSTANCE_B_T
(
  AIID                               RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  DATA                               BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.STAFF_MESSAGE_INSTANCE_B_T ADD(
  PRIMARY KEY ( AIID, KIND )
);

CREATE INDEX cmndb_owner.SMI_PIID ON cmndb_owner.STAFF_MESSAGE_INSTANCE_B_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.EVENT_INSTANCE_B_T
(
  EIID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  VTID                               RAW(16)              NOT NULL ,
  IS_TWO_WAY                         NUMBER(5,0)          NOT NULL ,
  IS_PRIMARY_EVENT_INSTANCE          NUMBER(5,0)          NOT NULL ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  AIID                               RAW(16)                       ,
  EHTID                              RAW(16)                       ,
  SIID                               RAW(16)                       ,
  TKIID                              RAW(16)                       ,
  NEXT_POSTED_EVENT                  RAW(16)                       ,
  LAST_POSTED_EVENT                  RAW(16)                       ,
  POST_COUNT                         NUMBER(10,0)         NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  MESSAGE                            BLOB                          ,
  REPLY_CONTEXT                      BLOB                          ,
  POST_TIME                          TIMESTAMP                     ,
  MAX_NUMBER_OF_POSTS                NUMBER(10,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.EVENT_INSTANCE_B_T ADD(
  PRIMARY KEY ( EIID )
);

CREATE INDEX cmndb_owner.EI_WSID1 ON cmndb_owner.EVENT_INSTANCE_B_T
(   
  WSID_1
) LOGGING;

CREATE INDEX cmndb_owner.EI_WSID2 ON cmndb_owner.EVENT_INSTANCE_B_T
(   
  WSID_2
) LOGGING;

CREATE INDEX cmndb_owner.EI_PI_PRIM_VTID ON cmndb_owner.EVENT_INSTANCE_B_T
(   
  PIID, IS_PRIMARY_EVENT_INSTANCE, VTID
) LOGGING;

CREATE TABLE cmndb_owner.REQUEST_INSTANCE_B_T
(
  RIID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  VTID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  EHIID                              RAW(16)                       ,
  TKIID                              RAW(16)                       ,
  FEIID                              RAW(16)                       ,
  INSTANTIATING                      NUMBER(5,0)          NOT NULL ,
  REPLY_CONTEXT                      BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.REQUEST_INSTANCE_B_T ADD(
  PRIMARY KEY ( RIID )
);

CREATE INDEX cmndb_owner.RI_PIID_VTID_EHIID ON cmndb_owner.REQUEST_INSTANCE_B_T
(   
  PIID, VTID
) LOGGING;

CREATE TABLE cmndb_owner.PARTNER_LINK_INSTANCE_B_T
(
  PIID                               RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(220)        NOT NULL ,
  ENDPOINT_REFERENCE                 BLOB                          ,
  SERVICE_DEFINITION                 BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PARTNER_LINK_INSTANCE_B_T ADD(
  PRIMARY KEY ( PIID, NAME )
);

CREATE INDEX cmndb_owner.PA_PIID ON cmndb_owner.PARTNER_LINK_INSTANCE_B_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.VARIABLE_SNAPSHOT_B_T
(
  SNID                               RAW(16)              NOT NULL ,
  CTID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  DATA                               BLOB                          ,
  COPY_VERSION                       NUMBER(5,0)          NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.VARIABLE_SNAPSHOT_B_T ADD(
  PRIMARY KEY ( SNID )
);

CREATE INDEX cmndb_owner.SN_PIID_CTID ON cmndb_owner.VARIABLE_SNAPSHOT_B_T
(   
  PIID, CTID
) LOGGING;

CREATE TABLE cmndb_owner.SUSPENDED_MESSAGE_INSTANCE_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  ENGINE_MESSAGE                     BLOB                 NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SUSPENDED_MESSAGE_INSTANCE_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.PIID ON cmndb_owner.SUSPENDED_MESSAGE_INSTANCE_B_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.CROSSING_LINK_INSTANCE_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  SOURCE_ATID                        RAW(16)              NOT NULL ,
  TARGET_ATID                        RAW(16)              NOT NULL ,
  EHIID                              RAW(16)                       ,
  FEIID                              RAW(16)                       ,
  CONDITION_VALUE                    NUMBER(10,0)         NOT NULL ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CROSSING_LINK_INSTANCE_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.CL_PI_TAT_EH_FE_SA ON cmndb_owner.CROSSING_LINK_INSTANCE_B_T
(   
  PIID, TARGET_ATID, EHIID, FEIID, SOURCE_ATID
) LOGGING;

CREATE TABLE cmndb_owner.INVOKE_RESULT_B_T
(
  PIID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  INVOKE_RESULT                      BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.INVOKE_RESULT_B_T ADD(
  PRIMARY KEY ( PIID, ATID )
);

CREATE TABLE cmndb_owner.INVOKE_RESULT2_B_T
(
  IRID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  EHIID                              RAW(16)                       ,
  FEIID                              RAW(16)                       ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  INVOKE_RESULT                      BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.INVOKE_RESULT2_B_T ADD(
  PRIMARY KEY ( IRID )
);

CREATE INDEX cmndb_owner.IR2_PI_AT_EH_FE ON cmndb_owner.INVOKE_RESULT2_B_T
(   
  PIID, ATID, EHIID, FEIID
) LOGGING;

CREATE TABLE cmndb_owner.EVENT_HANDLER_INSTANCE_B_T
(
  EHIID                              RAW(16)              NOT NULL ,
  EHTID                              RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  SIID                               RAW(16)              NOT NULL ,
  PARENT_EHIID                       RAW(16)                       ,
  FEIID                              RAW(16)                       ,
  SCHEDULER_TASK_ID                  VARCHAR2(254)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.EVENT_HANDLER_INSTANCE_B_T ADD(
  PRIMARY KEY ( EHIID )
);

CREATE INDEX cmndb_owner.EHI_PIID_EHTID ON cmndb_owner.EVENT_HANDLER_INSTANCE_B_T
(   
  PIID, EHTID
) LOGGING;

CREATE INDEX cmndb_owner.EHI_SIID_EHTID ON cmndb_owner.EVENT_HANDLER_INSTANCE_B_T
(   
  SIID, EHTID
) LOGGING;

CREATE TABLE cmndb_owner.CORRELATION_SET_INSTANCE_B_T
(
  PIID                               RAW(16)              NOT NULL ,
  COID                               RAW(16)              NOT NULL ,
  SIID                               RAW(16)              NOT NULL ,
  PROCESS_NAME                       VARCHAR2(220)        NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  STATUS                             NUMBER(10,0)         NOT NULL ,
  HASH_CODE                          RAW(16)              NOT NULL ,
  DATA                               VARCHAR2(3072)                ,
  DATA_LONG                          CLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CORRELATION_SET_INSTANCE_B_T ADD(
  PRIMARY KEY ( PIID, COID, SIID )
);

CREATE UNIQUE INDEX cmndb_owner.CSIB_HASH_PN ON cmndb_owner.CORRELATION_SET_INSTANCE_B_T
(   
  HASH_CODE, PROCESS_NAME
) LOGGING;

CREATE INDEX cmndb_owner.CSIB_PIID ON cmndb_owner.CORRELATION_SET_INSTANCE_B_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.CORRELATION_SET_PROPERTIES_B_T
(
  PIID                               RAW(16)              NOT NULL ,
  COID                               RAW(16)              NOT NULL ,
  SIID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  DATA                               BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CORRELATION_SET_PROPERTIES_B_T ADD(
  PRIMARY KEY ( PIID, COID, SIID )
);

CREATE TABLE cmndb_owner.UNDO_ACTION_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  PARENT_ATID                        RAW(16)                       ,
  PARENT_PIID                        RAW(16)                       ,
  PARENT_AIID                        RAW(16)                       ,
  PARENT_EHIID                       RAW(16)                       ,
  PARENT_FEIID                       RAW(16)                       ,
  PROCESS_NAME                       VARCHAR2(220)        NOT NULL ,
  CSCOPE_ID                          VARCHAR2(100)        NOT NULL ,
  UUID                               VARCHAR2(100)        NOT NULL ,
  COMP_CREATION_TIME                 TIMESTAMP            NOT NULL ,
  DO_OP_WAS_TXNAL                    NUMBER(5,0)          NOT NULL ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  INPUT_DATA                         BLOB                 NOT NULL ,
  FAULT_DATA                         BLOB                          ,
  CREATED                            NUMBER(10,0)         NOT NULL ,
  PROCESS_ADMIN                      VARCHAR2(128)        NOT NULL ,
  IS_VISIBLE                         NUMBER(5,0)          NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.UNDO_ACTION_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.UA_CSID_DOOP_UUID ON cmndb_owner.UNDO_ACTION_B_T
(   
  CSCOPE_ID, DO_OP_WAS_TXNAL, UUID
) LOGGING;

CREATE INDEX cmndb_owner.UA_CSID_STATE_CCT ON cmndb_owner.UNDO_ACTION_B_T
(   
  CSCOPE_ID, STATE, UUID
) LOGGING;

CREATE INDEX cmndb_owner.UA_STATE_ISV ON cmndb_owner.UNDO_ACTION_B_T
(   
  STATE, IS_VISIBLE
) LOGGING;

CREATE INDEX cmndb_owner.UA_AIID_STATE_UUID ON cmndb_owner.UNDO_ACTION_B_T
(   
  PARENT_AIID, STATE, UUID
) LOGGING;

CREATE INDEX cmndb_owner.UA_PIID ON cmndb_owner.UNDO_ACTION_B_T
(   
  PARENT_PIID
) LOGGING;

CREATE INDEX cmndb_owner.UA_PT_AT_CS_UU_CCT ON cmndb_owner.UNDO_ACTION_B_T
(   
  PTID, ATID, CSCOPE_ID, UUID, COMP_CREATION_TIME
) LOGGING;

CREATE TABLE cmndb_owner.CUSTOM_STMT_INSTANCE_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  SVIID                              RAW(16)                       ,
  NAMESPACE                          VARCHAR2(220)        NOT NULL ,
  LOCALNAME                          VARCHAR2(220)        NOT NULL ,
  PURPOSE                            VARCHAR2(220)        NOT NULL ,
  STATEMENT                          BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CUSTOM_STMT_INSTANCE_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.CSI_PIID_NS_LN_P ON cmndb_owner.CUSTOM_STMT_INSTANCE_B_T
(   
  PIID, NAMESPACE, LOCALNAME, PURPOSE
) LOGGING;

CREATE INDEX cmndb_owner.CSI_SVIID_NS_LN_P ON cmndb_owner.CUSTOM_STMT_INSTANCE_B_T
(   
  SVIID, NAMESPACE, LOCALNAME, PURPOSE
) LOGGING;

CREATE TABLE cmndb_owner.COMP_WORK_PENDING_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PARENT_PIID                        RAW(16)              NOT NULL ,
  PARENT_ATID                        RAW(16)              NOT NULL ,
  PARENT_EHIID                       RAW(16)                       ,
  PARENT_FEIID                       RAW(16)                       ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  CSCOPE_ID                          VARCHAR2(100)        NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.COMP_WORK_PENDING_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.CWP_PI_AT_CS_EH_FE ON cmndb_owner.COMP_WORK_PENDING_B_T
(   
  PARENT_PIID, PARENT_ATID, CSCOPE_ID, PARENT_EHIID, PARENT_FEIID
) LOGGING;

CREATE INDEX cmndb_owner.CWP_PI_AT_EHI ON cmndb_owner.COMP_WORK_PENDING_B_T
(   
  PARENT_PIID, PARENT_ATID, PARENT_EHIID
) LOGGING;

CREATE TABLE cmndb_owner.COMP_PARENT_ACTIVITY_INST_B_T
(
  AIID                               RAW(16)              NOT NULL ,
  SIID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)                       ,
  PIID                               RAW(16)              NOT NULL ,
  COMPLETION_NUMBER                  NUMBER(20,0)         NOT NULL ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  COMPENSATE_AIID                    RAW(16)                       ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.COMP_PARENT_ACTIVITY_INST_B_T ADD(
  PRIMARY KEY ( AIID )
);

CREATE INDEX cmndb_owner.CPAI_SI_S_CN_AI_PI ON cmndb_owner.COMP_PARENT_ACTIVITY_INST_B_T
(   
  SIID, STATE, COMPLETION_NUMBER, AIID, PIID
) LOGGING;

CREATE INDEX cmndb_owner.CPAI_PIID ON cmndb_owner.COMP_PARENT_ACTIVITY_INST_B_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.RESTART_EVENT_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  PORT_TYPE                          VARCHAR2(254)        NOT NULL ,
  OPERATION                          VARCHAR2(254)        NOT NULL ,
  NAMESPACE                          VARCHAR2(254)        NOT NULL ,
  INPUT_MESSAGE                      BLOB                          ,
  REPLY_CTX                          BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.RESTART_EVENT_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.REB_PIID ON cmndb_owner.RESTART_EVENT_B_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.PROGRESS_COUNTER_T
(
  PIID                               RAW(16)              NOT NULL ,
  COUNTER                            NUMBER(20,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PROGRESS_COUNTER_T ADD(
  PRIMARY KEY ( PIID )
);

CREATE TABLE cmndb_owner.RELEVANT_SCOPE_ATASK_T
(
  SIID                               RAW(16)              NOT NULL ,
  TKIID                              RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.RELEVANT_SCOPE_ATASK_T ADD(
  PRIMARY KEY ( SIID, TKIID )
);

CREATE INDEX cmndb_owner.RSAT_PIID ON cmndb_owner.RELEVANT_SCOPE_ATASK_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.CONFIG_INFO_T
(
  IDENTIFIER                         VARCHAR2(64)         NOT NULL ,
  DESCRIPTION                        VARCHAR2(128)                 ,
  PROPERTY                           NUMBER(10,0)                  ,
  COUNTER                            NUMBER(20,0)                  ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CONFIG_INFO_T ADD(
  PRIMARY KEY ( IDENTIFIER )
);

CREATE TABLE cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T
(
  PIID                               RAW(16)              NOT NULL ,
  ATTR_KEY                           VARCHAR2(220)        NOT NULL ,
  VALUE                              VARCHAR2(254)                 ,
  DATA_TYPE                          VARCHAR2(254)                 ,
  DATA                               BLOB                          ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T ADD(
  PRIMARY KEY ( PIID, ATTR_KEY )
);

CREATE INDEX cmndb_owner.PIA_VALUE ON cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T
(   
  VALUE
) LOGGING;

CREATE INDEX cmndb_owner.PIA_DATY ON cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T
(   
  DATA_TYPE
) LOGGING;

CREATE TABLE cmndb_owner.PROCESS_CONTEXT_T
(
  PIID                               RAW(16)              NOT NULL ,
  SHARED                             NUMBER(5,0)                   ,
  REPLY_CONTEXT                      BLOB                          ,
  SERVICE_CONTEXT                    BLOB                          ,
  STARTER_EXPIRES                    TIMESTAMP                     ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PROCESS_CONTEXT_T ADD(
  PRIMARY KEY ( PIID )
);

CREATE TABLE cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  ATID                               RAW(16)              NOT NULL ,
  EHIID                              RAW(16)                       ,
  FEIID                              RAW(16)                       ,
  AIID                               RAW(16)                       ,
  ATTR_KEY                           VARCHAR2(189)        NOT NULL ,
  ATTR_VALUE                         VARCHAR2(254)                 ,
  DATA_TYPE                          VARCHAR2(254)                 ,
  DATA                               BLOB                          ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE UNIQUE INDEX cmndb_owner.AIA_UNIQUE ON cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T
(   
  PIID, ATID, EHIID, FEIID, ATTR_KEY
) LOGGING;

CREATE INDEX cmndb_owner.AIA_FEEIATPI ON cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T
(   
  FEIID, EHIID, ATID, PIID
) LOGGING;

CREATE INDEX cmndb_owner.AIA_AIID ON cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T
(   
  AIID
) LOGGING;

CREATE INDEX cmndb_owner.AIA_VALUE ON cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T
(   
  ATTR_VALUE
) LOGGING;

CREATE INDEX cmndb_owner.AIA_DATY ON cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T
(   
  DATA_TYPE
) LOGGING;

CREATE TABLE cmndb_owner.NAVIGATION_EXCEPTION_T
(
  CORRELATION_ID                     RAW(220)             NOT NULL ,
  EXCEPTION_TYPE                     NUMBER(10,0)         NOT NULL ,
  PIID                               RAW(16)                       ,
  OUTPUT_MESSAGE                     BLOB                          ,
  TYPE_SYSTEM                        VARCHAR2(32)                  ,
  PROCESS_EXCEPTION                  BLOB                 NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.NAVIGATION_EXCEPTION_T ADD(
  PRIMARY KEY ( CORRELATION_ID, EXCEPTION_TYPE )
);

CREATE INDEX cmndb_owner.NE_PIID ON cmndb_owner.NAVIGATION_EXCEPTION_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.AWAITED_INVOCATION_T
(
  CORRELATION_ID                     RAW(254)             NOT NULL ,
  CORRELATION_INFO                   BLOB                 NOT NULL ,
  AIID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.AWAITED_INVOCATION_T ADD(
  PRIMARY KEY ( CORRELATION_ID )
);

CREATE INDEX cmndb_owner.AWI_PIID ON cmndb_owner.AWAITED_INVOCATION_T
(   
  PIID
) LOGGING;

CREATE INDEX cmndb_owner.AWI_AIID ON cmndb_owner.AWAITED_INVOCATION_T
(   
  AIID
) LOGGING;

CREATE TABLE cmndb_owner.STORED_QUERY_T
(
  SQID                               RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  NAME                               VARCHAR2(64)         NOT NULL ,
  OWNER_ID                           VARCHAR2(128)        NOT NULL ,
  SELECT_CLAUSE                      CLOB                 NOT NULL ,
  WHERE_CLAUSE                       CLOB                          ,
  ORDER_CLAUSE                       VARCHAR2(254)                 ,
  THRESHOLD                          NUMBER(10,0)                  ,
  TIMEZONE                           VARCHAR2(63)                  ,
  CREATOR                            VARCHAR2(128)                 ,
  TYPE                               VARCHAR2(128)                 ,
  PROPERTY                           BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.STORED_QUERY_T ADD(
  PRIMARY KEY ( SQID )
);

CREATE UNIQUE INDEX cmndb_owner.SQ_NAME ON cmndb_owner.STORED_QUERY_T
(   
  KIND, OWNER_ID, NAME
) LOGGING;

CREATE TABLE cmndb_owner.FOR_EACH_INSTANCE_B_T
(
  FEIID                              RAW(16)              NOT NULL ,
  PARENT_FEIID                       RAW(16)                       ,
  PIID                               RAW(16)              NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.FOR_EACH_INSTANCE_B_T ADD(
  PRIMARY KEY ( FEIID )
);

CREATE INDEX cmndb_owner.FEI_PIID ON cmndb_owner.FOR_EACH_INSTANCE_B_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T
(
  PKID                               RAW(16)              NOT NULL ,
  CTID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  PAID                               RAW(16)              NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  VARIABLE_NAME                      VARCHAR2(254)        NOT NULL ,
  PROPERTY_NAME                      VARCHAR2(255)        NOT NULL ,
  PROPERTY_NAMESPACE                 VARCHAR2(254)        NOT NULL ,
  TYPE                               NUMBER(10,0)         NOT NULL ,
  GENERIC_VALUE                      VARCHAR2(512)                 ,
  STRING_VALUE                       VARCHAR2(512)                 ,
  NUMBER_VALUE                       NUMBER(20,0)                  ,
  DECIMAL_VALUE                      NUMBER                        ,
  TIMESTAMP_VALUE                    TIMESTAMP                     ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.QVI_PI_CT_PA ON cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T
(   
  PIID, CTID, PAID
) LOGGING;

CREATE INDEX cmndb_owner.QVI_PI_PROPNAME ON cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T
(   
  PIID, PROPERTY_NAME
) LOGGING;

CREATE TABLE cmndb_owner.SYNC_T
(
  IDENTIFIER                         VARCHAR2(254)        NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL ,
  PRIMARY KEY ( IDENTIFIER )
) LOGGING;

CREATE TABLE cmndb_owner.MV_CTR_T
(
  ID                                 NUMBER(10,0)         NOT NULL ,
  SELECT_CLAUSE                      VARCHAR2(1024)       NOT NULL ,
  WHERE_CLAUSE                       VARCHAR2(1024)                ,
  ORDER_CLAUSE                       VARCHAR2(512)                 ,
  TBL_SPACE                          VARCHAR2(32)         NOT NULL ,
  UPDATED                            TIMESTAMP            NOT NULL ,
  UPD_STARTED                        TIMESTAMP                     ,
  AVG_UPD_TIME                       NUMBER(20,0)                  ,
  UPD_INTERVAL                       NUMBER(20,0)         NOT NULL ,
  IS_UPDATING                        NUMBER(5,0)          NOT NULL ,
  ACTIVE_MV                          NUMBER(5,0)          NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.MV_CTR_T ADD(
  PRIMARY KEY ( ID )
);

CREATE TABLE cmndb_owner.SAVED_ENGINE_MESSAGE_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)                       ,
  CREATION_TIME                      TIMESTAMP            NOT NULL ,
  REASON                             NUMBER(10,0)         NOT NULL ,
  ENGINE_MESSAGE_S                   RAW(2000)                     ,
  ENGINE_MESSAGE_L                   BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SAVED_ENGINE_MESSAGE_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.SEM_PIID ON cmndb_owner.SAVED_ENGINE_MESSAGE_B_T
(   
  PIID
) LOGGING;

CREATE INDEX cmndb_owner.SEM_REAS ON cmndb_owner.SAVED_ENGINE_MESSAGE_B_T
(   
  REASON, CREATION_TIME
) LOGGING;

CREATE TABLE cmndb_owner.NAVIGATION_CLEANUP_TIMER_B_T
(
  PKID                               RAW(16)              NOT NULL ,
  SCHEDULED_TIME                     TIMESTAMP            NOT NULL ,
  SCHEDULER_ID                       VARCHAR2(254)        NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.NAVIGATION_CLEANUP_TIMER_B_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE TABLE cmndb_owner.SCHEDULER_ACTION_T
(
  SCHEDULER_ID                       VARCHAR2(254)        NOT NULL ,
  OID                                RAW(16)              NOT NULL ,
  ACTION_OBJECT                      BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SCHEDULER_ACTION_T ADD(
  PRIMARY KEY ( SCHEDULER_ID )
);

CREATE INDEX cmndb_owner.SCEACT_OID ON cmndb_owner.SCHEDULER_ACTION_T
(   
  OID
) LOGGING;

CREATE TABLE cmndb_owner.QUERY_TABLE_T
(
  NAME                               VARCHAR2(32)         NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  TYPE                               NUMBER(10,0)         NOT NULL ,
  VERSION                            NUMBER(10,0)         NOT NULL ,
  LAST_UPDATED                       TIMESTAMP            NOT NULL ,
  PRIMARY_VIEW                       VARCHAR2(32)                  ,
  DEFINITION                         BLOB                 NOT NULL ,
  VV_CFG                             BLOB                          ,
  DV_CFG                             BLOB                          ,
  MV_CFG                             BLOB                          ,
  MT_CFG                             BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.QUERY_TABLE_T ADD(
  PRIMARY KEY ( NAME )
);

CREATE INDEX cmndb_owner.QT_KI ON cmndb_owner.QUERY_TABLE_T
(   
  KIND
) LOGGING;

CREATE INDEX cmndb_owner.QT_TY ON cmndb_owner.QUERY_TABLE_T
(   
  TYPE
) LOGGING;

CREATE TABLE cmndb_owner.QUERY_TABLE_REF_T
(
  REFEREE                            VARCHAR2(32)         NOT NULL ,
  SOURCE                             VARCHAR2(32)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.QUERY_TABLE_REF_T ADD(
  PRIMARY KEY ( REFEREE, SOURCE )
);

CREATE INDEX cmndb_owner.QTR_SRC ON cmndb_owner.QUERY_TABLE_REF_T
(   
  SOURCE
) LOGGING;

CREATE TABLE cmndb_owner.MIGRATION_FRONT_T
(
  PIID                               RAW(16)              NOT NULL ,
  MPTID                              RAW(16)              NOT NULL ,
  AIID                               RAW(16)              NOT NULL ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  SUB_STATE                          NUMBER(10,0)         NOT NULL ,
  STOP_REASON                        NUMBER(10,0)         NOT NULL ,
  SOURCE_ATID                        RAW(16)              NOT NULL ,
  TARGET_ATID                        RAW(16)              NOT NULL ,
  MIGRATION_TIME                     TIMESTAMP            NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.MIGRATION_FRONT_T ADD(
  PRIMARY KEY ( PIID, MPTID, AIID )
);

CREATE INDEX cmndb_owner.MGF_MPTID ON cmndb_owner.MIGRATION_FRONT_T
(   
  MPTID
) LOGGING;

CREATE TABLE cmndb_owner.SCOPE_COMPLETION_COUNTER_T
(
  SIID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  COUNTER                            NUMBER(20,0)                  ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SCOPE_COMPLETION_COUNTER_T ADD(
  PRIMARY KEY ( SIID )
);

CREATE INDEX cmndb_owner.SCC_PIID ON cmndb_owner.SCOPE_COMPLETION_COUNTER_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.ITERATION_COUNTER_INSTANCE_T
(
  ICIID                              RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  STARTED_WITH_AIID                  RAW(16)                       ,
  PARENT_ICIID                       RAW(16)              NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ITERATION_COUNTER_INSTANCE_T ADD(
  PRIMARY KEY ( ICIID )
);

CREATE INDEX cmndb_owner.ICI_PIID ON cmndb_owner.ITERATION_COUNTER_INSTANCE_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.IORCOUNTER_T
(
  GATEWAY_AIID                       RAW(16)              NOT NULL ,
  PIID                               RAW(16)              NOT NULL ,
  COUNTER                            CLOB                 NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.IORCOUNTER_T ADD(
  PRIMARY KEY ( GATEWAY_AIID )
);

CREATE INDEX cmndb_owner.IOC_PIID ON cmndb_owner.IORCOUNTER_T
(   
  PIID
) LOGGING;

CREATE TABLE cmndb_owner.AUDIT_LOG_T
(
  ALID                               RAW(16)              NOT NULL ,
  EVENT_TIME                         TIMESTAMP            NOT NULL ,
  EVENT_TIME_UTC                     TIMESTAMP                     ,
  AUDIT_EVENT                        NUMBER(10,0)         NOT NULL ,
  PTID                               RAW(16)              NOT NULL ,
  PIID                               RAW(16)                       ,
  AIID                               RAW(16)                       ,
  SIID                               RAW(16)                       ,
  VARIABLE_NAME                      VARCHAR2(254)                 ,
  PROCESS_TEMPL_NAME                 VARCHAR2(254)        NOT NULL ,
  PROCESS_INST_NAME                  VARCHAR2(254)                 ,
  TOP_LEVEL_PI_NAME                  VARCHAR2(254)                 ,
  TOP_LEVEL_PIID                     RAW(16)                       ,
  PARENT_PI_NAME                     VARCHAR2(254)                 ,
  PARENT_PIID                        RAW(16)                       ,
  VALID_FROM                         TIMESTAMP                     ,
  VALID_FROM_UTC                     TIMESTAMP                     ,
  ATID                               RAW(16)                       ,
  ACTIVITY_NAME                      VARCHAR2(254)                 ,
  ACTIVITY_KIND                      NUMBER(10,0)                  ,
  ACTIVITY_STATE                     NUMBER(10,0)                  ,
  CONTROL_LINK_NAME                  VARCHAR2(254)                 ,
  IMPL_NAME                          VARCHAR2(254)                 ,
  PRINCIPAL                          VARCHAR2(128)                 ,
  TERMINAL_NAME                      VARCHAR2(254)                 ,
  VARIABLE_DATA                      BLOB                          ,
  EXCEPTION_TEXT                     CLOB                          ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  CORR_SET_INFO                      CLOB                          ,
  USER_NAME                          VARCHAR2(128)                 ,
  ADDITIONAL_INFO                    CLOB                          ,
  OBJECT_META_TYPE                   NUMBER(10,0)                  ,
  SNAPSHOT_ID                        VARCHAR2(254)                 ,
  PROCESS_APP_ACRONYM                VARCHAR2(7)                   ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.AUDIT_LOG_T ADD(
  PRIMARY KEY ( ALID )
);

CREATE TABLE cmndb_owner.WORK_ITEM_T
(
  WIID                               RAW(16)              NOT NULL ,
  PARENT_WIID                        RAW(16)                       ,
  OWNER_ID                           VARCHAR2(128)                 ,
  GROUP_NAME                         VARCHAR2(128)                 ,
  EVERYBODY                          NUMBER(5,0)          NOT NULL ,
  EXCLUDE                            NUMBER(5,0)          NOT NULL ,
  QIID                               RAW(16)                       ,
  OBJECT_TYPE                        NUMBER(10,0)         NOT NULL ,
  OBJECT_ID                          RAW(16)              NOT NULL ,
  ASSOCIATED_OBJECT_TYPE             NUMBER(10,0)         NOT NULL ,
  ASSOCIATED_OID                     RAW(16)                       ,
  REASON                             NUMBER(10,0)         NOT NULL ,
  CREATION_TIME                      TIMESTAMP            NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  AUTH_INFO                          NUMBER(10,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.WORK_ITEM_T ADD(
  PRIMARY KEY ( WIID )
);

CREATE INDEX cmndb_owner.WI_ASSOBJ_REASON ON cmndb_owner.WORK_ITEM_T
(   
  ASSOCIATED_OID, ASSOCIATED_OBJECT_TYPE, REASON, PARENT_WIID
) LOGGING;

CREATE INDEX cmndb_owner.WI_OBJID_TYPE_QIID ON cmndb_owner.WORK_ITEM_T
(   
  OBJECT_ID, OBJECT_TYPE, QIID
) LOGGING;

CREATE INDEX cmndb_owner.WI_GROUP_NAME ON cmndb_owner.WORK_ITEM_T
(   
  GROUP_NAME
) LOGGING;

CREATE INDEX cmndb_owner.WI_AUTH_L ON cmndb_owner.WORK_ITEM_T
(   
  EVERYBODY, GROUP_NAME, OWNER_ID, QIID
) LOGGING;

CREATE INDEX cmndb_owner.WI_AUTH_U ON cmndb_owner.WORK_ITEM_T
(   
  AUTH_INFO, QIID
) LOGGING;

CREATE INDEX cmndb_owner.WI_AUTH_O ON cmndb_owner.WORK_ITEM_T
(   
  AUTH_INFO, OWNER_ID DESC
) LOGGING;

CREATE INDEX cmndb_owner.WI_AUTH_G ON cmndb_owner.WORK_ITEM_T
(   
  AUTH_INFO, GROUP_NAME
) LOGGING;

CREATE INDEX cmndb_owner.WI_AUTH_E ON cmndb_owner.WORK_ITEM_T
(   
  AUTH_INFO, EVERYBODY
) LOGGING;

CREATE INDEX cmndb_owner.WI_AUTH_R ON cmndb_owner.WORK_ITEM_T
(   
  AUTH_INFO, REASON DESC
) LOGGING;

CREATE INDEX cmndb_owner.WI_REASON ON cmndb_owner.WORK_ITEM_T
(   
  REASON
) LOGGING;

CREATE INDEX cmndb_owner.WI_OWNER ON cmndb_owner.WORK_ITEM_T
(   
  OWNER_ID, OBJECT_ID, REASON, OBJECT_TYPE
) LOGGING;

CREATE INDEX cmndb_owner.WI_QIID ON cmndb_owner.WORK_ITEM_T
(   
  QIID
) LOGGING;

CREATE INDEX cmndb_owner.WI_QRY ON cmndb_owner.WORK_ITEM_T
(   
  OBJECT_ID, REASON, EVERYBODY, OWNER_ID
) LOGGING;

CREATE INDEX cmndb_owner.WI_QI_OID_RS_OWN ON cmndb_owner.WORK_ITEM_T
(   
  QIID, OBJECT_ID, REASON, OWNER_ID
) LOGGING;

CREATE INDEX cmndb_owner.WI_QI_OID_OWN ON cmndb_owner.WORK_ITEM_T
(   
  QIID, OBJECT_ID, OWNER_ID
) LOGGING;

CREATE INDEX cmndb_owner.WI_OT_OID_RS ON cmndb_owner.WORK_ITEM_T
(   
  OBJECT_TYPE, OBJECT_ID, REASON
) LOGGING;

CREATE INDEX cmndb_owner.WI_WI_QI ON cmndb_owner.WORK_ITEM_T
(   
  WIID, QIID
) LOGGING;

CREATE INDEX cmndb_owner.WI_PWIID_OID ON cmndb_owner.WORK_ITEM_T
(   
  PARENT_WIID, OBJECT_ID
) LOGGING;

CREATE INDEX cmndb_owner.WI_PWIID_QIID ON cmndb_owner.WORK_ITEM_T
(   
  PARENT_WIID, QIID
) LOGGING;

CREATE INDEX cmndb_owner.WI_AUTH_GR_O_E ON cmndb_owner.WORK_ITEM_T
(   
  AUTH_INFO, GROUP_NAME, OWNER_ID, EVERYBODY
) LOGGING;

CREATE INDEX cmndb_owner.WI_PD1 ON cmndb_owner.WORK_ITEM_T
(   
  OWNER_ID, AUTH_INFO, OBJECT_TYPE, REASON, OBJECT_ID
) LOGGING;

CREATE INDEX cmndb_owner.WI_PD2 ON cmndb_owner.WORK_ITEM_T
(   
  AUTH_INFO, OBJECT_TYPE, REASON, OBJECT_ID, QIID
) LOGGING;

CREATE TABLE cmndb_owner.RETRIEVED_USER_T
(
  QIID                               RAW(16)              NOT NULL ,
  OWNER_ID                           VARCHAR2(128)        NOT NULL ,
  REASON                             NUMBER(10,0)         NOT NULL ,
  ASSOCIATED_OID                     RAW(16)                       ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.RETRIEVED_USER_T ADD(
  PRIMARY KEY ( QIID, OWNER_ID )
);

CREATE INDEX cmndb_owner.RUT_OWN_QIID ON cmndb_owner.RETRIEVED_USER_T
(   
  OWNER_ID, QIID
) LOGGING;

CREATE INDEX cmndb_owner.RUT_ASSOC ON cmndb_owner.RETRIEVED_USER_T
(   
  ASSOCIATED_OID
) LOGGING;

CREATE INDEX cmndb_owner.RUT_QIID ON cmndb_owner.RETRIEVED_USER_T
(   
  QIID
) LOGGING;

CREATE INDEX cmndb_owner.RUT_OWN_QIDESC ON cmndb_owner.RETRIEVED_USER_T
(   
  OWNER_ID, QIID DESC
) LOGGING;

CREATE TABLE cmndb_owner.RETRIEVED_GROUP_T
(
  QIID                               RAW(16)              NOT NULL ,
  GROUP_NAME                         VARCHAR2(128)        NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.RETRIEVED_GROUP_T ADD(
  PRIMARY KEY ( QIID, GROUP_NAME )
);

CREATE INDEX cmndb_owner.RGR_GN ON cmndb_owner.RETRIEVED_GROUP_T
(   
  GROUP_NAME
) LOGGING;

CREATE TABLE cmndb_owner.WIS_META_DATA_T
(
  WSID                               RAW(16)              NOT NULL ,
  HASH_CODE                          NUMBER(10,0)         NOT NULL ,
  OBJECT_TYPE                        NUMBER(10,0)         NOT NULL ,
  LAST_CHECK                         TIMESTAMP            NOT NULL ,
  UNUSED                             NUMBER(5,0)          NOT NULL ,
  AUTH_INFO_RETRIEVED_USER           NUMBER(5,0)          NOT NULL ,
  AUTH_INFO_OWNER_ID                 NUMBER(5,0)          NOT NULL ,
  AUTH_INFO_EVERYBODY                NUMBER(5,0)          NOT NULL ,
  AUTH_INFO_GROUP                    NUMBER(5,0)          NOT NULL ,
  AUTH_INFO_RETRIEVED_GROUP          NUMBER(5,0)          NOT NULL ,
  AUTH_INFO_EMPTY                    NUMBER(5,0)          NOT NULL ,
  SHARING_PATTERN                    NUMBER(10,0)         NOT NULL ,
  REASONS                            RAW(32)              NOT NULL ,
  PARAMETER_A                        NUMBER(10,0)                  ,
  PARAMETER_B                        NUMBER(10,0)                  ,
  PARAMETER_C                        NUMBER(10,0)                  ,
  PARAMETER_D                        RAW(16)                       ,
  PARAMETER_E                        TIMESTAMP                     ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.WIS_META_DATA_T ADD(
  PRIMARY KEY ( WSID )
);

CREATE INDEX cmndb_owner.WMD_HC ON cmndb_owner.WIS_META_DATA_T
(   
  HASH_CODE
) LOGGING;

CREATE TABLE cmndb_owner.E_SWI_T
(
  PKID                               RAW(16)              NOT NULL ,
  WIID                               RAW(16)              NOT NULL ,
  WSID                               RAW(16)              NOT NULL ,
  HASH_CODE                          NUMBER(10,0)         NOT NULL ,
  WIS_HASH_CODE                      NUMBER(10,0)                  ,
  PARENT_WIID                        RAW(16)                       ,
  REASON                             NUMBER(10,0)         NOT NULL ,
  INHERITED                          NUMBER(5,0)                   ,
  QIID                               RAW(16)                       ,
  OBJECT_TYPE                        NUMBER(10,0)         NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  SHARING_PATTERN                    NUMBER(10,0)         NOT NULL ,
  ACCESS_KEY                         NUMBER(10,0)         NOT NULL ,
  TEMPLATE_ID                        RAW(16)                       ,
  PARAMETER_A                        NUMBER(10,0)                  ,
  PARAMETER_B                        NUMBER(10,0)                  ,
  PARAMETER_C                        NUMBER(10,0)                  ,
  PARAMETER_D                        RAW(16)                       ,
  PARAMETER_E                        TIMESTAMP                     ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.E_SWI_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.WE_WSID ON cmndb_owner.E_SWI_T
(   
  WSID
) LOGGING;

CREATE INDEX cmndb_owner.WE_HASHCODE ON cmndb_owner.E_SWI_T
(   
  HASH_CODE
) LOGGING;

CREATE INDEX cmndb_owner.WE_HASH_TID ON cmndb_owner.E_SWI_T
(   
  HASH_CODE, TEMPLATE_ID
) LOGGING;

CREATE INDEX cmndb_owner.WE_WIID ON cmndb_owner.E_SWI_T
(   
  WIID
) LOGGING;

CREATE INDEX cmndb_owner.WE_QIID ON cmndb_owner.E_SWI_T
(   
  QIID
) LOGGING;

CREATE TABLE cmndb_owner.SWI_T
(
  PKID                               RAW(16)              NOT NULL ,
  WIID                               RAW(16)              NOT NULL ,
  PARENT_WIID                        RAW(16)                       ,
  OWNER_ID                           VARCHAR2(128)                 ,
  GROUP_NAME                         VARCHAR2(128)                 ,
  EVERYBODY                          NUMBER(5,0)          NOT NULL ,
  QIID                               RAW(16)                       ,
  OBJECT_TYPE                        NUMBER(10,0)         NOT NULL ,
  REASON                             NUMBER(10,0)         NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  AUTH_INFO                          NUMBER(10,0)         NOT NULL ,
  SHARING_PATTERN                    NUMBER(10,0)         NOT NULL ,
  ACCESS_KEY                         NUMBER(10,0)         NOT NULL ,
  WSID                               RAW(16)              NOT NULL ,
  HASH_CODE                          NUMBER(10,0)         NOT NULL ,
  WIS_HASH_CODE                      NUMBER(10,0)                  ,
  INHERITED                          NUMBER(5,0)                   ,
  TEMPLATE_ID                        RAW(16)                       ,
  PARAMETER_A                        NUMBER(10,0)                  ,
  PARAMETER_B                        NUMBER(10,0)                  ,
  PARAMETER_C                        NUMBER(10,0)                  ,
  PARAMETER_D                        RAW(16)                       ,
  PARAMETER_E                        TIMESTAMP                     ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SWI_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.SWI_WSID ON cmndb_owner.SWI_T
(   
  WSID
) LOGGING;

CREATE INDEX cmndb_owner.SWI_HASHCODE ON cmndb_owner.SWI_T
(   
  HASH_CODE
) LOGGING;

CREATE INDEX cmndb_owner.SWI_OTRPD ON cmndb_owner.SWI_T
(   
  OBJECT_TYPE, REASON, TEMPLATE_ID
) LOGGING;

CREATE INDEX cmndb_owner.SWI_WIID ON cmndb_owner.SWI_T
(   
  WIID
) LOGGING;

CREATE INDEX cmndb_owner.SWI_QIID ON cmndb_owner.SWI_T
(   
  QIID
) LOGGING;

CREATE INDEX cmndb_owner.SWI_OWN ON cmndb_owner.SWI_T
(   
  OWNER_ID, ACCESS_KEY, WSID, REASON
) LOGGING;

CREATE INDEX cmndb_owner.SWI_GRP ON cmndb_owner.SWI_T
(   
  GROUP_NAME, ACCESS_KEY, WSID, REASON
) LOGGING;

CREATE INDEX cmndb_owner.SWI_ACCK1 ON cmndb_owner.SWI_T
(   
  ACCESS_KEY, REASON, WSID, QIID
) LOGGING;

CREATE INDEX cmndb_owner.SWI_ACCK2 ON cmndb_owner.SWI_T
(   
  ACCESS_KEY, REASON, QIID, WSID
) LOGGING;

CREATE INDEX cmndb_owner.SWI_ACCK3 ON cmndb_owner.SWI_T
(   
  ACCESS_KEY, REASON, OWNER_ID, WSID
) LOGGING;

CREATE INDEX cmndb_owner.SWI_ACCK4 ON cmndb_owner.SWI_T
(   
  ACCESS_KEY, REASON, WSID
) LOGGING;

CREATE INDEX cmndb_owner.SWI_ACCK5 ON cmndb_owner.SWI_T
(   
  ACCESS_KEY, OWNER_ID, REASON, WSID
) LOGGING;

CREATE INDEX cmndb_owner.SWI_ACCK6 ON cmndb_owner.SWI_T
(   
  ACCESS_KEY, GROUP_NAME, REASON, WSID
) LOGGING;

CREATE TABLE cmndb_owner.STAFF_QUERY_INSTANCE_T
(
  QIID                               RAW(16)              NOT NULL ,
  QTID                               RAW(16)              NOT NULL ,
  EVERYBODY                          NUMBER(5,0)          NOT NULL ,
  NOBODY                             NUMBER(5,0)          NOT NULL ,
  IS_SHAREABLE                       NUMBER(5,0)          NOT NULL ,
  IS_TRANSFERRED                     NUMBER(5,0)          NOT NULL ,
  SR_HASH_CODE                       NUMBER(10,0)                  ,
  GROUP_NAME                         VARCHAR2(128)                 ,
  CONTEXT_VALUES                     VARCHAR2(3072)                ,
  CONTEXT_VALUES_LONG                CLOB                          ,
  HASH_CODE                          NUMBER(10,0)                  ,
  EXPIRES                            TIMESTAMP                     ,
  ASSOCIATED_OBJECT_TYPE             NUMBER(10,0)         NOT NULL ,
  ASSOCIATED_OID                     RAW(16)              NOT NULL ,
  NORMALIZED                         NUMBER(5,0)                   ,
  DENORMALIZED                       NUMBER(5,0)                   ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.STAFF_QUERY_INSTANCE_T ADD(
  PRIMARY KEY ( QIID )
);

CREATE INDEX cmndb_owner.SQI_QTID ON cmndb_owner.STAFF_QUERY_INSTANCE_T
(   
  QTID, HASH_CODE
) LOGGING;

CREATE INDEX cmndb_owner.SQI_ASSOCID ON cmndb_owner.STAFF_QUERY_INSTANCE_T
(   
  ASSOCIATED_OID, ASSOCIATED_OBJECT_TYPE
) LOGGING;

CREATE INDEX cmndb_owner.SQI_QIIDGN ON cmndb_owner.STAFF_QUERY_INSTANCE_T
(   
  QIID, GROUP_NAME
) LOGGING;

CREATE INDEX cmndb_owner.SQI_QIIDTREX ON cmndb_owner.STAFF_QUERY_INSTANCE_T
(   
  QIID, IS_TRANSFERRED, EXPIRES
) LOGGING;

CREATE INDEX cmndb_owner.SQI_ISSH ON cmndb_owner.STAFF_QUERY_INSTANCE_T
(   
  IS_SHAREABLE, QIID
) LOGGING;

CREATE INDEX cmndb_owner.SQI_GRP ON cmndb_owner.STAFF_QUERY_INSTANCE_T
(   
  GROUP_NAME
) LOGGING;

CREATE TABLE cmndb_owner.STAFF_LOCK_T
(
  QTID                               RAW(16)              NOT NULL ,
  HASH_CODE                          NUMBER(10,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.STAFF_LOCK_T ADD(
  PRIMARY KEY ( QTID, HASH_CODE )
);

CREATE TABLE cmndb_owner.APPLICATION_COMPONENT_T
(
  ACOID                              RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(64)         NOT NULL ,
  CALENDAR_NAME                      VARCHAR2(254)                 ,
  JNDI_NAME_CALENDAR                 VARCHAR2(254)                 ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR2(254)        NOT NULL ,
  DURATION_UNTIL_DELETED             VARCHAR2(254)                 ,
  EVENT_HANDLER_NAME                 VARCHAR2(64)                  ,
  INSTANCE_CREATOR_QTID              RAW(16)                       ,
  SUPPORTS_AUTO_CLAIM                NUMBER(5,0)          NOT NULL ,
  SUPPORTS_FOLLOW_ON_TASK            NUMBER(5,0)          NOT NULL ,
  SUPPORTS_CLAIM_SUSPENDED           NUMBER(5,0)          NOT NULL ,
  SUPPORTS_DELEGATION                NUMBER(5,0)          NOT NULL ,
  SUPPORTS_SUB_TASK                  NUMBER(5,0)          NOT NULL ,
  BUSINESS_RELEVANCE                 NUMBER(5,0)          NOT NULL ,
  SUBSTITUTION_POLICY                NUMBER(10,0)         NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.APPLICATION_COMPONENT_T ADD(
  PRIMARY KEY ( ACOID )
);

CREATE UNIQUE INDEX cmndb_owner.ACO_NAME ON cmndb_owner.APPLICATION_COMPONENT_T
(   
  NAME
) LOGGING;

CREATE TABLE cmndb_owner.ESCALATION_TEMPLATE_T
(
  ESTID                              RAW(16)              NOT NULL ,
  FIRST_ESTID                        RAW(16)                       ,
  PREVIOUS_ESTID                     RAW(16)                       ,
  TKTID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  MNTID                              RAW(16)                       ,
  NAME                               VARCHAR2(220)                 ,
  ACTIVATION_STATE                   NUMBER(10,0)         NOT NULL ,
  AT_LEAST_EXPECTED_STATE            NUMBER(10,0)         NOT NULL ,
  DURATION_UNTIL_ESCALATION          VARCHAR2(254)                 ,
  DURATION_UNTIL_REPEATS             VARCHAR2(254)                 ,
  INCREASE_PRIORITY                  NUMBER(10,0)         NOT NULL ,
  ACTION                             NUMBER(10,0)         NOT NULL ,
  ESCALATION_RECEIVER_QTID           RAW(16)                       ,
  RECEIVER_EMAIL_QTID                RAW(16)                       
) LOGGING;

ALTER TABLE cmndb_owner.ESCALATION_TEMPLATE_T ADD(
  PRIMARY KEY ( ESTID )
);

CREATE INDEX cmndb_owner.ET_TKTID ON cmndb_owner.ESCALATION_TEMPLATE_T
(   
  TKTID
) LOGGING;

CREATE INDEX cmndb_owner.ET_CCID ON cmndb_owner.ESCALATION_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.ESC_TEMPL_CPROP_T
(
  ESTID                              RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(220)        NOT NULL ,
  TKTID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  STRING_VALUE                       VARCHAR2(254)                 ,
  DATA_TYPE                          VARCHAR2(254)                 ,
  DATA                               BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.ESC_TEMPL_CPROP_T ADD(
  PRIMARY KEY ( ESTID, NAME )
);

CREATE INDEX cmndb_owner.ETCP_TKTID ON cmndb_owner.ESC_TEMPL_CPROP_T
(   
  TKTID
) LOGGING;

CREATE INDEX cmndb_owner.ETCP_CCID ON cmndb_owner.ESC_TEMPL_CPROP_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.ESC_TEMPL_LDESC_T
(
  ESTID                              RAW(16)              NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  TKTID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  DISPLAY_NAME                       VARCHAR2(64)                  ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  DOCUMENTATION                      CLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.ESC_TEMPL_LDESC_T ADD(
  PRIMARY KEY ( ESTID, LOCALE )
);

CREATE INDEX cmndb_owner.ETLD_TKTID ON cmndb_owner.ESC_TEMPL_LDESC_T
(   
  TKTID
) LOGGING;

CREATE INDEX cmndb_owner.ETLD_CCID ON cmndb_owner.ESC_TEMPL_LDESC_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TTASK_MESSAGE_DEFINITION_T
(
  TMTID                              RAW(16)              NOT NULL ,
  TKTID                              RAW(16)                       ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  FAULT_NAME                         VARCHAR2(254)                 ,
  MESSAGE_TYPE_NS                    VARCHAR2(220)        NOT NULL ,
  MESSAGE_TYPE_NAME                  VARCHAR2(220)        NOT NULL ,
  MESSAGE_DEFINITION                 BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.TTASK_MESSAGE_DEFINITION_T ADD(
  PRIMARY KEY ( TMTID )
);

CREATE INDEX cmndb_owner.TTMD_TKTID ON cmndb_owner.TTASK_MESSAGE_DEFINITION_T
(   
  TKTID
) LOGGING;

CREATE INDEX cmndb_owner.TTMD_CCID ON cmndb_owner.TTASK_MESSAGE_DEFINITION_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_TEMPLATE_T
(
  TKTID                              RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(220)        NOT NULL ,
  DEFINITION_NAME                    VARCHAR2(220)        NOT NULL ,
  NAMESPACE                          VARCHAR2(254)        NOT NULL ,
  TARGET_NAMESPACE                   VARCHAR2(254)        NOT NULL ,
  VALID_FROM                         TIMESTAMP            NOT NULL ,
  APPLICATION_NAME                   VARCHAR2(220)                 ,
  APPLICATION_DEFAULTS_ID            RAW(16)                       ,
  CONTAINMENT_CONTEXT_ID             RAW(16)                       ,
  SVTID                              RAW(16)                       ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  AUTO_DELETE_MODE                   NUMBER(10,0)         NOT NULL ,
  IS_AD_HOC                          NUMBER(5,0)          NOT NULL ,
  IS_INLINE                          NUMBER(5,0)          NOT NULL ,
  IS_SHARED                          NUMBER(5,0)          NOT NULL ,
  SUPPORTS_CLAIM_SUSPENDED           NUMBER(5,0)          NOT NULL ,
  SUPPORTS_AUTO_CLAIM                NUMBER(5,0)          NOT NULL ,
  SUPPORTS_FOLLOW_ON_TASK            NUMBER(5,0)          NOT NULL ,
  SUPPORTS_DELEGATION                NUMBER(5,0)          NOT NULL ,
  SUPPORTS_SUB_TASK                  NUMBER(5,0)          NOT NULL ,
  CONTEXT_AUTHORIZATION              NUMBER(10,0)         NOT NULL ,
  AUTONOMY                           NUMBER(10,0)         NOT NULL ,
  ADMIN_QTID                         RAW(16)                       ,
  EDITOR_QTID                        RAW(16)                       ,
  INSTANCE_CREATOR_QTID              RAW(16)                       ,
  POTENTIAL_STARTER_QTID             RAW(16)                       ,
  POTENTIAL_OWNER_QTID               RAW(16)                       ,
  READER_QTID                        RAW(16)                       ,
  DEFAULT_LOCALE                     VARCHAR2(32)                  ,
  CALENDAR_NAME                      VARCHAR2(254)                 ,
  DURATION_UNTIL_DELETED             VARCHAR2(254)                 ,
  DURATION_UNTIL_DUE                 VARCHAR2(254)                 ,
  DURATION_UNTIL_EXPIRES             VARCHAR2(254)                 ,
  JNDI_NAME_CALENDAR                 VARCHAR2(254)                 ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR2(254)        NOT NULL ,
  TYPE                               VARCHAR2(254)                 ,
  EVENT_HANDLER_NAME                 VARCHAR2(64)                  ,
  PRIORITY                           NUMBER(10,0)                  ,
  PRIORITY_DEFINITION                VARCHAR2(254)                 ,
  BUSINESS_RELEVANCE                 NUMBER(5,0)          NOT NULL ,
  SUBSTITUTION_POLICY                NUMBER(10,0)         NOT NULL ,
  CONTACTS_QTIDS                     BLOB                          ,
  UI_SETTINGS                        BLOB                          ,
  ASSIGNMENT_TYPE                    NUMBER(10,0)         NOT NULL ,
  INHERITED_AUTH                     NUMBER(10,0)         NOT NULL ,
  PARALLEL_INHERITED_AUTH            NUMBER(10,0)         NOT NULL ,
  NATIVE_LOOKUP_NAME                 VARCHAR2(254)                 ,
  WORK_BASKET                        VARCHAR2(254)                 ,
  EAR_VERSION                        NUMBER(10,0)         NOT NULL ,
  SCHEMA_VERSION                     NUMBER(10,0)         NOT NULL ,
  LANGUAGE_TYPE                      NUMBER(10,0)         NOT NULL ,
  DEPLOY_TYPE                        NUMBER(10,0)         NOT NULL ,
  CUSTOM_TEXT1                       VARCHAR2(64)                  ,
  CUSTOM_TEXT2                       VARCHAR2(64)                  ,
  CUSTOM_TEXT3                       VARCHAR2(64)                  ,
  CUSTOM_TEXT4                       VARCHAR2(64)                  ,
  CUSTOM_TEXT5                       VARCHAR2(64)                  ,
  CUSTOM_TEXT6                       VARCHAR2(64)                  ,
  CUSTOM_TEXT7                       VARCHAR2(64)                  ,
  CUSTOM_TEXT8                       VARCHAR2(64)                  
) LOGGING;

ALTER TABLE cmndb_owner.TASK_TEMPLATE_T ADD(
  PRIMARY KEY ( TKTID )
);

CREATE UNIQUE INDEX cmndb_owner.TT_NAME_VF_NS ON cmndb_owner.TASK_TEMPLATE_T
(   
  NAME, VALID_FROM, NAMESPACE
) LOGGING;

CREATE INDEX cmndb_owner.TT_CCID_STATE ON cmndb_owner.TASK_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID, STATE
) LOGGING;

CREATE INDEX cmndb_owner.TT_KND_INLN_VAL ON cmndb_owner.TASK_TEMPLATE_T
(   
  KIND, IS_INLINE, VALID_FROM
) LOGGING;

CREATE INDEX cmndb_owner.TT_NATLOOK_ADHOC ON cmndb_owner.TASK_TEMPLATE_T
(   
  NATIVE_LOOKUP_NAME, IS_AD_HOC
) LOGGING;

CREATE TABLE cmndb_owner.TASK_TEMPL_CPROP_T
(
  TKTID                              RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(220)        NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  DATA_TYPE                          VARCHAR2(254)                 ,
  STRING_VALUE                       VARCHAR2(254)                 ,
  DATA                               BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.TASK_TEMPL_CPROP_T ADD(
  PRIMARY KEY ( TKTID, NAME )
);

CREATE INDEX cmndb_owner.TTCP_TKTID ON cmndb_owner.TASK_TEMPL_CPROP_T
(   
  TKTID
) LOGGING;

CREATE INDEX cmndb_owner.TTCP_CCID ON cmndb_owner.TASK_TEMPL_CPROP_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_TEMPL_LDESC_T
(
  TKTID                              RAW(16)              NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  DISPLAY_NAME                       VARCHAR2(64)                  ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  DOCUMENTATION                      CLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.TASK_TEMPL_LDESC_T ADD(
  PRIMARY KEY ( TKTID, LOCALE )
);

CREATE INDEX cmndb_owner.TTLD_TKTID ON cmndb_owner.TASK_TEMPL_LDESC_T
(   
  TKTID
) LOGGING;

CREATE INDEX cmndb_owner.TTLD_CCID ON cmndb_owner.TASK_TEMPL_LDESC_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE INDEX cmndb_owner.TTLD_TT_LOC ON cmndb_owner.TASK_TEMPL_LDESC_T
(   
  TKTID, LOCALE DESC
) LOGGING;

CREATE TABLE cmndb_owner.TSERVICE_DESCRIPTION_T
(
  SVTID                              RAW(16)              NOT NULL ,
  TKTID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  IS_ONE_WAY                         NUMBER(5,0)          NOT NULL ,
  SERVICE_REF_NAME                   VARCHAR2(254)                 ,
  OPERATION                          VARCHAR2(254)        NOT NULL ,
  PORT                               VARCHAR2(254)                 ,
  PORT_TYPE_NS                       VARCHAR2(254)        NOT NULL ,
  PORT_TYPE_NAME                     VARCHAR2(254)        NOT NULL ,
  S_BEAN_JNDI_NAME                   VARCHAR2(254)                 ,
  SERVICE                            VARCHAR2(254)                 
) LOGGING;

ALTER TABLE cmndb_owner.TSERVICE_DESCRIPTION_T ADD(
  PRIMARY KEY ( SVTID )
);

CREATE INDEX cmndb_owner.TSD_TKTID ON cmndb_owner.TSERVICE_DESCRIPTION_T
(   
  TKTID
) LOGGING;

CREATE INDEX cmndb_owner.TSD_CCID ON cmndb_owner.TSERVICE_DESCRIPTION_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_CELL_MAP_T
(
  TKTID                              RAW(16)              NOT NULL ,
  CELL                               VARCHAR2(220)        NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_CELL_MAP_T ADD(
  PRIMARY KEY ( TKTID, CELL )
);

CREATE TABLE cmndb_owner.TMAIL_T
(
  MNTID                              RAW(16)              NOT NULL ,
  FROM_STATE                         NUMBER(10,0)         NOT NULL ,
  TO_STATE                           NUMBER(10,0)         NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  HASH_CODE                          NUMBER(10,0)         NOT NULL ,
  SUBJECT                            VARCHAR2(254)        NOT NULL ,
  BODY_TEXT                          CLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.TMAIL_T ADD(
  PRIMARY KEY ( MNTID, FROM_STATE, TO_STATE, LOCALE )
);

CREATE INDEX cmndb_owner.EMT_HC ON cmndb_owner.TMAIL_T
(   
  HASH_CODE
) LOGGING;

CREATE TABLE cmndb_owner.COMPLETION_TEMPLATE_T
(
  CMTID                              RAW(16)              NOT NULL ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL ,
  TKTID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  COMPL_CONDITION                    BLOB                          ,
  CRITERION_FOR                      VARCHAR2(254)                 ,
  COMPLETION_NAME                    VARCHAR2(220)                 ,
  IS_DEFAULT_COMPLETION              NUMBER(5,0)          NOT NULL ,
  PREFIX_MAP                         BLOB                          ,
  USE_DEFAULT_RESULT_CONSTRUCT       NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.COMPLETION_TEMPLATE_T ADD(
  PRIMARY KEY ( CMTID )
);

CREATE INDEX cmndb_owner.CMPT_TKTID_ORDER ON cmndb_owner.COMPLETION_TEMPLATE_T
(   
  TKTID, ORDER_NUMBER
) LOGGING;

CREATE INDEX cmndb_owner.CMPT_CCID ON cmndb_owner.COMPLETION_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.RESULT_AGGREGATION_TEMPLATE_T
(
  RATID                              RAW(16)              NOT NULL ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL ,
  CMTID                              RAW(16)              NOT NULL ,
  TKTID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  AGGR_PART                          VARCHAR2(254)                 ,
  AGGR_LOCATION                      BLOB                          ,
  AGGR_FUNCTION                      VARCHAR2(254)        NOT NULL ,
  AGGR_CONDITION                     BLOB                          ,
  PREFIX_MAP                         BLOB                          
) LOGGING;

ALTER TABLE cmndb_owner.RESULT_AGGREGATION_TEMPLATE_T ADD(
  PRIMARY KEY ( RATID )
);

CREATE INDEX cmndb_owner.RAGT_CMTID_ORD_TT ON cmndb_owner.RESULT_AGGREGATION_TEMPLATE_T
(   
  CMTID, ORDER_NUMBER, TKTID
) LOGGING;

CREATE INDEX cmndb_owner.RAGT_CCID ON cmndb_owner.RESULT_AGGREGATION_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.PEOPLE_RESOURCE_REF_TEMPLATE_T
(
  PRRTID                             RAW(16)              NOT NULL ,
  TEMPLATE_OID                       RAW(16)              NOT NULL ,
  REASON                             NUMBER(10,0)         NOT NULL ,
  PRID                               RAW(16)              NOT NULL ,
  PARAMETER_BINDINGS                 BLOB                          ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PEOPLE_RESOURCE_REF_TEMPLATE_T ADD(
  PRIMARY KEY ( PRRTID )
);

CREATE INDEX cmndb_owner.PRRT_PRID ON cmndb_owner.PEOPLE_RESOURCE_REF_TEMPLATE_T
(   
  PRID
) LOGGING;

CREATE INDEX cmndb_owner.PRRT_ccID ON cmndb_owner.PEOPLE_RESOURCE_REF_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.ESCALATION_INSTANCE_T
(
  ESIID                              RAW(16)              NOT NULL ,
  ESTID                              RAW(16)                       ,
  FIRST_ESIID                        RAW(16)                       ,
  PREVIOUS_ESIID                     RAW(16)                       ,
  TKIID                              RAW(16)              NOT NULL ,
  MNTID                              RAW(16)                       ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  NAME                               VARCHAR2(220)                 ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  ACTIVATION_STATE                   NUMBER(10,0)         NOT NULL ,
  AT_LEAST_EXPECTED_STATE            NUMBER(10,0)         NOT NULL ,
  ACTIVATION_TIME                    TIMESTAMP                     ,
  ESCALATION_TIME                    TIMESTAMP                     ,
  DURATION_UNTIL_ESCALATION          VARCHAR2(254)                 ,
  DURATION_UNTIL_REPEATS             VARCHAR2(254)                 ,
  INCREASE_PRIORITY                  NUMBER(10,0)         NOT NULL ,
  ACTION                             NUMBER(10,0)         NOT NULL ,
  ESCALATION_RECEIVER_QTID           RAW(16)                       ,
  RECEIVER_EMAIL_QTID                RAW(16)                       ,
  SCHEDULER_ID                       VARCHAR2(254)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ESCALATION_INSTANCE_T ADD(
  PRIMARY KEY ( ESIID )
);

CREATE INDEX cmndb_owner.ESI_FIRST ON cmndb_owner.ESCALATION_INSTANCE_T
(   
  FIRST_ESIID
) LOGGING;

CREATE INDEX cmndb_owner.ESI_TKIID_ASTATE ON cmndb_owner.ESCALATION_INSTANCE_T
(   
  TKIID, ACTIVATION_STATE, STATE
) LOGGING;

CREATE INDEX cmndb_owner.ESI_TKIID_STATE ON cmndb_owner.ESCALATION_INSTANCE_T
(   
  TKIID, STATE
) LOGGING;

CREATE INDEX cmndb_owner.ESI_PREV ON cmndb_owner.ESCALATION_INSTANCE_T
(   
  PREVIOUS_ESIID
) LOGGING;

CREATE INDEX cmndb_owner.ESI_ESTID ON cmndb_owner.ESCALATION_INSTANCE_T
(   
  ESTID
) LOGGING;

CREATE INDEX cmndb_owner.ESI_CCID ON cmndb_owner.ESCALATION_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE INDEX cmndb_owner.ESI_EST_ESI ON cmndb_owner.ESCALATION_INSTANCE_T
(   
  ESTID, ESIID
) LOGGING;

CREATE INDEX cmndb_owner.ESI_WSID1 ON cmndb_owner.ESCALATION_INSTANCE_T
(   
  WSID_1
) LOGGING;

CREATE INDEX cmndb_owner.ESI_WSID2 ON cmndb_owner.ESCALATION_INSTANCE_T
(   
  WSID_2
) LOGGING;

CREATE TABLE cmndb_owner.ESC_INST_CPROP_T
(
  ESIID                              RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(220)        NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  STRING_VALUE                       VARCHAR2(254)                 ,
  DATA_TYPE                          VARCHAR2(254)                 ,
  DATA                               BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ESC_INST_CPROP_T ADD(
  PRIMARY KEY ( ESIID, NAME )
);

CREATE INDEX cmndb_owner.EICP_CCID ON cmndb_owner.ESC_INST_CPROP_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.ESC_INST_LDESC_T
(
  ESIID                              RAW(16)              NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  DISPLAY_NAME                       VARCHAR2(64)                  ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ESC_INST_LDESC_T ADD(
  PRIMARY KEY ( ESIID, LOCALE )
);

CREATE INDEX cmndb_owner.EILD_CCID ON cmndb_owner.ESC_INST_LDESC_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.EIDOCUMENTATION_T
(
  ESIID                              RAW(16)              NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  DOCUMENTATION                      CLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.EIDOCUMENTATION_T ADD(
  PRIMARY KEY ( ESIID, LOCALE )
);

CREATE INDEX cmndb_owner.EIDOC_CCID ON cmndb_owner.EIDOCUMENTATION_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.ISERVICE_DESCRIPTION_T
(
  SVTID                              RAW(16)              NOT NULL ,
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  IS_ONE_WAY                         NUMBER(5,0)          NOT NULL ,
  SERVICE_REF_NAME                   VARCHAR2(254)                 ,
  OPERATION                          VARCHAR2(254)        NOT NULL ,
  PORT                               VARCHAR2(254)                 ,
  PORT_TYPE_NS                       VARCHAR2(254)        NOT NULL ,
  PORT_TYPE_NAME                     VARCHAR2(254)        NOT NULL ,
  S_BEAN_JNDI_NAME                   VARCHAR2(254)                 ,
  SERVICE                            VARCHAR2(254)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ISERVICE_DESCRIPTION_T ADD(
  PRIMARY KEY ( SVTID )
);

CREATE INDEX cmndb_owner.ISD_TKIID ON cmndb_owner.ISERVICE_DESCRIPTION_T
(   
  TKIID
) LOGGING;

CREATE INDEX cmndb_owner.ISD_CCID ON cmndb_owner.ISERVICE_DESCRIPTION_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_INSTANCE_T
(
  TKIID                              RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(220)        NOT NULL ,
  NAMESPACE                          VARCHAR2(254)        NOT NULL ,
  TKTID                              RAW(16)                       ,
  TOP_TKIID                          RAW(16)              NOT NULL ,
  FOLLOW_ON_TKIID                    RAW(16)                       ,
  APPLICATION_NAME                   VARCHAR2(220)                 ,
  APPLICATION_DEFAULTS_ID            RAW(16)                       ,
  CONTAINMENT_CONTEXT_ID             RAW(16)                       ,
  PARENT_CONTEXT_ID                  RAW(16)                       ,
  STATE                              NUMBER(10,0)         NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  AUTO_DELETE_MODE                   NUMBER(10,0)         NOT NULL ,
  HIERARCHY_POSITION                 NUMBER(10,0)         NOT NULL ,
  TYPE                               VARCHAR2(254)                 ,
  SVTID                              RAW(16)                       ,
  SUPPORTS_CLAIM_SUSPENDED           NUMBER(5,0)          NOT NULL ,
  SUPPORTS_AUTO_CLAIM                NUMBER(5,0)          NOT NULL ,
  SUPPORTS_FOLLOW_ON_TASK            NUMBER(5,0)          NOT NULL ,
  IS_AD_HOC                          NUMBER(5,0)          NOT NULL ,
  IS_ESCALATED                       NUMBER(5,0)          NOT NULL ,
  IS_INLINE                          NUMBER(5,0)          NOT NULL ,
  IS_SUSPENDED                       NUMBER(5,0)          NOT NULL ,
  IS_WAITING_FOR_SUBTASK             NUMBER(5,0)          NOT NULL ,
  SUPPORTS_DELEGATION                NUMBER(5,0)          NOT NULL ,
  SUPPORTS_SUB_TASK                  NUMBER(5,0)          NOT NULL ,
  IS_CHILD                           NUMBER(5,0)          NOT NULL ,
  HAS_ESCALATIONS                    NUMBER(5,0)                   ,
  START_TIME                         TIMESTAMP                     ,
  ACTIVATION_TIME                    TIMESTAMP                     ,
  LAST_MODIFICATION_TIME             TIMESTAMP                     ,
  LAST_STATE_CHANGE_TIME             TIMESTAMP                     ,
  COMPLETION_TIME                    TIMESTAMP                     ,
  DUE_TIME                           TIMESTAMP                     ,
  EXPIRATION_TIME                    TIMESTAMP                     ,
  FIRST_ACTIVATION_TIME              TIMESTAMP                     ,
  DEFAULT_LOCALE                     VARCHAR2(32)                  ,
  DURATION_UNTIL_DELETED             VARCHAR2(254)                 ,
  DURATION_UNTIL_DUE                 VARCHAR2(254)                 ,
  DURATION_UNTIL_EXPIRES             VARCHAR2(254)                 ,
  CALENDAR_NAME                      VARCHAR2(254)                 ,
  JNDI_NAME_CALENDAR                 VARCHAR2(254)                 ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR2(254)                 ,
  CONTEXT_AUTHORIZATION              NUMBER(10,0)         NOT NULL ,
  ORIGINATOR                         VARCHAR2(128)                 ,
  STARTER                            VARCHAR2(128)                 ,
  OWNER                              VARCHAR2(128)                 ,
  ADMIN_QTID                         RAW(16)                       ,
  EDITOR_QTID                        RAW(16)                       ,
  POTENTIAL_OWNER_QTID               RAW(16)                       ,
  POTENTIAL_STARTER_QTID             RAW(16)                       ,
  READER_QTID                        RAW(16)                       ,
  PRIORITY                           NUMBER(10,0)                  ,
  SCHEDULER_ID                       VARCHAR2(254)                 ,
  SERVICE_TICKET                     VARCHAR2(254)                 ,
  EVENT_HANDLER_NAME                 VARCHAR2(64)                  ,
  BUSINESS_RELEVANCE                 NUMBER(5,0)          NOT NULL ,
  RESUMES                            TIMESTAMP                     ,
  SUBSTITUTION_POLICY                NUMBER(10,0)         NOT NULL ,
  DELETION_TIME                      TIMESTAMP                     ,
  ASSIGNMENT_TYPE                    NUMBER(10,0)         NOT NULL ,
  INHERITED_AUTH                     NUMBER(10,0)         NOT NULL ,
  PARALLEL_INHERITED_AUTH            NUMBER(10,0)         NOT NULL ,
  INVOKED_INSTANCE_ID                RAW(16)                       ,
  INVOKED_INSTANCE_TYPE              NUMBER(10,0)         NOT NULL ,
  WORK_BASKET                        VARCHAR2(254)                 ,
  IS_READ                            NUMBER(5,0)          NOT NULL ,
  IS_TRANSFERRED_TO_WORK_BASKET      NUMBER(5,0)          NOT NULL ,
  CREATED_WITH_VERSION               NUMBER(10,0)         NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  CUSTOM_TEXT1                       VARCHAR2(64)                  ,
  CUSTOM_TEXT2                       VARCHAR2(64)                  ,
  CUSTOM_TEXT3                       VARCHAR2(64)                  ,
  CUSTOM_TEXT4                       VARCHAR2(64)                  ,
  CUSTOM_TEXT5                       VARCHAR2(64)                  ,
  CUSTOM_TEXT6                       VARCHAR2(64)                  ,
  CUSTOM_TEXT7                       VARCHAR2(64)                  ,
  CUSTOM_TEXT8                       VARCHAR2(64)                  ,
  EXT_ATTR                           NUMBER(10,0)                  ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_INSTANCE_T ADD(
  PRIMARY KEY ( TKIID )
);

CREATE INDEX cmndb_owner.TI_PARENT ON cmndb_owner.TASK_INSTANCE_T
(   
  PARENT_CONTEXT_ID
) LOGGING;

CREATE INDEX cmndb_owner.TI_SERVICET ON cmndb_owner.TASK_INSTANCE_T
(   
  SERVICE_TICKET
) LOGGING;

CREATE INDEX cmndb_owner.TI_CCID ON cmndb_owner.TASK_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE INDEX cmndb_owner.TI_TK_TOPTK ON cmndb_owner.TASK_INSTANCE_T
(   
  TKTID, TKIID, TOP_TKIID
) LOGGING;

CREATE INDEX cmndb_owner.TI_TOPTKIID ON cmndb_owner.TASK_INSTANCE_T
(   
  TOP_TKIID
) LOGGING;

CREATE INDEX cmndb_owner.TI_TI_KND_ST ON cmndb_owner.TASK_INSTANCE_T
(   
  TKIID, KIND, STATE
) LOGGING;

CREATE INDEX cmndb_owner.TI_WOBA ON cmndb_owner.TASK_INSTANCE_T
(   
  WORK_BASKET
) LOGGING;

CREATE INDEX cmndb_owner.TI_TYPE ON cmndb_owner.TASK_INSTANCE_T
(   
  TYPE
) LOGGING;

CREATE INDEX cmndb_owner.TI_WSID1 ON cmndb_owner.TASK_INSTANCE_T
(   
  WSID_1, KIND
) LOGGING;

CREATE INDEX cmndb_owner.TI_WSID2 ON cmndb_owner.TASK_INSTANCE_T
(   
  WSID_2, KIND
) LOGGING;

CREATE INDEX cmndb_owner.TI_WSID1S ON cmndb_owner.TASK_INSTANCE_T
(   
  WSID_1, KIND, STATE
) LOGGING;

CREATE INDEX cmndb_owner.TI_WSID2S ON cmndb_owner.TASK_INSTANCE_T
(   
  WSID_2, KIND, STATE
) LOGGING;

CREATE INDEX cmndb_owner.TI_Q1 ON cmndb_owner.TASK_INSTANCE_T
(   
  KIND, PRIORITY, OWNER, STARTER, ORIGINATOR
) LOGGING;

CREATE TABLE cmndb_owner.TASK_INSTANCE_EXT_ATTR_T
(
  TKIID                              RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  VALUE                              VARCHAR2(254)                 ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_INSTANCE_EXT_ATTR_T ADD(
  PRIMARY KEY ( TKIID, KIND )
);

CREATE INDEX cmndb_owner.TIEA_CTXID ON cmndb_owner.TASK_INSTANCE_EXT_ATTR_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_CONTEXT_T
(
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  SERVICE_CONTEXT                    BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_CONTEXT_T ADD(
  PRIMARY KEY ( TKIID )
);

CREATE INDEX cmndb_owner.TC_CCID ON cmndb_owner.TASK_CONTEXT_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.CONTACT_QUERIES_T
(
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  CONTACTS_QTIDS                     BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.CONTACT_QUERIES_T ADD(
  PRIMARY KEY ( TKIID )
);

CREATE INDEX cmndb_owner.CQ_CCID ON cmndb_owner.CONTACT_QUERIES_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.UISETTINGS_T
(
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  UI_SETTINGS                        BLOB                 NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.UISETTINGS_T ADD(
  PRIMARY KEY ( TKIID )
);

CREATE INDEX cmndb_owner.UIS_CCID ON cmndb_owner.UISETTINGS_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.REPLY_HANDLER_T
(
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  REPLY_HANDLER                      BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.REPLY_HANDLER_T ADD(
  PRIMARY KEY ( TKIID )
);

CREATE INDEX cmndb_owner.RH_CCID ON cmndb_owner.REPLY_HANDLER_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_TIMER_T
(
  OID                                RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  SCHEDULER_ID                       VARCHAR2(254)        NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_TIMER_T ADD(
  PRIMARY KEY ( OID, KIND )
);

CREATE TABLE cmndb_owner.TASK_INST_CPROP_T
(
  TKIID                              RAW(16)              NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  NAME                               VARCHAR2(220)        NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  DATA_TYPE                          VARCHAR2(254)                 ,
  STRING_VALUE                       VARCHAR2(254)                 ,
  DATA                               BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_INST_CPROP_T ADD(
  PRIMARY KEY ( TKIID, NAME )
);

CREATE INDEX cmndb_owner.TICP_CCID ON cmndb_owner.TASK_INST_CPROP_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_INST_LDESC_T
(
  TKIID                              RAW(16)              NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  DISPLAY_NAME                       VARCHAR2(64)                  ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_INST_LDESC_T ADD(
  PRIMARY KEY ( TKIID, LOCALE )
);

CREATE INDEX cmndb_owner.TILD_CCID ON cmndb_owner.TASK_INST_LDESC_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE INDEX cmndb_owner.TILD_PD1 ON cmndb_owner.TASK_INST_LDESC_T
(   
  LOCALE, TKIID, DESCRIPTION
) LOGGING;

CREATE INDEX cmndb_owner.TILD_PD2 ON cmndb_owner.TASK_INST_LDESC_T
(   
  LOCALE, TKIID, DISPLAY_NAME
) LOGGING;

CREATE TABLE cmndb_owner.TIDOCUMENTATION_T
(
  TKIID                              RAW(16)              NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  DOCUMENTATION                      CLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TIDOCUMENTATION_T ADD(
  PRIMARY KEY ( TKIID, LOCALE )
);

CREATE INDEX cmndb_owner.TIDOC_CCID ON cmndb_owner.TIDOCUMENTATION_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.ITASK_MESSAGE_DEFINITION_T
(
  TMTID                              RAW(16)              NOT NULL ,
  TKIID                              RAW(16)                       ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  FAULT_NAME                         VARCHAR2(254)                 ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  MESSAGE_TYPE_NS                    VARCHAR2(220)        NOT NULL ,
  MESSAGE_TYPE_NAME                  VARCHAR2(220)        NOT NULL ,
  MESSAGE_DEFINITION                 BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.ITASK_MESSAGE_DEFINITION_T ADD(
  PRIMARY KEY ( TMTID )
);

CREATE INDEX cmndb_owner.ITMD_IDKINSTYPE ON cmndb_owner.ITASK_MESSAGE_DEFINITION_T
(   
  TKIID, MESSAGE_TYPE_NS, MESSAGE_TYPE_NAME, KIND
) LOGGING;

CREATE INDEX cmndb_owner.ITMD_TKIIDKINDFN ON cmndb_owner.ITASK_MESSAGE_DEFINITION_T
(   
  TKIID, KIND, FAULT_NAME
) LOGGING;

CREATE INDEX cmndb_owner.ITMD_CCID ON cmndb_owner.ITASK_MESSAGE_DEFINITION_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_MESSAGE_INSTANCE_T
(
  TMIID                              RAW(16)              NOT NULL ,
  TMTID                              RAW(16)                       ,
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  FAULT_NAME                         VARCHAR2(254)                 ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  MESSAGE_TYPE_NS                    VARCHAR2(220)        NOT NULL ,
  MESSAGE_TYPE_NAME                  VARCHAR2(220)        NOT NULL ,
  DATA                               BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_MESSAGE_INSTANCE_T ADD(
  PRIMARY KEY ( TMIID )
);

CREATE INDEX cmndb_owner.TMI_TI_K ON cmndb_owner.TASK_MESSAGE_INSTANCE_T
(   
  TKIID, KIND
) LOGGING;

CREATE INDEX cmndb_owner.TMI_TMTID ON cmndb_owner.TASK_MESSAGE_INSTANCE_T
(   
  TMTID
) LOGGING;

CREATE INDEX cmndb_owner.TMI_CCID ON cmndb_owner.TASK_MESSAGE_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_AUDIT_LOG_T
(
  ALID                               RAW(16)              NOT NULL ,
  AUDIT_EVENT                        NUMBER(10,0)         NOT NULL ,
  TKIID                              RAW(16)                       ,
  TKTID                              RAW(16)                       ,
  ESIID                              RAW(16)                       ,
  ESTID                              RAW(16)                       ,
  TOP_TKIID                          RAW(16)                       ,
  FOLLOW_ON_TKIID                    RAW(16)                       ,
  PARENT_TKIID                       RAW(16)                       ,
  PARENT_CONTEXT_ID                  RAW(16)                       ,
  CONTAINMENT_CONTEXT_ID             RAW(16)                       ,
  WI_REASON                          NUMBER(10,0)                  ,
  NAME                               VARCHAR2(254)                 ,
  NAMESPACE                          VARCHAR2(254)                 ,
  VALID_FROM_UTC                     TIMESTAMP                     ,
  EVENT_TIME_UTC                     TIMESTAMP                     ,
  PARENT_TASK_NAME                   VARCHAR2(254)                 ,
  PARENT_TASK_NAMESPACE              VARCHAR2(254)                 ,
  TASK_KIND                          NUMBER(10,0)                  ,
  TASK_STATE                         NUMBER(10,0)                  ,
  FAULT_TYPE_NAME                    VARCHAR2(220)                 ,
  FAULT_NAMESPACE                    VARCHAR2(220)                 ,
  FAULT_NAME                         VARCHAR2(220)                 ,
  NEW_USER                           VARCHAR2(128)                 ,
  OLD_USER                           VARCHAR2(128)                 ,
  PRINCIPAL                          VARCHAR2(128)                 ,
  USERS                              CLOB                          ,
  DESCRIPTION                        CLOB                          ,
  MESSAGE_DATA                       BLOB                          ,
  SNAPSHOT_ID                        VARCHAR2(254)                 ,
  SNAPSHOT_NAME                      VARCHAR2(254)                 ,
  PROCESS_APP_ACRONYM                VARCHAR2(7)                   ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_AUDIT_LOG_T ADD(
  PRIMARY KEY ( ALID )
);

CREATE TABLE cmndb_owner.IMAIL_T
(
  OBJECT_ID                          RAW(16)              NOT NULL ,
  FROM_STATE                         NUMBER(10,0)         NOT NULL ,
  TO_STATE                           NUMBER(10,0)         NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  SUBJECT                            VARCHAR2(254)        NOT NULL ,
  URI                                VARCHAR2(254)                 ,
  BODY_TEXT                          CLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.IMAIL_T ADD(
  PRIMARY KEY ( OBJECT_ID, FROM_STATE, TO_STATE, LOCALE )
);

CREATE INDEX cmndb_owner.IMN_CTX ON cmndb_owner.IMAIL_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.TASK_HISTORY_T
(
  PKID                               RAW(16)              NOT NULL ,
  EVENT                              NUMBER(10,0)         NOT NULL ,
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  PARENT_TKIID                       RAW(16)                       ,
  ESIID                              RAW(16)                       ,
  REASON                             NUMBER(10,0)         NOT NULL ,
  EVENT_TIME                         TIMESTAMP            NOT NULL ,
  NEXT_TIME                          TIMESTAMP                     ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  PRINCIPAL                          VARCHAR2(128)        NOT NULL ,
  WORK_ITEM_KIND                     NUMBER(10,0)         NOT NULL ,
  FROM_ID                            VARCHAR2(128)                 ,
  TO_ID                              VARCHAR2(128)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.TASK_HISTORY_T ADD(
  PRIMARY KEY ( PKID )
);

CREATE INDEX cmndb_owner.TH_TKIID ON cmndb_owner.TASK_HISTORY_T
(   
  TKIID
) LOGGING;

CREATE INDEX cmndb_owner.TH_CTXID ON cmndb_owner.TASK_HISTORY_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.COMPLETION_INSTANCE_T
(
  CMIID                              RAW(16)              NOT NULL ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL ,
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  COMPL_CONDITION                    BLOB                          ,
  CRITERION_FOR                      VARCHAR2(254)                 ,
  CRITERION_FOR_TIME                 TIMESTAMP                     ,
  COMPLETION_NAME                    VARCHAR2(220)                 ,
  IS_DEFAULT_COMPLETION              NUMBER(5,0)          NOT NULL ,
  PREFIX_MAP                         BLOB                          ,
  USE_DEFAULT_RESULT_CONSTRUCT       NUMBER(5,0)          NOT NULL ,
  SCHEDULER_ID                       VARCHAR2(254)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.COMPLETION_INSTANCE_T ADD(
  PRIMARY KEY ( CMIID )
);

CREATE INDEX cmndb_owner.CMPI_TKIID_ORDER ON cmndb_owner.COMPLETION_INSTANCE_T
(   
  TKIID, ORDER_NUMBER
) LOGGING;

CREATE INDEX cmndb_owner.CMPI_CCID ON cmndb_owner.COMPLETION_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.RESULT_AGGREGATION_INSTANCE_T
(
  RAIID                              RAW(16)              NOT NULL ,
  ORDER_NUMBER                       NUMBER(10,0)         NOT NULL ,
  CMIID                              RAW(16)              NOT NULL ,
  TKIID                              RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  AGGR_PART                          VARCHAR2(254)                 ,
  AGGR_LOCATION                      BLOB                          ,
  AGGR_FUNCTION                      VARCHAR2(254)        NOT NULL ,
  AGGR_CONDITION                     BLOB                          ,
  PREFIX_MAP                         BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.RESULT_AGGREGATION_INSTANCE_T ADD(
  PRIMARY KEY ( RAIID )
);

CREATE INDEX cmndb_owner.RAGI_CMIID_ORDER ON cmndb_owner.RESULT_AGGREGATION_INSTANCE_T
(   
  CMIID, ORDER_NUMBER
) LOGGING;

CREATE INDEX cmndb_owner.RAGI_CCID ON cmndb_owner.RESULT_AGGREGATION_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.SAVED_TASK_MESSAGE_T
(
  STMID                              RAW(16)              NOT NULL ,
  RELATED_OID                        RAW(16)              NOT NULL ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  KIND                               NUMBER(10,0)         NOT NULL ,
  SCHEDULER_ID                       VARCHAR2(254)                 ,
  CREATION_TIME                      TIMESTAMP            NOT NULL ,
  EXPECTED_ARRIVAL_TIME              TIMESTAMP            NOT NULL ,
  MESSAGE                            BLOB                          ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.SAVED_TASK_MESSAGE_T ADD(
  PRIMARY KEY ( STMID )
);

CREATE INDEX cmndb_owner.STM_ROIDKIND ON cmndb_owner.SAVED_TASK_MESSAGE_T
(   
  RELATED_OID, KIND
) LOGGING;

CREATE INDEX cmndb_owner.STM_SID ON cmndb_owner.SAVED_TASK_MESSAGE_T
(   
  SCHEDULER_ID
) LOGGING;

CREATE INDEX cmndb_owner.STM_CTXID ON cmndb_owner.SAVED_TASK_MESSAGE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.PEOPLE_RESOURCE_REF_INSTANCE_T
(
  PRRIID                             RAW(16)              NOT NULL ,
  PRRTID                             RAW(16)              NOT NULL ,
  INSTANCE_OID                       RAW(16)              NOT NULL ,
  PARAMETER_VALUES                   BLOB                          ,
  CONTAINMENT_CONTEXT_ID             RAW(16)              NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PEOPLE_RESOURCE_REF_INSTANCE_T ADD(
  PRIMARY KEY ( PRRIID )
);

CREATE INDEX cmndb_owner.PRRI_INSTOID ON cmndb_owner.PEOPLE_RESOURCE_REF_INSTANCE_T
(   
  INSTANCE_OID
) LOGGING;

CREATE INDEX cmndb_owner.PRRI_ccID ON cmndb_owner.PEOPLE_RESOURCE_REF_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
) LOGGING;

CREATE TABLE cmndb_owner.PEOPLE_RESOURCE_T
(
  PRID                               RAW(16)              NOT NULL ,
  NAMESPACE                          VARCHAR2(254)        NOT NULL ,
  NAME                               VARCHAR2(254)        NOT NULL ,
  PARAMETERS                         BLOB                          ,
  BINDING_TYPE                       NUMBER(10,0)         NOT NULL ,
  BINDING_OID                        RAW(16)                       ,
  BINDING_DETAILS                    BLOB                          ,
  APPLICATION_NAME                   VARCHAR2(220)                 ,
  LAST_MODIFICATION_TIME             TIMESTAMP            NOT NULL ,
  EAR_VERSION                        NUMBER(10,0)         NOT NULL ,
  SCHEMA_VERSION                     NUMBER(10,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PEOPLE_RESOURCE_T ADD(
  PRIMARY KEY ( PRID )
);

CREATE INDEX cmndb_owner.PR_BOID ON cmndb_owner.PEOPLE_RESOURCE_T
(   
  BINDING_OID
) LOGGING;

CREATE INDEX cmndb_owner.PR_APPNAME_NS_NAME ON cmndb_owner.PEOPLE_RESOURCE_T
(   
  APPLICATION_NAME, NAMESPACE, NAME
) LOGGING;

CREATE TABLE cmndb_owner.PEOPLE_QUERY_T
(
  PQID                               RAW(16)              NOT NULL ,
  NAME                               VARCHAR2(254)        NOT NULL ,
  NAMESPACE                          VARCHAR2(254)        NOT NULL ,
  TYPE                               NUMBER(10,0)         NOT NULL ,
  QUERY_DEFINITION                   BLOB                          ,
  APPLICATION_NAME                   VARCHAR2(220)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PEOPLE_QUERY_T ADD(
  PRIMARY KEY ( PQID )
);

CREATE INDEX cmndb_owner.PQ_APPNAME ON cmndb_owner.PEOPLE_QUERY_T
(   
  APPLICATION_NAME
) LOGGING;

CREATE TABLE cmndb_owner.PEOPLE_RESOLUTION_RESULT_T
(
  PRRID                              RAW(16)              NOT NULL ,
  RELATED_OID                        RAW(16)              NOT NULL ,
  RELATED_TYPE                       NUMBER(10,0)         NOT NULL ,
  CONTEXT_DATA                       BLOB                          ,
  CONTEXT_HASH_CODE                  NUMBER(10,0)                  ,
  PARENT_PRRID                       RAW(16)                       ,
  EXPIRATION_TIME                    TIMESTAMP                     ,
  QIID4_UG                           RAW(16)              NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.PEOPLE_RESOLUTION_RESULT_T ADD(
  PRIMARY KEY ( PRRID )
);

CREATE INDEX cmndb_owner.PRR_RE_HC ON cmndb_owner.PEOPLE_RESOLUTION_RESULT_T
(   
  RELATED_OID, CONTEXT_HASH_CODE
) LOGGING;

CREATE INDEX cmndb_owner.PRR_QIID4UG ON cmndb_owner.PEOPLE_RESOLUTION_RESULT_T
(   
  QIID4_UG
) LOGGING;

CREATE TABLE cmndb_owner.WORK_BASKET_T
(
  WBID                               RAW(16)              NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  NAME                               VARCHAR2(254)        NOT NULL ,
  TYPE                               NUMBER(10,0)         NOT NULL ,
  OWNER                              VARCHAR2(128)                 ,
  SUBSTITUTION_POLICY                NUMBER(10,0)         NOT NULL ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR2(254)        NOT NULL ,
  DEFAULT_QUERY_TABLE                VARCHAR2(32)                  ,
  CUSTOM_TEXT1                       VARCHAR2(254)                 ,
  CUSTOM_TEXT2                       VARCHAR2(254)                 ,
  CUSTOM_TEXT3                       VARCHAR2(254)                 ,
  CUSTOM_TEXT4                       VARCHAR2(254)                 ,
  CUSTOM_TEXT5                       VARCHAR2(254)                 ,
  CUSTOM_TEXT6                       VARCHAR2(254)                 ,
  CUSTOM_TEXT7                       VARCHAR2(254)                 ,
  CUSTOM_TEXT8                       VARCHAR2(254)                 ,
  EXTENDED_DATA                      BLOB                          ,
  CREATION_TIME                      TIMESTAMP            NOT NULL ,
  LAST_MODIFICATION_TIME             TIMESTAMP            NOT NULL ,
  CREATED_WITH_VERSION               NUMBER(10,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.WORK_BASKET_T ADD(
  PRIMARY KEY ( WBID )
);

CREATE INDEX cmndb_owner.WBK_NAME ON cmndb_owner.WORK_BASKET_T
(   
  NAME
) LOGGING;

CREATE INDEX cmndb_owner.WBK_TYPE ON cmndb_owner.WORK_BASKET_T
(   
  TYPE
) LOGGING;

CREATE INDEX cmndb_owner.WBK_WSID1 ON cmndb_owner.WORK_BASKET_T
(   
  WSID_1
) LOGGING;

CREATE INDEX cmndb_owner.WBK_WSID2 ON cmndb_owner.WORK_BASKET_T
(   
  WSID_2
) LOGGING;

CREATE TABLE cmndb_owner.WORK_BASKET_LDESC_T
(
  WBID                               RAW(16)              NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  DISPLAY_NAME                       VARCHAR2(64)                  ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.WORK_BASKET_LDESC_T ADD(
  PRIMARY KEY ( WBID, LOCALE )
);

CREATE TABLE cmndb_owner.WORK_BASKET_DIST_TARGET_T
(
  SOURCE_WBID                        RAW(16)              NOT NULL ,
  TARGET_WBID                        RAW(16)              NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.WORK_BASKET_DIST_TARGET_T ADD(
  PRIMARY KEY ( SOURCE_WBID, TARGET_WBID )
);

CREATE INDEX cmndb_owner.WBDT_TWB ON cmndb_owner.WORK_BASKET_DIST_TARGET_T
(   
  TARGET_WBID
) LOGGING;

CREATE TABLE cmndb_owner.BUSINESS_CATEGORY_T
(
  BCID                               RAW(16)              NOT NULL ,
  PARENT_BCID                        RAW(16)                       ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  NAME                               VARCHAR2(254)        NOT NULL ,
  PRIORITY                           NUMBER(10,0)                  ,
  SUBSTITUTION_POLICY                NUMBER(10,0)         NOT NULL ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR2(254)        NOT NULL ,
  DEFAULT_QUERY_TABLE                VARCHAR2(32)                  ,
  CUSTOM_TEXT1                       VARCHAR2(254)                 ,
  CUSTOM_TEXT2                       VARCHAR2(254)                 ,
  CUSTOM_TEXT3                       VARCHAR2(254)                 ,
  CUSTOM_TEXT4                       VARCHAR2(254)                 ,
  CUSTOM_TEXT5                       VARCHAR2(254)                 ,
  CUSTOM_TEXT6                       VARCHAR2(254)                 ,
  CUSTOM_TEXT7                       VARCHAR2(254)                 ,
  CUSTOM_TEXT8                       VARCHAR2(254)                 ,
  EXTENDED_DATA                      BLOB                          ,
  CREATION_TIME                      TIMESTAMP            NOT NULL ,
  LAST_MODIFICATION_TIME             TIMESTAMP            NOT NULL ,
  CREATED_WITH_VERSION               NUMBER(10,0)         NOT NULL ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.BUSINESS_CATEGORY_T ADD(
  PRIMARY KEY ( BCID )
);

CREATE INDEX cmndb_owner.BCG_PARENTBCID ON cmndb_owner.BUSINESS_CATEGORY_T
(   
  PARENT_BCID
) LOGGING;

CREATE INDEX cmndb_owner.BCG_NAME ON cmndb_owner.BUSINESS_CATEGORY_T
(   
  NAME
) LOGGING;

CREATE INDEX cmndb_owner.BCG_WSID1 ON cmndb_owner.BUSINESS_CATEGORY_T
(   
  WSID_1
) LOGGING;

CREATE INDEX cmndb_owner.BCG_WSID2 ON cmndb_owner.BUSINESS_CATEGORY_T
(   
  WSID_2
) LOGGING;

CREATE TABLE cmndb_owner.BUSINESS_CATEGORY_LDESC_T
(
  BCID                               RAW(16)              NOT NULL ,
  LOCALE                             VARCHAR2(32)         NOT NULL ,
  WSID_1                             RAW(16)                       ,
  WSID_1_HC                          NUMBER(10,0)                  ,
  WSID_2                             RAW(16)                       ,
  WSID_2_HC                          NUMBER(10,0)                  ,
  DISPLAY_NAME                       VARCHAR2(64)                  ,
  DESCRIPTION                        VARCHAR2(254)                 ,
  VERSION_ID                         NUMBER(5,0)          NOT NULL 
) LOGGING;

ALTER TABLE cmndb_owner.BUSINESS_CATEGORY_LDESC_T ADD(
  PRIMARY KEY ( BCID, LOCALE )
);
-- set schema version to: 8550
INSERT INTO cmndb_owner.SCHEMA_VERSION (SCHEMA_VERSION, DATA_MIGRATION) VALUES( 8550, 0 );


-- View: ProcessTemplate
CREATE VIEW cmndb_owner.PROCESS_TEMPLATE(PTID, NAME, DISPLAY_NAME, VALID_FROM, TARGET_NAMESPACE, APPLICATION_NAME, VERSION, CREATED, STATE, EXECUTION_MODE, DESCRIPTION, CAN_RUN_SYNC, CAN_RUN_INTERRUP, COMP_SPHERE, CONTINUE_ON_ERROR, SNAPSHOT_ID, SNAPSHOT_NAME, TOP_LEVEL_TOOLKIT_ACRONYM, TOP_LEVEL_TOOLKIT_NAME, TRACK_NAME, PROCESS_APP_NAME, PROCESS_APP_ACRONYM, TOOLKIT_SNAPSHOT_ID, TOOLKIT_SNAPSHOT_NAME, TOOLKIT_NAME, TOOLKIT_ACRONYM, IS_TIP, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8 ) AS
 SELECT 
   cmndb_owner.PROCESS_TEMPLATE_B_T.PTID, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.NAME, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.DISPLAY_NAME, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.VALID_FROM, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.TARGET_NAMESPACE, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.APPLICATION_NAME, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.VERSION, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CREATED, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.STATE, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.EXECUTION_MODE, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.DESCRIPTION, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CAN_CALL, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CAN_INITIATE, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.COMPENSATION_SPHERE, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CONTINUE_ON_ERROR, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.SNAPSHOT_ID, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.SNAPSHOT_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOP_LEVEL_TOOLKIT_ACRONYM, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOP_LEVEL_TOOLKIT_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TRACK_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.PROCESS_APP_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.PROCESS_APP_ACRONYM, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOOLKIT_SNAPSHOT_ID, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOOLKIT_SNAPSHOT_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOOLKIT_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOOLKIT_ACRONYM, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.IS_TIP, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT1, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT2, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT3, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT4, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT5, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT6, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT7, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT8
 FROM cmndb_owner.PROCESS_TEMPLATE_B_T LEFT JOIN cmndb_owner.PC_VERSION_TEMPLATE_T ON (cmndb_owner.PC_VERSION_TEMPLATE_T.CONTAINMENT_CONTEXT_ID = cmndb_owner.PROCESS_TEMPLATE_B_T.PTID);

-- View: ProcessTemplAttr
CREATE VIEW cmndb_owner.PROCESS_TEMPL_ATTR(PTID, NAME, VALUE ) AS
 SELECT 
   cmndb_owner.PROCESS_TEMPLATE_ATTRIBUTE_B_T.PTID, 
   cmndb_owner.PROCESS_TEMPLATE_ATTRIBUTE_B_T.ATTR_KEY, 
   cmndb_owner.PROCESS_TEMPLATE_ATTRIBUTE_B_T.VALUE
 FROM cmndb_owner.PROCESS_TEMPLATE_ATTRIBUTE_B_T;

-- View: ProcessInstance
CREATE VIEW cmndb_owner.PROCESS_INSTANCE(PTID, PIID, NAME, STATE, CREATED, STARTED, COMPLETED, PARENT_NAME, TOP_LEVEL_NAME, PARENT_PIID, TOP_LEVEL_PIID, STARTER, DESCRIPTION, TEMPLATE_NAME, TEMPLATE_DESCR, RESUMES, CONTINUE_ON_ERROR, IS_MIGRATED, WSID_1, WSID_2, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8 ) AS
 SELECT 
   cmndb_owner.PROCESS_INSTANCE_B_T.PTID, 
   cmndb_owner.PROCESS_INSTANCE_B_T.PIID, 
   cmndb_owner.PROCESS_INSTANCE_B_T.NAME, 
   cmndb_owner.PROCESS_INSTANCE_B_T.STATE, 
   cmndb_owner.PROCESS_INSTANCE_B_T.CREATED, 
   cmndb_owner.PROCESS_INSTANCE_B_T.STARTED, 
   cmndb_owner.PROCESS_INSTANCE_B_T.COMPLETED, 
   cmndb_owner.PROCESS_INSTANCE_B_T.PARENT_NAME, 
   cmndb_owner.PROCESS_INSTANCE_B_T.TOP_LEVEL_NAME, 
   cmndb_owner.PROCESS_INSTANCE_B_T.PARENT_PIID, 
   cmndb_owner.PROCESS_INSTANCE_B_T.TOP_LEVEL_PIID, 
   cmndb_owner.PROCESS_INSTANCE_B_T.STARTER, 
   cmndb_owner.PROCESS_INSTANCE_B_T.DESCRIPTION, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.NAME, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.DESCRIPTION, 
   cmndb_owner.PROCESS_INSTANCE_B_T.RESUMES, 
   cmndb_owner.PROCESS_TEMPLATE_B_T.CONTINUE_ON_ERROR, 
   cmndb_owner.PROCESS_INSTANCE_B_T.IS_MIGRATED, 
   cmndb_owner.PROCESS_INSTANCE_B_T.WSID_1, 
   cmndb_owner.PROCESS_INSTANCE_B_T.WSID_2, 
   cmndb_owner.PROCESS_INSTANCE_B_T.CUSTOM_TEXT1, 
   cmndb_owner.PROCESS_INSTANCE_B_T.CUSTOM_TEXT2, 
   cmndb_owner.PROCESS_INSTANCE_B_T.CUSTOM_TEXT3, 
   cmndb_owner.PROCESS_INSTANCE_B_T.CUSTOM_TEXT4, 
   cmndb_owner.PROCESS_INSTANCE_B_T.CUSTOM_TEXT5, 
   cmndb_owner.PROCESS_INSTANCE_B_T.CUSTOM_TEXT6, 
   cmndb_owner.PROCESS_INSTANCE_B_T.CUSTOM_TEXT7, 
   cmndb_owner.PROCESS_INSTANCE_B_T.CUSTOM_TEXT8
 FROM cmndb_owner.PROCESS_INSTANCE_B_T, cmndb_owner.PROCESS_TEMPLATE_B_T
 WHERE cmndb_owner.PROCESS_INSTANCE_B_T.PTID = cmndb_owner.PROCESS_TEMPLATE_B_T.PTID;

-- View: ProcessAttribute
CREATE VIEW cmndb_owner.PROCESS_ATTRIBUTE(PIID, NAME, VALUE, DATA_TYPE, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T.PIID, 
   cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T.ATTR_KEY, 
   cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T.VALUE, 
   cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T.DATA_TYPE, 
   cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T.WSID_1, 
   cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T.WSID_2
 FROM cmndb_owner.PROCESS_INSTANCE_ATTRIBUTE_T;

-- View: Activity
CREATE VIEW cmndb_owner.ACTIVITY(PIID, AIID, PTID, ATID, SIID, STID, EHIID, ENCLOSING_FEIID, KIND, COMPLETED, ACTIVATED, FIRST_ACTIVATED, STARTED, STATE, SUB_STATE, STOP_REASON, OWNER, DESCRIPTION, EXPIRES, TEMPLATE_NAME, TEMPLATE_DESCR, BUSINESS_RELEVANCE, SKIP_REQUESTED, CONTINUE_ON_ERROR, INVOKED_INST_ID, INVOKED_INST_TYPE, PREVIOUS_EXPIRATION_TIME, HAS_WORK_ITEM, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.PIID, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.AIID, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.PTID, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.ATID, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.SIID, 
   cmndb_owner.ACTIVITY_TEMPLATE_B_T.PARENT_STID, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.EHIID, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.ENCLOSING_FEIID, 
   cmndb_owner.ACTIVITY_TEMPLATE_B_T.KIND, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.FINISHED, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.ACTIVATED, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.FIRST_ACTIVATED, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.STARTED, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.STATE, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.SUB_STATE, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.STOP_REASON, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.OWNER, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.DESCRIPTION, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.EXPIRES, 
   cmndb_owner.ACTIVITY_TEMPLATE_B_T.NAME, 
   cmndb_owner.ACTIVITY_TEMPLATE_B_T.DESCRIPTION, 
   cmndb_owner.ACTIVITY_TEMPLATE_B_T.BUSINESS_RELEVANCE, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.SKIP_REQUESTED, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.CONTINUE_ON_ERROR, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.INVOKED_INSTANCE_ID, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.INVOKED_INSTANCE_TYPE, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.PREVIOUS_EXPIRATION_DATE, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.HAS_WORK_ITEM, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.WSID_1, 
   cmndb_owner.ACTIVITY_INSTANCE_B_T.WSID_2
 FROM cmndb_owner.ACTIVITY_INSTANCE_B_T, cmndb_owner.ACTIVITY_TEMPLATE_B_T
 WHERE cmndb_owner.ACTIVITY_INSTANCE_B_T.ATID = cmndb_owner.ACTIVITY_TEMPLATE_B_T.ATID;

-- View: ActivityAttribute
CREATE VIEW cmndb_owner.ACTIVITY_ATTRIBUTE(AIID, NAME, VALUE, DATA_TYPE, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T.AIID, 
   cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T.ATTR_KEY, 
   cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T.ATTR_VALUE, 
   cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T.DATA_TYPE, 
   cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T.WSID_1, 
   cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T.WSID_2
 FROM cmndb_owner.ACTIVITY_INSTANCE_ATTR_B_T;

-- View: Event
CREATE VIEW cmndb_owner.EVENT(EIID, AIID, PIID, EHTID, SIID, NAME, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.EVENT_INSTANCE_B_T.EIID, 
   cmndb_owner.EVENT_INSTANCE_B_T.AIID, 
   cmndb_owner.EVENT_INSTANCE_B_T.PIID, 
   cmndb_owner.EVENT_INSTANCE_B_T.EHTID, 
   cmndb_owner.EVENT_INSTANCE_B_T.SIID, 
   cmndb_owner.SERVICE_TEMPLATE_B_T.NAME, 
   cmndb_owner.EVENT_INSTANCE_B_T.WSID_1, 
   cmndb_owner.EVENT_INSTANCE_B_T.WSID_2
 FROM cmndb_owner.EVENT_INSTANCE_B_T, cmndb_owner.SERVICE_TEMPLATE_B_T
 WHERE cmndb_owner.EVENT_INSTANCE_B_T.STATE = 2 AND cmndb_owner.EVENT_INSTANCE_B_T.VTID = cmndb_owner.SERVICE_TEMPLATE_B_T.VTID;

-- View: WorkItem
CREATE VIEW cmndb_owner.WORK_ITEM(WIID, OWNER_ID, GROUP_NAME, EVERYBODY, OBJECT_TYPE, OBJECT_ID, ASSOC_OBJECT_TYPE, ASSOC_OID, REASON, CREATION_TIME, QIID, KIND ) AS
 SELECT 
   cmndb_owner.WORK_ITEM_T.WIID, 
   cmndb_owner.WORK_ITEM_T.OWNER_ID, 
   cmndb_owner.WORK_ITEM_T.GROUP_NAME, 
   cmndb_owner.WORK_ITEM_T.EVERYBODY, 
   cmndb_owner.WORK_ITEM_T.OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.OBJECT_ID, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OID, 
   cmndb_owner.WORK_ITEM_T.REASON, 
   cmndb_owner.WORK_ITEM_T.CREATION_TIME, 
   cmndb_owner.WORK_ITEM_T.QIID, 
   cmndb_owner.WORK_ITEM_T.KIND
 FROM cmndb_owner.WORK_ITEM_T
 WHERE cmndb_owner.WORK_ITEM_T.AUTH_INFO = 1
 UNION ALL SELECT 
   cmndb_owner.WORK_ITEM_T.WIID, 
   cmndb_owner.WORK_ITEM_T.OWNER_ID, 
   cmndb_owner.WORK_ITEM_T.GROUP_NAME, 
   cmndb_owner.WORK_ITEM_T.EVERYBODY, 
   cmndb_owner.WORK_ITEM_T.OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.OBJECT_ID, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OID, 
   cmndb_owner.WORK_ITEM_T.REASON, 
   cmndb_owner.WORK_ITEM_T.CREATION_TIME, 
   cmndb_owner.WORK_ITEM_T.QIID, 
   cmndb_owner.WORK_ITEM_T.KIND
 FROM cmndb_owner.WORK_ITEM_T
 WHERE cmndb_owner.WORK_ITEM_T.AUTH_INFO = 2
 UNION ALL SELECT 
   cmndb_owner.WORK_ITEM_T.WIID, 
   cmndb_owner.WORK_ITEM_T.OWNER_ID, 
   cmndb_owner.WORK_ITEM_T.GROUP_NAME, 
   cmndb_owner.WORK_ITEM_T.EVERYBODY, 
   cmndb_owner.WORK_ITEM_T.OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.OBJECT_ID, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OID, 
   cmndb_owner.WORK_ITEM_T.REASON, 
   cmndb_owner.WORK_ITEM_T.CREATION_TIME, 
   cmndb_owner.WORK_ITEM_T.QIID, 
   cmndb_owner.WORK_ITEM_T.KIND
 FROM cmndb_owner.WORK_ITEM_T
 WHERE cmndb_owner.WORK_ITEM_T.AUTH_INFO = 3
 UNION ALL SELECT 
   cmndb_owner.WORK_ITEM_T.WIID, 
   cmndb_owner.RETRIEVED_USER_T.OWNER_ID, 
   cmndb_owner.WORK_ITEM_T.GROUP_NAME, 
   cmndb_owner.WORK_ITEM_T.EVERYBODY, 
   cmndb_owner.WORK_ITEM_T.OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.OBJECT_ID, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OID, 
   cmndb_owner.WORK_ITEM_T.REASON, 
   cmndb_owner.WORK_ITEM_T.CREATION_TIME, 
   cmndb_owner.WORK_ITEM_T.QIID, 
   cmndb_owner.WORK_ITEM_T.KIND
 FROM cmndb_owner.WORK_ITEM_T, cmndb_owner.RETRIEVED_USER_T
 WHERE cmndb_owner.WORK_ITEM_T.AUTH_INFO = 0 AND cmndb_owner.WORK_ITEM_T.QIID = cmndb_owner.RETRIEVED_USER_T.QIID
 UNION ALL SELECT 
   cmndb_owner.WORK_ITEM_T.WIID, 
   cmndb_owner.WORK_ITEM_T.OWNER_ID, 
   cmndb_owner.RETRIEVED_GROUP_T.GROUP_NAME, 
   cmndb_owner.WORK_ITEM_T.EVERYBODY, 
   cmndb_owner.WORK_ITEM_T.OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.OBJECT_ID, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OID, 
   cmndb_owner.WORK_ITEM_T.REASON, 
   cmndb_owner.WORK_ITEM_T.CREATION_TIME, 
   cmndb_owner.WORK_ITEM_T.QIID, 
   cmndb_owner.WORK_ITEM_T.KIND
 FROM cmndb_owner.WORK_ITEM_T, cmndb_owner.RETRIEVED_GROUP_T
 WHERE cmndb_owner.WORK_ITEM_T.AUTH_INFO = 4 AND cmndb_owner.WORK_ITEM_T.QIID = cmndb_owner.RETRIEVED_GROUP_T.QIID
 UNION ALL SELECT 
   cmndb_owner.WORK_ITEM_T.WIID, 
   cmndb_owner.RETRIEVED_USER_T.OWNER_ID, 
   cmndb_owner.WORK_ITEM_T.GROUP_NAME, 
   cmndb_owner.WORK_ITEM_T.EVERYBODY, 
   cmndb_owner.WORK_ITEM_T.OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.OBJECT_ID, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OID, 
   cmndb_owner.WORK_ITEM_T.REASON, 
   cmndb_owner.WORK_ITEM_T.CREATION_TIME, 
   cmndb_owner.WORK_ITEM_T.QIID, 
   cmndb_owner.WORK_ITEM_T.KIND
 FROM cmndb_owner.WORK_ITEM_T, cmndb_owner.RETRIEVED_USER_T
 WHERE cmndb_owner.WORK_ITEM_T.AUTH_INFO = 6 AND cmndb_owner.WORK_ITEM_T.QIID = cmndb_owner.RETRIEVED_USER_T.QIID
 UNION ALL SELECT 
   cmndb_owner.WORK_ITEM_T.WIID, 
   cmndb_owner.WORK_ITEM_T.OWNER_ID, 
   cmndb_owner.RETRIEVED_GROUP_T.GROUP_NAME, 
   cmndb_owner.WORK_ITEM_T.EVERYBODY, 
   cmndb_owner.WORK_ITEM_T.OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.OBJECT_ID, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, 
   cmndb_owner.WORK_ITEM_T.ASSOCIATED_OID, 
   cmndb_owner.WORK_ITEM_T.REASON, 
   cmndb_owner.WORK_ITEM_T.CREATION_TIME, 
   cmndb_owner.WORK_ITEM_T.QIID, 
   cmndb_owner.WORK_ITEM_T.KIND
 FROM cmndb_owner.WORK_ITEM_T, cmndb_owner.RETRIEVED_GROUP_T
 WHERE cmndb_owner.WORK_ITEM_T.AUTH_INFO = 6 AND cmndb_owner.WORK_ITEM_T.QIID = cmndb_owner.RETRIEVED_GROUP_T.QIID;

-- View: SharedWorkItem
CREATE VIEW cmndb_owner.SHARED_WORK_ITEM(WSID, OWNER_ID, GROUP_NAME, EVERYBODY, REASON ) AS
 SELECT 
   cmndb_owner.SWI_T.WSID, 
   cmndb_owner.SWI_T.OWNER_ID, 
   cmndb_owner.SWI_T.GROUP_NAME, 
   cmndb_owner.SWI_T.EVERYBODY, 
   cmndb_owner.SWI_T.REASON
 FROM cmndb_owner.SWI_T
 WHERE cmndb_owner.SWI_T.AUTH_INFO IN ( 1, 2, 3 )
 UNION ALL SELECT 
   cmndb_owner.SWI_T.WSID, 
   cmndb_owner.RETRIEVED_USER_T.OWNER_ID, 
   cmndb_owner.SWI_T.GROUP_NAME, 
   cmndb_owner.SWI_T.EVERYBODY, 
   cmndb_owner.SWI_T.REASON
 FROM cmndb_owner.SWI_T, cmndb_owner.RETRIEVED_USER_T
 WHERE cmndb_owner.SWI_T.QIID = cmndb_owner.RETRIEVED_USER_T.QIID AND cmndb_owner.SWI_T.AUTH_INFO IN (0, 4)
 UNION ALL SELECT 
   cmndb_owner.SWI_T.WSID, 
   cmndb_owner.SWI_T.OWNER_ID, 
   cmndb_owner.RETRIEVED_GROUP_T.GROUP_NAME, 
   cmndb_owner.SWI_T.EVERYBODY, 
   cmndb_owner.SWI_T.REASON
 FROM cmndb_owner.SWI_T, cmndb_owner.RETRIEVED_GROUP_T
 WHERE cmndb_owner.SWI_T.QIID = cmndb_owner.RETRIEVED_GROUP_T.QIID AND cmndb_owner.SWI_T.AUTH_INFO IN (4, 6);

-- View: ActivityService
CREATE VIEW cmndb_owner.ACTIVITY_SERVICE(EIID, AIID, PIID, VTID, PORT_TYPE, NAME_SPACE_URI, OPERATION, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.EVENT_INSTANCE_B_T.EIID, 
   cmndb_owner.EVENT_INSTANCE_B_T.AIID, 
   cmndb_owner.EVENT_INSTANCE_B_T.PIID, 
   cmndb_owner.EVENT_INSTANCE_B_T.VTID, 
   cmndb_owner.SERVICE_TEMPLATE_B_T.PORT_TYPE_NAME, 
   cmndb_owner.URI_TEMPLATE_B_T.URI, 
   cmndb_owner.SERVICE_TEMPLATE_B_T.OPERATION_NAME, 
   cmndb_owner.EVENT_INSTANCE_B_T.WSID_1, 
   cmndb_owner.EVENT_INSTANCE_B_T.WSID_2
 FROM cmndb_owner.EVENT_INSTANCE_B_T, cmndb_owner.SERVICE_TEMPLATE_B_T, cmndb_owner.URI_TEMPLATE_B_T
 WHERE cmndb_owner.EVENT_INSTANCE_B_T.STATE = 2 AND cmndb_owner.EVENT_INSTANCE_B_T.VTID = cmndb_owner.SERVICE_TEMPLATE_B_T.VTID AND cmndb_owner.SERVICE_TEMPLATE_B_T.PORT_TYPE_UTID = cmndb_owner.URI_TEMPLATE_B_T.UTID;

-- View: QueryProperty
CREATE VIEW cmndb_owner.QUERY_PROPERTY(PIID, VARIABLE_NAME, NAME, NAMESPACE, GENERIC_VALUE, STRING_VALUE, NUMBER_VALUE, DECIMAL_VALUE, TIMESTAMP_VALUE, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.PIID, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.VARIABLE_NAME, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.PROPERTY_NAME, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.PROPERTY_NAMESPACE, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.GENERIC_VALUE, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.STRING_VALUE, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.NUMBER_VALUE, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.DECIMAL_VALUE, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.TIMESTAMP_VALUE, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.WSID_1, 
   cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T.WSID_2
 FROM cmndb_owner.QUERYABLE_VARIABLE_INSTANCE_T;

-- View: QueryPropTempl
CREATE VIEW cmndb_owner.QUERY_PROP_TEMPL(PTID, NAME, PROPERTY_NAME, URI, QUERY_TYPE, JAVA_TYPE ) AS
 SELECT 
   cmndb_owner.QUERYABLE_VARIABLE_TEMPLATE_T.PTID, 
   cmndb_owner.VARIABLE_TEMPLATE_B_T.NAME, 
   cmndb_owner.PROPERTY_ALIAS_TEMPLATE_B_T.PROPERTY_NAME, 
   cmndb_owner.URI_TEMPLATE_B_T.URI, 
   cmndb_owner.QUERYABLE_VARIABLE_TEMPLATE_T.QUERY_TYPE, 
   cmndb_owner.PROPERTY_ALIAS_TEMPLATE_B_T.JAVA_TYPE
 FROM cmndb_owner.QUERYABLE_VARIABLE_TEMPLATE_T, cmndb_owner.VARIABLE_TEMPLATE_B_T, cmndb_owner.PROPERTY_ALIAS_TEMPLATE_B_T, cmndb_owner.URI_TEMPLATE_B_T
 WHERE cmndb_owner.QUERYABLE_VARIABLE_TEMPLATE_T.CTID = cmndb_owner.VARIABLE_TEMPLATE_B_T.CTID AND cmndb_owner.QUERYABLE_VARIABLE_TEMPLATE_T.PAID = cmndb_owner.PROPERTY_ALIAS_TEMPLATE_B_T.PAID AND cmndb_owner.PROPERTY_ALIAS_TEMPLATE_B_T.PROPERTY_UTID = cmndb_owner.URI_TEMPLATE_B_T.UTID;

-- View: MigrationFront
CREATE VIEW cmndb_owner.MIGRATION_FRONT(PIID, AIID, SOURCE_PTID, TARGET_PTID, STATE, SUB_STATE, STOP_REASON, SOURCE_ATID, TARGET_ATID, MIGRATION_TIME, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.MIGRATION_FRONT_T.PIID, 
   cmndb_owner.MIGRATION_FRONT_T.AIID, 
   cmndb_owner.MIGRATION_PLAN_TEMPLATE_T.SOURCE_PTID, 
   cmndb_owner.MIGRATION_PLAN_TEMPLATE_T.TARGET_PTID, 
   cmndb_owner.MIGRATION_FRONT_T.STATE, 
   cmndb_owner.MIGRATION_FRONT_T.SUB_STATE, 
   cmndb_owner.MIGRATION_FRONT_T.STOP_REASON, 
   cmndb_owner.MIGRATION_FRONT_T.SOURCE_ATID, 
   cmndb_owner.MIGRATION_FRONT_T.TARGET_ATID, 
   cmndb_owner.MIGRATION_FRONT_T.MIGRATION_TIME, 
   cmndb_owner.MIGRATION_FRONT_T.WSID_1, 
   cmndb_owner.MIGRATION_FRONT_T.WSID_2
 FROM cmndb_owner.MIGRATION_FRONT_T, cmndb_owner.MIGRATION_PLAN_TEMPLATE_T
 WHERE cmndb_owner.MIGRATION_FRONT_T.MPTID = cmndb_owner.MIGRATION_PLAN_TEMPLATE_T.MPTID;

-- View: AuditLog
CREATE VIEW cmndb_owner.AUDIT_LOG(ALID, EVENT_TIME, EVENT_TIME_UTC, AUDIT_EVENT, PTID, PIID, AIID, SIID, SCOPE_NAME, PROCESS_TEMPL_NAME, PROCESS_INST_NAME, TOP_LEVEL_PI_NAME, TOP_LEVEL_PIID, PARENT_PI_NAME, PARENT_PIID, VALID_FROM, VALID_FROM_UTC, ACTIVITY_NAME, ACTIVITY_KIND, ACTIVITY_STATE, CONTROL_LINK_NAME, IMPL_NAME, PRINCIPAL, TERMINAL_NAME, VARIABLE_DATA, EXCEPTION_TEXT, DESCRIPTION, CORR_SET_INFO, USER_NAME, ATID, ADDITIONAL_INFO, OBJECT_META_TYPE ) AS
 SELECT 
   cmndb_owner.AUDIT_LOG_T.ALID, 
   cmndb_owner.AUDIT_LOG_T.EVENT_TIME, 
   cmndb_owner.AUDIT_LOG_T.EVENT_TIME_UTC, 
   cmndb_owner.AUDIT_LOG_T.AUDIT_EVENT, 
   cmndb_owner.AUDIT_LOG_T.PTID, 
   cmndb_owner.AUDIT_LOG_T.PIID, 
   cmndb_owner.AUDIT_LOG_T.AIID, 
   cmndb_owner.AUDIT_LOG_T.SIID, 
   cmndb_owner.AUDIT_LOG_T.VARIABLE_NAME, 
   cmndb_owner.AUDIT_LOG_T.PROCESS_TEMPL_NAME, 
   cmndb_owner.AUDIT_LOG_T.PROCESS_INST_NAME, 
   cmndb_owner.AUDIT_LOG_T.TOP_LEVEL_PI_NAME, 
   cmndb_owner.AUDIT_LOG_T.TOP_LEVEL_PIID, 
   cmndb_owner.AUDIT_LOG_T.PARENT_PI_NAME, 
   cmndb_owner.AUDIT_LOG_T.PARENT_PIID, 
   cmndb_owner.AUDIT_LOG_T.VALID_FROM, 
   cmndb_owner.AUDIT_LOG_T.VALID_FROM_UTC, 
   cmndb_owner.AUDIT_LOG_T.ACTIVITY_NAME, 
   cmndb_owner.AUDIT_LOG_T.ACTIVITY_KIND, 
   cmndb_owner.AUDIT_LOG_T.ACTIVITY_STATE, 
   cmndb_owner.AUDIT_LOG_T.CONTROL_LINK_NAME, 
   cmndb_owner.AUDIT_LOG_T.IMPL_NAME, 
   cmndb_owner.AUDIT_LOG_T.PRINCIPAL, 
   cmndb_owner.AUDIT_LOG_T.IMPL_NAME, 
   cmndb_owner.AUDIT_LOG_T.VARIABLE_DATA, 
   cmndb_owner.AUDIT_LOG_T.EXCEPTION_TEXT, 
   cmndb_owner.AUDIT_LOG_T.DESCRIPTION, 
   cmndb_owner.AUDIT_LOG_T.CORR_SET_INFO, 
   cmndb_owner.AUDIT_LOG_T.USER_NAME, 
   cmndb_owner.AUDIT_LOG_T.ATID, 
   cmndb_owner.AUDIT_LOG_T.ADDITIONAL_INFO, 
   cmndb_owner.AUDIT_LOG_T.OBJECT_META_TYPE
 FROM cmndb_owner.AUDIT_LOG_T;

-- View: AuditLogB
CREATE VIEW cmndb_owner.AUDIT_LOG_B(ALID, EVENT_TIME, EVENT_TIME_UTC, AUDIT_EVENT, PTID, PIID, AIID, SIID, VARIABLE_NAME, PROCESS_TEMPL_NAME, TOP_LEVEL_PIID, PARENT_PIID, VALID_FROM, VALID_FROM_UTC, ATID, ACTIVITY_NAME, ACTIVITY_KIND, ACTIVITY_STATE, CONTROL_LINK_NAME, PRINCIPAL, VARIABLE_DATA, EXCEPTION_TEXT, DESCRIPTION, CORR_SET_INFO, USER_NAME, ADDITIONAL_INFO, SNAPSHOT_ID, SNAPSHOT_NAME, PROCESS_APP_ACRONYM ) AS
 SELECT 
   cmndb_owner.AUDIT_LOG_T.ALID, 
   cmndb_owner.AUDIT_LOG_T.EVENT_TIME, 
   cmndb_owner.AUDIT_LOG_T.EVENT_TIME_UTC, 
   cmndb_owner.AUDIT_LOG_T.AUDIT_EVENT, 
   cmndb_owner.AUDIT_LOG_T.PTID, 
   cmndb_owner.AUDIT_LOG_T.PIID, 
   cmndb_owner.AUDIT_LOG_T.AIID, 
   cmndb_owner.AUDIT_LOG_T.SIID, 
   cmndb_owner.AUDIT_LOG_T.VARIABLE_NAME, 
   cmndb_owner.AUDIT_LOG_T.PROCESS_TEMPL_NAME, 
   cmndb_owner.AUDIT_LOG_T.TOP_LEVEL_PIID, 
   cmndb_owner.AUDIT_LOG_T.PARENT_PIID, 
   cmndb_owner.AUDIT_LOG_T.VALID_FROM, 
   cmndb_owner.AUDIT_LOG_T.VALID_FROM_UTC, 
   cmndb_owner.AUDIT_LOG_T.ATID, 
   cmndb_owner.AUDIT_LOG_T.ACTIVITY_NAME, 
   cmndb_owner.AUDIT_LOG_T.ACTIVITY_KIND, 
   cmndb_owner.AUDIT_LOG_T.ACTIVITY_STATE, 
   cmndb_owner.AUDIT_LOG_T.CONTROL_LINK_NAME, 
   cmndb_owner.AUDIT_LOG_T.PRINCIPAL, 
   cmndb_owner.AUDIT_LOG_T.VARIABLE_DATA, 
   cmndb_owner.AUDIT_LOG_T.EXCEPTION_TEXT, 
   cmndb_owner.AUDIT_LOG_T.DESCRIPTION, 
   cmndb_owner.AUDIT_LOG_T.CORR_SET_INFO, 
   cmndb_owner.AUDIT_LOG_T.USER_NAME, 
   cmndb_owner.AUDIT_LOG_T.ADDITIONAL_INFO, 
   cmndb_owner.AUDIT_LOG_T.SNAPSHOT_ID, 
   cmndb_owner.AUDIT_LOG_T.TERMINAL_NAME, 
   cmndb_owner.AUDIT_LOG_T.PROCESS_APP_ACRONYM
 FROM cmndb_owner.AUDIT_LOG_T
 WHERE cmndb_owner.AUDIT_LOG_T.OBJECT_META_TYPE = 1;

-- View: ApplicationComp
CREATE VIEW cmndb_owner.APPLICATION_COMP(ACOID, BUSINESS_RELEVANCE, NAME, SUPPORT_AUTOCLAIM, SUPPORT_CLAIM_SUSP, SUPPORT_DELEGATION, SUPPORT_SUB_TASK, SUPPORT_FOLLOW_ON ) AS
 SELECT 
   cmndb_owner.APPLICATION_COMPONENT_T.ACOID, 
   cmndb_owner.APPLICATION_COMPONENT_T.BUSINESS_RELEVANCE, 
   cmndb_owner.APPLICATION_COMPONENT_T.NAME, 
   cmndb_owner.APPLICATION_COMPONENT_T.SUPPORTS_AUTO_CLAIM, 
   cmndb_owner.APPLICATION_COMPONENT_T.SUPPORTS_CLAIM_SUSPENDED, 
   cmndb_owner.APPLICATION_COMPONENT_T.SUPPORTS_DELEGATION, 
   cmndb_owner.APPLICATION_COMPONENT_T.SUPPORTS_SUB_TASK, 
   cmndb_owner.APPLICATION_COMPONENT_T.SUPPORTS_FOLLOW_ON_TASK
 FROM cmndb_owner.APPLICATION_COMPONENT_T;

-- View: Task
CREATE VIEW cmndb_owner.TASK(TKIID, ACTIVATED, APPLIC_DEFAULTS_ID, APPLIC_NAME, BUSINESS_RELEVANCE, COMPLETED, CONTAINMENT_CTX_ID, CTX_AUTHORIZATION, DUE, EXPIRES, FIRST_ACTIVATED, FOLLOW_ON_TKIID, IS_AD_HOC, IS_ESCALATED, IS_INLINE, IS_WAIT_FOR_SUB_TK, KIND, LAST_MODIFIED, LAST_STATE_CHANGE, NAME, NAME_SPACE, ORIGINATOR, OWNER, PARENT_CONTEXT_ID, PRIORITY, STARTED, STARTER, STATE, SUPPORT_AUTOCLAIM, SUPPORT_CLAIM_SUSP, SUPPORT_DELEGATION, SUPPORT_SUB_TASK, SUPPORT_FOLLOW_ON, HIERARCHY_POSITION, IS_CHILD, SUSPENDED, TKTID, TOP_TKIID, TYPE, RESUMES, ASSIGNMENT_TYPE, INHERITED_AUTH, INVOKED_INSTANCE_ID, INVOKED_INSTANCE_TYPE, WORK_BASKET, IS_READ, IS_TRANSFERRED_TO_WORK_BASKET, WSID_1, WSID_2, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8 ) AS
 SELECT 
   cmndb_owner.TASK_INSTANCE_T.TKIID, 
   cmndb_owner.TASK_INSTANCE_T.ACTIVATION_TIME, 
   cmndb_owner.TASK_INSTANCE_T.APPLICATION_DEFAULTS_ID, 
   cmndb_owner.TASK_INSTANCE_T.APPLICATION_NAME, 
   cmndb_owner.TASK_INSTANCE_T.BUSINESS_RELEVANCE, 
   cmndb_owner.TASK_INSTANCE_T.COMPLETION_TIME, 
   cmndb_owner.TASK_INSTANCE_T.CONTAINMENT_CONTEXT_ID, 
   cmndb_owner.TASK_INSTANCE_T.CONTEXT_AUTHORIZATION, 
   cmndb_owner.TASK_INSTANCE_T.DUE_TIME, 
   cmndb_owner.TASK_INSTANCE_T.EXPIRATION_TIME, 
   cmndb_owner.TASK_INSTANCE_T.FIRST_ACTIVATION_TIME, 
   cmndb_owner.TASK_INSTANCE_T.FOLLOW_ON_TKIID, 
   cmndb_owner.TASK_INSTANCE_T.IS_AD_HOC, 
   cmndb_owner.TASK_INSTANCE_T.IS_ESCALATED, 
   cmndb_owner.TASK_INSTANCE_T.IS_INLINE, 
   cmndb_owner.TASK_INSTANCE_T.IS_WAITING_FOR_SUBTASK, 
   cmndb_owner.TASK_INSTANCE_T.KIND, 
   cmndb_owner.TASK_INSTANCE_T.LAST_MODIFICATION_TIME, 
   cmndb_owner.TASK_INSTANCE_T.LAST_STATE_CHANGE_TIME, 
   cmndb_owner.TASK_INSTANCE_T.NAME, 
   cmndb_owner.TASK_INSTANCE_T.NAMESPACE, 
   cmndb_owner.TASK_INSTANCE_T.ORIGINATOR, 
   cmndb_owner.TASK_INSTANCE_T.OWNER, 
   cmndb_owner.TASK_INSTANCE_T.PARENT_CONTEXT_ID, 
   cmndb_owner.TASK_INSTANCE_T.PRIORITY, 
   cmndb_owner.TASK_INSTANCE_T.START_TIME, 
   cmndb_owner.TASK_INSTANCE_T.STARTER, 
   cmndb_owner.TASK_INSTANCE_T.STATE, 
   cmndb_owner.TASK_INSTANCE_T.SUPPORTS_AUTO_CLAIM, 
   cmndb_owner.TASK_INSTANCE_T.SUPPORTS_CLAIM_SUSPENDED, 
   cmndb_owner.TASK_INSTANCE_T.SUPPORTS_DELEGATION, 
   cmndb_owner.TASK_INSTANCE_T.SUPPORTS_SUB_TASK, 
   cmndb_owner.TASK_INSTANCE_T.SUPPORTS_FOLLOW_ON_TASK, 
   cmndb_owner.TASK_INSTANCE_T.HIERARCHY_POSITION, 
   cmndb_owner.TASK_INSTANCE_T.IS_CHILD, 
   cmndb_owner.TASK_INSTANCE_T.IS_SUSPENDED, 
   cmndb_owner.TASK_INSTANCE_T.TKTID, 
   cmndb_owner.TASK_INSTANCE_T.TOP_TKIID, 
   cmndb_owner.TASK_INSTANCE_T.TYPE, 
   cmndb_owner.TASK_INSTANCE_T.RESUMES, 
   cmndb_owner.TASK_INSTANCE_T.ASSIGNMENT_TYPE, 
   cmndb_owner.TASK_INSTANCE_T.INHERITED_AUTH, 
   cmndb_owner.TASK_INSTANCE_T.INVOKED_INSTANCE_ID, 
   cmndb_owner.TASK_INSTANCE_T.INVOKED_INSTANCE_TYPE, 
   cmndb_owner.TASK_INSTANCE_T.WORK_BASKET, 
   cmndb_owner.TASK_INSTANCE_T.IS_READ, 
   cmndb_owner.TASK_INSTANCE_T.IS_TRANSFERRED_TO_WORK_BASKET, 
   cmndb_owner.TASK_INSTANCE_T.WSID_1, 
   cmndb_owner.TASK_INSTANCE_T.WSID_2, 
   cmndb_owner.TASK_INSTANCE_T.CUSTOM_TEXT1, 
   cmndb_owner.TASK_INSTANCE_T.CUSTOM_TEXT2, 
   cmndb_owner.TASK_INSTANCE_T.CUSTOM_TEXT3, 
   cmndb_owner.TASK_INSTANCE_T.CUSTOM_TEXT4, 
   cmndb_owner.TASK_INSTANCE_T.CUSTOM_TEXT5, 
   cmndb_owner.TASK_INSTANCE_T.CUSTOM_TEXT6, 
   cmndb_owner.TASK_INSTANCE_T.CUSTOM_TEXT7, 
   cmndb_owner.TASK_INSTANCE_T.CUSTOM_TEXT8
 FROM cmndb_owner.TASK_INSTANCE_T;

-- View: TaskTempl
CREATE VIEW cmndb_owner.TASK_TEMPL(TKTID, APPLIC_DEFAULTS_ID, APPLIC_NAME, BUSINESS_RELEVANCE, CONTAINMENT_CTX_ID, CTX_AUTHORIZATION, DEFINITION_NAME, DEFINITION_NS, IS_AD_HOC, IS_INLINE, KIND, NAME, NAMESPACE, PRIORITY, STATE, SUPPORT_AUTOCLAIM, SUPPORT_CLAIM_SUSP, SUPPORT_DELEGATION, SUPPORT_SUB_TASK, SUPPORT_FOLLOW_ON, TYPE, VALID_FROM, AUTONOMY, ASSIGNMENT_TYPE, INHERITED_AUTH, WORK_BASKET, SNAPSHOT_ID, SNAPSHOT_NAME, TOP_LEVEL_TOOLKIT_ACRONYM, TOP_LEVEL_TOOLKIT_NAME, TRACK_NAME, PROCESS_APP_NAME, PROCESS_APP_ACRONYM, TOOLKIT_SNAPSHOT_ID, TOOLKIT_SNAPSHOT_NAME, TOOLKIT_NAME, TOOLKIT_ACRONYM, IS_TIP, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8 ) AS
 SELECT 
   cmndb_owner.TASK_TEMPLATE_T.TKTID, 
   cmndb_owner.TASK_TEMPLATE_T.APPLICATION_DEFAULTS_ID, 
   cmndb_owner.TASK_TEMPLATE_T.APPLICATION_NAME, 
   cmndb_owner.TASK_TEMPLATE_T.BUSINESS_RELEVANCE, 
   cmndb_owner.TASK_TEMPLATE_T.CONTAINMENT_CONTEXT_ID, 
   cmndb_owner.TASK_TEMPLATE_T.CONTEXT_AUTHORIZATION, 
   cmndb_owner.TASK_TEMPLATE_T.DEFINITION_NAME, 
   cmndb_owner.TASK_TEMPLATE_T.TARGET_NAMESPACE, 
   cmndb_owner.TASK_TEMPLATE_T.IS_AD_HOC, 
   cmndb_owner.TASK_TEMPLATE_T.IS_INLINE, 
   cmndb_owner.TASK_TEMPLATE_T.KIND, 
   cmndb_owner.TASK_TEMPLATE_T.NAME, 
   cmndb_owner.TASK_TEMPLATE_T.NAMESPACE, 
   cmndb_owner.TASK_TEMPLATE_T.PRIORITY, 
   cmndb_owner.TASK_TEMPLATE_T.STATE, 
   cmndb_owner.TASK_TEMPLATE_T.SUPPORTS_AUTO_CLAIM, 
   cmndb_owner.TASK_TEMPLATE_T.SUPPORTS_CLAIM_SUSPENDED, 
   cmndb_owner.TASK_TEMPLATE_T.SUPPORTS_DELEGATION, 
   cmndb_owner.TASK_TEMPLATE_T.SUPPORTS_SUB_TASK, 
   cmndb_owner.TASK_TEMPLATE_T.SUPPORTS_FOLLOW_ON_TASK, 
   cmndb_owner.TASK_TEMPLATE_T.TYPE, 
   cmndb_owner.TASK_TEMPLATE_T.VALID_FROM, 
   cmndb_owner.TASK_TEMPLATE_T.AUTONOMY, 
   cmndb_owner.TASK_TEMPLATE_T.ASSIGNMENT_TYPE, 
   cmndb_owner.TASK_TEMPLATE_T.INHERITED_AUTH, 
   cmndb_owner.TASK_TEMPLATE_T.WORK_BASKET, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.SNAPSHOT_ID, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.SNAPSHOT_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOP_LEVEL_TOOLKIT_ACRONYM, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOP_LEVEL_TOOLKIT_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TRACK_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.PROCESS_APP_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.PROCESS_APP_ACRONYM, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOOLKIT_SNAPSHOT_ID, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOOLKIT_SNAPSHOT_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOOLKIT_NAME, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.TOOLKIT_ACRONYM, 
   cmndb_owner.PC_VERSION_TEMPLATE_T.IS_TIP, 
   cmndb_owner.TASK_TEMPLATE_T.CUSTOM_TEXT1, 
   cmndb_owner.TASK_TEMPLATE_T.CUSTOM_TEXT2, 
   cmndb_owner.TASK_TEMPLATE_T.CUSTOM_TEXT3, 
   cmndb_owner.TASK_TEMPLATE_T.CUSTOM_TEXT4, 
   cmndb_owner.TASK_TEMPLATE_T.CUSTOM_TEXT5, 
   cmndb_owner.TASK_TEMPLATE_T.CUSTOM_TEXT6, 
   cmndb_owner.TASK_TEMPLATE_T.CUSTOM_TEXT7, 
   cmndb_owner.TASK_TEMPLATE_T.CUSTOM_TEXT8
 FROM cmndb_owner.TASK_TEMPLATE_T LEFT JOIN cmndb_owner.PC_VERSION_TEMPLATE_T ON (cmndb_owner.PC_VERSION_TEMPLATE_T.CONTAINMENT_CONTEXT_ID = cmndb_owner.TASK_TEMPLATE_T.TKTID);

-- View: Escalation
CREATE VIEW cmndb_owner.ESCALATION(ESIID, ACTION, ACTIVATION_STATE, ACTIVATION_TIME, ESCALATION_TIME, AT_LEAST_EXP_STATE, ESTID, FIRST_ESIID, INCREASE_PRIORITY, NAME, STATE, TKIID, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.ESCALATION_INSTANCE_T.ESIID, 
   cmndb_owner.ESCALATION_INSTANCE_T.ACTION, 
   cmndb_owner.ESCALATION_INSTANCE_T.ACTIVATION_STATE, 
   cmndb_owner.ESCALATION_INSTANCE_T.ACTIVATION_TIME, 
   cmndb_owner.ESCALATION_INSTANCE_T.ESCALATION_TIME, 
   cmndb_owner.ESCALATION_INSTANCE_T.AT_LEAST_EXPECTED_STATE, 
   cmndb_owner.ESCALATION_INSTANCE_T.ESTID, 
   cmndb_owner.ESCALATION_INSTANCE_T.FIRST_ESIID, 
   cmndb_owner.ESCALATION_INSTANCE_T.INCREASE_PRIORITY, 
   cmndb_owner.ESCALATION_INSTANCE_T.NAME, 
   cmndb_owner.ESCALATION_INSTANCE_T.STATE, 
   cmndb_owner.ESCALATION_INSTANCE_T.TKIID, 
   cmndb_owner.ESCALATION_INSTANCE_T.WSID_1, 
   cmndb_owner.ESCALATION_INSTANCE_T.WSID_2
 FROM cmndb_owner.ESCALATION_INSTANCE_T;

-- View: EscTempl
CREATE VIEW cmndb_owner.ESC_TEMPL(ESTID, FIRST_ESTID, PREVIOUS_ESTID, TKTID, CONTAINMENT_CTX_ID, NAME, ACTIVATION_STATE, AT_LEAST_EXP_STATE, INCREASE_PRIORITY, ACTION ) AS
 SELECT 
   cmndb_owner.ESCALATION_TEMPLATE_T.ESTID, 
   cmndb_owner.ESCALATION_TEMPLATE_T.FIRST_ESTID, 
   cmndb_owner.ESCALATION_TEMPLATE_T.PREVIOUS_ESTID, 
   cmndb_owner.ESCALATION_TEMPLATE_T.TKTID, 
   cmndb_owner.ESCALATION_TEMPLATE_T.CONTAINMENT_CONTEXT_ID, 
   cmndb_owner.ESCALATION_TEMPLATE_T.NAME, 
   cmndb_owner.ESCALATION_TEMPLATE_T.ACTIVATION_STATE, 
   cmndb_owner.ESCALATION_TEMPLATE_T.AT_LEAST_EXPECTED_STATE, 
   cmndb_owner.ESCALATION_TEMPLATE_T.INCREASE_PRIORITY, 
   cmndb_owner.ESCALATION_TEMPLATE_T.ACTION
 FROM cmndb_owner.ESCALATION_TEMPLATE_T;

-- View: EscTemplDesc
CREATE VIEW cmndb_owner.ESC_TEMPL_DESC(ESTID, LOCALE, TKTID, DISPLAY_NAME, DESCRIPTION ) AS
 SELECT 
   cmndb_owner.ESC_TEMPL_LDESC_T.ESTID, 
   cmndb_owner.ESC_TEMPL_LDESC_T.LOCALE, 
   cmndb_owner.ESC_TEMPL_LDESC_T.TKTID, 
   cmndb_owner.ESC_TEMPL_LDESC_T.DISPLAY_NAME, 
   cmndb_owner.ESC_TEMPL_LDESC_T.DESCRIPTION
 FROM cmndb_owner.ESC_TEMPL_LDESC_T;

-- View: TaskTemplCProp
CREATE VIEW cmndb_owner.TASK_TEMPL_CPROP(TKTID, NAME, DATA_TYPE, STRING_VALUE ) AS
 SELECT 
   cmndb_owner.TASK_TEMPL_CPROP_T.TKTID, 
   cmndb_owner.TASK_TEMPL_CPROP_T.NAME, 
   cmndb_owner.TASK_TEMPL_CPROP_T.DATA_TYPE, 
   cmndb_owner.TASK_TEMPL_CPROP_T.STRING_VALUE
 FROM cmndb_owner.TASK_TEMPL_CPROP_T;

-- View: EscTemplCProp
CREATE VIEW cmndb_owner.ESC_TEMPL_CPROP(ESTID, NAME, TKTID, DATA_TYPE, VALUE ) AS
 SELECT 
   cmndb_owner.ESC_TEMPL_CPROP_T.ESTID, 
   cmndb_owner.ESC_TEMPL_CPROP_T.NAME, 
   cmndb_owner.ESC_TEMPL_CPROP_T.TKTID, 
   cmndb_owner.ESC_TEMPL_CPROP_T.DATA_TYPE, 
   cmndb_owner.ESC_TEMPL_CPROP_T.STRING_VALUE
 FROM cmndb_owner.ESC_TEMPL_CPROP_T;

-- View: TaskTemplDesc
CREATE VIEW cmndb_owner.TASK_TEMPL_DESC(TKTID, LOCALE, DESCRIPTION, DISPLAY_NAME ) AS
 SELECT 
   cmndb_owner.TASK_TEMPL_LDESC_T.TKTID, 
   cmndb_owner.TASK_TEMPL_LDESC_T.LOCALE, 
   cmndb_owner.TASK_TEMPL_LDESC_T.DESCRIPTION, 
   cmndb_owner.TASK_TEMPL_LDESC_T.DISPLAY_NAME
 FROM cmndb_owner.TASK_TEMPL_LDESC_T;

-- View: TaskCProp
CREATE VIEW cmndb_owner.TASK_CPROP(TKIID, NAME, DATA_TYPE, STRING_VALUE, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.TASK_INST_CPROP_T.TKIID, 
   cmndb_owner.TASK_INST_CPROP_T.NAME, 
   cmndb_owner.TASK_INST_CPROP_T.DATA_TYPE, 
   cmndb_owner.TASK_INST_CPROP_T.STRING_VALUE, 
   cmndb_owner.TASK_INST_CPROP_T.WSID_1, 
   cmndb_owner.TASK_INST_CPROP_T.WSID_2
 FROM cmndb_owner.TASK_INST_CPROP_T;

-- View: TaskDesc
CREATE VIEW cmndb_owner.TASK_DESC(TKIID, LOCALE, DESCRIPTION, DISPLAY_NAME, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.TASK_INST_LDESC_T.TKIID, 
   cmndb_owner.TASK_INST_LDESC_T.LOCALE, 
   cmndb_owner.TASK_INST_LDESC_T.DESCRIPTION, 
   cmndb_owner.TASK_INST_LDESC_T.DISPLAY_NAME, 
   cmndb_owner.TASK_INST_LDESC_T.WSID_1, 
   cmndb_owner.TASK_INST_LDESC_T.WSID_2
 FROM cmndb_owner.TASK_INST_LDESC_T;

-- View: EscalationCProp
CREATE VIEW cmndb_owner.ESCALATION_CPROP(ESIID, NAME, DATA_TYPE, STRING_VALUE, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.ESC_INST_CPROP_T.ESIID, 
   cmndb_owner.ESC_INST_CPROP_T.NAME, 
   cmndb_owner.ESC_INST_CPROP_T.DATA_TYPE, 
   cmndb_owner.ESC_INST_CPROP_T.STRING_VALUE, 
   cmndb_owner.ESC_INST_CPROP_T.WSID_1, 
   cmndb_owner.ESC_INST_CPROP_T.WSID_2
 FROM cmndb_owner.ESC_INST_CPROP_T;

-- View: TaskHistory
CREATE VIEW cmndb_owner.TASK_HISTORY(TKIID, ESIID, PARENT_TKIID, EVENT, REASON, EVENT_TIME, NEXT_TIME, PRINCIPAL, WORK_ITEM_KIND, FROM_ID, TO_ID, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.TASK_HISTORY_T.TKIID, 
   cmndb_owner.TASK_HISTORY_T.ESIID, 
   cmndb_owner.TASK_HISTORY_T.PARENT_TKIID, 
   cmndb_owner.TASK_HISTORY_T.EVENT, 
   cmndb_owner.TASK_HISTORY_T.REASON, 
   cmndb_owner.TASK_HISTORY_T.EVENT_TIME, 
   cmndb_owner.TASK_HISTORY_T.NEXT_TIME, 
   cmndb_owner.TASK_HISTORY_T.PRINCIPAL, 
   cmndb_owner.TASK_HISTORY_T.WORK_ITEM_KIND, 
   cmndb_owner.TASK_HISTORY_T.FROM_ID, 
   cmndb_owner.TASK_HISTORY_T.TO_ID, 
   cmndb_owner.TASK_HISTORY_T.WSID_1, 
   cmndb_owner.TASK_HISTORY_T.WSID_2
 FROM cmndb_owner.TASK_HISTORY_T;

-- View: EscalationDesc
CREATE VIEW cmndb_owner.ESCALATION_DESC(ESIID, LOCALE, DESCRIPTION, DISPLAY_NAME, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.ESC_INST_LDESC_T.ESIID, 
   cmndb_owner.ESC_INST_LDESC_T.LOCALE, 
   cmndb_owner.ESC_INST_LDESC_T.DESCRIPTION, 
   cmndb_owner.ESC_INST_LDESC_T.DISPLAY_NAME, 
   cmndb_owner.ESC_INST_LDESC_T.WSID_1, 
   cmndb_owner.ESC_INST_LDESC_T.WSID_2
 FROM cmndb_owner.ESC_INST_LDESC_T;

-- View: TaskAuditLog
CREATE VIEW cmndb_owner.TASK_AUDIT_LOG(ALID, AUDIT_EVENT, CONTAINMENT_CTX_ID, ESIID, ESTID, EVENT_TIME, FAULT_NAME, FAULT_TYPE_NAME, FAULT_NAME_SPACE, FOLLOW_ON_TKIID, NAME, NAMESPACE, NEW_USER, OLD_USER, PARENT_CONTEXT_ID, PARENT_TASK_NAME, PARENT_TASK_NAMESP, PARENT_TKIID, PRINCIPAL, TASK_KIND, TASK_STATE, TKIID, TKTID, TOP_TKIID, VAILD_FROM, WORK_ITEM_REASON, USERS, DESCRIPTION, MESSAGE_DATA, SNAPSHOT_ID, SNAPSHOT_NAME, PROCESS_APP_ACRONYM ) AS
 SELECT 
   cmndb_owner.TASK_AUDIT_LOG_T.ALID, 
   cmndb_owner.TASK_AUDIT_LOG_T.AUDIT_EVENT, 
   cmndb_owner.TASK_AUDIT_LOG_T.CONTAINMENT_CONTEXT_ID, 
   cmndb_owner.TASK_AUDIT_LOG_T.ESIID, 
   cmndb_owner.TASK_AUDIT_LOG_T.ESTID, 
   cmndb_owner.TASK_AUDIT_LOG_T.EVENT_TIME_UTC, 
   cmndb_owner.TASK_AUDIT_LOG_T.FAULT_NAME, 
   cmndb_owner.TASK_AUDIT_LOG_T.FAULT_TYPE_NAME, 
   cmndb_owner.TASK_AUDIT_LOG_T.FAULT_NAMESPACE, 
   cmndb_owner.TASK_AUDIT_LOG_T.FOLLOW_ON_TKIID, 
   cmndb_owner.TASK_AUDIT_LOG_T.NAME, 
   cmndb_owner.TASK_AUDIT_LOG_T.NAMESPACE, 
   cmndb_owner.TASK_AUDIT_LOG_T.NEW_USER, 
   cmndb_owner.TASK_AUDIT_LOG_T.OLD_USER, 
   cmndb_owner.TASK_AUDIT_LOG_T.PARENT_CONTEXT_ID, 
   cmndb_owner.TASK_AUDIT_LOG_T.PARENT_TASK_NAME, 
   cmndb_owner.TASK_AUDIT_LOG_T.PARENT_TASK_NAMESPACE, 
   cmndb_owner.TASK_AUDIT_LOG_T.PARENT_TKIID, 
   cmndb_owner.TASK_AUDIT_LOG_T.PRINCIPAL, 
   cmndb_owner.TASK_AUDIT_LOG_T.TASK_KIND, 
   cmndb_owner.TASK_AUDIT_LOG_T.TASK_STATE, 
   cmndb_owner.TASK_AUDIT_LOG_T.TKIID, 
   cmndb_owner.TASK_AUDIT_LOG_T.TKTID, 
   cmndb_owner.TASK_AUDIT_LOG_T.TOP_TKIID, 
   cmndb_owner.TASK_AUDIT_LOG_T.VALID_FROM_UTC, 
   cmndb_owner.TASK_AUDIT_LOG_T.WI_REASON, 
   cmndb_owner.TASK_AUDIT_LOG_T.USERS, 
   cmndb_owner.TASK_AUDIT_LOG_T.DESCRIPTION, 
   cmndb_owner.TASK_AUDIT_LOG_T.MESSAGE_DATA, 
   cmndb_owner.TASK_AUDIT_LOG_T.SNAPSHOT_ID, 
   cmndb_owner.TASK_AUDIT_LOG_T.SNAPSHOT_NAME, 
   cmndb_owner.TASK_AUDIT_LOG_T.PROCESS_APP_ACRONYM
 FROM cmndb_owner.TASK_AUDIT_LOG_T;

-- View: WorkBasket
CREATE VIEW cmndb_owner.WORK_BASKET(WBID, NAME, TYPE, OWNER, DEFAULT_QUERY_TABLE, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8, CREATED, LAST_MODIFIED, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.WORK_BASKET_T.WBID, 
   cmndb_owner.WORK_BASKET_T.NAME, 
   cmndb_owner.WORK_BASKET_T.TYPE, 
   cmndb_owner.WORK_BASKET_T.OWNER, 
   cmndb_owner.WORK_BASKET_T.DEFAULT_QUERY_TABLE, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT1, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT2, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT3, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT4, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT5, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT6, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT7, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT8, 
   cmndb_owner.WORK_BASKET_T.CREATION_TIME, 
   cmndb_owner.WORK_BASKET_T.LAST_MODIFICATION_TIME, 
   cmndb_owner.WORK_BASKET_T.WSID_1, 
   cmndb_owner.WORK_BASKET_T.WSID_2
 FROM cmndb_owner.WORK_BASKET_T;

-- View: WorkBasketLDesc
CREATE VIEW cmndb_owner.WORK_BASKET_LDESC(WBID, LOCALE, DISPLAY_NAME, DESCRIPTION, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.WORK_BASKET_LDESC_T.WBID, 
   cmndb_owner.WORK_BASKET_LDESC_T.LOCALE, 
   cmndb_owner.WORK_BASKET_LDESC_T.DISPLAY_NAME, 
   cmndb_owner.WORK_BASKET_LDESC_T.DESCRIPTION, 
   cmndb_owner.WORK_BASKET_LDESC_T.WSID_1, 
   cmndb_owner.WORK_BASKET_LDESC_T.WSID_2
 FROM cmndb_owner.WORK_BASKET_LDESC_T;

-- View: WorkBasketDistTarget
CREATE VIEW cmndb_owner.WORK_BASKET_DIST_TARGET(WBID, NAME, TYPE, OWNER, DEFAULT_QUERY_TABLE, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8, CREATED, LAST_MODIFIED, SOURCE_WBID, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.WORK_BASKET_DIST_TARGET_T.TARGET_WBID, 
   cmndb_owner.WORK_BASKET_T.NAME, 
   cmndb_owner.WORK_BASKET_T.TYPE, 
   cmndb_owner.WORK_BASKET_T.OWNER, 
   cmndb_owner.WORK_BASKET_T.DEFAULT_QUERY_TABLE, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT1, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT2, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT3, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT4, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT5, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT6, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT7, 
   cmndb_owner.WORK_BASKET_T.CUSTOM_TEXT8, 
   cmndb_owner.WORK_BASKET_T.CREATION_TIME, 
   cmndb_owner.WORK_BASKET_T.LAST_MODIFICATION_TIME, 
   cmndb_owner.WORK_BASKET_DIST_TARGET_T.SOURCE_WBID, 
   cmndb_owner.WORK_BASKET_T.WSID_1, 
   cmndb_owner.WORK_BASKET_T.WSID_2
 FROM cmndb_owner.WORK_BASKET_DIST_TARGET_T, cmndb_owner.WORK_BASKET_T
 WHERE cmndb_owner.WORK_BASKET_T.WBID = cmndb_owner.WORK_BASKET_DIST_TARGET_T.TARGET_WBID;

-- View: BusinessCategory
CREATE VIEW cmndb_owner.BUSINESS_CATEGORY(BCID, PARENT_BCID, NAME, PRIORITY, DEFAULT_QUERY_TABLE, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8, CREATED, LAST_MODIFIED, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.BUSINESS_CATEGORY_T.BCID, 
   cmndb_owner.BUSINESS_CATEGORY_T.PARENT_BCID, 
   cmndb_owner.BUSINESS_CATEGORY_T.NAME, 
   cmndb_owner.BUSINESS_CATEGORY_T.PRIORITY, 
   cmndb_owner.BUSINESS_CATEGORY_T.DEFAULT_QUERY_TABLE, 
   cmndb_owner.BUSINESS_CATEGORY_T.CUSTOM_TEXT1, 
   cmndb_owner.BUSINESS_CATEGORY_T.CUSTOM_TEXT2, 
   cmndb_owner.BUSINESS_CATEGORY_T.CUSTOM_TEXT3, 
   cmndb_owner.BUSINESS_CATEGORY_T.CUSTOM_TEXT4, 
   cmndb_owner.BUSINESS_CATEGORY_T.CUSTOM_TEXT5, 
   cmndb_owner.BUSINESS_CATEGORY_T.CUSTOM_TEXT6, 
   cmndb_owner.BUSINESS_CATEGORY_T.CUSTOM_TEXT7, 
   cmndb_owner.BUSINESS_CATEGORY_T.CUSTOM_TEXT8, 
   cmndb_owner.BUSINESS_CATEGORY_T.CREATION_TIME, 
   cmndb_owner.BUSINESS_CATEGORY_T.LAST_MODIFICATION_TIME, 
   cmndb_owner.BUSINESS_CATEGORY_T.WSID_1, 
   cmndb_owner.BUSINESS_CATEGORY_T.WSID_2
 FROM cmndb_owner.BUSINESS_CATEGORY_T;

-- View: BusinessCategoryLDesc
CREATE VIEW cmndb_owner.BUSINESS_CATEGORY_LDESC(BCID, LOCALE, DISPLAY_NAME, DESCRIPTION, WSID_1, WSID_2 ) AS
 SELECT 
   cmndb_owner.BUSINESS_CATEGORY_LDESC_T.BCID, 
   cmndb_owner.BUSINESS_CATEGORY_LDESC_T.LOCALE, 
   cmndb_owner.BUSINESS_CATEGORY_LDESC_T.DISPLAY_NAME, 
   cmndb_owner.BUSINESS_CATEGORY_LDESC_T.DESCRIPTION, 
   cmndb_owner.BUSINESS_CATEGORY_LDESC_T.WSID_1, 
   cmndb_owner.BUSINESS_CATEGORY_LDESC_T.WSID_2
 FROM cmndb_owner.BUSINESS_CATEGORY_LDESC_T;


-- start import scheduler DDL: createSchemaOracle.ddl



CREATE TABLE cmndb_owner."SCHED_TASK"("TASKID" NUMBER(19) NOT NULL,
               "VERSION" VARCHAR2(5) NOT NULL,
               "ROW_VERSION" NUMBER(10) NOT NULL,
               "TASKTYPE" NUMBER(10) NOT NULL,
               "TASKSUSPENDED" NUMBER(1) NOT NULL,
               "CANCELLED" NUMBER(1) NOT NULL,
               "NEXTFIRETIME" NUMBER(19) NOT NULL,
               "STARTBYINTERVAL" VARCHAR2(254),
               "STARTBYTIME" NUMBER(19),
               "VALIDFROMTIME" NUMBER(19),
               "VALIDTOTIME" NUMBER(19),
               "REPEATINTERVAL" VARCHAR2(254),
               "MAXREPEATS" NUMBER(10) NOT NULL,
               "REPEATSLEFT" NUMBER(10) NOT NULL,
               "TASKINFO" BLOB,
               "NAME" VARCHAR2(254),
               "AUTOPURGE" NUMBER(10) NOT NULL,
               "FAILUREACTION" NUMBER(10),
               "MAXATTEMPTS" NUMBER(10),
               "QOS" NUMBER(10),
               "PARTITIONID" NUMBER(10),
               "OWNERTOKEN" VARCHAR2(200) NOT NULL,
               "CREATETIME" NUMBER(19) NOT NULL,
               PRIMARY KEY ("TASKID") );

CREATE INDEX cmndb_owner."SCHED_TASK_IDX1" ON cmndb_owner."SCHED_TASK" ("TASKID",
              "OWNERTOKEN") ;

CREATE INDEX cmndb_owner."SCHED_TASK_IDX2" ON cmndb_owner."SCHED_TASK" ("NEXTFIRETIME" ASC,
               "REPEATSLEFT",
               "PARTITIONID");

CREATE TABLE cmndb_owner."SCHED_TREG" ("REGKEY" VARCHAR2(254) NOT NULL ,
               "REGVALUE" VARCHAR2(254) ,
               PRIMARY KEY ( "REGKEY" ));

CREATE TABLE cmndb_owner."SCHED_LMGR" ("LEASENAME" VARCHAR2(254) NOT NULL,
               "LEASEOWNER" VARCHAR2(254),
               "LEASE_EXPIRE_TIME" NUMBER(19),
               "DISABLED" VARCHAR2(254),
               PRIMARY KEY ( "LEASENAME" ));

CREATE TABLE cmndb_owner."SCHED_LMPR" ("LEASENAME" VARCHAR2(254) NOT NULL,
               "NAME" VARCHAR2(254) NOT NULL,
               "VALUE" VARCHAR2(254) NOT NULL );

CREATE INDEX cmndb_owner."SCHED_LMPR_IDX1" ON cmndb_owner."SCHED_LMPR" ("LEASENAME",
               "NAME") ;

-- end import scheduler DDL: createSchemaOracle.ddl

-- BEGIN COPYRIGHT
-- *************************************************************************
-- 
--  Licensed Materials - Property of IBM
--  5725-C94, 5725-C95, 5725-C96
--  (C) Copyright IBM Corporation 2013, 2016. All Rights Reserved.
--  US Government Users Restricted Rights- Use, duplication or disclosure
--  restricted by GSA ADP Schedule Contract with IBM Corp.
-- 
-- *************************************************************************
-- END COPYRIGHT

create table cmndb_owner.persistentlock (
    lockId integer not null,
    sequenceId integer not null,
    owner integer not null,
    moduleName varchar2 (250),
    compName varchar2 (250),
    method varchar2 (250),
    msgHandleString varchar2 (128),
    primary key (lockId,sequenceId));

-- *******************************************
-- create table FailedEvents and indexes
-- *******************************************
CREATE TABLE cmndb_owner.FailedEvents
  (MsgId            VARCHAR2 (255) NOT NULL,
   Destination_Module_Name  VARCHAR2 (255),
   Destination_Component_Name   VARCHAR2 (255),
   Destination_Method_Name  VARCHAR2 (255),
   Source_Module_Name       VARCHAR2 (255),
   Source_Component_Name    VARCHAR2 (255),
   ResubmitDestination      VARCHAR2 (512),
   InteractionType      VARCHAR2 (128),
   ExceptionDetails     VARCHAR2 (1024),
   SessionId            VARCHAR2 (255),
   CorrelationId        VARCHAR2 (255),
   DeploymentTarget     VARCHAR2 (200),
   FailureTime          DATE NOT NULL,
   Status           INTEGER NOT NULL,
   EsQualified              SMALLINT,
   EventType        VARCHAR (10));

ALTER TABLE cmndb_owner.FailedEvents
   ADD CONSTRAINT PK_FailedEvents PRIMARY KEY (MsgId);

CREATE INDEX cmndb_owner.INX_FEDest ON cmndb_owner.FailedEvents
  (Destination_Module_Name,
   Destination_Component_Name,
   Destination_Method_Name);

CREATE INDEX cmndb_owner.INX_FESrc ON cmndb_owner.FailedEvents
  (Source_Module_Name,
   Source_Component_Name);

CREATE INDEX cmndb_owner.INX_FESID ON cmndb_owner.FailedEvents (SessionId);

CREATE INDEX cmndb_owner.INX_FEFTime ON cmndb_owner.FailedEvents (FailureTime);

CREATE INDEX cmndb_owner.INX_FEESQualified ON cmndb_owner.FailedEvents (EsQualified);

CREATE INDEX cmndb_owner.INX_FEEventType ON cmndb_owner.FailedEvents (EventType);

-- *******************************************
-- create table FailedEventBOTypes and indexes
-- *******************************************
CREATE TABLE cmndb_owner.FailedEventBOTypes
  (MsgId        VARCHAR2 (255) NOT NULL,
   BOType       VARCHAR2 (255) NOT NULL,
   Argument_Position    INTEGER NOT NULL);

ALTER TABLE cmndb_owner.FailedEventBOTypes
   ADD CONSTRAINT PK_FailedEventBO PRIMARY KEY (MsgId, Argument_Position);

ALTER TABLE cmndb_owner.FailedEventBOTypes
   ADD CONSTRAINT FK_FailedEventBO FOREIGN KEY (MsgId) REFERENCES cmndb_owner.FailedEvents(MsgId);

CREATE INDEX cmndb_owner.FailedEventBOTp ON cmndb_owner.FailedEventBOTypes (BOType);

-- *******************************************
-- create table FailedEventMessage and indexes
-- *******************************************
CREATE TABLE cmndb_owner.FailedEventMessage
  (MsgId        VARCHAR2 (255) NOT NULL,
   JserviceMessage  BLOB);

ALTER TABLE cmndb_owner.FailedEventMessage
   ADD CONSTRAINT PK_FailedEventMSG PRIMARY KEY (MsgId);

ALTER TABLE cmndb_owner.FailedEventMessage
   ADD CONSTRAINT FK_FailedEventMSG FOREIGN KEY (MsgId) REFERENCES cmndb_owner.FailedEvents(MsgId);

-- *******************************************
-- create table FailedEventDetail and indexes
-- *******************************************
CREATE TABLE cmndb_owner.FailedEventDetail
  (MsgId        VARCHAR (255) NOT NULL,
   Message      BLOB,
   Parameters       BLOB,
   ExceptionDetail  BLOB,
   WrapperType          SMALLINT,
   ApplicationName  VARCHAR (255),
   CEITraceControl  VARCHAR (255),
   UserIdentity     VARCHAR(128),
   ExpirationTime   TIMESTAMP);

ALTER TABLE cmndb_owner.FailedEventDetail
   ADD CONSTRAINT PK_FailedEventDTL PRIMARY KEY (MsgId);

ALTER TABLE cmndb_owner.FailedEventDetail
   ADD CONSTRAINT FK_FailedEventDTL FOREIGN KEY (MsgId) REFERENCES cmndb_owner.FailedEvents(MsgId);

-- ***************************************************************** 
--                                                                   
-- Licensed Materials - Property of IBM                              
--                                                                   
-- 5725-C94, 5725-C95, 5725-C96                                                          
--                                                                   
-- Copyright IBM Corp. 2012, 2014, 2018  All Rights Reserved.                    
--                                                                   
-- US Government Users Restricted Rights - Use, duplication or       
-- disclosure restricted by GSA ADP Schedule Contract with           
-- IBM Corp.                                                         
--                                                                   
-- ***************************************************************** 
--
-- NAVIGATOR Oracle SQL Script 
--
--


-- Drop table

-- ALTER SESSION SET CURRENT_SCHEMA = icndb_owner;

-- DROP TABLE icndb_owner.CONFIGURATION;


-- Create table

ALTER SESSION SET CURRENT_SCHEMA = icndb_owner;

CREATE TABLE icndb_owner.CONFIGURATION (
        ID VARCHAR2(256) NOT NULL,
        ATTRIBUTES CLOB,
	CONSTRAINT ID_PK PRIMARY KEY (ID)
);


-- Create grant

ALTER SESSION SET CURRENT_SCHEMA = icndb_owner;

GRANT INSERT,UPDATE,SELECT,DELETE ON CONFIGURATION TO icndb_owner;


--

INSERT INTO icndb_owner.CONFIGURATION VALUES ('application.navigator', 'locales=ar,he,en,zh_CN,zh_TW,cs,hr,da,nl,fi,fr,de,el,hu,it,ja,ko,nb,pl,pt,pt_BR,ru,sk,sl,es,sv,th,tr,ro,kk,ca,vi;threadSleepTime=5;themes=azurite,cordierite,malachite,obsidian,quartz;plugins=;menus=;repositories=;desktops=admin;viewers=default;servers=cm,od,p8,cmis;key=871bf66c911f811fd48a6cc97aea40a4;objectExpiration=10;desktop=default');

INSERT INTO icndb_owner.CONFIGURATION VALUES ('settings.navigator.default', 'mobileAccess=true;logging.level=2;logging.excludes=com.ibm.ecm.configuration;iconStatus=docHold,docNotes,docMinorVersions,docDeclaredRecord,docBookmarks,docCheckedOut,workItemSuspended,workItemDeadlineImportance,workItemDeadlineReminderSent,workItemLocked,workItemCheckedOut;adminUsers=dmgr_admin');

INSERT INTO icndb_owner.CONFIGURATION VALUES ('desktop.navigator.admin', 'authenticationType=1;workflowNotification=false;fileIntoFolder=false;showSecurity=false;viewer=default;theme=;name=Admin Desktop;isDefault=Yes;menuPrefix=Default;applicationName=IBM Content Navigator;configInfo=;layout=ecm.widget.layout.NavigatorMainLayout;defaultFeature=ecmClientAdmin;actionHandler=ecm.widget.layout.CommonActionsHandler;servers=cm,od,ci,p8,cmis;repositories=');

INSERT INTO icndb_owner.CONFIGURATION VALUES ('version.navigator', 'version=3.0.1');



-- *****************************************************************
-- ***************************************************************** 
-- ECM TaskManager
-- *****************************************************************
-- ***************************************************************** 

-- Create table
ALTER SESSION SET CURRENT_SCHEMA = icndb_owner;

CREATE TABLE icndb_owner.APP_LOCK (id NUMBER NOT NULL, category VARCHAR2(30) NOT NULL, LOCK_STATUS NUMBER, objectID NUMBER, version NUMBER, PRIMARY KEY (id));
CREATE TABLE icndb_owner.TASKAUDIT (id NUMBER NOT NULL, EVT_ACTION VARCHAR2(128), EVT_TS TIMESTAMP, EVT_INFO CLOB, EVT_TYPE VARCHAR2(128), originator VARCHAR2(380), status VARCHAR2(128), TASK_ID NUMBER, PRIMARY KEY (id));
CREATE TABLE icndb_owner.BATCHES (id NUMBER NOT NULL, BATCH_DATA BLOB, CREATED_BY VARCHAR2(128), SEQ_ID NUMBER, START_TIME TIMESTAMP, status NUMBER, STOP_TIME TIMESTAMP, SUCCESS_CNT NUMBER, TASK_ID NUMBER, TOTAL_CNT NUMBER, PRIMARY KEY (id));
CREATE TABLE icndb_owner.SERVER (id NUMBER NOT NULL, ACCESS_TIME TIMESTAMP, name VARCHAR2(80) NOT NULL, serverURL VARCHAR2(256), port NUMBER, PROC_ID NUMBER, protocol VARCHAR2(10), status NUMBER, PRIMARY KEY (id));
CREATE TABLE icndb_owner.TASK (id NUMBER NOT NULL, AUTO_RESUME NUMBER, CREATED_BY VARCHAR2(128), description VARCHAR2(1024), END_TIME TIMESTAMP, HANDLER_NAME VARCHAR2(256) NOT NULL, LOCAL_STATE NUMBER, LOG_LEV VARCHAR2(8), name VARCHAR2(256) NOT NULL, NOTIFY_INFO CLOB, parent VARCHAR2(256), REPEAT_PERIOD NUMBER, SERVER_ID NUMBER, START_TIME TIMESTAMP, status NUMBER, STOP_TIME TIMESTAMP, SUCCESS_CNT NUMBER, TASK_INFO CLOB, TASK_MODE NUMBER, TIMER_HANDLE VARCHAR2(512), TOTAL_CNT NUMBER, PRIMARY KEY (id));
CREATE TABLE icndb_owner.TASK_ERROR (id NUMBER NOT NULL, CREATE_TIME TIMESTAMP, ERROR_CODE NUMBER, ERROR_MSG VARCHAR2(1024), TASK_ID NUMBER, PRIMARY KEY (id));
CREATE TABLE icndb_owner.TASK_EXREC (id NUMBER NOT NULL, SERVER_ID NUMBER, START_TIME TIMESTAMP, status NUMBER, STOP_TIME TIMESTAMP, SUCCESS_CNT NUMBER, EXEC_INFO CLOB, TASK_ID NUMBER, TOTAL_CNT NUMBER, PRIMARY KEY (id));
CREATE TABLE icndb_owner.TASK_QUEUE (id NUMBER NOT NULL, CREATED_BY VARCHAR2(128), EXEC_TIME TIMESTAMP, status NUMBER, TASK_ID NUMBER NOT NULL, version NUMBER, PRIMARY KEY (id));
CREATE TABLE icndb_owner.TASK_SEQ_TABLE (ID VARCHAR2(256) NOT NULL, SEQUENCE_VALUE NUMBER(20) default NULL, PRIMARY KEY (ID));

INSERT INTO icndb_owner.TASK_SEQ_TABLE VALUES ('APP_LOCK', 4999);
INSERT INTO icndb_owner.TASK_SEQ_TABLE VALUES ('Server', 4999);
INSERT INTO icndb_owner.TASK_SEQ_TABLE VALUES ('TaskAudit', 4999);
INSERT INTO icndb_owner.TASK_SEQ_TABLE VALUES ('TASK_ERROR', 4999);
INSERT INTO icndb_owner.TASK_SEQ_TABLE VALUES ('TASK_QUEUE', 4999);
INSERT INTO icndb_owner.TASK_SEQ_TABLE VALUES ('Batches', 4999);
INSERT INTO icndb_owner.TASK_SEQ_TABLE VALUES ('Task', 4999);
INSERT INTO icndb_owner.TASK_SEQ_TABLE VALUES ('TASK_EXREC', 4999);

-- Create grant
ALTER SESSION SET CURRENT_SCHEMA = icndb_owner;

GRANT INSERT,UPDATE,SELECT,DELETE ON APP_LOCK TO icndb_owner;
GRANT INSERT,UPDATE,SELECT,DELETE ON TASKAUDIT TO icndb_owner;
GRANT INSERT,UPDATE,SELECT,DELETE ON BATCHES TO icndb_owner;
GRANT INSERT,UPDATE,SELECT,DELETE ON SERVER TO icndb_owner;
GRANT INSERT,UPDATE,SELECT,DELETE ON TASK TO icndb_owner;
GRANT INSERT,UPDATE,SELECT,DELETE ON TASK_ERROR TO icndb_owner;
GRANT INSERT,UPDATE,SELECT,DELETE ON TASK_EXREC TO icndb_owner;
GRANT INSERT,UPDATE,SELECT,DELETE ON TASK_QUEUE TO icndb_owner;
GRANT INSERT,UPDATE,SELECT,DELETE ON TASK_SEQ_TABLE TO icndb_owner;

-- *****************************************************************
-- ***************************************************************** 
-- SYNC Services
-- *****************************************************************
-- ***************************************************************** 

-- Create the static tables required for sync and grant privileges

ALTER SESSION SET CURRENT_SCHEMA = icndb_owner;

--------------------------------------------------------------------
-- SYNCREPOSMAPPING
--------------------------------------------------------------------

CREATE TABLE icndb_owner.SYNCREPOSMAPPING (
	ID NUMBER  NOT NULL   , 
	TABLENAMEPREFIX VARCHAR2 (16)  NOT NULL , 
	REPOSID1 VARCHAR2 (36)  NOT NULL , 
	REPOSID2 VARCHAR2 (36)  NOT NULL , 
	CONNECTIONINFO VARCHAR2 (256) , 
	EVENTID VARCHAR2 (36)  NOT NULL , 
	REPOSTYPE NUMBER(5) DEFAULT 0  NOT NULL  , 
	LASTUPDATEID NUMBER DEFAULT 0  NOT NULL , 
	LASTMODRECEIVED TIMESTAMP , 
	MARKDELETED NUMBER(5) DEFAULT 0  NOT NULL  , 
    CODEMODULEREV SMALLINT , 
	CONSTRAINT CC1392679913540 PRIMARY KEY ( ID) , 
	CONSTRAINT CC1392679924904 UNIQUE ( TABLENAMEPREFIX) 
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE icndb_owner.SYNCREPOSMAPPING_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE;

CREATE OR REPLACE TRIGGER icndb_owner.SYNCREPOSMAPPING_seq_tr
BEFORE INSERT ON icndb_owner.SYNCREPOSMAPPING
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT icndb_owner.SYNCREPOSMAPPING_seq.nextval INTO :NEW.ID FROM dual;
END;
/

GRANT INSERT, DELETE, UPDATE, SELECT ON icndb_owner.SYNCREPOSMAPPING TO icndb_owner;

--------------------------------------------------------------------
-- SYNCITEMS
--------------------------------------------------------------------

CREATE TABLE icndb_owner.SYNCITEMS ( 
	ID NUMBER  NOT NULL   , 
	NAME VARCHAR2 (256)  NOT NULL , 
	OBJECTID VARCHAR2 (36)  NOT NULL , 
	USERID VARCHAR2 (64)  NOT NULL , 
	DESKTOPID VARCHAR2 (64)  NOT NULL , 
	REPOSID NUMBER  NOT NULL , 
	LASTUPDATETS TIMESTAMP DEFAULT  SYSTIMESTAMP NOT NULL , 
	MARKDELETED NUMBER(5) DEFAULT 0  NOT NULL   , 
	CONSTRAINT CC1392680242650 PRIMARY KEY ( ID) , 
	CONSTRAINT CC1392680358320 FOREIGN KEY (REPOSID) REFERENCES SYNCREPOSMAPPING (ID)
) ;

-- Generate ID using sequence and trigger
CREATE SEQUENCE icndb_owner.SYNCITEMS_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE;

CREATE OR REPLACE TRIGGER icndb_owner.SYNCITEMS_seq_tr
BEFORE INSERT ON icndb_owner.SYNCITEMS
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT icndb_owner.SYNCITEMS_seq.nextval INTO :NEW.ID FROM dual;
END;
/

GRANT INSERT, DELETE, UPDATE, SELECT ON icndb_owner.SYNCITEMS TO icndb_owner;

--------------------------------------------------------------------
-- DEVICEREGISTRY
--------------------------------------------------------------------

CREATE TABLE icndb_owner.DEVICEREGISTRY ( 
	ID NUMBER  NOT NULL   , 
	DEVICEID VARCHAR2 (36)  NOT NULL , 
	LASTPING TIMESTAMP , 
	MARKDELETED NUMBER(5) DEFAULT 0  NOT NULL   , 
	CONSTRAINT CC1392680754897 PRIMARY KEY ( ID) , 
	CONSTRAINT CC1392680759037 UNIQUE ( DEVICEID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE icndb_owner.DEVICEREGISTRY_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE;

CREATE OR REPLACE TRIGGER icndb_owner.DEVICEREGISTRY_seq_tr
BEFORE INSERT ON DEVICEREGISTRY
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT icndb_owner.DEVICEREGISTRY_seq.nextval INTO :NEW.ID FROM dual;
END;
/

GRANT INSERT, DELETE, UPDATE, SELECT ON icndb_owner.DEVICEREGISTRY TO icndb_owner;

--------------------------------------------------------------------
-- DEVICESYNCMAP
--------------------------------------------------------------------

CREATE TABLE icndb_owner.DEVICESYNCMAP ( 
	ID NUMBER  NOT NULL   , 
	DEVREGID NUMBER  NOT NULL , 
	SYNCITEMID NUMBER  NOT NULL , 
	MARKDELETED NUMBER(5) DEFAULT 0  NOT NULL   , 
	CONSTRAINT CC1392681213562 PRIMARY KEY ( ID) , 
	CONSTRAINT CC1392681269094 FOREIGN KEY (DEVREGID) REFERENCES DEVICEREGISTRY (ID)  , 
	CONSTRAINT CC1392681292746 FOREIGN KEY (SYNCITEMID) REFERENCES SYNCITEMS (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE icndb_owner.DEVICESYNCMAP_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE;

CREATE OR REPLACE TRIGGER icndb_owner.DEVICESYNCMAP_seq_tr
BEFORE INSERT ON icndb_owner.DEVICESYNCMAP
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT icndb_owner.DEVICESYNCMAP_seq.nextval INTO :NEW.ID FROM dual;
END;
/

GRANT INSERT, DELETE, UPDATE, SELECT ON icndb_owner.DEVICESYNCMAP TO icndb_owner;

--------------------------------------------------------------------
-- CONFIGURATION
--------------------------------------------------------------------
CREATE TABLE icndb_owner.SYNCCONFIGURATION (
	ID VARCHAR(256) NOT NULL, 
	ATTRIBUTES CLOB, 
	PRIMARY KEY(ID) 
);

GRANT INSERT, DELETE, UPDATE, SELECT ON icndb_owner.SYNCCONFIGURATION TO icndb_owner;

-- Create extra indexes

CREATE INDEX I_DR_LASTPING_MARKDELETED ON icndb_owner.DEVICEREGISTRY ( LASTPING , MARKDELETED );
CREATE INDEX I_DSM_SYNCITEMID ON icndb_owner.DEVICESYNCMAP ( SYNCITEMID );
CREATE INDEX I_DSM_DEVREGID ON icndb_owner.DEVICESYNCMAP ( DEVREGID );	
CREATE INDEX I_DSM_MARKDELETED ON icndb_owner.DEVICESYNCMAP ( MARKDELETED );	
CREATE INDEX I_SI_REPOSID ON icndb_owner.SYNCITEMS ( REPOSID );
CREATE INDEX I_SI_UID ON icndb_owner.SYNCITEMS ( USERID );
CREATE INDEX I_SI_OID_UID ON icndb_owner.SYNCITEMS ( OBJECTID, USERID );
CREATE INDEX I_SRM_REP1_REP2_MARKDELETED ON icndb_owner.SYNCREPOSMAPPING ( REPOSID1 , REPOSID2 , MARKDELETED );

-- Load the initial application configuration into the table

INSERT INTO icndb_owner.SYNCREPOSMAPPING (TABLENAMEPREFIX, REPOSID1, REPOSID2, CONNECTIONINFO, EVENTID, LASTUPDATEID) VALUES ('NULL', 'NULL', 'NULL', 'NULL', 'NULL', 0);
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('sync.task.states', '{}');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_Property_SyncServerUrl', 'name=IcnSyncServerUrl;descr=sync server URL name;attributes=IcnSyncServerUrl');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncEventAction_DisplayName', 'name=Sync Event Action;descr=Sync Event Action display name;attributes=Sync Event Action');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncEventActionClass_ID', 'name=Action class P8 ID;descr=Filenet P8 action class ID;attributes={A8239821-CD3F-499D-8FAE-F2DA54AC5A99}');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncEventAction_FullyQualifiedClass', 'name=Event action class name;descr=Fully qualified event action handler class name;attributes=com.ibm.ecm.sync.core.store.p8.P8SyncEventActionHandler');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncEventActionClass_Name', 'name=IcnSyncEventAction;descr=Sync Event class name;attributes=IcnSyncEventAction');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncInstanceSubscriptionClass_ID', 'name=Sync instance subscription ID;descr=Filenet P8 instance subscription ID;attributes=DA09A1F1-65C4-4044-8ACA-5AF043BD61B4}');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncInstanceSubscriptionClass_Name', 'name=IcnSyncInstanceSubscription;descr=Instance subscription name;attributes=IcnSyncInstanceSubscription');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncCodeModule_ID', 'name=Sync Code module ID;descr=Filenet P8 Sync code module ID;attributes={9cf33dbe-600d-40c7-a8bb-351fa38ab5a6}');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncCodeModule_Name', 'name=Sync code module name;descr=Sync code module name;attributes=Sync Code Module');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.api.RepositoryController.publicSyncUrl', 'name=Public sync URL;descr=Public sync URL;attributes=http://localhost:9082/sync/notify');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.WebAppListener.poolSize','name=Internal task pool size;descr=Internal task pool size;attributes=3');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.WebAppListener.deviceCleanupInitialDelay', 'name=Initial deplay for the database clean up task;descr=Initial deplay for the database clean up task (in days);attributes=1');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.WebAppListener.deviceCleanupPeriod', 'name=Device clean up cycle time;descr=Device clean up cycle time (in days);attributes=7');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.tools.cleanup.CleanupTask.deviceExpiration','name=Device expiration;descr=device expiration (in days);attributes=90');
INSERT INTO icndb_owner.SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('synchdb.version','400');
-- COMMIT;

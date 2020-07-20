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

-- *******************************************
-- AppScheduler
-- *******************************************

CREATE TABLE cell_owner.WSCH_TASK
(
  TASKID             NUMBER(19)            NOT NULL ,
  VERSION            VARCHAR2(5)           NOT NULL ,
  ROW_VERSION        NUMBER(10)            NOT NULL ,
  TASKTYPE           NUMBER(10)            NOT NULL ,
  TASKSUSPENDED      NUMBER(1)             NOT NULL ,
  CANCELLED          NUMBER(1)             NOT NULL ,
  NEXTFIRETIME       NUMBER(19)            NOT NULL ,
  STARTBYINTERVAL    VARCHAR2(254)                  ,
  STARTBYTIME        NUMBER(19)                     ,
  VALIDFROMTIME      NUMBER(19)                     ,
  VALIDTOTIME        NUMBER(19)                     ,
  REPEATINTERVAL     VARCHAR2(254)                  ,
  MAXREPEATS         NUMBER(10)            NOT NULL ,
  REPEATSLEFT        NUMBER(10)            NOT NULL ,
  TASKINFO           BLOB                           ,
  NAME               VARCHAR2(254)                  ,
  AUTOPURGE          NUMBER(10)            NOT NULL ,
  FAILUREACTION      NUMBER(10)                     ,
  MAXATTEMPTS        NUMBER(10)                     ,
  QOS                NUMBER(10)                     ,
  PARTITIONID        NUMBER(10)                     ,
  OWNERTOKEN         VARCHAR2(200)         NOT NULL ,
  CREATETIME         NUMBER(19)            NOT NULL ,
  PRIMARY KEY (TASKID)
) ;

CREATE INDEX cell_owner.WSCH_TASK_IDX1 ON cell_owner.WSCH_TASK
(
  TASKID, OWNERTOKEN
) ;

CREATE INDEX cell_owner.WSCH_TASK_IDX2 ON cell_owner.WSCH_TASK
(
  NEXTFIRETIME ASC ,
  REPEATSLEFT ,
  PARTITIONID
) ;

CREATE TABLE cell_owner.WSCH_TREG
(
  REGKEY             VARCHAR2(254)         NOT NULL ,
  REGVALUE           VARCHAR2(254)                  ,
  PRIMARY KEY ( REGKEY )
) ;

CREATE TABLE cell_owner.WSCH_LMGR
(
  LEASENAME          VARCHAR2(254)         NOT NULL ,
  LEASEOWNER         VARCHAR2(254)                  ,
  LEASE_EXPIRE_TIME  NUMBER(19)                     ,
  DISABLED           VARCHAR2(254)                  ,
  PRIMARY KEY ( LEASENAME )
) ;

CREATE TABLE cell_owner.WSCH_LMPR
(
  LEASENAME          VARCHAR2(254)         NOT NULL ,
  NAME               VARCHAR2(254)         NOT NULL ,
  VALUE              VARCHAR2(254)         NOT NULL
) ;

CREATE INDEX cell_owner.WSCH_LMPR_IDX1 ON cell_owner.WSCH_LMPR
(
  LEASENAME, NAME
) ;

-- *******************************************
-- Customization
-- *******************************************
-- *******************************************
-- Create the BYTESTORE table
-- *******************************************

CREATE TABLE cell_owner.BYTESTORE
  (ARTIFACTTNS VARCHAR2(250) NOT NULL,
   ARTIFACTNAME VARCHAR2(200) NOT NULL,
   ARTIFACTTYPE VARCHAR2(50) NOT NULL,
   INITIALBYTES BLOB,
   TIMESTAMP1 NUMBER(19) NOT NULL,
   FILENAME VARCHAR2(250),
   BACKINGCLASS VARCHAR2(250),
   CHARENCODING VARCHAR2(50),
   APPNAME VARCHAR2(200),
   COMPONENTTNS VARCHAR2(250),
   COMPONENTNAME VARCHAR2(200),
   SCAMODULENAME VARCHAR2(200),
   SCACOMPONENTNAME VARCHAR2(200));

ALTER TABLE cell_owner.BYTESTORE
  ADD CONSTRAINT PK_BYTESTORE PRIMARY KEY (ARTIFACTTYPE, ARTIFACTTNS, ARTIFACTNAME);

CREATE INDEX cell_owner.BYTESTORE_INDEX1 ON cell_owner.BYTESTORE (
      COMPONENTTNS,
      COMPONENTNAME);

CREATE INDEX cell_owner.BYTESTORE_INDEX2 ON cell_owner.BYTESTORE (
      ARTIFACTTYPE,
      COMPONENTTNS,
      COMPONENTNAME);


-- *******************************************
-- Create the BYTESTOREOVERFLOW table
-- *******************************************

CREATE TABLE cell_owner.BYTESTOREOVERFLOW
  (ARTIFACTTYPE VARCHAR2(50) NOT NULL,
   ARTIFACTTNS VARCHAR2(250) NOT NULL,
   ARTIFACTNAME VARCHAR2(200) NOT NULL,
   SEQUENCENUMBER NUMBER(10) NOT NULL,
   BYTES BLOB);

ALTER TABLE cell_owner.BYTESTOREOVERFLOW
  ADD CONSTRAINT PK_BYTESTOREOVERFL PRIMARY KEY (ARTIFACTTYPE, ARTIFACTTNS, ARTIFACTNAME, SEQUENCENUMBER);


-- *******************************************
-- Create the APPTIMESTAMP table
-- *******************************************

CREATE TABLE cell_owner.APPTIMESTAMP
  (APPNAME VARCHAR2(200) NOT NULL,
   TIMESTAMP1 NUMBER(19) NOT NULL);

ALTER TABLE cell_owner.APPTIMESTAMP
  ADD CONSTRAINT PK_APPTIMESTAMP PRIMARY KEY (APPNAME);

-- *******************************************
-- Create the CUSTPROPERTIES table
-- *******************************************

CREATE TABLE cell_owner.CUSTPROPERTIES
  (PROPERTYID VARCHAR (128) NOT NULL,
   ARTIFACTTNS VARCHAR(250) NOT NULL,
   ARTIFACTNAME VARCHAR(200) NOT NULL,
   ARTIFACTTYPE VARCHAR(50) NOT NULL,
   PNAME VARCHAR(250) NOT NULL,
   PVALUE VARCHAR(250) NOT NULL,
   PTYPE VARCHAR (16) NOT NULL);

ALTER TABLE cell_owner.CUSTPROPERTIES
  ADD CONSTRAINT PK_CUSTPROPERTIES PRIMARY KEY (PROPERTYID);

CREATE INDEX cell_owner.CUSTPROPERTIES_INDEX1 ON cell_owner.CUSTPROPERTIES (
      ARTIFACTTYPE,
      ARTIFACTTNS);  
      
CREATE INDEX cell_owner.CUSTPROPERTIES_INDEX2 ON cell_owner.CUSTPROPERTIES (
      ARTIFACTTYPE,
      ARTIFACTNAME);
  
CREATE INDEX cell_owner.CUSTPROPERTIES_INDEX3 ON cell_owner.CUSTPROPERTIES (
      ARTIFACTTYPE,
      ARTIFACTTNS,
      ARTIFACTNAME);  
      
CREATE INDEX cell_owner.CUSTPROPERTIES_INDEX4 ON cell_owner.CUSTPROPERTIES (
      ARTIFACTTYPE,
      PNAME);      
      
CREATE INDEX cell_owner.CUSTPROPERTIES_INDEX5 ON cell_owner.CUSTPROPERTIES (
      ARTIFACTTYPE,
      ARTIFACTTNS,
      PNAME);      


-- *******************************************
-- DirectDeploy
-- *******************************************

create TABLE cell_owner.d2d_item (
    id varchar(255) not null, 
    state varchar(20) not null,
    item_level int not null,
    module_name varchar(255),
    application_name varchar(255),
    version varchar(30), 
    wps_version varchar(10),
    new_app_name varchar(255),
    primary key (id));

create TABLE cell_owner.d2d_progress (
    item_id varchar(255) not null,
    progress INTEGER,
    progress_msg varchar(255),
    progress_error_code  varchar(255),
    primary key (item_id));

create TABLE cell_owner.d2d_content (
    item_id varchar(255) not null,
    pi  blob,
    primary key (item_id));

create TABLE cell_owner.d2d_metadata(
    item_id varchar(255) not null,
    name varchar(255) not null,
    value varchar(255) );

create TABLE cell_owner.d2d_lock(
    item_lock character(1),
    lastUpdate timestamp);

insert into cell_owner.d2d_lock values ('x', null);

create TABLE cell_owner.d2d_message(
    item_id varchar(255) not null,
    seq int not null,
    id  varchar(63),
    description varchar(1024),
    affected_resource varchar(255),
    location varchar(63),
    folder varchar(255),
    chr varchar(63),
    tag varchar(63),
    severity varchar(15),
    time timestamp,
    primary key (item_id, seq));


-- *******************************************
-- ESDLoggerMediation
-- *******************************************

CREATE TABLE cell_owner.MsgLog
  (TimeStamp TIMESTAMP(6) NOT NULL,
   MessageID VARCHAR2(36) NOT NULL,
   MediationName VARCHAR2(256) NOT NULL,
   ModuleName VARCHAR2(256),
   Message CLOB,
   Version VARCHAR2(10));

ALTER TABLE cell_owner.MsgLog
  ADD CONSTRAINT PK_MSGLOG PRIMARY KEY (TimeStamp, MessageID, MediationName);


-- *******************************************
-- GovernanceRepository
-- *******************************************

  CREATE TABLE cell_owner.W_LIT_DOUBLE 
   (    ID NUMBER(*,0), 
    LITVAL FLOAT(126)
   ) ;
  ALTER TABLE cell_owner.W_LIT_DOUBLE ADD PRIMARY KEY (ID) ENABLE;

  CREATE INDEX cell_owner.idx_obj_dbl ON cell_owner.w_lit_double (litval);
 
  CREATE TABLE cell_owner.W_LIT_FLOAT 
   (    ID NUMBER(*,0), 
    LITVAL FLOAT(63)
   ) ;
  ALTER TABLE cell_owner.W_LIT_FLOAT ADD PRIMARY KEY (ID) ENABLE;

  CREATE INDEX cell_owner.idx_obj_flt ON cell_owner.w_lit_float (litval);
 
  CREATE TABLE cell_owner.W_LIT_LONG 
   (    ID NUMBER(*,0), 
    LITVAL NUMBER(38,0)
   ) ;
  ALTER TABLE cell_owner.W_LIT_LONG ADD PRIMARY KEY (ID) ENABLE;

  CREATE INDEX cell_owner.idx_obj_long ON cell_owner.w_lit_long (litval);
 
  CREATE TABLE cell_owner.W_NAMESPACE 
   (    ID NUMBER(*,0), 
    NAMESPACE VARCHAR2(254) NOT NULL ENABLE
   ) ;
  ALTER TABLE cell_owner.W_NAMESPACE ADD PRIMARY KEY (ID) ENABLE;
 
  CREATE TABLE cell_owner.W_OBJ_LIT_ANY 
   (    ID NUMBER(*,0), 
    LARGE BLOB, 
    HASH VARCHAR2(40), 
    TYPE_URI VARCHAR2(254) NOT NULL ENABLE
   ) ;
  ALTER TABLE cell_owner.W_OBJ_LIT_ANY ADD PRIMARY KEY (ID) ENABLE;

  CREATE INDEX cell_owner.idx_obj_any ON cell_owner.w_obj_lit_any (type_uri);
 
  CREATE TABLE cell_owner.W_OBJ_LIT_DATE 
   (    ID NUMBER(*,0), 
    LITVAL TIMESTAMP (6)
   ) ;
  ALTER TABLE cell_owner.W_OBJ_LIT_DATE ADD PRIMARY KEY (ID) ENABLE;
 
  CREATE INDEX cell_owner.idx_obj_date ON cell_owner.w_obj_lit_date (litval);

  CREATE TABLE cell_owner.W_OBJ_LIT_DATETIME 
   (    ID NUMBER(*,0), 
    LITVAL TIMESTAMP (6)
   ) ;
  ALTER TABLE cell_owner.W_OBJ_LIT_DATETIME ADD PRIMARY KEY (ID) ENABLE;

  CREATE INDEX cell_owner.idx_obj_time ON cell_owner.w_obj_lit_datetime (litval);

 
  CREATE TABLE cell_owner.W_OBJ_LIT_STRING 
   (    ID NUMBER(*,0), 
    LARGE BLOB, 
    LITVAL VARCHAR2(1024), 
    HASH VARCHAR2(40)
   ) ;
  ALTER TABLE cell_owner.W_OBJ_LIT_STRING ADD PRIMARY KEY (ID) ENABLE;

  CREATE INDEX cell_owner.idx_obj_str ON cell_owner.w_obj_lit_string (hash);
 
  CREATE TABLE cell_owner.W_STATEMENT 
   (    ID NUMBER(*,0), 
    VERSION_FROM NUMBER(*,0) NOT NULL ENABLE, 
    VERSION_TO NUMBER(*,0) NOT NULL ENABLE, 
    SUBJ_ID NUMBER(*,0) NOT NULL ENABLE, 
    PRED_ID NUMBER(*,0) NOT NULL ENABLE, 
    OBJ_ID NUMBER(*,0) NOT NULL ENABLE, 
    OBJ_TYP_CD NUMBER(*,0) NOT NULL ENABLE,
    PARTITION_ID NUMBER(*,0) NOT NULL ENABLE
   ) ;
  ALTER TABLE cell_owner.W_STATEMENT ADD PRIMARY KEY (ID) ENABLE;
  
  CREATE INDEX cell_owner.idx_smt_by_sbj ON cell_owner.w_statement (subj_id, version_from, version_to);
  CREATE INDEX cell_owner.idx_smt_by_fvr ON cell_owner.w_statement (version_from);
  CREATE INDEX cell_owner.idx_sbj_by_prp ON cell_owner.w_statement (pred_id, obj_id);
  CREATE INDEX cell_owner.idx_smt_by_val ON cell_owner.w_statement (obj_id, subj_id);
  CREATE INDEX cell_owner.idx_val_by_prp ON cell_owner.w_statement (subj_id, pred_id);
 
  CREATE TABLE cell_owner.W_URI 
   (    ID NUMBER(*,0), 
    URI VARCHAR2(254) NOT NULL ENABLE, 
    NAMESPACE_ID NUMBER(*,0) NOT NULL ENABLE
   ) ;
  ALTER TABLE cell_owner.W_URI ADD PRIMARY KEY (ID) ENABLE;
  ALTER TABLE cell_owner.W_URI ADD CONSTRAINT W_URI_FK_NAMESP FOREIGN KEY (NAMESPACE_ID)
      REFERENCES cell_owner.W_NAMESPACE (ID) ENABLE;
 
  CREATE TABLE cell_owner.W_VERSION 
   (    USERNAME VARCHAR2(64) NOT NULL ENABLE, 
    CHANGE_TIME TIMESTAMP (6) NOT NULL ENABLE, 
    CL_GID VARCHAR2(36), 
    CL_LID VARCHAR2(10), 
    SCHEMA_NS_ID NUMBER(*,0), 
    SCHEMA_REV NUMBER(*,0), 
    ID NUMBER(*,0) NOT NULL ENABLE,
    PARTITION_ID NUMBER(*,0) NOT NULL ENABLE
   ) ;
  ALTER TABLE cell_owner.W_VERSION ADD PRIMARY KEY (ID, PARTITION_ID) ENABLE;
  ALTER TABLE cell_owner.W_VERSION ADD CONSTRAINT W_VER_FK_NAMESP FOREIGN KEY (SCHEMA_NS_ID)
      REFERENCES cell_owner.W_NAMESPACE (ID) ENABLE;

  CREATE INDEX cell_owner.idx_ver_schema ON cell_owner.w_version (schema_ns_id);

CREATE TABLE cell_owner.W_ARTIFACT_BLOB 
(
 ID VARCHAR2(254) NOT NULL, 
 CONTENT BLOB, 
 DELETED NUMBER(1,0)
);
ALTER TABLE cell_owner.W_ARTIFACT_BLOB ADD PRIMARY KEY (ID) ENABLE;

CREATE UNIQUE INDEX cell_owner.IDX_URI ON cell_owner.W_URI (URI);
CREATE UNIQUE INDEX cell_owner.IDX_URI_BY_NS ON cell_owner.W_URI (NAMESPACE_ID, ID);

CREATE UNIQUE INDEX cell_owner.IDX_NAMESPACE ON cell_owner.W_NAMESPACE (NAMESPACE);

CREATE SEQUENCE  cell_owner.SEQ_W_LIT_DOUBLE_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  cell_owner.SEQ_W_LIT_FLOAT_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  cell_owner.SEQ_W_LIT_LONG_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  cell_owner.SEQ_W_NAMESPACE_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  cell_owner.SEQ_W_OBJ_LIT_ANY_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  cell_owner.SEQ_W_OBJ_LIT_DATE_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  cell_owner.SEQ_W_OBJ_LIT_DATETIME_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  cell_owner.SEQ_W_OBJ_LIT_STRING_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  cell_owner.SEQ_W_STATEMENT_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  cell_owner.SEQ_W_URI_ID  MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

  CREATE TABLE cell_owner.W_LOCALE
  (    ID NUMBER(*,0),
       LOCALE VARCHAR2(8)
  ) ;
  
  ALTER TABLE cell_owner.W_LOCALE ADD PRIMARY KEY (ID) ENABLE;

  ALTER TABLE cell_owner.W_LOCALE ADD CONSTRAINT UNIQUE_LOCALE UNIQUE (LOCALE);
  
  INSERT INTO cell_owner.W_LOCALE VALUES (1000, 'root');

  INSERT INTO cell_owner.W_LOCALE VALUES (1001, 'en');

  INSERT INTO cell_owner.W_LOCALE VALUES (1002, 'en-us');
 
  INSERT INTO cell_owner.W_LOCALE VALUES (1003, 'en-uk');
  
  INSERT INTO cell_owner.W_LOCALE VALUES (1004, 'en-gb');

  INSERT INTO cell_owner.W_LOCALE VALUES (1032, 'cs');

  INSERT INTO cell_owner.w_locale VALUES (1064, 'es');

  INSERT INTO cell_owner.w_locale VALUES (1096, 'de');

  INSERT INTO cell_owner.w_locale VALUES (1128, 'de-de');

  INSERT INTO cell_owner.w_locale VALUES (1129, 'fr');

  INSERT INTO cell_owner.w_locale VALUES (1160, 'fr-ca-sk');

  INSERT INTO cell_owner.w_locale VALUES (1161, 'hu');

  INSERT INTO cell_owner.w_locale VALUES (1192, 'it');

  INSERT INTO cell_owner.w_locale VALUES (1224, 'ja');

  INSERT INTO cell_owner.w_locale VALUES (1256, 'ko');

  INSERT INTO cell_owner.w_locale VALUES (1288, 'pl');

  INSERT INTO cell_owner.w_locale VALUES (1320, 'pt-br');

  INSERT INTO cell_owner.w_locale VALUES (1352, 'ru');

  INSERT INTO cell_owner.w_locale VALUES (1384, 'zh');

  INSERT INTO cell_owner.w_locale VALUES (1416, 'zh-tw');

  INSERT INTO cell_owner.w_locale VALUES (1448, 'el');



CREATE TABLE cell_owner.w_subj_pred_index (
    subj_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    predicate_map RAW(1024),
    version_from NUMBER(*,0) NOT NULL,
    version_to NUMBER(*,0) NOT NULL,
    partition_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    PRIMARY KEY (subj_id, version_from, version_to, partition_id)
);

CREATE TABLE cell_owner.w_subj_obj_index (
    subj_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    object_map RAW(1024),
    obj_typ_cd NUMBER(*,0) NOT NULL,
    version_from NUMBER(*,0) NOT NULL,
    version_to NUMBER(*,0) NOT NULL,
    partition_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    PRIMARY KEY (subj_id, obj_typ_cd, version_from, version_to, partition_id)
);

CREATE TABLE cell_owner.w_pred_subj_index (
    pred_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    subject_map RAW(1024),
    version_from NUMBER(*,0) NOT NULL,
    version_to NUMBER(*,0) NOT NULL,
    partition_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    PRIMARY KEY (pred_id, version_from, version_to, partition_id)
);

CREATE TABLE cell_owner.w_pred_obj_index (
    pred_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    object_map RAW(1024),
    obj_typ_cd NUMBER(*,0) NOT NULL,
    version_from NUMBER(*,0) NOT NULL,
    version_to NUMBER(*,0) NOT NULL,
    partition_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    PRIMARY KEY (pred_id, obj_typ_cd, version_from, version_to, partition_id)
);

CREATE TABLE cell_owner.w_obj_subj_index (
    obj_id NUMBER(*,0) NOT NULL,
    obj_typ_cd NUMBER(*,0) NOT NULL,
    subject_map RAW(1024),
    version_from NUMBER(*,0) NOT NULL,
    version_to NUMBER(*,0) NOT NULL,
    partition_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    PRIMARY KEY (obj_id, obj_typ_cd, version_from, version_to, partition_id)
);

CREATE TABLE cell_owner.w_obj_pred_index (
    obj_id NUMBER(*,0) NOT NULL,
    obj_typ_cd NUMBER(*,0) NOT NULL,
    predicate_map RAW(1024),
    version_from NUMBER(*,0) NOT NULL,
    version_to NUMBER(*,0) NOT NULL,
    partition_id NUMBER(*,0) NOT NULL REFERENCES cell_owner.w_uri (id),
    PRIMARY KEY (obj_id, obj_typ_cd, version_from, version_to, partition_id)
);




  CREATE TABLE cell_owner.W_DBVERSION  
  (   SUBSYSTEM VARCHAR2(8) NOT NULL ENABLE, 
      CUR_VERSION NUMBER(*,0) NOT NULL ENABLE   
  ) ;
  ALTER TABLE cell_owner.W_DBVERSION ADD PRIMARY KEY (SUBSYSTEM) ENABLE;


-- *******************************************
-- Mediation
-- *******************************************

create TABLE cell_owner.mediation_tickets (
    targetTicketID varchar(255) not null, 
    ticketEntry long raw, 
    version varchar(255) not null, 
    primary key (targetTicketID));

-- *******************************************
-- RelationshipService
-- *******************************************

CREATE TABLE cell_owner.RELN_METADATA_T(RELATIONSHIP_NAME VARCHAR2(255) NOT NULL, VERSION VARCHAR2(10) NOT NULL);
CREATE UNIQUE INDEX cell_owner.RMT_RELN_NAME_I ON cell_owner.RELN_METADATA_T (RELATIONSHIP_NAME);


CREATE TABLE cell_owner.RELN_VIEW_META_T ( VIEW_NAME VARCHAR(255) NOT NULL,
                RELATIONSHIP_NAME VARCHAR(255) NOT NULL,
                ROLE_NAME VARCHAR(255) NOT NULL,
                VERSION VARCHAR(10) NOT NULL
                            );                                      
CREATE UNIQUE INDEX cell_owner.RELN_VIEW_I ON cell_owner.RELN_VIEW_META_T (RELATIONSHIP_NAME, ROLE_NAME);

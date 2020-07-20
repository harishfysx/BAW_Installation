-- BEGIN COPYRIGHT
-- *************************************************************************
--
--  Licensed Materials - Property of IBM
--  5725-C94, 5725-C95, 5725-C96
--  (C) Copyright IBM Corporation 2010, 2016. All Rights Reserved.
--  US Government Users Restricted Rights- Use, duplication or disclosure
--  restricted by GSA ADP Schedule Contract with IBM Corp.
--
-- *************************************************************************
-- END COPYRIGHT



	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('PS_WLSTORE') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.PS_WLSTORE(
"ID" NUMBER(30,0) NOT NULL ENABLE,
"TYPE" NUMBER(30,0),
"HANDLE" NUMBER(30,0),
"RECORD" LONG RAW
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_SYSTEM') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_SYSTEM(
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"NAME" NVARCHAR2(64) NOT NULL ENABLE,
"DESCRIPTION" NCLOB,
"ARCHIVED" DATE,
"VERSION" NUMBER(31,0),
"LAST_MODIFIED_BY_USER_ID" NUMBER(31,0),
"LAST_MODIFIED" DATE
)
LOB ("DESCRIPTION") STORE AS SECUREFILE';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TRACKING_GROUP') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TRACKING_GROUP(
"TRACKING_GROUP_ID" NUMBER(31,0) NOT NULL ENABLE,
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"EXTERNAL_UNIQUE_ID" NVARCHAR2(64),
"NAME" NVARCHAR2(64) NOT NULL ENABLE,
"DESCRIPTION" NCLOB,
"ARCHIVED" DATE,
"VERSION" NUMBER(31,0),
"LAST_MODIFIED_BY_USER_ID" NUMBER(31,0),
"LAST_MODIFIED" DATE,
"TABLE_ID" NUMBER(31,0),
"SNAPSHOT_ID" CHAR(36) NOT NULL ENABLE
)
LOB ("DESCRIPTION") STORE AS SECUREFILE';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TRACKING_POINT') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TRACKING_POINT(
"TRACKING_POINT_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKING_GROUP_ID" NUMBER(31,0) NOT NULL ENABLE,
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"EXTERNAL_UNIQUE_ID" NVARCHAR2(64),
"NAME" NVARCHAR2(600) NOT NULL ENABLE,
"DESCRIPTION" NCLOB,
"ARCHIVED" DATE,
"VERSION" NUMBER(31,0),
"LAST_MODIFIED_BY_USER_ID" NUMBER(31,0),
"LAST_MODIFIED" DATE,
"TYPE" NVARCHAR2(50),
"LOCAL_PROCESS_GUID" NVARCHAR2(64),
"PROCESS_ITEM_ID" NVARCHAR2(100),
"SNAPSHOT_ID" CHAR(36) NOT NULL ENABLE
)
LOB ("DESCRIPTION") STORE AS SECUREFILE';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TRACKED_FIELD') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TRACKED_FIELD(
"TRACKED_FIELD_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKING_GROUP_ID" NUMBER(31,0) NOT NULL ENABLE,
"EXTERNAL_UNIQUE_ID" NVARCHAR2(64),
"NAME" NVARCHAR2(64) NOT NULL ENABLE,
"DESCRIPTION" NCLOB,
"FIELD_TYPE" NUMBER(2,0) NOT NULL ENABLE,
"ARCHIVED" DATE,
"COLUMN_ID" NUMBER(31,0),
"ALLOCATED" DATE,
"SNAPSHOT_ID" CHAR(36) NOT NULL ENABLE
)
LOB ("DESCRIPTION") STORE AS SECUREFILE';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TRACKED_FIELD_USE') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TRACKED_FIELD_USE(
"TRACKED_FIELD_USE_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKING_GROUP_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKING_POINT_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKED_FIELD_ID" NUMBER(31,0) NOT NULL ENABLE,
"ARCHIVED" DATE,
"SNAPSHOT_ID" CHAR(36) NOT NULL ENABLE
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TIMING_INTERVAL') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TIMING_INTERVAL(
"TIMING_INTERVAL_ID" NUMBER(31,0) NOT NULL ENABLE,
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"EXTERNAL_UNIQUE_ID" NVARCHAR2(64),
"IS_AUTO" NCHAR(1) DEFAULT ' || '''' ||'T' || '''' || ' NOT NULL ENABLE,
"NAME" NVARCHAR2(800) NOT NULL ENABLE,
"DESCRIPTION" NCLOB,
"START_BOUND" NUMBER(2,0) NOT NULL ENABLE,
"END_BOUND" NUMBER(2,0) NOT NULL ENABLE,
"ARCHIVED" DATE,
"VERSION" NUMBER(31,0),
"LAST_MODIFIED_BY_USER_ID" NUMBER(31,0),
"LAST_MODIFIED" DATE
)
LOB ("DESCRIPTION") STORE AS SECUREFILE';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TIMING_INTERVAL_BOUND') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TIMING_INTERVAL_BOUND(
"TIMING_INTERVAL_BOUND_ID" NUMBER(31,0) NOT NULL ENABLE,
"TIMING_INTERVAL_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKING_POINT_ID" NUMBER(31,0) NOT NULL ENABLE,
"BOUND" NUMBER(2,0) NOT NULL ENABLE,
"ARCHIVED" DATE,
"SNAPSHOT_ID" CHAR(36) NOT NULL ENABLE
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TASK_PLAYBACK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TASK_PLAYBACK(
"TASK_ID" NUMBER(31,0) NOT NULL ENABLE
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TASK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TASK(
"TASK_ID" NUMBER(31,0) NOT NULL ENABLE,
"FUNCTIONAL_TASK_ID" NUMBER(31,0) NOT NULL ENABLE,
"IS_INSTANCE" NCHAR(1) DEFAULT ' || '''' ||'F' || '''' || ' NOT NULL ENABLE,
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"SYSTEM_USER_ID" NVARCHAR2(64),
"SYSTEM_TASK_ID" NVARCHAR2(64),
"SYSTEM_FUNCTIONAL_TASK_ID" NVARCHAR2(64),
"BPD_NAME" NVARCHAR2(64),
"STARTING_PROCESS_ID" NVARCHAR2(2000),
"STARTING_PROCESS_SNAPSHOT_ID" CHAR(36),
"ACTIVITY_NAME" NVARCHAR2(580),
"CREATED_BY_PROCESS_ITEM_ID" NVARCHAR2(64),
"CREATION_TIME" TIMESTAMP,
"START_TIME" TIMESTAMP,
"END_TIME" TIMESTAMP,
"STATUS" NUMBER(31,0),
"ASSIGNED_GROUP_ID" NVARCHAR2(261),
"SNAPSHOT_ID" CHAR(36),
"PROJECT_ID" CHAR(36),
"MAX_STEP" NUMBER(31,0) DEFAULT ' || '''' ||0 || '''' || '
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TIMING_INTERVAL_VALUE') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TIMING_INTERVAL_VALUE(
"TIMING_INTERVAL_VALUE_ID" NUMBER(31,0) NOT NULL ENABLE,
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"TIMING_INTERVAL_ID" NUMBER(31,0) NOT NULL ENABLE,
"FUNCTIONAL_TASK_ID" NUMBER(31,0) NOT NULL ENABLE,
"START_TASK_ID" NUMBER(31,0) NOT NULL ENABLE,
"START_TRACKING_GROUP_ID" NUMBER(31,0) NOT NULL ENABLE,
"START_TRACKING_POINT_ID" NUMBER(31,0) NOT NULL ENABLE,
"START_TRACKING_POINT_VALUE_ID" NUMBER(31,0) NOT NULL ENABLE,
"START_TIME" TIMESTAMP,
"END_TASK_ID" NUMBER(31,0) NOT NULL ENABLE,
"END_TRACKING_GROUP_ID" NUMBER(31,0) NOT NULL ENABLE,
"END_TRACKING_POINT_ID" NUMBER(31,0) NOT NULL ENABLE,
"END_TRACKING_POINT_VALUE_ID" NUMBER(31,0) NOT NULL ENABLE,
"END_TIME" TIMESTAMP,
"DURATION" NUMBER(16,0) NOT NULL ENABLE
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TRACKING_POINT_VALUE') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TRACKING_POINT_VALUE(
"TRACKING_POINT_VALUE_ID" NUMBER(31,0) NOT NULL ENABLE,
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKING_GROUP_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKING_POINT_ID" NUMBER(31,0) NOT NULL ENABLE,
"TASK_ID" NUMBER(31,0) NOT NULL ENABLE,
"FUNCTIONAL_TASK_ID" NUMBER(31,0) NOT NULL ENABLE,
"TIME_STAMP" TIMESTAMP,
"STEP_NUMBER" NUMBER(31,0),
"SNAPSHOT_ID" CHAR(36)
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_PRI_KEY') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_PRI_KEY(
"TABLE_ID" NVARCHAR2(64) NOT NULL ENABLE,
"HIGH_KEY" NUMBER(31,0) NOT NULL ENABLE
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_LOAD_TRACE') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_LOAD_TRACE(
"LOAD_TRACE_ID" NUMBER(31,0) NOT NULL ENABLE,
"SYNCHRONIZATION_EUID" NVARCHAR2(64) NOT NULL ENABLE,
"LOAD_TYPE" NUMBER(2,0) NOT NULL ENABLE,
"TIME_RECEIVED" TIMESTAMP NOT NULL ENABLE,
"TIME_VALIDATED" TIMESTAMP,
"TIME_LOADED" TIMESTAMP,
"TIME_DELETED" TIMESTAMP,
"TIME_REQUEUED" TIMESTAMP,
"STATUS" NUMBER(2,0) NOT NULL ENABLE
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_VIEW') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_VIEW(
"VIEW_ID" NUMBER(31,0) NOT NULL ENABLE,
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"TABLE_ID" NUMBER(31,0),
"VIEW_TYPE" NUMBER(5,0),
"NAME" NVARCHAR2(100),
"CREATED_DATE" DATE
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_USR_XREF') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_USR_XREF(
"USER_ID" NUMBER(12,0) NOT NULL ENABLE,
"USER_NAME" NVARCHAR2(64) NOT NULL ENABLE,
"PROVIDER" NVARCHAR2(128)
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_DATA_TRANSFER_ERRORS') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_DATA_TRANSFER_ERRORS(
"DATA_TRANSFER_ERRORS_ID" NVARCHAR2(64) NOT NULL ENABLE,
"TIME_CLAIMED" DATE,
"CLAIMED_BY" NVARCHAR2(64),
"REPROCESS" NCHAR(1),
"TIME_OF_ERROR" DATE,
"ERROR" NCLOB,
"DATA" BLOB NOT NULL ENABLE
)
LOB ("ERROR","DATA") STORE AS SECUREFILE';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_OPTIMIZER_DATA') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_OPTIMIZER_DATA(
"TRACKING_POINT_VALUE_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKED_FIELD_ID" NUMBER(31,0) NOT NULL ENABLE,
"NUMBER_VALUE" NUMBER(31,6),
"DATE_VALUE" DATE,
"STRING_VALUE" NVARCHAR2(255)
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_USER_MAPPINGS') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_USER_MAPPINGS(
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"USER_ID" NUMBER(31,0) NOT NULL ENABLE,
"USERNAME" NVARCHAR2(64) NOT NULL ENABLE
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_SYSTEM_SCHEMA') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_SYSTEM_SCHEMA(
"PROPNAME" NVARCHAR2(50) NOT NULL ENABLE,
"PROPVALUE" NVARCHAR2(50)
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_TABLE') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_TABLE(
"TABLE_ID" NUMBER(31,0) NOT NULL ENABLE,
"SYSTEM_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKING_GROUP_NAME" NVARCHAR2(64) NOT NULL ENABLE,
"EXTERNAL_UNIQUE_ID" NVARCHAR2(64),
"ARCHIVED" DATE,
"VERSION" NUMBER(31,0),
"LAST_MODIFIED_BY_USER_ID" NUMBER(31,0),
"LAST_MODIFIED" DATE,
"TABLE_NAME" NVARCHAR2(100),
"REP_STATUS" NUMBER(2,0),
"REP_ACTION" NUMBER(2,0),
"NEW_TABLE_NAME" NVARCHAR2(100),
"NEW_CONSTR_PREFIX" NVARCHAR2(14)
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_COLUMN') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_COLUMN(
"COLUMN_ID" NUMBER(31,0) NOT NULL ENABLE,
"TABLE_ID" NUMBER(31,0) NOT NULL ENABLE,
"TRACKED_FIELD_NAME" NVARCHAR2(64) NOT NULL ENABLE,
"EXTERNAL_UNIQUE_ID" NVARCHAR2(64),
"FIELD_TYPE" NUMBER(2,0) NOT NULL ENABLE,
"ARCHIVED" DATE,
"COLUMN_NAME" NVARCHAR2(100),
"ALLOCATED" DATE,
"NEW_COLUMN_NAME" NVARCHAR2(100),
"NEW_FIELD_TYPE" NUMBER(2,0)
)';
    END IF ;
    END ;
    END ;
    
/


	BEGIN
		DECLARE
		v_table_count NUMBER;
  	BEGIN
    	select count(*) into v_table_count from all_objects where object_type='TABLE' and object_name = UPPER('LSW_SNAPSHOT') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') ) ;    
	    IF (v_table_count = 0) THEN 
	    EXECUTE IMMEDIATE  'CREATE  TABLE pdwdb_owner.LSW_SNAPSHOT(
"SNAPSHOT_ID" CHAR(36) NOT NULL ENABLE,
"NAME" NVARCHAR2(64),
"DESCRIPTION" NCLOB,
"SHORT_NAME" NVARCHAR2(64),
"ARCHIVED" DATE
)
LOB ("DESCRIPTION") STORE AS SECUREFILE';
    END IF ;
    END ;
    END ;
    
/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('WLC_WLSTORE_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.WLC_WLSTORE_PK ON pdwdb_owner.PS_WLSTORE("ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('WLC_WLSTORE_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.PS_WLSTORE ADD CONSTRAINT WLC_WLSTORE_PK
    PRIMARY KEY("ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_SYSTEM_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_SYSTEM_PK ON pdwdb_owner.LSW_SYSTEM("SYSTEM_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_SYSTEM_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_SYSTEM ADD CONSTRAINT LSWC_SYSTEM_PK
    PRIMARY KEY("SYSTEM_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGGRP_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TRCKNGGRP_PK ON pdwdb_owner.LSW_TRACKING_GROUP("TRACKING_GROUP_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TRCKNGGRP_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKING_GROUP ADD CONSTRAINT LSWC_TRCKNGGRP_PK
    PRIMARY KEY("TRACKING_GROUP_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGPNT_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TRCKNGPNT_PK ON pdwdb_owner.LSW_TRACKING_POINT("TRACKING_POINT_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TRCKNGPNT_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKING_POINT ADD CONSTRAINT LSWC_TRCKNGPNT_PK
    PRIMARY KEY("TRACKING_POINT_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKDFELD_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TRCKDFELD_PK ON pdwdb_owner.LSW_TRACKED_FIELD("TRACKED_FIELD_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TRCKDFELD_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKED_FIELD ADD CONSTRAINT LSWC_TRCKDFELD_PK
    PRIMARY KEY("TRACKED_FIELD_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKFLDUS_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TRCKFLDUS_PK ON pdwdb_owner.LSW_TRACKED_FIELD_USE("TRACKED_FIELD_USE_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TRCKFLDUS_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKED_FIELD_USE ADD CONSTRAINT LSWC_TRCKFLDUS_PK
    PRIMARY KEY("TRACKED_FIELD_USE_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTRVL_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TMNGNTRVL_PK ON pdwdb_owner.LSW_TIMING_INTERVAL("TIMING_INTERVAL_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TMNGNTRVL_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TIMING_INTERVAL ADD CONSTRAINT LSWC_TMNGNTRVL_PK
    PRIMARY KEY("TIMING_INTERVAL_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTRVBD_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TMNGNTRVBD_PK ON pdwdb_owner.LSW_TIMING_INTERVAL_BOUND("TIMING_INTERVAL_BOUND_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TMNGNTRVBD_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TIMING_INTERVAL_BOUND ADD CONSTRAINT LSWC_TMNGNTRVBD_PK
    PRIMARY KEY("TIMING_INTERVAL_BOUND_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_PLAYBACK_TASK_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_PLAYBACK_TASK_PK ON pdwdb_owner.LSW_TASK_PLAYBACK("TASK_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_PLAYBACK_TASK_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TASK_PLAYBACK ADD CONSTRAINT LSWC_PLAYBACK_TASK_PK
    PRIMARY KEY("TASK_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TASK_PK ON pdwdb_owner.LSW_TASK("TASK_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TASK_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TASK ADD CONSTRAINT LSWC_TASK_PK
    PRIMARY KEY("TASK_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTRVLL_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TMNGNTRVLL_PK ON pdwdb_owner.LSW_TIMING_INTERVAL_VALUE("TIMING_INTERVAL_VALUE_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TMNGNTRVLL_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TIMING_INTERVAL_VALUE ADD CONSTRAINT LSWC_TMNGNTRVLL_PK
    PRIMARY KEY("TIMING_INTERVAL_VALUE_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGPNTL_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TRCKNGPNTL_PK ON pdwdb_owner.LSW_TRACKING_POINT_VALUE("TRACKING_POINT_VALUE_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TRCKNGPNTL_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKING_POINT_VALUE ADD CONSTRAINT LSWC_TRCKNGPNTL_PK
    PRIMARY KEY("TRACKING_POINT_VALUE_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_PRI_KEY_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_PRI_KEY_PK ON pdwdb_owner.LSW_PRI_KEY("TABLE_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_PRI_KEY_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_PRI_KEY ADD CONSTRAINT LSWC_PRI_KEY_PK
    PRIMARY KEY("TABLE_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_LOADTRACE_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_LOADTRACE_PK ON pdwdb_owner.LSW_LOAD_TRACE("LOAD_TRACE_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_LOADTRACE_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_LOAD_TRACE ADD CONSTRAINT LSWC_LOADTRACE_PK
    PRIMARY KEY("LOAD_TRACE_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_VIEW_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_VIEW_PK ON pdwdb_owner.LSW_VIEW("VIEW_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_VIEW_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_VIEW ADD CONSTRAINT LSWC_VIEW_PK
    PRIMARY KEY("VIEW_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_UXREF_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_UXREF_PK ON pdwdb_owner.LSW_USR_XREF("USER_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_UXREF_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_USR_XREF ADD CONSTRAINT LSWC_UXREF_PK
    PRIMARY KEY("USER_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_DT_ERR_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_DT_ERR_PK ON pdwdb_owner.LSW_DATA_TRANSFER_ERRORS("DATA_TRANSFER_ERRORS_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_DT_ERR_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_DATA_TRANSFER_ERRORS ADD CONSTRAINT LSWC_DT_ERR_PK
    PRIMARY KEY("DATA_TRANSFER_ERRORS_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_OPTDATA_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_OPTDATA_PK ON pdwdb_owner.LSW_OPTIMIZER_DATA("TRACKING_POINT_VALUE_ID","TRACKED_FIELD_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_OPTDATA_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_OPTIMIZER_DATA ADD CONSTRAINT LSWC_OPTDATA_PK
    PRIMARY KEY("TRACKING_POINT_VALUE_ID","TRACKED_FIELD_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_USERMAP_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_USERMAP_PK ON pdwdb_owner.LSW_USER_MAPPINGS("USER_ID","SYSTEM_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_USERMAP_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_USER_MAPPINGS ADD CONSTRAINT LSWC_USERMAP_PK
    PRIMARY KEY("USER_ID","SYSTEM_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_SYSSCHEMA_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_SYSSCHEMA_PK ON pdwdb_owner.LSW_SYSTEM_SCHEMA("PROPNAME")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_SYSSCHEMA_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_SYSTEM_SCHEMA ADD CONSTRAINT LSWC_SYSSCHEMA_PK
    PRIMARY KEY("PROPNAME")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TABLE_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TABLE_PK ON pdwdb_owner.LSW_TABLE("TABLE_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_TABLE_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TABLE ADD CONSTRAINT LSWC_TABLE_PK
    PRIMARY KEY("TABLE_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_COLUMN_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_COLUMN_PK ON pdwdb_owner.LSW_COLUMN("COLUMN_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_COLUMN_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_COLUMN ADD CONSTRAINT LSWC_COLUMN_PK
    PRIMARY KEY("COLUMN_ID")';		 
   	END IF ;
  END ;
END ;        

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_SNAPSHOT_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_SNAPSHOT_PK ON pdwdb_owner.LSW_SNAPSHOT("SNAPSHOT_ID")';		
   	END IF ;
  END ;
END ;      

/



BEGIN
DECLARE
v_table_count NUMBER;       
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name = UPPER('LSWC_SNAPSHOT_PK') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_SNAPSHOT ADD CONSTRAINT LSWC_SNAPSHOT_PK
    PRIMARY KEY("SNAPSHOT_ID")';		 
   	END IF ;
  END ;
END ;        

/



    
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_SYSTEM_UQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_SYSTEM_UQ0 ON pdwdb_owner.LSW_SYSTEM("NAME")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TRCKNGGRP_FK1' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKING_GROUP ADD CONSTRAINT LSWC_TRCKNGGRP_FK1
	FOREIGN KEY("SYSTEM_ID")
	REFERENCES pdwdb_owner.LSW_SYSTEM("SYSTEM_ID")
	';
   	END IF ;
  END ;
END ;	

/

    
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGGRP_UQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TRCKNGGRP_UQ1 ON pdwdb_owner.LSW_TRACKING_GROUP("SYSTEM_ID","EXTERNAL_UNIQUE_ID","SNAPSHOT_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGGRP_NQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKNGGRP_NQ1 ON pdwdb_owner.LSW_TRACKING_GROUP("SYSTEM_ID")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TRCKNGPNT_FK0' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKING_POINT ADD CONSTRAINT LSWC_TRCKNGPNT_FK0
	FOREIGN KEY("TRACKING_GROUP_ID")
	REFERENCES pdwdb_owner.LSW_TRACKING_GROUP("TRACKING_GROUP_ID")
	';
   	END IF ;
  END ;
END ;	

/

    
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGPNT_UQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TRCKNGPNT_UQ1 ON pdwdb_owner.LSW_TRACKING_POINT("SYSTEM_ID","EXTERNAL_UNIQUE_ID","SNAPSHOT_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGPNT_NQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKNGPNT_NQ0 ON pdwdb_owner.LSW_TRACKING_POINT("TRACKING_GROUP_ID")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TRCKDFELD_FK0' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKED_FIELD ADD CONSTRAINT LSWC_TRCKDFELD_FK0
	FOREIGN KEY("TRACKING_GROUP_ID")
	REFERENCES pdwdb_owner.LSW_TRACKING_GROUP("TRACKING_GROUP_ID")
	';
   	END IF ;
  END ;
END ;	

/

    
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKDFELD_UQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TRCKDFELD_UQ0 ON pdwdb_owner.LSW_TRACKED_FIELD("TRACKING_GROUP_ID","EXTERNAL_UNIQUE_ID","SNAPSHOT_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKDFELD_NQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKDFELD_NQ0 ON pdwdb_owner.LSW_TRACKED_FIELD("TRACKING_GROUP_ID")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TRCKFLDUS_FK0' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKED_FIELD_USE ADD CONSTRAINT LSWC_TRCKFLDUS_FK0
	FOREIGN KEY("TRACKED_FIELD_ID")
	REFERENCES pdwdb_owner.LSW_TRACKED_FIELD("TRACKED_FIELD_ID")
	';
   	END IF ;
  END ;
END ;	

/


BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TRCKFLDUS_FK1' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKED_FIELD_USE ADD CONSTRAINT LSWC_TRCKFLDUS_FK1
	FOREIGN KEY("TRACKING_POINT_ID")
	REFERENCES pdwdb_owner.LSW_TRACKING_POINT("TRACKING_POINT_ID")
	';
   	END IF ;
  END ;
END ;	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKFLDUS_NQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKFLDUS_NQ0 ON pdwdb_owner.LSW_TRACKED_FIELD_USE("TRACKED_FIELD_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKFLDUS_NQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKFLDUS_NQ1 ON pdwdb_owner.LSW_TRACKED_FIELD_USE("TRACKING_POINT_ID")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TMNGNTRVL_FK1' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TIMING_INTERVAL ADD CONSTRAINT LSWC_TMNGNTRVL_FK1
	FOREIGN KEY("SYSTEM_ID")
	REFERENCES pdwdb_owner.LSW_SYSTEM("SYSTEM_ID")
	';
   	END IF ;
  END ;
END ;	

/

    
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTRVL_UQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TMNGNTRVL_UQ1 ON pdwdb_owner.LSW_TIMING_INTERVAL("SYSTEM_ID","EXTERNAL_UNIQUE_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTRVL_NQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TMNGNTRVL_NQ1 ON pdwdb_owner.LSW_TIMING_INTERVAL("SYSTEM_ID")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TMNGNTVBD_FK0' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TIMING_INTERVAL_BOUND ADD CONSTRAINT LSWC_TMNGNTVBD_FK0
	FOREIGN KEY("TIMING_INTERVAL_ID")
	REFERENCES pdwdb_owner.LSW_TIMING_INTERVAL("TIMING_INTERVAL_ID")
	';
   	END IF ;
  END ;
END ;	

/


BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TMNGNTVBD_FK1' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TIMING_INTERVAL_BOUND ADD CONSTRAINT LSWC_TMNGNTVBD_FK1
	FOREIGN KEY("TRACKING_POINT_ID")
	REFERENCES pdwdb_owner.LSW_TRACKING_POINT("TRACKING_POINT_ID")
	';
   	END IF ;
  END ;
END ;	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTVBD_NQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TMNGNTVBD_NQ0 ON pdwdb_owner.LSW_TIMING_INTERVAL_BOUND("TIMING_INTERVAL_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTVBD_NQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TMNGNTVBD_NQ1 ON pdwdb_owner.LSW_TIMING_INTERVAL_BOUND("TRACKING_POINT_ID")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_PLAYBACK_TASK_FK' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TASK_PLAYBACK ADD CONSTRAINT LSWC_PLAYBACK_TASK_FK
	FOREIGN KEY("TASK_ID")
	REFERENCES pdwdb_owner.LSW_TASK("TASK_ID")
	ON DELETE CASCADE';
   	END IF ;
  END ;
END ;	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TASK_FK0' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TASK ADD CONSTRAINT LSWC_TASK_FK0
	FOREIGN KEY("SYSTEM_ID")
	REFERENCES pdwdb_owner.LSW_SYSTEM("SYSTEM_ID")
	';
   	END IF ;
  END ;
END ;	

/

    
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_UQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_TASK_UQ0 ON pdwdb_owner.LSW_TASK("SYSTEM_TASK_ID","SYSTEM_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_NQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TASK_NQ0 ON pdwdb_owner.LSW_TASK("SYSTEM_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_NQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TASK_NQ1 ON pdwdb_owner.LSW_TASK("IS_INSTANCE")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_NQ2') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TASK_NQ2 ON pdwdb_owner.LSW_TASK("FUNCTIONAL_TASK_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_NQ3') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TASK_NQ3 ON pdwdb_owner.LSW_TASK("MAX_STEP")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_NQ4') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TASK_NQ4 ON pdwdb_owner.LSW_TASK("CREATION_TIME","TASK_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_NQ5') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TASK_NQ5 ON pdwdb_owner.LSW_TASK("START_TIME","TASK_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_NQ6') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TASK_NQ6 ON pdwdb_owner.LSW_TASK("END_TIME","TASK_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TASK_NQ7') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TASK_NQ7 ON pdwdb_owner.LSW_TASK("SYSTEM_USER_ID")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TMNGNTRLL_FK0' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TIMING_INTERVAL_VALUE ADD CONSTRAINT LSWC_TMNGNTRLL_FK0
	FOREIGN KEY("TIMING_INTERVAL_ID")
	REFERENCES pdwdb_owner.LSW_TIMING_INTERVAL("TIMING_INTERVAL_ID")
	';
   	END IF ;
  END ;
END ;	

/


BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TMNGNTRLL_FK1' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TIMING_INTERVAL_VALUE ADD CONSTRAINT LSWC_TMNGNTRLL_FK1
	FOREIGN KEY("FUNCTIONAL_TASK_ID")
	REFERENCES pdwdb_owner.LSW_TASK("TASK_ID")
	';
   	END IF ;
  END ;
END ;	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTRLL_NQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TMNGNTRLL_NQ0 ON pdwdb_owner.LSW_TIMING_INTERVAL_VALUE("TIMING_INTERVAL_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTRLL_NQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TMNGNTRLL_NQ1 ON pdwdb_owner.LSW_TIMING_INTERVAL_VALUE("FUNCTIONAL_TASK_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TMNGNTRLL_UQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TMNGNTRLL_UQ0 ON pdwdb_owner.LSW_TIMING_INTERVAL_VALUE("TIMING_INTERVAL_ID","START_TRACKING_POINT_VALUE_ID","END_TRACKING_POINT_VALUE_ID")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TRCKNGPTL_FK0' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKING_POINT_VALUE ADD CONSTRAINT LSWC_TRCKNGPTL_FK0
	FOREIGN KEY("TRACKING_POINT_ID")
	REFERENCES pdwdb_owner.LSW_TRACKING_POINT("TRACKING_POINT_ID")
	';
   	END IF ;
  END ;
END ;	

/


BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TRCKNGPTL_FK1' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKING_POINT_VALUE ADD CONSTRAINT LSWC_TRCKNGPTL_FK1
	FOREIGN KEY("TASK_ID")
	REFERENCES pdwdb_owner.LSW_TASK("TASK_ID")
	';
   	END IF ;
  END ;
END ;	

/


BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TRCKNGPTL_FK2' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKING_POINT_VALUE ADD CONSTRAINT LSWC_TRCKNGPTL_FK2
	FOREIGN KEY("FUNCTIONAL_TASK_ID")
	REFERENCES pdwdb_owner.LSW_TASK("TASK_ID")
	';
   	END IF ;
  END ;
END ;	

/


BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_TRCKNGPTL_FK3' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_TRACKING_POINT_VALUE ADD CONSTRAINT LSWC_TRCKNGPTL_FK3
	FOREIGN KEY("TRACKING_GROUP_ID")
	REFERENCES pdwdb_owner.LSW_TRACKING_GROUP("TRACKING_GROUP_ID")
	';
   	END IF ;
  END ;
END ;	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGPTL_NQ0') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKNGPTL_NQ0 ON pdwdb_owner.LSW_TRACKING_POINT_VALUE("TRACKING_POINT_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGPTL_NQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKNGPTL_NQ1 ON pdwdb_owner.LSW_TRACKING_POINT_VALUE("TASK_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGPTL_NQ2') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKNGPTL_NQ2 ON pdwdb_owner.LSW_TRACKING_POINT_VALUE("FUNCTIONAL_TASK_ID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGPTL_NQ3') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKNGPTL_NQ3 ON pdwdb_owner.LSW_TRACKING_POINT_VALUE("TRACKING_GROUP_ID","TRACKING_POINT_ID","TRACKING_POINT_VALUE_ID","TIME_STAMP")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_TRCKNGPTL_NQ4') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_TRCKNGPTL_NQ4 ON pdwdb_owner.LSW_TRACKING_POINT_VALUE("TIME_STAMP","TRACKING_POINT_VALUE_ID")';	
   	END IF ;
  END ;
END ;    	

/



 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_LDTRACE_NUQ') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_LDTRACE_NUQ ON pdwdb_owner.LSW_LOAD_TRACE("SYNCHRONIZATION_EUID")';	
   	END IF ;
  END ;
END ;    	

/

 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_LDTRACE_NUQ1') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_LDTRACE_NUQ1 ON pdwdb_owner.LSW_LOAD_TRACE("LOAD_TRACE_ID","SYNCHRONIZATION_EUID","LOAD_TYPE","TIME_RECEIVED","TIME_VALIDATED","TIME_LOADED","TIME_DELETED","TIME_REQUEUED","STATUS")';	
   	END IF ;
  END ;
END ;    	

/



BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_VIEW_FK1' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_VIEW ADD CONSTRAINT LSWC_VIEW_FK1
	FOREIGN KEY("TABLE_ID")
	REFERENCES pdwdb_owner.LSW_TABLE("TABLE_ID")
	';
   	END IF ;
  END ;
END ;	

/

    
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_VIEW_NAME_UQ') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_VIEW_NAME_UQ ON pdwdb_owner.LSW_VIEW("NAME")';	
   	END IF ;
  END ;
END ;    	

/


    
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_UXREF_UQ') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE UNIQUE INDEX pdwdb_owner.LSWC_UXREF_UQ ON pdwdb_owner.LSW_USR_XREF("USER_NAME","PROVIDER")';	
   	END IF ;
  END ;
END ;    	

/


 
BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_objects where object_type='INDEX' and object_name = UPPER('LSWC_DT_ERR_NUQ') AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );     
    IF (v_table_count = 0) THEN 
    	EXECUTE IMMEDIATE  'CREATE INDEX pdwdb_owner.LSWC_DT_ERR_NUQ ON pdwdb_owner.LSW_DATA_TRANSFER_ERRORS("CLAIMED_BY","REPROCESS")';	
   	END IF ;
  END ;
END ;    	

/







BEGIN
DECLARE
v_table_count NUMBER;
  BEGIN
    select count(*) into v_table_count from all_constraints where constraint_name='LSWC_COLUMN_FK1' AND ( owner='pdwdb_owner' OR owner=UPPER('pdwdb_owner') );
    IF (v_table_count = 0) THEN
      EXECUTE IMMEDIATE  'ALTER TABLE pdwdb_owner.LSW_COLUMN ADD CONSTRAINT LSWC_COLUMN_FK1
	FOREIGN KEY("TABLE_ID")
	REFERENCES pdwdb_owner.LSW_TABLE("TABLE_ID")
	';
   	END IF ;
  END ;
END ;	

/


    
DECLARE
v_table_count NUMBER;
  BEGIN
   SELECT COUNT(*) INTO v_table_count FROM 
    pdwdb_owner.LSW_SYSTEM_SCHEMA WHERE PROPNAME = 'DatabaseSchemaVersion' ; 
     IF (v_table_count = 0) THEN  
      INSERT INTO 
    pdwdb_owner.LSW_SYSTEM_SCHEMA("PROPNAME",
 "PROPVALUE") 
VALUES ('DatabaseSchemaVersion' ,
 '1.3.0') ; 
END IF ;
END ;      

/

    
DECLARE
v_table_count NUMBER;
  BEGIN
   SELECT COUNT(*) INTO v_table_count FROM 
    pdwdb_owner.LSW_SYSTEM_SCHEMA WHERE PROPNAME = 'DatabaseSchemaFormat' ; 
     IF (v_table_count = 0) THEN  
      INSERT INTO 
    pdwdb_owner.LSW_SYSTEM_SCHEMA("PROPNAME",
 "PROPVALUE") 
VALUES ('DatabaseSchemaFormat' ,
 'DatabaseVersionOnly') ; 
END IF ;
END ;      

/


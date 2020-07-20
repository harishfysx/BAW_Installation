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


-- Create tablespaces

CREATE TABLESPACE WFICNTS
    DATAFILE '/u02/orcl151/WFICNTS.dbf' SIZE 200M REUSE
    AUTOEXTEND ON NEXT 20M
    EXTENT MANAGEMENT LOCAL
    SEGMENT SPACE MANAGEMENT AUTO
    ONLINE
    PERMANENT
;

CREATE TEMPORARY TABLESPACE WFICNTSTEMP
    TEMPFILE '/u02/orcl151/WFICNTSTEMP.dbf' SIZE 200M REUSE
    AUTOEXTEND ON NEXT 20M
    EXTENT MANAGEMENT LOCAL
;


-- Alter existing schema

ALTER USER icndb_owner
    DEFAULT TABLESPACE WFICNTS 
    TEMPORARY TABLESPACE WFICNTSTEMP;

GRANT CONNECT, RESOURCE to icndb_owner;
GRANT UNLIMITED TABLESPACE TO icndb_owner;



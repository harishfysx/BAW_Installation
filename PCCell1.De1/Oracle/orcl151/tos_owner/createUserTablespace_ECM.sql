-- BEGIN COPYRIGHT
-- *************************************************************************
--
--  Licensed Materials - Property of IBM
--  5725-C94, 5725-C95, 5725-C96
--  (C) Copyright IBM Corporation 2010, 2018. All Rights Reserved.
--  US Government Users Restricted Rights- Use, duplication or disclosure
--  restricted by GSA ADP Schedule Contract with IBM Corp.
--
-- *************************************************************************
-- END COPYRIGHT

CREATE SMALLFILE TABLESPACE TOSSA_DATA_TS DATAFILE '/u02/orcl151/TOSSA_DATA_TS.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 51200K MAXSIZE 32767M LOGGING EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER tos_owner PROFILE DEFAULT IDENTIFIED BY &1 DEFAULT TABLESPACE TOSSA_DATA_TS TEMPORARY TABLESPACE TEMP ACCOUNT UNLOCK;
GRANT UNLIMITED TABLESPACE TO tos_owner;
GRANT CONNECT TO tos_owner;
GRANT RESOURCE TO tos_owner;
grant create view to tos_owner;
grant execute on dbms_lock to tos_owner;
grant select on pending_trans$ to tos_owner;
grant select on dba_2pc_pending to tos_owner;
grant select on dba_pending_transactions to tos_owner;
grant execute on dbms_xa to tos_owner;

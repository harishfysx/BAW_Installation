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

-- create a new user
CREATE USER cmndb_owner IDENTIFIED BY &1;

-- allow the user to connect to the database
grant connect to cmndb_owner;

-- provide quota on all tablespaces with BPM tables
grant unlimited tablespace to cmndb_owner;

-- grant privileges to create database objects:
grant resource to cmndb_owner;
grant create view to cmndb_owner;

-- grant access rights to resolve lock issues
grant execute on dbms_lock to cmndb_owner;

-- grant access rights to resolve XA related issues:
grant select on pending_trans$ to cmndb_owner;
grant select on dba_2pc_pending to cmndb_owner;
grant select on dba_pending_transactions to cmndb_owner;
-- If using Oracle 10.2.0.3 or lower JDBC driver, un-comment the following statement:
-- grant execute on dbms_system to cmndb_owner; 
-- If not using Oracle 10.2.0.4 or higher JDBC driver, comment the following statement:
grant execute on dbms_xa to cmndb_owner;

CREATE OR REPLACE FUNCTION bpmdb_owner.LSW_CURRENTDATE_GMT RETURN DATE AS

gmtDate DATE;
gmtDateString VARCHAR2(100);

BEGIN

SELECT REPLACE(TO_CHAR(sys.standard.sys_at_time_zone(localtimestamp,'0:00'),'DD-MON-RR HH:MI:SS AM'),'.',':')
INTO gmtDateString
FROM DUAL;

gmtDate := TO_DATE(SUBSTR(gmtDateString, 1, 21), 'DD-MON-RR HH:MI:SS AM');

RETURN(gmtDate);

END;
/

CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_TASK_CLOSE(userId IN NUMBER, taskId IN NUMBER, returnStatus OUT NUMBER) AS

BEGIN

DECLARE

taskUserId NUMBER;
taskGroupId NUMBER;
taskStatus VARCHAR2(2);
taskProcessRef NUMBER;
taskExecutionStatus NUMBER;

flgCanClose CHAR;

BEGIN

returnStatus := -1;

SELECT USER_ID,GROUP_ID,STATUS,START_PROCESS_REF,EXECUTION_STATUS
	   INTO taskUserId,taskGroupId,taskStatus,taskProcessRef,taskExecutionStatus
	   FROM bpmdb_owner.LSW_TASK
	   WHERE TASK_ID = taskId;

/* See if we can close this task */
flgCanClose := 'F';
IF (SUBSTR(taskStatus, 1, 1) <> '3') THEN
  IF (taskProcessRef IS NULL) THEN
    flgCanClose := 'T';
  ELSE
    IF ((taskExecutionStatus = 1) OR (taskExecutionStatus = 4)) THEN
	  flgCanClose := 'T';
	END IF;
  END IF;

  /* See if we own this task */
  IF (userId <> taskUserId) THEN
    flgCanClose := 'F';
    DBMS_OUTPUT.PUT_LINE('Not the owner of task ' || taskId);
  END IF;
END IF;

/* OK, so now close this task */
IF (flgCanClose = 'T') THEN
  UPDATE bpmdb_owner.LSW_TASK SET STATUS = '32', CLOSE_DATETIME = bpmdb_owner.LSW_CURRENTDATE_GMT(), CLOSE_BY = userId, EXECUTION_STATUS = 1
  		 WHERE TASK_ID = taskId;
  returnStatus := 0;
END IF;

EXCEPTION

WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('Invalid TASK_ID ' || taskId || '. No data found');

END;

END;
/

CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_TASK_DELETE(userId IN NUMBER, taskId IN NUMBER, returnStatus OUT NUMBER) AS

BEGIN

DECLARE

taskUserId NUMBER;
taskGroupId NUMBER;
taskStatus VARCHAR2(2);
taskProcessRef NUMBER;
taskExecutionStatus NUMBER;

flgCanDelete CHAR;

BEGIN

returnStatus := -1;

SELECT USER_ID,GROUP_ID,STATUS,START_PROCESS_REF,EXECUTION_STATUS
	   INTO taskUserId,taskGroupId,taskStatus,taskProcessRef,taskExecutionStatus
	   FROM bpmdb_owner.LSW_TASK
	   WHERE TASK_ID = taskId;

/* See if we can delete task */
flgCanDelete := 'F';
IF ((SUBSTR(taskStatus, 1, 1) = '2') OR (SUBSTR(taskStatus, 1, 1) = '3')) THEN
  IF (taskProcessRef IS NULL) THEN
    flgCanDelete := 'T';
  ELSE
    IF ((taskExecutionStatus = 1) OR (taskExecutionStatus = 4)) THEN
	  flgCanDelete := 'T';
	END IF;
  END IF;

  /* See if we own this task */
  IF (userId <> taskUserId) THEN
    flgCanDelete := 'F';
    DBMS_OUTPUT.PUT_LINE('Not the owner of task ' || taskId);
  END IF;
END IF;

/* OK, so now delete this task */
IF (flgCanDelete = 'T') THEN
  IF (SUBSTR(taskStatus, 1, 1) = '2') THEN
    UPDATE bpmdb_owner.LSW_TASK SET STATUS = '92'
  		 WHERE TASK_ID = taskId;
  ELSE
    UPDATE bpmdb_owner.LSW_TASK SET STATUS = '91'
  		 WHERE TASK_ID = taskId;
  END IF;

  returnStatus := 0;
END IF;

EXCEPTION

WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('Invalid TASK_ID ' || taskId || '. No data found');

END;

END;
/


CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_ERASE_TEMP_GROUPS AS

  /* This procedure deletes all temporary groups that are no longer referenced by a task. */

  groupId NUMBER;

  CURSOR groupsToDelete IS
    SELECT DISTINCT G.GROUP_ID FROM bpmdb_owner.LSW_USR_GRP_XREF G WHERE G. GROUP_TYPE = 2 AND NOT EXISTS ( SELECT T.GROUP_ID FROM bpmdb_owner.LSW_TASK T WHERE T.GROUP_ID = G.GROUP_ID UNION ALL SELECT T.GROUP_ID FROM bpmdb_owner.LSW_TASK T WHERE T.GROUP_ID = - G.GROUP_ID );
BEGIN

  OPEN groupsToDelete;

  LOOP

    FETCH groupsToDelete INTO groupId;

    EXIT WHEN groupsToDelete%NOTFOUND;
    
    DELETE FROM bpmdb_owner.LSW_USR_GRP_MEM_XREF WHERE GROUP_ID = groupId;
    DELETE FROM bpmdb_owner.LSW_GRP_GRP_MEM_EXPLODED_XREF WHERE GROUP_ID = groupId OR CONTAINER_GROUP_ID = groupId;
    DELETE FROM bpmdb_owner.LSW_GRP_GRP_MEM_XREF WHERE GROUP_ID = groupId OR CONTAINER_GROUP_ID = groupId;
    DELETE FROM bpmdb_owner.LSW_USR_GRP_XREF WHERE GROUP_ID = groupId;

  END LOOP;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_HOUSE_KEEPING(modeHK IN NUMBER) AS

BEGIN

DECLARE

TYPE typeStatusArray IS VARRAY(5) OF VARCHAR(2);
TYPE typeDeleteId IS TABLE OF NUMBER;

rootTaskId NUMBER;
taskId NUMBER;
taskStatus VARCHAR(2);
CURSOR curRootTask (taskId IN NUMBER) IS SELECT TASK_ID, STATUS FROM bpmdb_owner.LSW_TASK WHERE ORIG_TASK_ID = taskId;
CURSOR curAllRootTasks IS SELECT DISTINCT ORIG_TASK_ID FROM bpmdb_owner.LSW_TASK;
i INTEGER;
statuses typeStatusArray := typeStatusArray();
deleteIds typeDeleteId := typeDeleteId();
flgDelete CHAR(1);
flgStatusExist CHAR(1);

BEGIN

IF (modeHK = 1) THEN

  /* Delete orphaned and DELETED task attachments*/
  DELETE FROM bpmdb_owner.LSW_TASK_FILE WHERE TASK_ID IN (SELECT TASK_ID FROM bpmdb_owner.LSW_TASK WHERE STATUS IN (91,92));
  DELETE FROM bpmdb_owner.LSW_FILE WHERE FILE_ID NOT IN (SELECT FILE_ID FROM bpmdb_owner.LSW_TASK_FILE) OR FILE_ID NOT IN (SELECT FILE_ID FROM bpmdb_owner.LSW_TASK,bpmdb_owner.LSW_TASK_FILE WHERE bpmdb_owner.LSW_TASK.TASK_ID = bpmdb_owner.LSW_TASK_FILE.TASK_ID);
  DELETE FROM bpmdb_owner.LSW_TASK_FILE WHERE FILE_ID NOT IN (SELECT FILE_ID FROM bpmdb_owner.LSW_FILE) OR TASK_ID NOT IN (SELECT bpmdb_owner.LSW_TASK.TASK_ID FROM bpmdb_owner.LSW_TASK,bpmdb_owner.LSW_TASK_FILE WHERE bpmdb_owner.LSW_TASK.TASK_ID = bpmdb_owner.LSW_TASK_FILE.TASK_ID);

  /* Delete orphaned task-scoped temporary groups */
  bpmdb_owner.LSW_ERASE_TEMP_GROUPS();


ELSIF (modeHK > 1) THEN

  /* Define what task statuses we are interested in */
  IF (modeHK >= 2) THEN
    statuses.extend;
    statuses(statuses.count) := '91';
    statuses.extend;
    statuses(statuses.count) := '92';
  END IF;
  IF (modeHK >= 3) THEN
    statuses.extend;
    statuses(statuses.count) := '21';
  END IF;
  IF (modeHK >= 4) THEN
    statuses.extend;
    statuses(statuses.count) := '31';
    statuses.extend;
    statuses(statuses.count) := '32';
  END IF;

  /* Go through each root task id */
  OPEN curAllRootTasks;
  LOOP
    FETCH curAllRootTasks INTO rootTaskId;
    EXIT WHEN curAllRootTasks%NOTFOUND;

	/* Check each task belonging to the current root task group. If ALL tasks in this group belong to
	   the statuses we are interested in, then we can remove these tasks */
	flgDelete := 'T';
	deleteIds.delete;
	OPEN curRootTask (rootTaskId);
	<<lblMainLoop>>
	LOOP
      FETCH curRootTask INTO taskId,taskStatus;
      EXIT WHEN curRootTask%NOTFOUND;
	  
	  flgStatusExist := 'F';
      FOR i IN statuses.FIRST..statuses.LAST LOOP
	  IF (taskStatus = statuses(i)) THEN
	    flgStatusExist := 'T';
	    EXIT;
	  END IF;
      END LOOP;
	  IF (flgStatusExist = 'F') THEN
	    flgDelete := 'F';
	    EXIT lblMainLoop;
	  END IF;

	  /* Save the task ids to delete */
	  deleteIds.extend;
	  deleteIds(deleteIds.count) := taskId;
	END LOOP;
	CLOSE curRootTask;

	IF (flgDelete = 'T') THEN
        FOR i IN deleteIds.FIRST..deleteIds.LAST LOOP
	    DELETE FROM bpmdb_owner.LSW_TASK_NARR WHERE TASK_ID = deleteIds(i);
	    DELETE FROM bpmdb_owner.LSW_TASK_FILE WHERE TASK_ID = deleteIds(i);
	    DELETE FROM bpmdb_owner.LSW_TASK_ADDR WHERE TASK_ID = deleteIds(i);
	    DELETE FROM bpmdb_owner.LSW_TASK_EXECUTION_CONTEXT WHERE TASK_ID = deleteIds(i);
	    DELETE FROM bpmdb_owner.LSW_TASK_IPF_DATA WHERE TASK_ID = deleteIds(i);
	    DELETE FROM bpmdb_owner.LSW_TASK_EXTACT_DATA WHERE TASK_ID = deleteIds(i);
	    DELETE FROM bpmdb_owner.LSW_TASK WHERE TASK_ID = deleteIds(i);
	    DELETE FROM bpmdb_owner.BPM_SHARED_OBJECT
	          WHERE TASK_ID = deleteIds(i)
	            AND BPD_INSTANCE_ID IS NULL
	            AND DEFINITION_VERSION_ID NOT IN (
	                SELECT DISTINCT SHARED_OBJECT_ID
	                  FROM bpmdb_owner.LSW_BPD_INSTANCE_SHARED_USAGE
	                 WHERE SHARED_OBJECT_ID IN (
	                       SELECT DEFINITION_VERSION_ID
	                         FROM bpmdb_owner.BPM_SHARED_OBJECT
	                        WHERE TASK_ID = deleteIds(i)
	                       )
	                );
	    UPDATE bpmdb_owner.BPM_SHARED_OBJECT SET TASK_ID = NULL WHERE TASK_ID = deleteIds(i);
	  END LOOP;
	END IF;
	
  END LOOP;

  CLOSE curAllRootTasks;

  /* Delete all attachment files that are not referenced by any task */
  DELETE FROM bpmdb_owner.LSW_FILE WHERE FILE_ID NOT IN (SELECT FILE_ID FROM bpmdb_owner.LSW_TASK_FILE);

  /* Delete orphaned task-scoped temporary groups */
  bpmdb_owner.LSW_ERASE_TEMP_GROUPS();

END IF;

END;

END;
/

CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_ERASE_TASK_NO_GROUP (taskId IN NUMBER) AS

  /* This procedure deletes a task and its dependent entries. It does NOT delete temporary groups that were created for this task. */

BEGIN

  DELETE FROM bpmdb_owner.LSW_TASK_ADDR WHERE TASK_ID = taskId;

  DELETE FROM bpmdb_owner.LSW_TASK_EXECUTION_CONTEXT WHERE TASK_ID = taskId;

  DELETE FROM bpmdb_owner.LSW_TASK_NARR WHERE TASK_ID = taskId;

  DELETE FROM bpmdb_owner.LSW_TASK_FILE WHERE TASK_ID = taskId;

  DELETE FROM bpmdb_owner.LSW_TASK_IPF_DATA WHERE TASK_ID = taskId;
    
  DELETE FROM bpmdb_owner.LSW_TASK_EXTACT_DATA WHERE TASK_ID = taskId;

  DELETE FROM bpmdb_owner.LSW_TASK WHERE TASK_ID = taskId;

  /* Delete all shared business objects that are only used by the task */
  DELETE FROM bpmdb_owner.BPM_SHARED_OBJECT
        WHERE TASK_ID = taskId
          AND BPD_INSTANCE_ID IS NULL
          AND DEFINITION_VERSION_ID NOT IN (
              SELECT DISTINCT SHARED_OBJECT_ID
                FROM bpmdb_owner.LSW_BPD_INSTANCE_SHARED_USAGE
               WHERE SHARED_OBJECT_ID IN (
                     SELECT DEFINITION_VERSION_ID
                       FROM bpmdb_owner.BPM_SHARED_OBJECT
                      WHERE TASK_ID = taskId
                     )
              );

  /* Set the TASK_ID to null for the remaining shared business objects */
  UPDATE bpmdb_owner.BPM_SHARED_OBJECT SET TASK_ID = NULL WHERE TASK_ID = taskId;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;

END;
/

CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_ERASE_TASK (taskId IN NUMBER) AS

  /* This procedure deletes a task and its dependent entries, including temporary groups that were created for this task. */

BEGIN

  /* Delete the task itself */
  bpmdb_owner.LSW_ERASE_TASK_NO_GROUP(taskId);
  
  /* Cleanup: Delete orphaned task-scoped temporary groups */
  bpmdb_owner.LSW_ERASE_TEMP_GROUPS();
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;

END;
/

CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_ERASE_BPD_INST_NO_GROUP (bpdInstanceId in NUMBER) AS

  /* This procedure deletes a BPD instance and its dependent entries. It does NOT delete temporary groups. */

BEGIN

    DELETE FROM bpmdb_owner.LSW_BPD_INSTANCE_DOC_PROPS WHERE DOC_ID IN (SELECT DOC_ID FROM bpmdb_owner.LSW_BPD_INSTANCE_DOCUMENTS WHERE BPD_INSTANCE_ID = bpdInstanceId);

    DELETE FROM bpmdb_owner.LSW_BPD_INSTANCE_DOCUMENTS WHERE BPD_INSTANCE_ID = bpdInstanceId;

    DELETE FROM bpmdb_owner.LSW_BPD_INSTANCE_VARIABLES WHERE BPD_INSTANCE_ID = bpdInstanceId;
    
    DELETE FROM bpmdb_owner.LSW_BPD_INSTANCE_DATA WHERE BPD_INSTANCE_ID = bpdInstanceId;

    DELETE FROM bpmdb_owner.LSW_BPD_INSTANCE_CORRELATION WHERE BPD_INSTANCE_ID = bpdInstanceId;
    
    DELETE FROM bpmdb_owner.LSW_BPD_INSTANCE_EXT_DATA WHERE BPD_INSTANCE_ID = bpdInstanceId;

    DELETE FROM bpmdb_owner.LSW_BPD_NOTIFICATION WHERE BPD_INSTANCE_ID = bpdInstanceId;
    
    DELETE FROM bpmdb_owner.LSW_RUNTIME_ERROR WHERE BPD_INSTANCE_ID = bpdInstanceId;

    DELETE FROM bpmdb_owner.LSW_BPD_INSTANCE WHERE BPD_INSTANCE_ID = bpdInstanceId;

    DELETE FROM bpmdb_owner.LSW_INST_MSG_INCL WHERE BPD_INSTANCE_ID = bpdInstanceId; 

    DELETE FROM bpmdb_owner.LSW_INST_MSG_EXCL WHERE BPD_INSTANCE_ID = bpdInstanceId;
    
    DELETE FROM bpmdb_owner.LSW_BPD_ACTIVITY_INSTANCE WHERE BPD_INSTANCE_ID = bpdInstanceId;
    
    /* Delete the shared business objects where the owner is the BPD instance or deleted and where no more instance is registered in the usage table */
    DELETE FROM bpmdb_owner.BPM_SHARED_OBJECT
          WHERE TASK_ID IS NULL
            AND (BPD_INSTANCE_ID IS NULL OR BPD_INSTANCE_ID = bpdInstanceId)
            AND (
        		 DEFINITION_VERSION_ID IN (SELECT SHARED_OBJECT_ID FROM bpmdb_owner.LSW_BPD_INSTANCE_SHARED_USAGE WHERE BPD_INSTANCE_ID = bpdInstanceId)
              OR DEFINITION_VERSION_ID IN (SELECT DEFINITION_VERSION_ID FROM bpmdb_owner.BPM_SHARED_OBJECT WHERE BPD_INSTANCE_ID = bpdInstanceId)
                )
            AND DEFINITION_VERSION_ID NOT IN (
                SELECT DISTINCT SHARED_OBJECT_ID
                  FROM (SELECT SHARED_OBJECT_ID AS SHARED_OBJECT_ID, BPD_INSTANCE_ID AS BPD_INSTANCE_ID
                          FROM bpmdb_owner.LSW_BPD_INSTANCE_SHARED_USAGE
                         WHERE SHARED_OBJECT_ID IN (SELECT SHARED_OBJECT_ID FROM bpmdb_owner.LSW_BPD_INSTANCE_SHARED_USAGE WHERE BPD_INSTANCE_ID = bpdInstanceId)
                            OR SHARED_OBJECT_ID IN (SELECT DEFINITION_VERSION_ID FROM bpmdb_owner.BPM_SHARED_OBJECT WHERE BPD_INSTANCE_ID = bpdInstanceId)
                       )
                 WHERE BPD_INSTANCE_ID <> bpdInstanceId
                );

    /* Remove owner relationship */
    UPDATE bpmdb_owner.BPM_SHARED_OBJECT SET BPD_INSTANCE_ID = NULL WHERE BPD_INSTANCE_ID = bpdInstanceId;

    /* Delete the entries from the relationship table */
    DELETE FROM bpmdb_owner.LSW_BPD_INSTANCE_SHARED_USAGE WHERE BPD_INSTANCE_ID = bpdInstanceId;

    /* Delete the entries from the ECM objects table */
    DELETE FROM bpmdb_owner.BPM_ECM_OBJECT WHERE BPD_INSTANCE_ID = bpdInstanceId;

    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;

END;
/

CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_ERASE_BPD_INSTANCE (bpdInstanceId in NUMBER) AS

  /* This procedure deletes a BPD instance and its dependent entries, including temporary groups. */

BEGIN

    bpmdb_owner.LSW_ERASE_BPD_INST_NO_GROUP(bpdInstanceId);
    
    bpmdb_owner.LSW_ERASE_TEMP_GROUPS();
    
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;

END;
/

CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_BPD_INST_DELETE_NO_GROUP (bpdInstanceId IN NUMBER) AS

  /* This procedure deletes a BPD instance and its dependent entries, as well as tasks that are part of this instance. It does NOT delete temporary groups. */

  taskId NUMBER;

  CURSOR tasksToDelete (bpdInstanceId IN NUMBER) IS
    SELECT TASK_ID
    FROM bpmdb_owner.LSW_TASK
    WHERE BPD_INSTANCE_ID = bpdInstanceId;

BEGIN

  OPEN tasksToDelete(bpdInstanceId);

  LOOP

    FETCH tasksToDelete INTO taskId;

    EXIT WHEN tasksToDelete%NOTFOUND;

    bpmdb_owner.LSW_ERASE_TASK_NO_GROUP(taskId);

  END LOOP;

  bpmdb_owner.LSW_ERASE_BPD_INST_NO_GROUP(bpdInstanceId);

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE bpmdb_owner.LSW_BPD_INSTANCE_DELETE (bpdInstanceId IN NUMBER) AS

  /* This procedure deletes a BPD instance and its dependent entries, as well as tasks that are part of this instance and temporary groups. */

BEGIN

  /* Delete the BPD instance itself */
  bpmdb_owner.LSW_BPD_INST_DELETE_NO_GROUP(bpdInstanceId);
    
  /* Cleanup: Delete orphaned task-scoped temporary groups */
  bpmdb_owner.LSW_ERASE_TEMP_GROUPS();

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
END;

/

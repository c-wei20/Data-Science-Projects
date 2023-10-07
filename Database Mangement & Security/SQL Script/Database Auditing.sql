-- SERVER AUDITING
-- Login/Logout Audit ----------------------------------
USE master;
GO

CREATE SERVER AUDIT LoginLogout_Audit TO FILE (FILEPATH = 'C:\Temp')
GO
-- Enable the server audit.
ALTER SERVER AUDIT LoginLogout_Audit WITH (STATE=ON);
Go

--Create Audit Specification
CREATE SERVER AUDIT SPECIFICATION [LoginLogout_Audit_Specification]
FOR SERVER AUDIT [LoginLogout_Audit]
ADD (SUCCESSFUL_LOGIN_GROUP),
ADD (LOGOUT_GROUP)
WITH (STATE=ON)
Go

--Reading The Audit File
DECLARE @AuditFilePath VARCHAR(8000)
Select @AuditFilePath = audit_file_path
From sys.dm_server_audit_status
where name='LoginLogout_Audit'
select action_id, event_time, server_principal_name, server_instance_name, 
	connection_id, statement, host_name
from sys.fn_get_audit_file (@AuditFilePath, default, default)


--ALTER SERVER AUDIT LoginLogout_Audit
--WITH (STATE = OFF);
--DROP SERVER AUDIT LoginLogout_Audit

--ALTER SERVER AUDIT SPECIFICATION LoginLogout_Audit_Specification
--WITH (STATE = OFF);
--DROP SERVER AUDIT SPECIFICATION LoginLogout_Audit_Specification


-- Database Structure Audit ------------------------------------
USE master;
GO

CREATE SERVER AUDIT DatabaseStructure_Audit TO FILE(FILEPATH = 'C:\Temp');
GO
-- Enable the server audit.
ALTER SERVER AUDIT DatabaseStructure_Audit WITH (STATE=ON);
Go

--Create Audit Specification
CREATE SERVER AUDIT SPECIFICATION [DatabaseStructure_Audit_Specification]
FOR SERVER AUDIT [DatabaseStructure_Audit]
ADD (DATABASE_CHANGE_GROUP),
ADD (DATABASE_OBJECT_CHANGE_GROUP),
ADD (DATABASE_PRINCIPAL_CHANGE_GROUP),
ADD (DATABASE_ROLE_MEMBER_CHANGE_GROUP),
ADD (SCHEMA_OBJECT_CHANGE_GROUP)
WITH (STATE=ON)
Go

--Reading The Audit File
DECLARE @AuditFilePath VARCHAR(8000)
Select @AuditFilePath = audit_file_path
From sys.dm_server_audit_status
where name='DatabaseStructure_Audit'
select action_id, event_time, server_principal_name, database_name, database_principal_name,
object_name, statement
from sys.fn_get_audit_file (@AuditFilePath, default, default)


--ALTER SERVER AUDIT DatabaseStructure_Audit
--WITH (STATE = OFF);
--DROP SERVER AUDIT DatabaseStructure_Audit

--ALTER SERVER AUDIT SPECIFICATION DatabaseStructure_Audit_Specification
--WITH (STATE = OFF);
--DROP SERVER AUDIT SPECIFICATION DatabaseStructure_Audit_Specification


--Auditing DML activities -------------------------------
USE master;
GO

CREATE SERVER AUDIT AllTables_DML TO FILE(FILEPATH = 'C:\Temp');
GO
ALTER SERVER AUDIT AllTables_DML WITH (STATE=ON);
Go
--Enable the server audit.
USE [DBS_ASSIGNMENT]
CREATE DATABASE AUDIT SPECIFICATION AllTables_DML_Specifications
FOR SERVER AUDIT AllTables_DML
ADD (INSERT, UPDATE, DELETE, SELECT
ON DATABASE::[DBS_ASSIGNMENT] BY public)
WITH (STATE=ON);
GO

--to read back the audit data
DECLARE @AuditFilePath VARCHAR(8000);

Select @AuditFilePath = audit_file_path
From sys.dm_server_audit_status
where name = 'AllTables_DML'

select action_id, event_time, server_principal_name, database_name, 
database_principal_name, object_name, statement
from sys.fn_get_audit_file(@AuditFilePath,default,default)
Where database_name = 'DBS_ASSIGNMENT'


--ALTER SERVER AUDIT AllTables_DML
--WITH (STATE = OFF);
--DROP SERVER AUDIT AllTables_DML

--USE DBS_ASSIGNMENT
--ALTER DATABASE AUDIT SPECIFICATION AllTables_DML_Specifications
--WITH (STATE = OFF);
--DROP DATABASE AUDIT SPECIFICATION AllTables_DML_Specifications



-- User Permission Changes ----------------------------------------------
USE master;
GO

CREATE SERVER AUDIT UserPermission_Audit TO FILE(FILEPATH = 'C:\Temp');
GO
-- Enable the server audit.
ALTER SERVER AUDIT UserPermission_Audit WITH (STATE=ON);
Go

--Create Audit Specification
CREATE SERVER AUDIT SPECIFICATION [UserPermission_Audit_Specification]
FOR SERVER AUDIT [UserPermission_Audit]
ADD (DATABASE_PERMISSION_CHANGE_GROUP),
ADD (DATABASE_OBJECT_PERMISSION_CHANGE_GROUP),
ADD (SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP)
WITH (STATE=ON)
Go

--Reading The Audit File
DECLARE @AuditFilePath VARCHAR(8000)
Select @AuditFilePath = audit_file_path
From sys.dm_server_audit_status
where name='UserPermission_Audit'
select action_id, event_time, server_principal_name, database_name, database_principal_name, 
	target_database_principal_name, object_name, statement
from sys.fn_get_audit_file (@AuditFilePath, default, default)


--ALTER SERVER AUDIT UserPermission_Audit
--WITH (STATE = OFF);
--DROP SERVER AUDIT UserPermission_Audit

--ALTER SERVER AUDIT SPECIFICATION UserPermission_Audit_Specification
--WITH (STATE = OFF);
--DROP SERVER AUDIT SPECIFICATION UserPermission_Audit_Specification

USE DBS_ASSIGNMENT;
GO

-- Member Detials View for MEMBERS role
CREATE OR ALTER VIEW dbo.[DECRYPTED_MEMBER] AS
SELECT  m.member_id,
        m.login_id,
        m.member_role,
        CONVERT(varchar, DECRYPTBYKEYAUTOCERT(CERT_ID('Cert1'), NULL, m.national_reg_id_passport)) AS national_reg_id_passport,
        m.first_name,
        m.last_name,
        m.phone_number,
        m.street,
        m.postcode,
        m.city,
        m.state,
        m.status
FROM dbo.MEMBER m
GO

--SELECT * FROM [DECRYPTED_MEMBER]
--GO

CREATE SCHEMA SECURITY;
GO

CREATE OR ALTER FUNCTION Security.fn_user_view
(@UserName AS nvarchar(100))
RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS user_view_result
        WHERE (@UserName = (SELECT member_id FROM dbo.MEMBER WHERE login_id = USER_NAME()) AND IS_MEMBER('MEMBERS') = 1)
        OR IS_MEMBER('STORE CLERKS') = 1
		OR IS_MEMBER('DATABASE ADMINS') = 1
		OR IS_MEMBER('MANAGEMENT') = 1
        OR USER_NAME() = 'dbo';
GO

CREATE OR ALTER FUNCTION Security.fn_purchase_view
(@transacion_id AS int)
RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS user_view_result
        WHERE (
        @transacion_id IN (
		        SELECT t.transaction_id
		        FROM dbo.[TRANSACTION] t
		        JOIN dbo.MEMBER m ON t.member_id = m.member_id
		        WHERE m.login_id = USER_NAME()
		    )
		    AND IS_MEMBER('MEMBERS') = 1
		)
		OR IS_MEMBER('STORE CLERKS') = 1
		OR IS_MEMBER('DATABASE ADMINS') = 1
		OR IS_MEMBER('MANAGEMENT') = 1
		OR USER_NAME() = 'dbo';
GO

CREATE SECURITY POLICY [UserRecordsPolicy]
ADD FILTER PREDICATE [SECURITY].[fn_user_view](member_id) ON [dbo].MEMBER, --filter view
ADD BLOCK PREDICATE [SECURITY].[fn_user_view](member_id) ON [dbo].MEMBER --block modifications (including inserts)

CREATE SECURITY POLICY [TransactionRecordsPolicy]
ADD FILTER PREDICATE [SECURITY].[fn_user_view](member_id) ON [dbo].[TRANSACTION],
ADD BLOCK PREDICATE [SECURITY].[fn_user_view](member_id) ON [dbo].[TRANSACTION]

CREATE SECURITY POLICY [PurchasedItemRecordsPolicy]
ADD FILTER PREDICATE [SECURITY].fn_purchase_view(transaction_id) ON [dbo].PURCHASED_ITEM,
ADD BLOCK PREDICATE [SECURITY].fn_purchase_view(transaction_id) ON [dbo].PURCHASED_ITEM

--DROP SECURITY POLICY [UserRecordsPolicy]
--DROP SECURITY POLICY [TransactionRecordsPolicy]
--DROP SECURITY POLICY [PurchasedItemRecordsPolicy]

-- Grant permission to access symmetric key and certificate to all roles available
GRANT CONTROL ON SYMMETRIC KEY::SimKey1 TO [MEMBERS], [STORE CLERKS], [DATABASE ADMINS];
GRANT CONTROL ON CERTIFICATE::Cert1 TO [MEMBERS], [STORE CLERKS], [DATABASE ADMINS];
GO

--Member View for Store Clerks & Management
CREATE OR ALTER View [dbo].[MEMBER_DETAILS_SC_MGT]
AS
SELECT
    [member_id],
    [login_id],
    [member_role],
    [first_name],
    [last_name],
    [phone_number],
    [street],
    [postcode],
    [city],
    [state],
    [status]
FROM [MEMBER]
WHERE [member_role] = 'MEMBERS'
GO


--TDE-------------------------------------------------------------
Use master
go
create master key encryption by password = 'QwErTy12345!@#$%'
go
select * from sys.symmetric_keys
go
Create Certificate CertMasterDB
With Subject = 'CertmasterDB'
go

--go to the actual db that you want to encrypt
USE DBS_ASSIGNMENT
go
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_128
ENCRYPTION BY SERVER CERTIFICATE CertMasterDB;
go
ALTER DATABASE DBS_ASSIGNMENT
SET ENCRYPTION ON;

--check database encryption status
Use master
select b.name as DBS_ASSIGNMENT, a.encryption_state_desc, a.key_algorithm,
a.encryptor_type
from sys.dm_database_encryption_keys a
inner join sys.databases b on a.database_id = b.database_id
where b.name = 'DBS_ASSIGNMENT'



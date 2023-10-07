use DBS_ASSIGNMENT
go
create master key encryption by password = 'QwErTy12345!@#$%'
go
select * from sys.symmetric_keys
go

Create Certificate Cert1 With Subject = 'Cert1'
go

CREATE SYMMETRIC KEY SimKey1
WITH ALGORITHM = AES_256  
ENCRYPTION BY CERTIFICATE Cert1
GO

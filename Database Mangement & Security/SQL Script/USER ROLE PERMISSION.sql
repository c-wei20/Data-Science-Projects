USE DBS_ASSIGNMENT

----GRANT MEMBER permission-----------------------------------------
-- Grant permissions on the TRANSACTION table
GRANT SELECT, INSERT, DELETE ON dbo.[TRANSACTION] TO MEMBERS;
-- Grant permissions on the PURCHASED_ITEM table
GRANT SELECT, INSERT, DELETE ON dbo.PURCHASED_ITEM TO MEMBERS;
-- Grant SELECT permissions on the DECRYPTED_MEMBER view
GRANT SELECT ON dbo.DECRYPTED_MEMBER TO MEMBERS;
-- Grant SELECT permissions on the AVAILABLE EQUIPMENT view
GRANT SELECT ON dbo.AVAILABLE_EQUIPMENT TO MEMBERS;
-- Grant SELECT permissions on the ORDER VIEW view
GRANT SELECT ON dbo.ORDERS_VIEW TO MEMBERS;
-- Grant SELECT permissions on the ORDERS_DETAILS view
GRANT SELECT ON dbo.ORDERS_DETAILS TO MEMBERS;
--Cannot modify member_id, login_id, role, status
GRANT UPDATE ON dbo.MEMBER (national_reg_id_passport, first_name, last_name, 
	phone_number, street, postcode, city, state) TO MEMBERS
GRANT UPDATE ON dbo.PURCHASED_ITEM (quantity_purchased) TO MEMBERS



-- Store Clerks -----------------------------------------
-- Table permission
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.EQUIPMENT TO [STORE CLERKS];
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.CATEGORY TO [STORE CLERKS];
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.DISCOUNT TO [STORE CLERKS];
--View Permission
-- Grant SELECT permission on views
GRANT SELECT ON dbo.AVAILABLE_EQUIPMENT TO [STORE CLERKS];
GRANT SELECT ON dbo.ORDERS_VIEW TO [STORE CLERKS];
GRANT SELECT ON dbo.ORDERS_DETAILS TO [STORE CLERKS];
GRANT SELECT ON dbo.MEMBER_DETAILS_SC_MGT TO [STORE CLERKS];
-- Column level permission
GRANT INSERT, UPDATE (first_name, last_name, phone_number, 
street, postcode, city, state, status) ON dbo.MEMBER TO [STORE CLERKS];
GRANT SELECT ON dbo.MEMBER(member_id) TO [STORE CLERKS];


-- GRANT DBA permission-----------------------------------------
-- Grant database permissions to [DATABASE ADMINS] role
GRANT ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::DBS_ASSIGNMENT TO [DATABASE ADMINS];

DENY SELECT, UPDATE ON dbo.MEMBER(national_reg_id_passport) TO [DATABASE ADMINS];
DENY SELECT ON dbo.[DECRYPTED_MEMBER](national_reg_id_passport) TO [DATABASE ADMINS]; --View



----GRANT MANAGEMENT  permission-----------------------------------------
-- Grant SELECT permission on tables
GRANT SELECT ON dbo.CATEGORY TO [MANAGEMENT];
GRANT SELECT ON dbo.DISCOUNT TO [MANAGEMENT];
GRANT SELECT ON dbo.EQUIPMENT TO [MANAGEMENT];
GRANT SELECT ON dbo.PURCHASED_ITEM TO [MANAGEMENT];
GRANT SELECT ON dbo.[TRANSACTION] TO [MANAGEMENT];

-- Grant SELECT permission on views
GRANT SELECT ON dbo.AVAILABLE_EQUIPMENT TO [MANAGEMENT];
GRANT SELECT ON dbo.ORDERS_VIEW TO [MANAGEMENT];
GRANT SELECT ON dbo.ORDERS_DETAILS TO [MANAGEMENT];
GRANT SELECT ON dbo.MEMBER_DETAILS_SC_MGT TO [MANAGEMENT];

-- Grant SELECT permission on columns in the table "Member"
GRANT SELECT (member_id, login_id, member_role, first_name, last_name, phone_number, 
street, postcode, city, state, status) ON dbo.Member TO [MANAGEMENT];


--REVERT
--SELECT USER_NAME()
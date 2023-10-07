CREATE DATABASE DBS_ASSIGNMENT

USE DBS_ASSIGNMENT
CREATE TABLE MEMBER
(
	member_id Char(6) PRIMARY KEY NOT NULL,
	login_id Varchar(20) UNIQUE NOT NULL,
	member_role Varchar(20) DEFAULT 'MEMBERS' NOT NULL,
	national_reg_id_passport Varbinary(MAX),
	first_name Varchar(40) NOT NULL,
	last_name Varchar(40) NOT NULL,
	phone_number Varchar(15) NOT NULL,
	street Varchar(30),
	postcode Char(5),
	city Varchar(20),
	[state] Varchar(20),
	[status] Varchar(10) DEFAULT 'ACTIVE' NOT NULL,
	CONSTRAINT CheckStatus CHECK ([status] = 'ACTIVE' OR [status] = 'EXPIRED'),
	CONSTRAINT CheckRole CHECK (member_role IN ('MEMBERS', 'STORE CLERKS', 'DATABASE ADMINS', 'MANAGEMENT'))
)

CREATE TABLE CATEGORY
(
	category_id Char(4) PRIMARY KEY NOT NULL,
	category_name Varchar(20) NOT NULL,
)

CREATE TABLE DISCOUNT
(
	discount_id Char(4) PRIMARY KEY NOT NULL,
	category_id Char(4) NOT NULL,
	[start_date] Date DEFAULT GETDATE() NOT NULL,
	[end_date] Date,
	discount_rate Numeric(4,2) DEFAULT 0 NOT NULL,
	CONSTRAINT CheckDiscount CHECK (discount_rate >= 0 AND discount_rate <= 1),
	FOREIGN KEY (category_id) REFERENCES CATEGORY(category_id)	
)

CREATE TABLE EQUIPMENT
(
	equipment_id Char(4) PRIMARY KEY NOT NULL,
	category_id Char(4) NOT NULL,
	equipment_name Varchar(100) NOT NULL,
	price_per_unit Decimal DEFAULT 0 NOT NULL,
	quantity_in_stock Int DEFAULT 0 NOT NULL,
	country Varchar(15) NOT NULL,
	tax_rate Numeric(4,2) DEFAULT 0 NOT NULL,
	CONSTRAINT CheckPrice CHECK (price_per_unit > 0),
	CONSTRAINT CheckQuantity CHECK (quantity_in_stock >= 0),
	CONSTRAINT CheckTax CHECK (tax_rate = 0 OR tax_rate = 0.1),
	FOREIGN KEY (category_id) REFERENCES CATEGORY(category_id)
)

CREATE TABLE [TRANSACTION]
(
	transaction_id Int IDENTITY PRIMARY KEY NOT NULL,
	member_id Char(6) NOT NULL,
	transaction_date Date DEFAULT GETDATE() NOT NULL,
	CONSTRAINT CheckDate CHECK (transaction_date <= GETDATE()),
	FOREIGN KEY (member_id) REFERENCES MEMBER(member_id)
)


CREATE TABLE PURCHASED_ITEM
(
	pur_item_id Int  IDENTITY PRIMARY KEY NOT NULL,
	transaction_id Int NOT NULL,
	equipment_id Char(4) NOT NULL,
	quantity_purchased Int DEFAULT 1 NOT NULL,
	CONSTRAINT CheckQuantityPurchased CHECK (quantity_purchased > 0),
	FOREIGN KEY (transaction_id) REFERENCES [TRANSACTION](transaction_id),
	FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT(equipment_id)
)

--create_member_user_role-----------
CREATE ROLE [MEMBERS]
CREATE ROLE [STORE CLERKS];
CREATE ROLE [DATABASE ADMINS];
CREATE ROLE [MANAGEMENT];

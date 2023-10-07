-- Purchansed Item Triggers ------------------------------------------------------------
--before purchased check quantity in stock
CREATE OR ALTER TRIGGER dbo.Purchased_Item_InsteadOfInsert
ON PURCHASED_ITEM
INSTEAD OF
INSERT
AS
Begin
Declare @equipmentname varchar(100), @quantity_in_stock int, @quantity_purchase int, 
	@equipmentid char(4), @transactionid int, @member_status Varchar(10)
-- Create a cursor to process each row in the Inserted table
    DECLARE Cursor_Inserted_Rows CURSOR FOR
    SELECT i.transaction_id, i.equipment_id, i.quantity_purchased, m.[status]
    FROM Inserted i
	JOIN [TRANSACTION] t ON t.transaction_id = i.transaction_id
	JOIN [MEMBER] m ON m.member_id = t.member_id;

    -- Open the cursor
    OPEN Cursor_Inserted_Rows;

    -- Fetch the first row from the cursor
    FETCH NEXT FROM Cursor_Inserted_Rows INTO @transactionid, @equipmentid, @quantity_purchase, @member_status;

	-- Loop through each row in the Deleted table
    WHILE @@FETCH_STATUS = 0
    BEGIN
        Select @equipmentname = equipment_name, @quantity_in_stock = quantity_in_stock
		From EQUIPMENT
		Where equipment_id = @equipmentid

		If @member_status = 'EXPIRED'
		Begin
			Print 'Your Account is expired, please reactive your account to purchase item(s).'
		End
		Else If @quantity_in_stock > @quantity_purchase

		Begin
			INSERT INTO [dbo].[PURCHASED_ITEM]([transaction_id], [equipment_id], [quantity_purchased])
			VALUES (@transactionid, @equipmentid, @quantity_purchase)

			UPDATE EQUIPMENT
			SET quantity_in_stock = quantity_in_stock - @quantity_purchase
			WHERE equipment_id = @equipmentid
		End
		Else
		Begin
			Print 'Not enough stock for this equipment: ' + @equipmentname + '. Unsuccessful to purchased'
		End

        -- Fetch the next row from the cursor
        FETCH NEXT FROM Cursor_Inserted_Rows INTO @transactionid, @equipmentid, @quantity_purchase, @member_status;
    END;

    -- Close and deallocate the cursor
    CLOSE Cursor_Inserted_Rows;
    DEALLOCATE Cursor_Inserted_Rows;
End
Go


--before return check returnable
CREATE OR ALTER TRIGGER dbo.Purchased_Item_InsteadOfDelete
ON PURCHASED_ITEM
INSTEAD OF 
DELETE
AS
BEGIN
    DECLARE @transactionid INT, @itemid INT, @equipmentid char(4), @quantity int, @transactiondate DATE, 
			@member_status Varchar(10);

    -- Create a cursor to process each row in the Deleted table
    DECLARE Cursor_DeletedRows CURSOR FOR
    SELECT d.transaction_id, d.pur_item_id, d.equipment_id, d.quantity_purchased, m.[status]
    FROM Deleted d
	JOIN [TRANSACTION] t ON t.transaction_id = d.transaction_id
	JOIN [MEMBER] m ON m.member_id = t.member_id;

    -- Open the cursor
    OPEN Cursor_DeletedRows;

    -- Fetch the first row from the cursor
    FETCH NEXT FROM Cursor_DeletedRows INTO @transactionid, @itemid, @equipmentid, @quantity, @member_status;

    -- Loop through each row in the Deleted table
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @transactiondate = transaction_date
        FROM [TRANSACTION]
        WHERE transaction_id = @transactionid;

		IF @member_status = 'EXPIRED'
		BEGIN
			Print 'Your Account is expired, please reactive your account.'
		END
        ELSE IF DATEDIFF(DAY, GETDATE(), @transactiondate) >= -3
        BEGIN
            DELETE FROM [dbo].[PURCHASED_ITEM]
            WHERE transaction_id = @transactionid AND pur_item_id = @itemid;

			UPDATE EQUIPMENT
			SET quantity_in_stock = quantity_in_stock + @quantity
			WHERE equipment_id = @equipmentid
        END
        ELSE
        BEGIN
            PRINT 'The transaction with ID ' + CONVERT(VARCHAR(10), @transactionid) + 
                  ' was made more than 3 days. Return Permission Rejected';
        END;

        -- Fetch the next row from the cursor
        FETCH NEXT FROM Cursor_DeletedRows INTO @transactionid, @itemid, @member_status;
    END;

    -- Close and deallocate the cursor
    CLOSE Cursor_DeletedRows;
    DEALLOCATE Cursor_DeletedRows;
END;
GO

-- update purchased item quantity trigger for transaction made in current date
CREATE OR ALTER TRIGGER dbo.Purchased_Item_Quantity_Update
ON PURCHASED_ITEM
INSTEAD OF UPDATE AS
Begin
Declare @pur_item_id int, @quantity int, @update_quantity int, @equipmentid char(4), @transactiondate DATE, 
		@quantity_stock int, @member_status Varchar(10);
Select @pur_item_id = p.pur_item_id, @equipmentid = p.equipment_id, @quantity = p.quantity_purchased, 
	   @update_quantity = i.quantity_purchased, @transactiondate = t.transaction_date, 
	   @quantity_stock = e.quantity_in_stock, @member_status = m.[status]
From PURCHASED_ITEM p
INNER JOIN inserted i ON p.pur_item_id = i.pur_item_id
INNER JOIN [TRANSACTION] t ON p.transaction_id = t.transaction_id
INNER JOIN EQUIPMENT e ON e.equipment_id = p.equipment_id
INNER JOIN [MEMBER] m ON m.member_id = t.member_id;

IF @member_status = 'EXPIRED'
BEGIN
	Print 'Your Account is expired, please reactive your account.'
END
ELSE IF (@transactiondate = CAST(GETDATE() AS DATE)) AND (@update_quantity - @quantity) > 0
BEGIN
	IF (@quantity_stock >= (@update_quantity - @quantity))
		BEGIN
			Update EQUIPMENT
			Set quantity_in_stock = quantity_in_stock - (@update_quantity - @quantity)
			Where equipment_id = @equipmentid
			Update PURCHASED_ITEM
			Set quantity_purchased = @update_quantity
			Where pur_item_id = @pur_item_id
		END
	ELSE
		BEGIN
			PRINT 'This purchased item has not enough stock for update. Update Quantity Permission Rejected';
		END
END
ELSE IF DATEDIFF(DAY, GETDATE(), @transactiondate) >= -3
BEGIN
	Update EQUIPMENT
	Set quantity_in_stock = quantity_in_stock + (@update_quantity - @quantity)
	Where equipment_id = @equipmentid
	Update PURCHASED_ITEM
	Set quantity_purchased = @update_quantity
	Where pur_item_id = @pur_item_id
END
ELSE
BEGIN
	PRINT 'This purchased item is not purchased today at ' + CAST(CAST(GETDATE() AS DATE) AS VARCHAR(10)) + ' for add more quantity 
			or this is purchased item is purchased more than 3 days and is not returnable. Update Quantity Permission Rejected';
END
End
Go


--before return check returnable
CREATE OR ALTER TRIGGER dbo.Transaction_InsteadOfDelete
ON [TRANSACTION]
INSTEAD OF
DELETE
AS
Begin
Declare @transactionid int, @transactiondate date, @member_status Varchar(10)
Select @transactionid = d.transaction_id, @transactiondate = d.transaction_date, @member_status = m.[status]
From Deleted d
JOIN [TRANSACTION] t ON t.transaction_id = d.transaction_id
JOIN [MEMBER] m ON m.member_id = t.member_id

If @member_status = 'EXPIRED'
Begin
	Print 'Your Account is expired, please reactive your account.'
End
Else If DATEDIFF(day, GETDATE(), @transactiondate) >= -3
Begin
	--Delete all the purchased item of that transaction
	DELETE FROM [dbo].PURCHASED_ITEM
	WHERE transaction_id = @transactionid
	--Delete the transaction of that transaction
	DELETE FROM [dbo].[TRANSACTION]
	WHERE transaction_id = @transactionid
End
Else
Begin
	Print 'The transaction was made more than 3 days. Return Permission Rejected'
End
End
Go

-- Member insert trigger -------------------------------------
CREATE OR ALTER TRIGGER dbo.create_user_role_trigger
ON MEMBER
AFTER INSERT
AS
BEGIN
  DECLARE @new_username VARCHAR(255);
  DECLARE @sql NVARCHAR(MAX);
  DECLARE @new_password NVARCHAR(255);
  DECLARE @role VARCHAR(20);

  -- Cursor to process each row in the "inserted" table
  DECLARE cursor_member CURSOR FOR
  SELECT login_id, member_role FROM inserted;

  OPEN cursor_member;
  FETCH NEXT FROM cursor_member INTO @new_username, @role;

  WHILE @@FETCH_STATUS = 0
  BEGIN
	IF(USER_NAME() = 'dbo')
	BEGIN
		SET @new_password = CONVERT(NVARCHAR(36), '12345');
  
		-- Create the login
		SET @sql = N'CREATE LOGIN ' + QUOTENAME(@new_username) + N' WITH PASSWORD = ' + QUOTENAME(@new_password, '''');
		EXEC sys.sp_executesql @sql;

		-- Create the user
		SET @sql = N'CREATE USER ' + QUOTENAME(@new_username) + N' FOR LOGIN ' + QUOTENAME(@new_username);
		EXEC sys.sp_executesql @sql;
  
		-- Assign the role to the user
		SET @sql = N'ALTER ROLE [' + @role + N'] ADD MEMBER ' + QUOTENAME(@new_username); 
		EXEC sys.sp_executesql @sql;
	END

	IF(IS_MEMBER('DATABASE ADMINS') = 1)
	BEGIN
		-- Create the user
		SET @sql = N'CREATE USER ' + QUOTENAME(@new_username) + N' WITHOUT LOGIN';
		EXEC sys.sp_executesql @sql;
  
		-- Assign the role to the user
		SET @sql = N'ALTER ROLE [' + @role + N'] ADD MEMBER ' + QUOTENAME(@new_username); 
		EXEC sys.sp_executesql @sql;
	END
	
	FETCH NEXT FROM cursor_member INTO @new_username, @role;
  END

  CLOSE cursor_member;
  DEALLOCATE cursor_member;
END;
GO


-- Prevent deletion --------------------------------------------------
CREATE OR ALTER TRIGGER [TABLE_DELETION_PREVENTION]
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    -- Get the name of the table being deleted
    DECLARE @TableName NVARCHAR(128);
    SET @TableName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(128)');

	IF	@TableName IS NOT NULL
		PRINT 'You must disable Trigger [TABLE_DELETION_PREVENTION] to drop the ' + @TableName + ' table!';
	
	ROLLBACK;
END;
GO

-- Trigger to prevent deletion in CATEGORY table
CREATE OR ALTER TRIGGER [AVOID_DELETE_CATEGORY]
ON CATEGORY
INSTEAD OF DELETE
AS
	PRINT 'ATTENTION! Delete the record from CATEGORY table is not allowed!';
ROLLBACK;
GO

SELECT * FROM sys.triggers;
GO

-- Trigger to prevent deletion in EQUIPMENT table
CREATE OR ALTER TRIGGER [AVOID_DELETE_EQUIPMENT]
ON EQUIPMENT
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'ATTENTION! Deleting records from the EQUIPMENT table is not allowed!';
    ROLLBACK;
END;
GO

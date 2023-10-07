USE DBS_ASSIGNMENT

OPEN SYMMETRIC KEY SimKey1 DECRYPTION BY CERTIFICATE Cert1
INSERT INTO MEMBER (member_id, login_id, member_role, national_reg_id_passport, first_name, last_name, phone_number, street, postcode, city, state, status)
VALUES
  ('M00001', 'lisa77', 'MEMBERS', EncryptByKey(Key_GUID('SimKey1'), 'A12345678'), 'Lisa', 'Taylor', '012-3456789', '1 Jalan Raja', '50050', 'Kuala Lumpur', 'KUL', 'Active'),
  ('M00002', 'mohd88', 'MEMBERS', EncryptByKey(Key_GUID('SimKey1'), 'B98765432'), 'Mohd', 'Ibrahim', '019-8765432', '2 Jalan Sultan Ismail', '50250', 'Kuala Lumpur', 'KUL', 'Active'),
  ('M00003', 'jessica91', 'MEMBERS', EncryptByKey(Key_GUID('SimKey1'), 'C24681357'), 'Jessica', 'Lee', '010-9876543', '3 Jalan Tun Abdul Razak', '60000', 'Kuala Lumpur', 'KUL', 'Active'),
  ('M00004', 'siti87', 'MEMBERS', EncryptByKey(Key_GUID('SimKey1'), 'D13579246'), 'Siti', 'Binti Abdullah', '017-2345678', '4 Jalan Ampang', '50450', 'Kuala Lumpur', 'KUL', 'Active'),
  ('M00005', 'ali123', 'MEMBERS', EncryptByKey(Key_GUID('SimKey1'), 'E86420931'), 'Ali', 'Ahmad', '016-8765432', '5 Jalan Bukit Bintang', '55100', 'Kuala Lumpur', 'KUL', 'Active');
CLOSE SYMMETRIC KEY SimKey1

INSERT INTO CATEGORY(category_id, category_name)
VALUES
  ('C001', 'Balls'),
  ('C002', 'Rackets'),
  ('C003', 'Bats'),
  ('C004', 'Nets'),
  ('C005', 'Accessories');


INSERT INTO DISCOUNT(discount_id, category_id, discount_rate, start_date, end_date)
VALUES
  ('D001', 'C001', 0.1, '2023-01-01', '2023-12-31'),
  ('D002', 'C002', 0.2, '2023-02-01', '2023-11-30'),
  ('D003', 'C003', 0.15, '2023-03-01', '2023-10-31'),
  ('D004', 'C004', 0.25, '2023-04-01', '2023-09-30'),
  ('D005', 'C005', 0.3, '2023-05-01', '2023-08-31');


INSERT INTO EQUIPMENT(equipment_id, category_id, equipment_name, price_per_unit, quantity_in_stock, country, tax_rate)
VALUES
  ('E001', 'C001', 'Basketball', 50, 100, 'USA', 0.1),
  ('E002', 'C001', 'Soccer Ball', 40, 150, 'Malaysia', 0),
  ('E003', 'C001', 'Tennis Ball', 5, 200, 'China', 0.1),
  ('E004', 'C002', 'Tennis Racket', 100, 80, 'China', 0.1),
  ('E005', 'C002', 'Badminton Racket', 60, 120, 'USA', 0.1),
  ('E006', 'C002', 'Table Tennis Paddle', 30, 180, 'China', 0.1),
  ('E007', 'C003', 'Baseball Bat', 70, 100, 'Japan', 0.1),
  ('E008', 'C003', 'Cricket Bat', 80, 90, 'USA', 0.1),
  ('E009', 'C003', 'Softball Bat', 60, 110, 'USA', 0.1),
  ('E010', 'C004', 'Basketball Net', 30, 80, 'Malaysia', 0),
  ('E011', 'C004', 'Soccer Goal Net', 50, 70, 'USA', 0.1),
  ('E012', 'C004', 'Tennis Net', 40, 90, 'Japan', 0.1),
  ('E013', 'C005', 'Sports Bag', 50, 100, 'Malaysia', 0),
  ('E014', 'C005', 'Water Bottle', 10, 200, 'Malaysia', 0),
  ('E015', 'C005', 'Headband', 5, 300, 'Malaysia', 0),
  ('E016', 'C005', 'Wristband', 3, 400, 'Japan', 0.1),
  ('E017', 'C005', 'Sunglasses', 20, 150, 'Malaysia', 0);


INSERT INTO [TRANSACTION] (member_id, transaction_date)
VALUES
  ('M00001', '2023-01-05'),
  ('M00002', '2023-02-10'),
  ('M00003', '2023-03-15'),
  ('M00004', '2023-04-20'),
  ('M00005', '2023-05-25'),
  ('M00001', '2023-06-01'),
  ('M00002', '2023-06-15'),
  ('M00003', '2023-06-17'),
  ('M00005', '2023-06-18'),
  ('M00002', '2023-06-19'),
  ('M00004', '2023-06-20'),
  ('M00003', '2023-06-21');


INSERT INTO PURCHASED_ITEM (transaction_id, equipment_id, quantity_purchased)
VALUES
  (1, 'E001', 2),
  (1, 'E002', 1),
  (2, 'E003', 1),
  (3, 'E004', 3),
  (4, 'E005', 2),
  (4, 'E006', 1),
  (5, 'E007', 2),
  (6, 'E008', 1),
  (7, 'E009', 2),
  (8, 'E001', 1),
  (8, 'E010', 3),
  (8, 'E014', 2),
  (9, 'E011', 1),
  (10, 'E012', 2),
  (11, 'E013', 1),
  (11, 'E014', 3),
  (12, 'E015', 1),
  (12, 'E016', 2),
  (12, 'E017', 1);



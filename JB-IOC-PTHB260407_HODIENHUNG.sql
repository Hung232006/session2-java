------------------------------------------------------PHẦN I---------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- tạo bảng Passengers
CREATE TABLE Passengers(
passenger_id VARCHAR(5) PRIMARY KEY NOT NULL,
passenger_full_name VARCHAR(100) NOT NULL,
passenger_email VARCHAR(100) NOT NULL,
passenger_phone VARCHAR(15) NOT NULL,
passenger_cccd VARCHAR(20) NOT NULL
);

-- tạo bảng Trains
CREATE TABLE Trains(
train_id VARCHAR(5) PRIMARY KEY NOT NULL,
train_name VARCHAR(100) NOT NULL,
train_type VARCHAR(10) NOT NULL,
total_seats INT NOT NULL
);

--tạo bảng Tickets
CREATE TABLE Tickets(
ticket_id VARCHAR(5) PRIMARY KEY NOT NULL,
passenger_id VARCHAR(5) NOT NULL,
train_id VARCHAR(5) NOT NULL,
departure_date DATE NOT NULL,
seat_number VARCHAR(10) NOT NULL,
ticket_price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
FOREIGN KEY (train_id) REFERENCES Trains(train_id)
);

-- tạo bảng Transactions
CREATE TABLE Transactions(
transaction_id VARCHAR(5) PRIMARY KEY NOT NULL,
ticket_id VARCHAR(5) NOT NULL,
payment_method VARCHAR(50) NOT NULL,
transaction_date DATE NOT NULL,
amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);
-- câu 2
-- BẢNG Passengers thêm data
INSERT INTO Passengers(passenger_id,passenger_full_name,passenger_email, passenger_phone,passenger_cccd)
VALUES 
		('P001', 'Nguyen Van An', 'an.nguyen@example.com', 0912345678, 001234567890),
		('P002', 'Tran Thi Binh', 'binh.tran@example.com', 0923456789, 002345678901),
		('P003', 'Le Minh Chau', 'chau.le@example.com', 0934567890, 003456789012),
		('P004', 'Pham Quoc Dat', 'dat.pham@example.com', 0945678901, 004567890123),
		('P005', 'Vo Thanh Em', 'em.vo@example.com', 0956789012, 005678901234);

SELECT *FROM Passengers;

-- BẢNG Trains thêm data
INSERT INTO Trains(train_id,train_name,train_type, total_seats)
VALUES 
		('T001', 'Tau Thong Nhat 1', 'SE', 500),
		('T002', 'Tau Thong Nhat 2', 'TN', 450),
		('T003', 'Tau Sai Gon - Hue', 'SE', 400),
		('T004', 'Tau Ha Noi - Lao Cai', 'TN', 350),
		('T005', 'Tau Da Nang Express', 'SE', 300);
SELECT *FROM Trains;


--BẢNG Tickets thêm data

INSERT INTO Tickets(ticket_id,passenger_id,train_id, departure_date,seat_number,ticket_price)
VALUES 
		('TK001', 'P001', 'T001', '2025-06-10', 'A01',850000),
		('TK002', 'P002', 'T002', '2025-06-11', 'B05',650000),
		('TK003', 'P003', 'T003', '2025-06-12', 'C10',720000),
		('TK004', 'P004', 'T004', '2025-06-13', 'D12',500000),
		('TK005', 'P005', 'T005', '2025-06-14', 'E08',900000);
SELECT *FROM Tickets;


--BẢNG Transactions thêm data


INSERT INTO Transactions(transaction_id,ticket_id,payment_method, transaction_date,amount)
VALUES 
		('TR001', 'TK001', 'Credit Card', '2025-06-01',850000),
		('TR002', 'TK002', 'Cash' 		, '2025-06-02',650000),
		('TR003', 'TK003', 'Bank Transfer', '2025-06-03',720000),
		('TR004', 'TK004',  'E-Wallet'	, '2025-06-04',500000),
		('TR005', 'TK005', 'Credit Card', '2025-06-05',900000);
SELECT *FROM Transactions;



-- CÂU 3
UPDATE Tickets SET ticket_price = (ticket_price * 0.85) WHERE departure_date < '2025-05-01';
--CÂU 4
DELETE FROM Transactions WHERE payment_method LIKE'%E-Wallet%' AND amount < 200000;

-------------------------------------------------------PHẦN II----------------------------------------------
------------------------------------------------------------------------------------------------------------
													
 --CÂU 5
 SELECT passenger_id, passenger_full_name, passenger_email, passenger_phone FROM Passengers ORDER BY passenger_full_name DESC;
 --CÂU 6
 SELECT train_id, train_name, total_seats FROM Trains ORDER BY total_seats ASC;
 --CÂU 7
 SELECT p.passenger_full_name, tr.train_name, t.departure_date, t.seat_number FROM Passengers p 
 JOIN Tickets t ON p.passenger_id = t.passenger_id
 JOIN Trains tr ON t.train_id = tr.train_id
 GROUP BY p.passenger_full_name, tr.train_name, t.departure_date, t.seat_number;
 --CÂU 8
 SELECT p.passenger_id, p.passenger_full_name, tra.payment_method, tra.amount 
 FROM Passengers p
 JOIN Tickets t ON p.passenger_id = t.passenger_id
 JOIN Transactions tra ON t.ticket_id = tra.ticket_id
 GROUP BY p.passenger_id, p.passenger_full_name, tra.payment_method, tra.amount
 ORDER BY tra.amount ASC;
 --CÂU 9
 SELECT *FROM Passengers  ORDER BY passenger_full_name DESC LIMIT 3 OFFSET 2;
 --CÂU 10
 SELECT p.passenger_full_name FROM Passengers p
 JOIN Tickets t ON p.passenger_id = t.passenger_id
 JOIN Transactions tra ON t.ticket_id = tra.ticket_id
 GROUP BY  p.passenger_full_name HAVING COUNT(tra.ticket_id) >=3;
 --CÂU 11
 SELECT tr.train_name, tr.train_id  FROM Trains tr
 JOIN Tickets t ON tr.train_id = t.train_id
 GROUP BY tr.train_name, tr.train_id  HAVING COUNT(t.ticket_id) >10;
 --CÂU12
 SELECT p.passenger_id, p.passenger_full_name, tr.train_id, SUM(tra.amount) AS total_amount
 FROM Passengers p 
 JOIN Tickets t ON p.passenger_id = t.passenger_id
 JOIN Trains tr ON t.train_id = tr.train_id
 JOIN Transactions tra ON t.ticket_id = tra.ticket_id
 GROUP BY p.passenger_id, p.passenger_full_name, tr.train_id, tra.amount  HAVING SUM(tra.amount) > 2000000;
 --CÂU 13
 SELECT passenger_full_name, passenger_email FROM Passengers 
 WHERE passenger_full_name LIKE'%Hoang%'
 OR passenger_email LIKE'%@gmail.com'
 ORDER BY passenger_full_name ASC;
 --CÂU 14
 SELECT tr.train_id, tr.train_name, t.seat_number FROM Trains tr
 JOIN Tickets t ON tr.train_id = t.train_id
 GROUP BY  tr.train_id, tr.train_name, t.seat_number
  ORDER BY 	t.seat_number DESC;



-------------------------------------------------------PHẦN III----------------------------------------------
------------------------------------------------------------------------------------------------------------
 -- CÂU 15 
 CREATE VIEW vw_UpcomingTrips AS
 SELECT p.passenger_full_name AS TEN,
 		tr.train_name AS TENTAU, -- dùng AS để đặt tên thay thế
		 t.seat_number AS SOGHE,
		 t.ticket_price AS GIAVE,
		 t.departure_date AS NGAYDI
FROM Passengers p
JOIN Tickets t ON p.passenger_id = t.passenger_id 
JOIN Trains tr ON t.train_id = tr.train_id	
WHERE t.departure_date > '2025-06-01';
 
 SELECT *FROM vw_UpcomingTrips;

--CÂU 16
 CREATE VIEW vw_HighValueTickets AS
 SELECT p.passenger_full_name AS TEN,
 		tr.train_name AS TENTAU,
		 t.seat_number AS SOGHE,
		 t.ticket_price AS GIAVE
FROM Passengers p
JOIN Tickets t ON p.passenger_id = t.passenger_id -- thực hiện JOIN vào Tickets để liên kết bảng
JOIN Trains tr ON t.train_id = tr.train_id -- thực hiện JOIN vào Trains để liên kết bảng
WHERE t.ticket_price > 500000;
 
 SELECT *FROM vw_HighValueTickets;


-------------------------------------------------------PHẦN IV----------------------------------------------
------------------------------------------------------------------------------------------------------------
--CÂU 17
CREATE OR REPLACE FUNCTION check_ticket_date ()
RETURNS TRIGGER AS $$
BEGIN
IF NEW.departure_date > NEW.transaction_date THEN 
RAISE EXCEPTION 'NGAY KHOI HANH KHONG HOP LE';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER tg_check_ticket_date 
BEFORE INSERT OR UPDATE ON Tickets 
FOR EACH ROW
EXECUTE FUNCTION check_ticket_date ();

--CÂU 18

CREATE OR REPLACE FUNCTION update_seats  ()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE Trains
	SET total_seats = total_seats - 1
	WHERE train_id = NEW.train_id;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER tg_update_seats  
BEFORE INSERT OR UPDATE ON Tickets 
FOR EACH ROW
EXECUTE FUNCTION update_seats  ();


-------------------------------------------------------PHẦN V----------------------------------------------
------------------------------------------------------------------------------------------------------------

--CÂU 19
CREATE OR REPLACE PROCEDURE sp_add_passenger(
IN p_passenger_id VARCHAR,
IN p_passenger_full_name VARCHAR,
IN p_passenger_email VARCHAR,
IN p_passenger_phone VARCHAR,
IN p_passenger_cccd VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
-- insert data 
INSERT INTO Passengers(passenger_full_name,passenger_email,passenger_phone,passenger_id,passenger_cccd)
VALUES(p_passenger_id,p_passenger_full_name,p_passenger_email,p_passenger_phone,p_passenger_cccd);
END;
$$;
CALL sp_add_passenger(
'P006',
'HO DIEN HUNG',
'H@gmail.com',
0354099530,
005678901111
);

--CÂU 20

CREATE OR REPLACE PROCEDURE sp_add_passenger(
IN p_ticket_id VARCHAR
)
LANGUAGE plpgsql 
AS $$
BEGIN
	--xóa các giao dịch liên quan
	DELETE FROM Transactions
	WHERE ticket_id = p_ticket_id;
	-- xóa vé
	DELETE FROM Tickets
	WHERE ticket_id = p_ticket_id;
END;
$$;
CALL sp_add_passenger('T001');

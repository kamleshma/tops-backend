CREATE DATABASE IF NOT EXISTS bank;
USE bank;

CREATE TABLE IF NOT EXISTS Bank (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    branch_city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Account_Holder (
    account_holder_id INT PRIMARY KEY,
    account_no INT UNIQUE,
    account_holder_name VARCHAR(100),
    city VARCHAR(50),
    contact VARCHAR(20),
    date_of_account_created DATE,
    account_status VARCHAR(10) CHECK (account_status IN ('active', 'terminated')),
    account_type VARCHAR(20),
    balance DECIMAL(15, 2)
);

CREATE TABLE IF NOT EXISTS Loan (
    loan_no INT PRIMARY KEY,
    branch_id INT,
    account_holder_id INT,
    loan_amount DECIMAL(15, 2),
    loan_type VARCHAR(50),
    FOREIGN KEY (branch_id) REFERENCES Bank(branch_id),
    FOREIGN KEY (account_holder_id) REFERENCES Account_Holder(account_holder_id)
);

INSERT INTO Bank (branch_id, branch_name, branch_city)
VALUES
(1, 'Downtown Branch', 'New York'),
(2, 'Uptown Branch', 'New York'),
(3, 'Central Branch', 'Los Angeles'),
(4, 'Beachside Branch', 'Miami'),
(5, 'Lakeside Branch', 'Chicago');

INSERT INTO Account_Holder (account_holder_id, account_no, account_holder_name, city, contact, date_of_account_created, account_status, account_type, balance)
VALUES
(1, 1001, 'Alice Johnson', 'New York', '1234567890', '2022-01-10', 'active', 'savings', 1500.00),
(2, 1002, 'Bob Smith', 'New York', '2345678901', '2022-03-15', 'active', 'checking', 800.00),
(3, 1003, 'Charlie Davis', 'Los Angeles', '3456789012', '2021-06-20', 'terminated', 'savings', 500.00),
(4, 1004, 'Diana Ross', 'Miami', '4567890123', '2020-12-05', 'active', 'checking', 1200.00),
(5, 1005, 'Ethan Hunt', 'Chicago', '5678901234', '2019-08-30', 'active', 'savings', 2000.00),
(6, 1006, 'Fiona Clark', 'Chicago', '6789012345', '2023-01-12', 'active', 'checking', 350.00),
(7, 1007, 'George Brown', 'Miami', '7890123456', '2021-11-22', 'terminated', 'savings', 700.00),
(8, 1008, 'Hannah Lee', 'Los Angeles', '8901234567', '2022-09-18', 'active', 'checking', 950.00),
(9, 1009, 'Ian Wright', 'New York', '9012345678', '2020-04-11', 'active', 'savings', 300.00),
(10, 1010, 'Jackie Chan', 'Chicago', '0123456789', '2021-07-14', 'active', 'checking', 1800.00);

INSERT INTO Loan (loan_no, branch_id, account_holder_id, loan_amount, loan_type)
VALUES
(1, 1, 1, 5000.00, 'Personal Loan'),
(2, 2, 2, 2000.00, 'Auto Loan'),
(3, 3, 3, 8000.00, 'Mortgage'),
(4, 4, 4, 1500.00, 'Personal Loan'),
(5, 5, 5, 3000.00, 'Business Loan'),
(6, 1, 6, 1000.00, 'Auto Loan'),
(7, 2, 7, 4000.00, 'Mortgage'),
(8, 3, 8, 2000.00, 'Personal Loan'),
(9, 4, 9, 3500.00, 'Business Loan'),
(10, 5, 10, 2500.00, 'Auto Loan');

START TRANSACTION;

UPDATE Account_Holder
SET balance = balance - 100
WHERE account_no = 1001 AND balance >= 100;

UPDATE Account_Holder
SET balance = balance + 100
WHERE account_no = 1002;

COMMIT;

SELECT *
FROM Account_Holder
WHERE city = 'New York';

SELECT account_no, account_holder_name
FROM Account_Holder
WHERE DAY(date_of_account_created) > 15;

SELECT branch_city, COUNT(branch_id) AS Count_Branch
FROM Bank
GROUP BY branch_city;

SELECT a.account_holder_id, a.account_holder_name, l.branch_id, l.loan_amount
FROM Account_Holder a
INNER JOIN Loan l ON a.account_holder_id = l.account_holder_id;

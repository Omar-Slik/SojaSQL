USE master
if exists (select * from sysdatabases where name='Soja')
        alter database Soja set single_user with rollback immediate
        drop database Soja
GO
	CREATE DATABASE Soja;
GO
USE Soja;

	CREATE TABLE Employee(
		[Employee_ID] INT  PRIMARY KEY IDENTITY(1,1),
		[Person_Number] VARCHAR(20) UNIQUE,
		[First_Name] VARCHAR(30),
		[Last_Name] VARCHAR(30),	
	);	
	CREATE INDEX Employee_Name ON Employee([First_Name],[Last_Name]);
	CREATE TABLE [Telefon_Number](
		[Id] INT PRIMARY KEY IDENTITY (1,1),
		[Employee]  INT,
		[Phone] VARCHAR (20),
		[Phone2] VARCHAR (20),
		FOREIGN KEY (Employee) REFERENCES Employee([Employee_ID])
	);
	CREATE TABLE [E_mail](
		[Id] INT PRIMARY KEY IDENTITY (1,1),
		[Employee]  INT,
		[mail] VARCHAR(100),
		[mail2] VARCHAR(100),
		FOREIGN KEY (Employee) REFERENCES Employee([Employee_ID])
		);
	CREATE TABLE Department(
		[Name] VARCHAR(30) PRIMARY KEY,
		[Employee] INT NOT NULL FOREIGN KEY REFERENCES Employee([Employee_ID])
	);
	CREATE TABLE Campain(
		[Campain_Id] INT  PRIMARY KEY IDENTITY(1,1),
		[%_Price_Drop] FLOAT
	);
	CREATE TABLE Product(
		[ID] INT PRIMARY KEY IDENTITY(1,1),
		[Bar_Code] CHAR(9) UNIQUE,
		[Number_In_store]INT NOT NULL,
		[Name]VARCHAR(45) NOT NULL,
		[List_Of_Ingredients]VARCHAR(100),
		[Exp_Date] DATE,
		[Price]INT,
		[Campain] INT FOREIGN KEY REFERENCES Campain([Campain_Id]),
		[Employee] INT FOREIGN KEY REFERENCES Employee([Employee_Id]),
		[Date_Of_Last_Check] DATE
		);
	CREATE INDEX Produkt_Name ON Product([Name]);
	CREATE TABLE BelongsTo(
		[Bar_Code] CHAR(9) FOREIGN KEY REFERENCES Product([Bar_Code]),
		[Name] VARCHAR(30) FOREIGN KEY REFERENCES Department([Name]),
		PRIMARY KEY ([Bar_Code], [Name])
	);
	CREATE TABLE Mentorship(
		[Exe_Date] DATETIME2,
		[Employee1] INT FOREIGN KEY REFERENCES Employee([Employee_ID]),
		[Employee2] INT FOREIGN KEY REFERENCES Employee([Employee_ID]),
		PRIMARY KEY (Employee1,Employee2)
	);
	INSERT INTO Employee([Person_Number],[First_Name],[Last_Name])
		VALUES
		('9004072142','Omar','Slik'),
		('9407247294','Ulf','Hedberg'),
		('9112314292','Agda','Erikson'),
		('9506053255','Samauel','Norlund'),
		('8801013287','Erik','Anderson'),
		('8909034212','Pelle','Haglund'),
		('9906024632','Albin','Eklund'),
		('9007068576','Victoria','Husak')
	;
	INSERT INTO Telefon_Number(Employee,Phone,Phone2)VALUES
		(1,'0790763259','0748769147'),
		(2,'0753982342',NULL),
		(3,'0702397109',NULL),
		(4,'0742315214','0752233147'),
		(5,'0709523021',NULL),
		(6,'0767415941','0786425147'),
		(7,'0743268453',NULL),
		(8,'0790765689',NULL)
	;
	INSERT INTO E_mail(Employee,mail,mail2)VALUES
		(1,'omar.slik@outlook.com','omar.slik@studerande-skys.com'),
		(2,'Adham.samauelson@outlook.com',NULL),
		(3,'Agda.erikson@outlook.com','Agda.erikson@gmail.com'),
		(4,'Samauel.Norlund@outlook.com',NULL),
		(5,'erik.anderson@outlook.com','erik.anderson@hotmail.com'),
		(6,'pelle.haglund@outlook.com',NULL),
		(7,'albin.eklund@outlook.com','albin.eklund@gmail.com'),
		(8,'victoria.Husak@outlook.com','victoria.Husak@hotmail.com')
	;
	INSERT INTO Department([Name],Employee)VALUES
		('Dairy',1),
		('Fruit',2),
		('Pantry',3),
		('Drinks',4),
		('Bread',5),
		('Meat',5);
	INSERT INTO Campain([%_Price_Drop])VALUES 
		(10),
		(15),
		(25),
		(50)
	;
	INSERT INTO Product([Bar_Code],[Number_In_store],[Name],[Exp_Date],[Price],
						[Campain],[Employee],[Date_Of_Last_Check])VALUES
		('D5905d216',3,'Milk','2021-05-23',300,1,4,'2021-12-21'),
		('D7502f749',1,'Cheese','2021-08-23',400,4,2,'2021-12-26'),
		('F2480d759',3,'Apple','2021-02-12',400,3,1,'2021-12-25'),
		('F1309p572',9,'Banana','2021-07-01',600,2,4,'2021-12-12'),
		('F6592d093',3,'Peach','2021-11-24',200,1,5,'2021-12-15'),
		('P1379b043',1,'Flour','2021-06-25',800,3,5,'2021-12-22'),
		('P9845p037',2,'Sugar','2021-02-26',400,2,1,'2021-12-29'),
		('D5754f521',4,'Juice','2021-08-25',800,4,5,'2021-12-28'),
		('D5467d807',8,'Tea','2021-06-17',600,3,4,'2021-12-26'),
		('B9087m314',6,'Toast','2021-05-18',200,3,2,'2021-12-21'),
		('B5454p879',3,'Roll','2021-04-19',400,2,3,'2021-12-15'),
		('B6432m665',3,'Pudding','2021-09-16',600,1,1,'2021-12-18'),
		('M6367f485',2,'Sausages','2021-07-11',400,4,5,'2021-12-11'),
		('M7954d208',4,'Fresh','2021-08-14',300,2,2,'2021-12-07'),
		('M3213p656',1,'Poultry','2021-11-22',200,2,3,'2021-12-09')
	;
	INSERT INTO Product([Bar_Code],[Number_In_store],[Name],[Exp_Date],[Price],
						[List_Of_Ingredients],[Employee],[Date_Of_Last_Check])VALUES
		('D1207d865',4,'Yogurt','2021-12-23',600,'Milk,Bacteria',3,'2021-12-04'),
		('P3254m697',3,'Pasta','2021-09-27',100,'Durum,Flour',4,'2021-12-28'),
		('D3252d375',6,'Coffee','2021-03-25',800,'Caffeine,Tannin,Oil,Carbohydrates',1,'2021-12-01')
	;
	INSERT INTO BelongsTo (Bar_Code,[Name])VALUES
		('D5905d216','Dairy'),('D3252d375','Dairy'),('D5467d807','Dairy'),
		('D1207d865','Dairy'),('D7502f749','Dairy'),
		('F2480d759','Fruit'),('D5754f521','Fruit'),('F1309p572','Fruit'),
		('F6592d093','Fruit'),('D7502f749','Fruit'),
		('F1309p572','Pantry'),('P3254m697','Pantry'),('P9845p037','Pantry'),
		('P1379b043','Pantry'),('B5454p879','Pantry'),	
		('D5905d216','Drinks'),('D5754f521','Drinks'),('D3252d375','Drinks'),
		('D5467d807','Drinks'),('F6592d093','Drinks'),('F2480d759','Drinks'),
		('D1207d865','Drinks'),		
		('B9087m314','Bread'),('B5454p879','Bread'),('B6432m665','Bread'),
		('P1379b043','Bread'),	
		('B9087m314','Meat'),('B6432m665','Meat'),('P3254m697','Meat'),
		('M6367f485','Meat'),('M7954d208','Meat'),('M3213p656','Meat')
	;
----VG DELEN----
	CREATE TABLE ProductLog(
		[Id] INT PRIMARY KEY IDENTITY(1,1),
		[Changes_Date] DATETIME2,
		[Product] VARCHAR(45),
		[number_Left] INT,
	);
GO
	CREATE TRIGGER Product_Change
		ON Product
			AFTER UPDATE 
		AS 
	INSERT INTO ProductLog(Changes_Date,Product,number_Left)VALUES
		(CURRENT_TIMESTAMP,(SELECT inserted.[Name] FROM inserted),
			(SELECT inserted.[Number_In_store] FROM inserted))

GO 
GO 
	CREATE VIEW ProductStatus AS
		SELECT [Name], ( CASE WHEN Product.Number_In_store > 3  THEN 'OK'
			ELSE 'LIMITED QUANTITY' END )AS STATU FROM Product;
GO 
--SELECT * FROM EMPLOYEE
--SELECT * FROM Department
--SELECT * FROM Product
--SELECT * FROM Campain
--SELECT * FROM BelongsTo ORDER BY [Name]

USE Soja

--1

	SELECT [Name], [Number_In_Store] FROM Product ORDER BY (Number_In_Store);

--2

	SELECT Department.[Name],Employee.First_Name,Employee.Last_Name FROM  Department 
		INNER JOIN Employee ON Department.Employee=Employee.Employee_ID;

--3

	SELECT COUNT(Employee_ID) FROM Employee;

--4

	SELECT Product.[Name] FROM Product JOIN BelongsTo ON BelongsTo.[Name] = 'Dairy' 
		AND BelongsTo.Bar_Code = Product.Bar_Code AND Product.Number_In_store <= 3;

--5

	SELECT Product.[Name],Employee.First_Name FROM Product JOIN Employee ON
		Product.Employee=Employee.Employee_ID AND 
		ABS( DATEDIFF(day, GETDATE(), Product.Date_Of_Last_Check) ) <= 7;

----VG DELEN----

--6 

  SELECT Product.[Name],COALESCE(Product.Price-(Product.Price*Campain.[%_Price_Drop]/100), Product.Price) AS Price
	FROM Product LEFT JOIN Campain 
	ON  Campain.Campain_Id = Product.Campain;
 
--7 

	SELECT COUNT(Employee.Employee_ID)AS [Employee without department] 
		FROM Employee LEFT JOIN Department ON Department.Employee = Employee.Employee_ID WHERE Department.Employee IS NULL
		
--8

	SELECT Employee.First_Name,CONCAT_WS(', ', mail, mail2) AS [E_Mail]
	FROM Employee INNER JOIN E_mail ON Employee.Employee_ID = E_mail.Id ORDER BY E_mail.Id;

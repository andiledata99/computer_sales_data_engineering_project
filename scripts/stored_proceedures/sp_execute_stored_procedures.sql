---CREATING A TABLE
DROP TABLE [computer_std]. [dbo].[fact_pc_sales]
CREATE TABLE[computer_std]. [dbo].[fact_pc_sales](
    [SalesID] INT IDENTITY (1,1) PRIMARY KEY,
	[ChannelID] INT NOT NULL,
	[CustomerID] INT NOT NULL,
	[DateID] INT NOT NULL, 
	[StoreID] INT NOT NULL,
	[PriorityID] INT NOT NULL,
	[EmployeeID] INT NOT NULL,
	[LocationID] INT NOT NULL,
	[PaymentMethodID] INT NOT NULL,
	[ProductID] INT NOT NULL,
	[Cost_Price]  decimal(10, 2) NOT NULL,
	[Sale_Price] decimal(10, 2)NOT NULL,
	[Discount_Amount] decimal(10, 2) NOT NULL,
	[Finance_Amount]  decimal(10, 2)NOT NULL,
	[Cost_of_Repairs] decimal(10, 2) NOT NULL,
	[Total_Sales_per_Employee]  decimal(10, 2) NOT NULL,
	[PC_Market_Price]  decimal(10, 2)NOT NULL,
	[Credit_Score] INT NOT NULL,
	
  

	[load_date] DATETIME DEFAULT GETDATE()
) 

---INSERTING VALUES INTO A TABLE
INSERT INTO[computer_std]. [dbo].[fact_pc_sales](
            
			ChannelID, 
	CustomerID, 
	DateID, 
	StoreID,
	PriorityID,
	EmployeeID ,
	LocationID,
	PaymentMethodID,
	ProductID, 
	Cost_Price, 
	Sale_Price,
	Discount_Amount,
	Finance_Amount,  
	Cost_of_Repairs, 
	Total_Sales_per_Employee, 
	PC_Market_Price  ,
	Credit_Score 
	
  
			)

SELECT 
               ch.ChannelID, 
	c.CustomerID, 
	d.DateID, 
	s.StoreID,
	pr.PriorityID,
	e.EmployeeID ,
	l.LocationID,
	pm.PaymentMethodID,
	p.ProductID, 
	Cost_Price, 
	Sale_Price,
	Discount_Amount,
	Finance_Amount,  
	Cost_of_Repairs, 
	Total_Sales_per_Employee, 
	PC_Market_Price  ,
	Credit_Score 

FROM [computer_std].[dbo].[raw_pc_data] as std
inner join [computer_std].[dbo].[dim_channel] ch 
on std.Channel = ch.channel

inner join [computer_std].[dbo].[dim_customer] c 
on std.Customer_Name = c.customer_name
and std.Customer_Surname = c.customer_surname
and std.Customer_Contact_Number = c.customer_contact_number
and std.Customer_Email_Address = c.customer_email_address

inner join [computer_std].[dbo].[dim_date] d 
on std.Purchase_Date = d.purchase_date
and std.Ship_Date = d.ship_date

inner join [computer_std].[dbo].[dim_store] s 
on std.Shop_Name =s.shop_name
and std.Shop_Age = s.shop_age

inner join[computer_std].[dbo].[dim_priority] pr 
on std.Priority = pr.priority

inner join[computer_std].[dbo].[dim_employee] e 
on std.Sales_Person_Name = e.sales_person_name
and std.Sales_Person_Department = e.sales_person_department

inner join [computer_std].[dbo].[dim_location] l 
on std.Continent = l.continent
and std.Province_or_City = l.province_or_city
and std.Country_or_State = l.country_or_state

inner join [computer_std].[dbo].[dim_payment_method] pm 
on std.Payment_Method = pm.payment_method

inner join [computer_std].[dbo].[dim_product] p 
on std.PC_Model = p.pc_model
and std.PC_Make =p.pc_make
and std.Storage_Capacity = p.storage_capacity
and std.Storage_Type = p.storage_type
and std.Ram = p.ram


SELECT * FROM [computer_std]. [dbo].[fact_pc_sales]

END;
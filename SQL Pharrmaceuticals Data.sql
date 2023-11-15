select * from dbo.Pharma_data$

/*unique countries*/
select COUNT(DISTINCT Country) as unique_countries
from dbo.Pharma_data$

/*Select the names of all the customers on the 'Retail' channel.*/
select [CustomerName]
from dbo.Pharma_data$
where [Channel] = 'Retail';

/*Find the total quantity sold for the 'Electronics' product class.*/
select COUNT (ProductClass)
from dbo.Pharma_data$
where [ProductClass] = 'Electronics';

/* List all the distinct months present in the dataset.*/
Select DISTINCT Month 
from dbo.Pharma_data$;


Select Distinct Year
from dbo.Pharma_data$


/*Calculate the total sales for each year.*/ 
select Year,sum(Sales) as Total_Sales
from dbo.Pharma_data$
group by Year 
order by Year DESC;

/*Find the customer with the highest sales value*/
Select CustomerName, sum(Sales) as Total_Sales_per_Customer
from dbo.Pharma_data$
group by CustomerName
order by Total_Sales_per_Customer desc;

Select Distinct CustomerName
from dbo.Pharma_data$

/*Get the names of all employees who are Sales Reps and are managed by 'John Smith'.*/
select [Name of Sales Rep]
from dbo.Pharma_data$
where Manager ='John Smith';

/*. Retrieve the top 5 cities with the highest sales.*/
select TOP 5 City, sum(Sales) as Highest_sales_per_city
from dbo.Pharma_data$
group by City
order by Highest_sales_per_city desc;

/* Calculate the average price of products in each sub-channel.*/
select DISTINCT Subchannel
from dbo.Pharma_data$

select Subchannel,AVG(Price) as SubChannel_AVG_PRICE
from dbo.Pharma_data$
group by [Subchannel];

/*Salesrep and corresponding Sales.*/
select [Name of Sales Rep], SUM (Sales) as Total_Sum_Of_Sales_PERSR
FROM dbo.Pharma_data$
group by [Name of Sales Rep];

/*Calculate the total sales for each product class, for each month, and order the results by 
year, month, and product class.*/

SELECT [Product_Class], Year, Month, SUM(Sales) AS Total
FROM dbo.Pharma_data$
GROUP BY [Product_Class], Year, Month;

/*. Find the top 3 sales reps with the highest sales in 2023*/

SELECT Top 3 [Name of Sales Rep], Year ,sum(Sales) As Highest_SalesRep
from dbo.Pharma_data$
where Year =2020
Group by [Name of Sales Rep], Year;

/*Calculate the monthly total sales for each sub-channel, and then calculate the average 
monthly sales for each sub-channel over the years.*/

SELECT Subchannel,Month ,Year,SUM(Sales)as Total_Sales,AVG(Sales)as Average_Sales
from dbo.Pharma_data$
group by Subchannel,Month  ,Year 
order by Year Desc, Month Desc

/*Create a summary report that includes the total sales, average price, and total quantity 
sold for each product class.*/SELECT [Product_Class], SUM(Sales) as Total_Product_Class,AVG(Sales) as Average_Product_Class,SUM(Quantity)from dbo.Pharma_data$group by Product_Class;/*Find the top 5 customers with the highest sales for each year.*/WITH RankedSalesData AS (
    SELECT CustomerName, Year, SUM(Sales) AS TotalSales,
           ROW_NUMBER() OVER (PARTITION BY Year ORDER BY SUM(Sales) DESC) AS SalesRank
    FROM dbo.Pharma_data$
    GROUP BY CustomerName, Year

)
SELECT CustomerName, Year, TotalSales AS Highest_sales_per_customer
FROM RankedSalesData
WHERE SalesRank <= 5;WITH YearGrowth AS (    SELECT Country, Year, SUM(Sales)as Total_Year_Sales,	  ROW_NUMBER () OVER (PARTITION BY YEAR ORDER BY SUM(Sales) DESC) AS Total_Year_Sales    FROM dbo.Pharma_data$	GROUP BY Country,Year	)


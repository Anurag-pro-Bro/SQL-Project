use amazon_schema;
select * from amazon; 

Alter table amazon
modify invoice_id varchar(30);

Alter table amazon
modify Branch varchar(5);

Alter table amazon
modify city varchar(30);

Alter table amazon
modify Customer_type varchar(30);

Alter table amazon
modify Gender varchar(10);

Alter table amazon
modify Product_line varchar(100);

Alter table amazon
modify Unit_price DECIMAL(10,2);

Alter table amazon
modify Quantity varchar(5);

Alter table amazon
modify VAT DECIMAL(10,2);

Alter table amazon
modify Total DECIMAL(10,2);

update amazon 
set Date=str_to_date(Date,"%d-%m-%Y");

Alter table amazon
modify Date DATE;

Alter table amazon
modify Time TIME;

Alter table amazon
modify Payment varchar(20);

Alter table amazon
modify cogs DECIMAL(10,2);

Alter table amazon
modify gross_margin_percentage DECIMAL(10,2);

Alter table amazon
modify gross_income DECIMAL(10,2);

Alter table amazon
modify Rating Decimal(10, 2);

Alter table amazon
add timeofday varchar(25) 

update amazon
set timeofday = 'Afternoon'
where time between '12:43:00' and '18:00:00';

update amazon
set timeofday = 'Morning'
where time between '6:00:00' and '12:42:00';

update amazon
set timeofday = 'Evening'
where time between '18:00:00' and '21:00:00';

Alter table amazon
add dayname varchar(25)

update amazon
set dayname = dayname(date);

Alter table amazon
add monthname varchar(25)

update amazon
set monthname = monthname(date);

select * from amazon;

# 1.What is the count of distinct cities in the dataset? #
select count(distinct city) as city_count from amazon;

# 2.For each branch, what is the corresponding city?#
select distinct branch, city from amazon;

# 3.What is the count of distinct product lines in the dataset? #
select count(distinct Product_line) as Product_line_count from amazon;

# 4. Which payment method occurs most frequently? #
select payment, count(payment) as Payment_count from amazon
group by payment
order by Payment_count desc
limit 1;

# 5. Which product line has the highest sales? #
select Product_line, count(Product_line) as Product_line_count from amazon
group by Product_line
order by Product_line_count desc
limit 1;

# 6. How much revenue is generated each month? #
select  distinct monthname, sum(total) as Revenue from amazon
group by monthname ;

# 7. In which month did the cost of goods sold reach its peak?  #
select  distinct monthname, sum(cogs) as Total_cogs from amazon
group by monthname
order by Total_cogs desc
limit 1;

# 8. Which product line generated the highest revenue? #
select  distinct Product_line, sum(total) as Revenue from amazon
group by Product_line
order by Revenue desc
limit  1;

# 9. In which city was the highest revenue recorded? #
select  distinct city, sum(total) as Revenue from amazon
group by city
order by Revenue desc
limit  1;

# 10. Which product line incurred the highest Value Added Tax? #
select  distinct Product_line, sum(vat) as Total_Tax from amazon
group by Product_line
order by Total_Tax desc
limit  1;

# 11. For each product line, 
# add a column indicating "Good" if its sales are above average, otherwise "Bad."#
select Product_line, quantity,
case
when quantity > (select avg(quantity) from amazon) then "Good"
else "Bad"
end as 'About_Sales'
from amazon;

# 12. Identify the branch that exceeded the average number of products sold. #
select branch, a.quantity, avg_quantity.AvgQuantity from amazon a 
inner join (select avg(quantity) as Avgquantity from amazon) as avg_quantity
on a.quantity > avg_quantity.Avgquantity;

# 13. Which product line is most frequently associated with each gender? #
select gender, Product_line, freq as most_freq 
from(select gender,Product_line,count(*) as freq,
row_number() over (partition by gender order by count(*) desc) as row_num
from amazon
group by Gender,Product_line) as temp_data
where row_num =1;

# 14. Calculate the average rating for each product line. #
select  distinct Product_line, avg(rating) as Avg_rating from amazon
group by Product_line;

# 15. Count the sales occurrences for each time of day on every weekday. #
select timeofday, count(quantity) as sales_count from amazon
group by timeofday;

# 16. Identify the customer type contributing the highest revenue. #
select  distinct Customer_type, sum(total) as Revenue from amazon
group by Customer_type
order by Revenue desc
limit 1 ;

# 17. Determine the city with the highest VAT percentage. #
select  distinct city, sum(vat) as Total_Vat from amazon
group by city
order by Total_Vat desc;

# 18. Identify the customer type with the highest VAT payments. #
select  distinct Customer_type, sum(vat) as Total_Vat from amazon
group by Customer_type
order by Total_Vat desc;

# 19. What is the count of distinct customer types in the dataset? #
select count(distinct Customer_type) as Distinct_Customer_Type from amazon;

# 20. What is the count of distinct payment methods in the dataset? #
select count(distinct Payment) as Distinct_Payment from amazon;

# 21. Which customer type occurs most frequently? #
select Customer_type, count(Customer_type) as Customer_type_count from amazon
group by Customer_type
order by Customer_type_count desc;

# 22. Identify the customer type with the highest purchase frequency. #
select  distinct Customer_type, sum(total) as Highest_Purchase from amazon
group by Customer_type
order by Highest_Purchase desc
limit 1 ;

# 23. Determine the predominant gender among customers. #
select max(gender) as Predominant_gender from amazon;

# 24. Examine the distribution of genders within each branch. #
select Branch,gender, count(gender) as gender_count from amazon
group by branch,gender
order by Branch; 

# 25. Identify the time of day when customers provide the most ratings. #
select timeofday, count(rating) as Most_rating from amazon
group by timeofday
order by Most_rating desc;

# 26. Determine the time of day with the highest customer ratings for each branch. #
select timeofday, count(rating) as Highest_rating, branch from amazon
group by  timeofday,Branch 
order by Branch,timeofday desc;

# 27. Identify the day of the week with the highest average ratings.#
select dayname, avg(rating) as Highest_Avg from amazon
group by dayname
order by Highest_Avg desc;

# 28. Determine the day of the week with the highest average ratings for each branch.#
select dayname, avg(rating) as Highest_Avg,branch from amazon
group by dayname,Branch
order by  branch,Highest_Avg desc;

 








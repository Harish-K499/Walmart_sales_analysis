USE walmart_db;
select * from walmart limit 10;

-- BUSINESS PROBLEMS:

-- Q1. Find different payment methods, number of transactions and number of qty sold?

select  payment_method,
count(*) as num_payments,
sum(quantity) from walmart
group by payment_method;

-- Q2. IDENTIFY THE HIGHEST RATED CATEGORY IN EACH BRANCH DISPLAYING THE BRANCH & CATEGORY?

SELECT * from
(select 
      branch,
      category,
      rating,
      rank() over (partition by branch order by max(rating) desc) as rn
      from walmart
      group by branch, category, rating
) numberone
where rn = 1;

-- Q3. IDENTIFY THE BUSIEST DAY IN WALMART FOR EACH BRANCH BASED ON TRANSACTIONS?

SELECT * from (
    select
    branch,
    DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS days,
    RANK() OVER (PARTITION BY branch order by COUNT(*) DESC) as ranks
    FROM walmart
    group by branch, days) busiestdays
where ranks = 1;

-- Q4. CALCULATE THE TOTAL QUANTITY OF ITEMS SOLD PER PAYMENT METHOD AND DISPLAY PAYMENT METHOD AND TOTAL QUANTITY?

select 
       payment_method,
       count(*) as no_payments,
	   sum(quantity)
from walmart
group by payment_method;

-- Q5. DESCRIBE THE AVG,MINIMUM,MAXIMUM RATING OF THE CATEGORY FOR EACH CITY?
-- LIST CITY'S AVG, MINMIUM, MAXIMUM RATING.

select 
      city,
      category,
      min(rating) as min_rating,
      max(rating) as max_rating,
      avg(rating) as avg_rating
from walmart
group by city, category;

-- Q6. calculate the total profit for each category by considering total profit as
-- (unit_price* quantity*profit_margin) list category and total _profit in desc?

select category,sum(unit_price*quantity*profit_margin) as total_profit
from walmart
group by 1
order by total_profit desc

-- Q7 determine the most common payment_method for each branch.
 -- Display branch and preffered payment method?
select branch,
	payment_method,
    ranks, total_trans from
        (select branch,
		payment_method,
        count(*) as total_trans,
        rank() over (partition by branch order by count(*) desc) as ranks
from walmart
group by 1,2) t
where ranks = 1;

-- Q8. CATEGORIZE SALES INTO 3 GROUPS MORNING,EVENING AND AFTERNOON.
-- FIND OUT EACH OF THE SHIFT AND NUMBER OF INVOICES.

SELECT branch,
case 
    when extract(hour from time) between 6 and 12 then 'morning'
	when extract(hour from time) between 13 and 18 then 'afternoon'
    else 'night'
    end as shift,
    count(*) as invoices
from walmart 
group by 1,2

-- Q9. Identify 5 branch with highest decrease ratio in revenue compared to last year (current year 2023 and last year 2022)

with last_year_rev as(
select branch,extract(year from date) as Date_,sum(total_revenue) as revenue from walmart
 where extract(year from date)='2022'
 group by branch,Date_),
 current_year_rev as (
 select branch,extract(year from date) as Date_,sum(total_revenue) as revenue from walmart
 where extract(year from date)='2023'
 group by branch,Date_)
 select cr.*,lr.reven
     
    
    


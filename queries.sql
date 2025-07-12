USE MAY25;

CREATE TABLE Sales (
    cust_id INT NOT NULL, 
    name VARCHAR(40), 
    store_id VARCHAR(20) NOT NULL, 
    bill_no INT NOT NULL,
    bill_date DATE NOT NULL,
    bill_year INT NOT NULL,  -- extra column for year
    amount DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (bill_year, bill_date)  -- PRIMARY KEY must include partition column
)
PARTITION BY RANGE (bill_year) (
    PARTITION P1 VALUES LESS THAN (2016),
    PARTITION P2 VALUES LESS THAN (2017),
    PARTITION P3 VALUES LESS THAN (2018),
    PARTITION P4 VALUES LESS THAN (2020)
);

select * from sales
   

----#Q9 identify 5 branch with highest decrease ratio in revenue compared to last year (current year 2023 and last year 2022)

with last_year_rev as(
select branch,extract(year from date) as Date_,sum(total_revenue) as revenue from walmart
 where extract(year from date)='2022'
 group by branch,Date_),
 current_year_rev as (
 select branch,extract(year from date) as Date_,sum(total_revenue) as revenue from walmart
 where extract(year from date)='2023'
 group by branch,Date_)
 select cr.*,lr.revenue as last_year_rev,round((lr.revenue-cr.revenue)/lr.revenue*100,2)  as revenue_decrease_ratio from current_year_rev as cr
 join  last_year_rev lr on cr.branch=lr.branch
 order by cr.revenue desc
 limit 5;
 
 select * from walmart
 

x----------------------------------------------------------------------------------------------------------x


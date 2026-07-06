-- who generated more revenue male or female ? 
select gender, SUM(purchase_amount) as revenue
from customer
group by gender;

--  which customers used a discount but still spent more that avg purchase amount ?

select customer_id , purchase_amount
from customer
where discount_applied = 'Yes' and purchase_amount >=(select AVG(purchase_amount) from customer);

-- top 5 products  with highest average review rating ? 


select item_purchased,ROUND(AVG(CAST(review_rating AS DECIMAL(10,2))), 2) as "AVG_rating" from customer 
group by item_purchased
order by avg(review_rating) desc
limit 5;

-- Compare the avg purchase amount between standard and express shipping 

select shipping_type, AVG(purchase_amount) from customer
where shipping_type in ('Standard','Express')
group by shipping_type;


--  avg spend and total revenue btw subs and non subs 

select subscription_status, 
Count(customer_id) as total_customers,
ROUND(avg(purchase_amount),2) as avg_spend,
ROUND(SUM(purchase_amount),2) as total_revenue from customer
group by subscription_status order by  total_revenue , avg_spend desc;


 -- top 5 products solde with discounts 
 SELECT 
    item_purchased, 
   ROUND((100* SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)),2) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;


-- segemt customers into new returning and loyal based on their total number of orders 
with customer_type as (
select customer_id , previous_purchases,
Case when previous_purchases  = 1 THen 'NEW'
when previous_purchases between 2 and 10 then 'Returning'
else 'Loyal'
End as customer_segment

from customer
)

select customer_segment , count(*) as 'Number of customers'
from customer_type
group by customer_segment;

-- top 3 products with in each category 
with item_counts as (
select category , item_purchased , Count(customer_id ) as total_orders,
row_number() over( partition by category order by count(customer_id) desc ) as item_rank 
from customer
group by category,item_purchased
)

select item_rank ,category , item_purchased, total_orders from item_counts
where item_rank<=3 ; 

-- are returning buyers also likely to subscribe ? 

select subscription_status, count(customer_id) as repeat_buyers from customer

where previous_purchases > 5 
group by subscription_status ;

 -- THE OUTPUT WAS YES = 958 AND NO = 2518 WHICH MEANS THAT  repeat customers are not finding the subscription to the platform worth there money 
 -- 
 what is the revenue contribution of each age group 
 
 select age_group, SUM(purchase_amount) as total_revenue
 from customer
 group by age_group
 order by total_revenue desc; 
 
 
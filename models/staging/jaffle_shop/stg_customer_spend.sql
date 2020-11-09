select customer_id, 
sum(amount) as lifetime_value
 from {{ ref('fct_orders' )}} as orders
 group by customer_id
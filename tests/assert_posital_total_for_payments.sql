select 
    orderid,
    sum(amount) as total_amount 
from {{ ref('stg_payments')}}
group by orderid 
having not(total_amount >= 0)
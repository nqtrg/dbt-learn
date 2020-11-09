select 
    orders.order_id,
    orders.customer_id,
    payment.amount
from {{ ref('stg_orders') }} as orders 
left join {{ ref('stg_payment')}} as payment 
    on orders.order_id = payment.orderid
select 
    id,
    orderid,
    paymentmethod,
    status,
    {{ cents_to_dollars('amount') }} as amount,
    created
 from raw.stripe.payment
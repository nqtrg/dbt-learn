{%- set paymentmethods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}
with payments as (
    select * from {{ ref('stg_payments') }}
),
pivoted as (
    select 
        orderid,
        {% for paymentmethod in paymentmethods -%}
        sum(case when paymentmethod='{{ paymentmethod }}' then amount else 0 end) as {{ paymentmethod }}_amount
        {%- if not loop.last -%}
        ,
        {% endif %}
        {%- endfor %}
    from payments
    where status = 'success'
    group by orderid
)

select * from pivoted

-- vanila sql
-- with payments as (
--     select * from {{ ref('stg_payments') }}
-- ),
-- pivoted as (
--     select 
--         orderid,
--         sum(case when paymentmethod='bank_transfer' then amount else 0 end) as bank_transfer_amount,
--         sum(case when paymentmethod='coupon' then amount else 0 end) as coupon_amount,
--         sum(case when paymentmethod='credit_card' then amount else 0 end) as credit_card_amount,
--         sum(case when paymentmethod='gift_card' then amount else 0 end) as gift_card_amount
--     from payments
--     where status = 'success'
--     group by orderid
-- )

-- select * from pivoted
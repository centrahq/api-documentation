---
title: How to sell products in subscription in your Store
altTitle: Subscriptions
excerpt: It is possible to sell products in subscription in Centra. Here is how to handle it in your Front End.
taxonomy:
  category: docs
---

## How do Subscriptions work in Centra?

[notice-box=info]
This feature is still in development.
[/notice-box]

Merchant is allowed to setup a `subscription plans` and select an interval and which product variants should be available in such plan. This can be done via AMS. Once a shopper checks out a product variant available in subscription plan, (s)he can decide to enroll into subscription plan for this variant. It is not mandatory and you can mix subscription and non-subscription variants in one basket. You can even have the same variant in different (including none) subscription plans in one basket. Upon checkout shopper can't decide on the start date of the subscription - they start immediately.

During payment process Centra will detect if there are subscribed products in the basket and will handle payment process accordingly. There is no need to modify anything on frontend side. It might however be required to review and reconfigure Payment Service Provider settings to allow for recurring or tokenized payments. Contact PSP's support for further details.

### Common parts

Getting subscription plans is pretty much the same for ShopAPI(`GET` `/api/shop/products`) and CheckoutAPI(`GET` `/api/checkout/products`).

For each product there is one new field - `subscription_plans` of type `array`.

## Example

`subscription_plans` field content example for product with defined 5 subscription plans:
```json
[
    {
        "id": "1",
        "name": "1 month subscription",
        "intervalValue": "1",
        "intervalType": "month"
    },
    {
        "id": "2",
        "name": "3 months subscription",
        "intervalValue": "3",
        "intervalType": "month"
    },
    {
        "id": "3",
        "name": "1 year subscription",
        "intervalValue": "1",
        "intervalType": "year"
    },
    {
        "id": "4",
        "name": "6 months subscription",
        "intervalValue": "6",
        "intervalType": "month"
    },
    {
        "id": "5",
        "name": "2 weeks subscription",
        "intervalValue": "2",
        "intervalType": "week"
    }
]
```

### Fields description:
- `id` is unique number representing subscription plan
- `name` is subscription plan name defined when creating subscription plan
- `intervalValue` is a numeric field specifying the number of units of time
- `intervalType` is string representing the unit of time used; can be any of: `day`, `week`, `month`, `year`

## Checking out
Checkout process is the same implementation-wise, read more in [Checkout API Order flow guide](https://docs.centra.com/api-references/checkout-api/order-flow).

# ShopAPI
We assume configured url for ShopAPI is `/api/shop/`

## Adding items with subscription plan to basket
Adding an item with subscription to basket is the same as usual, using:

`POST` `/api/shop/selections/{{selection}}/items/{{item}}`

But in the request body, we specify the subscription plan we want to use:
```json
{
    "subscriptionPlan": {{subscriptionPlanId}}
}
```

## Adding subscription plan to existing item
`PUT` `/api/shop/selections/{{selection}}/lines/{{selectionLineItem}}/subscription-plan/{{subscriptionPlanId}}`

## Deleting subscription plan from item
`DELETE` `/api/shop/selections/{{selection}}/lines/{{selectionLineItem}}/subscription-plan/`

# CheckoutAPI
We assume configured url for CheckoutAPI is `/api/checkout/`

Standard selection/checkout documentation is located [here](https://docs.centra.com/api-references/checkout-api/api-reference/selections-and-orders).

## Adding items to basket
After [creating selection](https://docs.centra.com/api-references/checkout-api/order-flow#create-selection-add-items-to-selection)
or [adding items to selection](https://docs.centra.com/api-references/checkout-api/order-flow#add-another-product-to-selection)
the usual way, we can add subscription plan for that item using:

`PUT` `/api/checkout/lines/{{lineItem}}/subscription-plan/{{subscriptionPlanId}}`

We can also add subscription plan without item into basked using:
`POST` `/api/checkout/items/{{item}}`
with body:
```json
{
    "subscriptionPlan": {{subscriptionPlanId}}
}
```

## Deleting subscription plan from item
`DELETE` `/api/checkout/lines/{{subscriptionLineItem}}/subscription-plan/`

---
title: How to sell products in subscription in your Store
altTitle: Subscriptions
excerpt: It is possible to sell products as subscriptions in Centra. Here is how to handle it in your Front End.
taxonomy:
  category: docs
---

[notice-box=info]
Please note that this feature is still in development.
[/notice-box]

### How do Subscriptions work in Centra?

Merchant is allowed to setup a `subscription plan` to select an interval and which product variants should be available in such plan. This can be done via AMS. Once a shopper checks out a product variant available in subscription plan, they can decide to enroll into subscription plan for this variant. It is not mandatory and you can mix subscription and non-subscription variants in one basket. You can even have the same variant in different (including none) subscription plans in one basket. Upon checkout shopper can't decide on the start date of the subscription - they start immediately.

During payment process Centra will detect if there are subscribed products in the basket and will handle payment process accordingly. There is no need to modify anything on frontend side. It might however be required to review and reconfigure Payment Service Provider settings to allow for recurring or tokenized payments. Contact PSP's support for further details.

### Common parts

Getting subscription plans is pretty much the same for ShopAPI(`GET` `/api/shop/products`) and CheckoutAPI(`GET` `/api/checkout/products`).

For each product there is one new field - `subscriptionPlans` of type `array`.

#### Example

`subscriptionPlans` field content example for product with defined 5 subscription plans:
```json
[
    {
        "id": "1",
        "name": "1 month subscription",
        "intervalValue": "1",
        "intervalType": "month",
        "discountPercent": 10
    },
    {
        "id": "2",
        "name": "3 months subscription",
        "intervalValue": "3",
        "intervalType": "month",
        "discountPercent": 10
    },
    {
        "id": "3",
        "name": "1 year subscription",
        "intervalValue": "1",
        "intervalType": "year",
        "discountPercent": 10
    },
    {
        "id": "4",
        "name": "6 months subscription",
        "intervalValue": "6",
        "intervalType": "month",
        "discountPercent": 10
    },
    {
        "id": "5",
        "name": "2 weeks subscription",
        "intervalValue": "2",
        "intervalType": "week",
        "discountPercent": 10
    }
]
```

### Fields description:
- `id` is unique number representing subscription plan,
- `name` is subscription plan name defined when creating subscription plan,
- `intervalValue` is a numeric field specifying the number of units of time,
- `intervalType` is a string representing the unit of time used; can be any of: `day`, `week`, `month` or `year`,
- `discountPercent` is a numeric value of flat rate discount set on the subscription plan.

### Checking out
Checkout process is the same when it comes to implementation, you can read more in [Checkout API Order flow guide](https://docs.centra.com/api-references/checkout-api/order-flow). The only difference is that the customer has to be a registered client in order to be able to subscribe to an item. The user can log in before the checkout or create the account during the checkout. Keep in mind that it is only possible to create an account if the email is not already associated with any created account. If the account with given email already exists it is mandatory to log in before checking out with a subscription.

## ShopAPI
We assume configured url for ShopAPI is `/api/shop/`.

### Adding items with subscription plan to basket
Adding an item with subscription to basket is the same as usual, using [POST /api/shop/selections/{{selection}}/items/{{item}}](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/post_selections__selection__items__item_). In the request body, we specify the subscription plan we want to use:
```json
{
    "subscriptionPlan": {{subscriptionPlanId}}
}
```

### Adding subscription plan to existing item
[PUT /api/shop/selections/{{selection}}/lines/{{selectionLineItem}}/subscription-plan/{{subscriptionPlanId}}](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/put_selections__selection__lines__line__subscription_plan__subscriptionPlan_)

### Deleting subscription plan from item
[DELETE /api/shop/selections/{{selection}}/lines/{{selectionLineItem}}/subscription-plan/](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/delete_selections__selection__lines__line__subscription_plan)

### Log in

Log the customer into your system. You can verify the customer credentials in [POST /api/shop/customers/{{email}}/login](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/post_customers__email__login). Once you have the customer authenticated you should indicate that in `POST /api/shop/selections/{{selectionId}}/payment` request by adding `loggedIn` property:

```json
{
    "address": {
        "loggedIn": true
    }
}
```

### Registration

If the email address is not taken by a registered customer then it is possible to register during checkout by adding registration specific fields to `POST /api/shop/selections/{{selectionId}}/payment` request:

```json
{
    "address": {
        "register": true,
        "password": "password for the user"
    }
}
```

## CheckoutAPI
We assume configured url for CheckoutAPI is `/api/checkout/`.

Standard selection/checkout documentation is located [here](https://docs.centra.com/api-references/checkout-api/api-reference/selections-and-orders).

### Adding items to basket
After [creating selection](https://docs.centra.com/api-references/checkout-api/order-flow#create-selection-add-items-to-selection)
or [adding items to selection](https://docs.centra.com/api-references/checkout-api/order-flow#add-another-product-to-selection)
the usual way, we can add subscription plan for that item using:

[PUT /api/checkout/lines/{{lineItem}}/subscription-plan/{{subscriptionPlanId}}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/2.%20selection%20handling%2C%20cart/put_lines__line__subscription_plan__subscriptionPlan_)

We can also add subscription plan without item into basked using [POST /api/checkout/items/{{item}}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/2.%20selection%20handling%2C%20cart/post_items__item_) with body:
```json
{
    "subscriptionPlan": {{subscriptionPlanId}}
}
```

### Deleting subscription plan from item
[DELETE /api/checkout/lines/{{subscriptionLineItem}}/subscription-plan/](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/2.%20selection%20handling%2C%20cart/delete_lines__line__subscription_plan)

### Log in

Log the customer into your system. You can verify the customer credentials in [POST /api/checkout/login/{{email}}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/post_login__email_). If the credentials are correct the customer will be logged in in current shopping session (for current API-Token).

### Registration

If the email address is not taken by a registered customer then it is possible to register during checkout by adding registration specific fields to `POST /api/checkout/selections/{{selectionId}}/payment` request:

```json
{
    "address": {
        "register": true,
        "password": "password for the user"
    }
}
```

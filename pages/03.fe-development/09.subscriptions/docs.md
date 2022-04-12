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

### Subscription contract
While working with subscriptions it is essential to grasp the concept of subscription contract. This is what binds together all the things: the customer, the payment method, shipping address and a set of products the customer subscribed to. Each checkout event generates one subscription contract that may contain multiple subscriptions.

### Subscription
Each product (or bundle) added to the contract is called "subscription". One subscription always means one item of deliverables (product or bundle). Subscription has it's own delivery schedule that can be modified (if current plans allow that). If deliveries of multiple subscriptions in one contract fall on the same day they will be shipped as one order.

### Checking out
Checkout process is the same when it comes to implementation, you can read more in [Checkout API Order flow guide](https://docs.centra.com/api-references/checkout-api/order-flow). The only difference is that the customer has to be a registered client in order to be able to subscribe to an item. The user can log in before the checkout or create the account during the checkout. Keep in mind that it is only possible to create an account if the email is not already associated with any created account. If the account with given email already exists it is mandatory to log in before checking out with a subscription.

### Subscription management
Once subscription is created it is possible to browse customer's subscriptions as well as manage their state and shipping address or change subscription plan. Keep in mind that shipping country cannot be changed. If the customer wishes to change destination country they have to cancel the subscription and check out again with new address.

#### Changing interval
Interval on which items should be delivered can only be changed if the same item is currently available in a subscription plan. One can choose any of currently available plans. Keep in mind that all plan's properties will be transferred to subscribed item: interval and discount. Each subscription can have its own interval and they can be modified separately.

#### Changing status
Subscription might be paused at any given time with no consequences. In such case orders are not generated if they fall on the send interval. After resuming the subscription next send interval will be calculated and orders will resume from that interval. No items will be shipped to make up for pause period. When you cancel a subscription it is not possible to bring it back. When all contract's subscriptions are cancelled then payment details will be purged for safety reasons. Be careful not to cancel all subscriptions if you plan to have this contract going in the future.

#### Changing address
Address is set on contract level and therefore it is only possible to change shipping address for all subscriptions on that contract. It is only possible to change address inside the same destination country as original subscription order. If the shopper wishes to ship subscription to a different country they have to cancel the current subscription and check out with subscribed items again in different country.

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

### Browsing subscriptions

Customer's current subscriptions can be listed using [POST /customer/{{email}}/subscriptions](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/post_customers__email__subscriptions) endpoint. Because Shop API works in stateless manner you do not have to log in as customer. Authorization should be handled by frontend. Subscriptions are grouped by the contract they belong to.

### Changing contract address

To edit shipping address you have to provide the contract id that will be modified and use Shop API endpoint [PUT /subscriptions/address](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/put_subscription_address). You should provide a customer for which you modify the contract.

```json
{
  "customer": "example@example.com",
  "contract": 1,
  "firstName": "First Name",
  "lastName": "Last Name",
  "address1": "Address1",
  "address2": "Address2",
  "zipCode": "12345",
  "city": "City",
  "phoneNumber": "123123123",
  "email": "example@example.com"
}
```

### Changing interval

Changing subscription interval is only possible by providing a new subscription plan id. All plan properties will be copied onto subscription: [PUT /subscription/interval](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/put_subscription_interval)

```json
{
  "subscription": 123,
  "subscriptionPlan": 32
}
```

### Changing status

Status modifications use a [POST /subscription/status](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/put_subscription_status) endpoint. You need to provide a subscription id as well as new status:

```json
{
  "subscription": 1,
  "status": "active"
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

### Browsing subscriptions

Customer's current subscriptions can be listed using [POST /customer/subscriptions](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/post_customer_subscriptions) endpoint. Because Checkout API maintains user session, you can only access that endpoint once you are logged in.

### Changing contract address

To edit shipping address you have to provide the contract id that will be modified and use Ceckout API endpoint [PUT /subscriptions/address](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/put_subscription_address).

```json
{
  "contract": 1,
  "firstName": "First Name",
  "lastName": "Last Name",
  "address1": "Address1",
  "address2": "Address2",
  "zipCode": "12345",
  "city": "City",
  "phoneNumber": "123123123",
  "email": "example@example.com"
}
```

### Changing interval

Changing subscription interval is only possible by providing a new subscription plan id. All plan properties will be copied onto subscription: [PUT /subscription/interval](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/put_subscription_interval)

```json
{
  "subscription": 123,
  "subscriptionPlan": 32
}
```

### Changing status

Status modifications use a [POST /subscription/status](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/put_subscription_status) endpoint. You need to provide a subscription id as well as new status:

```json
{
  "subscription": 1,
  "status": "active"
}
```

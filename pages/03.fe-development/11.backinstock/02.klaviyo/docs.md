---
title: Back in stock feature using Klaviyo
altTitle: Back in stock with Klaviyo
taxonomy:
    category: docs
excerpt: It is possible to set up the Back in stock feature to e-mail your customers reminders when an item is back in stock. Here's how you can configure it.
---

### Back in stock subscriptions

In order to enable back in stock feature you need to perform initial product catalog synchronisation first.
Once it's done you can enable back in stock and access product catalog information in back in stock emails using catalog lookup feature.

![back_in_stock_disabled.png](back_in_stock_disabled.png)

![back_in_stock_enabled.png](back_in_stock_enabled.png)

Back in stock requires frontend implementation against Checkout API or Shop API. The specification of endpoint is available in our swagger docs:
- [Back in stock in Checkout API](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/post_back_in_stock_subscription)
- [Back in stock in Shop API](https://docs.centra.com/swagger-ui/?api=ShopAPI&urls.primaryName=ShopAPI#/6.%20customer%20handling/post_back_in_stock_subscription)

#### Back in stock flow
1. POST request towards Checkout API/Shop API
```json
POST https://centra-instance.com/api/checkout-api/back-in-stock-subscription
{   
    "item": "12366-23400",
    "shipTo": {
        "country": "SE"
    },
    "email": "test@email.com",
    "language": "sv"
}
```
2. Centra creates back in stock product

Back in stock products are assigned with a special category and are supposed to be used only for internal purposes of back in stock automation.
Concept of back in stock products is described in details [here](#backinstock-category-of-products).

Back in stock product identifier consists of multiple parts, which on the example of `12366_SE_00` are:
- 12366 - display item id in Centra, which is top-level product identifier in Klaviyo
- SE - ISO code of ship-to location country
- 00 - ISO code of ship-to location state (Sweden does not have states, placeholder `00` is used)

![back_in_stock_product.png](back_in_stock_product.png)

3. Centra creates back in stock variant

Variants are divided across ship-to locations supported in your retail store and across available sizes.
Variant identifier consists of multiple parts, which on the example of `12366_SE_00_23400` are:
- 12366 - display item id in Centra, which is top-level product identifier in Klaviyo
- SE - ISO code of ship-to location country
- 00 - ISO code of ship-to location state (Sweden does not have states, placeholder `00` is used)
- 23401 - size identifier in Centra

![back_in_stock_variant.png](back_in_stock_variant.png)


4. Centra sends customer's back in stock subscription towards variant

To see active back in stock subscriptions in Klaviyo go to [Back In Stock Report](https://www.klaviyo.com/catalog/reports/back-in-stock)

![back_in_stock_report.png](back_in_stock_report.png)

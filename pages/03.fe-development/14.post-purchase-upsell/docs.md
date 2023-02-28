---
title: Post-purchase Upsell feature
altTitle: Upsell
taxonomy:
    category: docs
excerpt: It provides a great way to recommend additional products to customers that are related to the items they have already purchased.
---

## Overview

Upsell is an effective marketing tactic used by many stores to increase sales and revenues.
It is a type of sales technique that encourages customers to purchase additional items when making a purchase.
This feature allows customers to add products the order in one click, after they have already completed their checkout.

## What is required to enable Upsell?

Currently, Upsell feature available in CheckoutAPI and ShopAPI when using Klarna Checkout v3. Read how to enable Upsell feature for [Klarna Checkout v3 plugin](https://support.centra.com/centra-sections/settings/plugins/klarnacheckoutv3).

## How does Upsell feature work?

Upsell feature allows to add additional products to the order in one click, after checkout is completed and without filling shipping address and payment details again.

![upsell-flow.png](upsell-flow.png)

1. Store customer finished checkout and was redirected to thank you page by payment provider
2. Your website calls `PUT /payment-result` response to the call contains object `upsell` which provides information whether payment provider supports upsell:
    ```json
      {
        // ...
        "upsell": {
          "isAllowed":  true, // Is post purchase upselling allowed
          "timeLimit": 3 // Upsell time limit in minutes
        }
        // ...
      }
    ```
3. If the order supports upsell you can offer the customer to add additional products to the order.
4. For adding upsell products to the order serve dedicated API endpoints in [Shop API](https://docs.centra.com/swagger-ui/?api=CheckoutAPI&urls.primaryName=ShopAPI) and [Checkout API](https://docs.centra.com/swagger-ui/?api=CheckoutAPI): `POST orders/{order}/items/{item}`
5. When upsell time out is over Centra sends Order Confirmation email to customer

### Which products can be added to order?

For upsell products work the same rules as for the products that can be added to basket.
The only exception - flexible bundles are not available for upselling.

### Getting products information through APIs

Getting upsell products information is the same for both Checkout API and Shop API.

The product information should be identical to a standard products call.
It includes all the pricing information like:
* `price`
* `priceAsNumber`
* `priceWithoutTax`
* `priceWithoutTaxAsNumber`
* `priceBeforeDiscount`
* `priceBeforeDiscountAsNumber`

You can get the upsold products information by calling following endpoint:

`POST <api-url>/orders/<order-number>/items`

ie. `POST /checkout-api/orders/69/items`

with body specifying which products should the API return:
```json
{
  "products": [1, 2, 3, 4, 5]
}
```

You must specify which product data to return.

#### Success
If all the products are found then the response will be:
```json
{
  "token": "...",
  "products": [
    {
      "product": "1",
      "name": "Test Product",
      "uri": "test-product",
      "sku": "123456",
      ...
    },
    ...
  ]
}
```
#### Partial success
If products will be fetched partially, then the response will be:
```json
{
  "token": "...",
  "successfullyFetched": [
    1,
    2,
    5
  ],
  "failedToFetch": [
    3,
    4
  ],
  "products": [
    {
      "product": "1",
      "name": "Test Product",
      "uri": "test-product",
      "sku": "123456",
      ...
    },
    ...
  ]
}
```
#### Failure
If no products can be found an error will be returned:
```json
{
    "token": "...",
    "errors": {
        "products": "products not found"
    }
}
```

#### Full response example
```json
{
    "token": "...",
    "products": [
        {
            "product": "1",
            "name": "Test Product",
            "uri": "test-product",
            "sku": "123456",
            "productSku": "123",
            "brand": "1",
            "brandName": "Brand",
            "brandUri": "brand",
            "collection": "1",
            "collectionName": "Collection",
            "collectionUri": "collection",
            "variantName": "Red",
            "countryOrigin": "",
            "excerpt": "",
            "excerptHtml": "",
            "description": "",
            "descriptionHtml": "",
            "metaTitle": "",
            "metaDescription": "",
            "metaKeywords": "",
            "stockUnit": "",
            "category": "1",
            "centraProduct": "1",
            "centraVariant": "1445",
            "itemQuantityMinimum": 1,
            "itemQuantityMultipleOf": 1,
            "price": "100.00 SEK",
            "priceAsNumber": 100,
            "priceWithoutTax": "80.00 SEK",
            "priceWithoutTaxAsNumber": 80,
            "priceBeforeDiscount": "100.00 SEK",
            "priceBeforeDiscountAsNumber": 100,
            "discountPercent": 0,
            "showAsOnSale": false,
            "showAsNew": false,
            "itemTable": {
                "unit": "",
                "original": {
                    "x": [
                        ""
                    ],
                    "y": []
                },
                "x": [
                    ""
                ],
                "y": [],
                "dividerSymbol": "x",
                "desc": "One Size"
            },
            "items": [
                {
                    "sizeId": "1",
                    "item": "1-1",
                    "ean": "ABCDEFGHIJKL",
                    "itemTableY": 0,
                    "itemTableX": 0,
                    "name": "",
                    "sku": "123456789"
                }
            ],
            "categoryName": [
                "Shop"
            ],
            "categoryUri": "shop",
            "categories": [
                {
                    "pathIds": [],
                    "uri": "shop",
                    "sortOrder": 1000001,
                    "name": [
                        "Shop"
                    ],
                    "category": "1"
                }
            ],
            "media": {
                "standard": [
                    "https://example.com/client/dynamic/images/1_9adfeff6f2-red.jpg",
                    "https://example.com/client/dynamic/images/1_3a541eaec0-no-connect.jpg"
                ]
            },
            "mediaObjects": [
                {
                    "media": 1,
                    "sources": {
                        "standard": [
                            {
                                "url": "https://example.com/client/dynamic/images/1_9adfeff6f2-red.jpg"
                            }
                        ]
                    },
                    "attributes": {
                        "test_media_attribute_test": "test attribute"
                    }
                },
                {
                    "media": 2,
                    "sources": {
                        "standard": [
                            {
                                "url": "https://example.com/client/dynamic/images/1_3a541eaec0-no-connect.jpg"
                            }
                        ]
                    },
                    "attributes": []
                }
            ],
            "subscriptionPlans": [
                {
                    "intervalType": "month",
                    "discountPercent": 0,
                    "subscriptionPlan": 1,
                    "name": "1 month subscription",
                    "shippingType": "DYNAMIC",
                    "id": "1",
                    "intervalValue": 1,
                    "status": "ACTIVE"
                }
            ],
            "modifiedAt": "2023-02-23 12:38:42",
            "createdAt": "2020-02-01 12:00:00",
            "campaigns": [
                {
                    "pricelists": [
                        23
                    ],
                    "markets": [
                        1
                    ],
                    "showAsNew": false,
                    "flags": 1,
                    "percent": 23400.5,
                    "startDate": "2018-12-17T12:00:00+0100",
                    "stopDate": "2024-02-09T15:54:35+0100",
                    "showAsOnSale": false
                },
                {
                    "pricelists": [
                        19
                    ],
                    "markets": [
                        3
                    ],
                    "showAsNew": false,
                    "flags": 0,
                    "percent": 50,
                    "startDate": "2019-01-04T13:00:00+0100",
                    "stopDate": "2023-03-09T15:54:35+0100",
                    "showAsOnSale": true
                }
            ],
            "measurementChart": [],
            "some_variation_attribute_text": "red variation value",
            "relation": "variant",
            "relatedProducts": [
                {
                    "product": "10",
                    "media": {
                        "standard": [
                            "https://example.com/client/dynamic/images/1_3a541eaec0-no-connect.jpg"
                        ]
                    },
                    "mediaObjects": [
                        {
                            "media": 2,
                            "sources": {
                                "standard": [
                                    {
                                        "url": "https://example.com/client/dynamic/images/1_3a541eaec0-no-connect.jpg"
                                    }
                                ]
                            },
                            "attributes": []
                        }
                    ],
                    "relation": "variant"
                }
            ]
        }
    ]
}
```

### Centra AMS

#### Order with upsell products
Order lines that were added to Order through upsell are displayed in section “Order products“
![upsell-product-vew.png](upsell-product-view.png)

Order history section contains information about upsell transactions. Previous auth transactions are “deprecated“ by adding suffix “-old“. Centra creates new auth transaction.

![ams-upsell-order-payment-history.png](ams-upsell-order-payment-history.png)

Order History section contains data about upsold products.

![ams-upsell-order-history.png](ams-upsell-order-history.png)

#### Order with failed upsell transaction

In case when Upsell transaction failed, Centra:
- reverts Order to the state before adding new Line Item
- logs failed transaction
- logs data to Order history
- Order Receipt email is sent after upsell time out limit is over

[notice-box=info]
The previous successful transaction remains active and can be captured as usual.
[/notice-box]

![ams-order-with-failed-upsell-transaction.png](ams-order-with-failed-upsell-transaction.png)

![ams-order-history-with-failed-upsell-transaction.png](ams-order-history-with-failed-upsell-transaction.png)

### Upsell feature using Klarna Checkout plugin

After a successful checkout webshop displays a list of products that the customer can add to the created order.

Increasing the order amount is not allowed for all payment methods, see below for details on when it is allowed. Any update to the order amount will override and replace the original order amount as well as any possible order lines you might have sent with the order.

Important note: Sometimes the increase might be rejected as we are not allowed to grant a customer an extended order amount. In these cases, the customer should be asked to place a new order in your shop for the new items. Be aware that increasing the order amount will trigger a second risk assessment on the customer, sometimes even a credit lookup.

![klarna-methods-that-support-upsell.png](klarna-methods-that-support-upsell.png)

Update the total order amount flow
![klarna-update-order-amount-flow.png](klarna-update-order-amount-flow.png)

More information read in documentation [Klarna. Update order amount](https://docs.klarna.com/order-management/pre-delivery/update-order-amount/).

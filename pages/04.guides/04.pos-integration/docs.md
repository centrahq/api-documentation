---
title: Integrating Centra with POS systems
altTitle: POS integration
excerpt: In addition to selling your goods online, does your business also sell your products in brick-and-mortar stores? Click here to learn how to integrate Centra with your Point of Sales system.
taxonomy:
  category: docs
---

Connecting your Centra store with a Point of Sale system can be done using the Order API. It's relatively similar to how the WMS integrations work, with the main exception being that the sale is made outside of Centra. Some customers can even decide not to create the PoS orders in Centra at all.

### Overview

In general, PoS system integration will use Order API endpoints to fetch products and prices and update the existing stock accordingly. If you choose to create an order in Centra, stock will be updated automatically.

### Prerequisites

To implement a PoS integration using the Order API, you need access to Centra with a configured Order API endpoint. Please note that you would need to authorise with the secret key configured in the Centra Order API settings.

[notice-box=alert]Warning: Never use the integration you build towards a production Centra environment before it is thoroughly tested and verified to be working as intended![/notice-box]

### Initial configuration

For PoS system integration, the following Order API plugin configuration is recommended:

![pos-plugin-settings1.png](pos-plugin-settings1.png)

First setting will allow you to easily calculate profit. Second will apply a tax amount appropriate to the country of sale. Due to the difference in tax rules around the world, you will need to configure one API endpoint per every country in which you have points of sale.

### Fetching products

This API call allows you to look for products by their SKU, EAN or interal `productId`, with options to filter them by created/modified date and limit the amount of results. In response you will receive a list of products with details such as their name, brand, collection, categories, status (active or not) and product prices in each pricelist.

More information: [Order API - Get products](https://docs.centra.com/reference/stable/order-api/get-products)

#### Example request

```text
GET http://customer.centra.com/api/order-api/products/?ean=5901144123590
```

#### Example response

TBD

### Fetching stock

With the use of this endpoint you can fetch the amount of items available for purchase. You can search by `productId`, SKU or EAN, and in return you will get, among other details:

```json
"physicalStock": 499,
"allocatedStock": 7,
"availableStock": 492
```

You'll want to use `availableStock` value, since `allocatedStock` is already reserved to other existing orders, and will be deducted from `physicalStock` once those are shipped. To learn more about stock statuses, see [Example stock levels and definitions](/overview/stock/#example-stock-levels-and-definitions).

If a product has multiple sizes, the API will return the stock values for each of the product sizes separately.

More information: [Order API - Get stock](https://docs.centra.com/reference/stable/order-api/get-stock)

#### Example request

```text
GET http://customer.centra.com/api/order-api/stock/?ean=5901144123590
```

#### Example response

TBD

### Updating stock

Once the purchase is done, you need to update the physical stock levels in Centra so that you don't oversell your stock. **Remember**: This endpoint works by allowing you to set the stock amount of specific product to the **new** value, **not** deduct the amount that you're just now selling. In other words, if the `physicalStock` was 499, and the customer is buying 5 items, you'll want to update the stock to 494.

[notice-box=alert]Centra will not allow you to update the `physicalStock` below what's already reserved for other orders (`allocatedStock`). If you attempt to do that, Centra will set the quantity to the lowest possible value without affecting any other orders.[/notice-box]

The `product` in the call body needs to uniquely identify product, variant and size, so you can either use a combination of `productSku`, `variantSku` and `sizeSku`, or use EAN number instead.

More information: [Order API - Update stock](https://docs.centra.com/reference/stable/order-api/update-stock)

#### Example request

```text
POST http://customer.centra.com/api/order-api/stock/
```
```json
{
  "products": [
    {
      "product": "5901144123590",
      "quantity": 494
    }
  ]
}
```

#### Example response

TBD

<!--
### [Optional] Creating an order

[This chapter is work in progress]

If you wish, Centra can store the information about an order made in your Point of Sale. To enable this feature, you need to enable an additional function in the Order API plugin configuration:

![pos-plugin-settings2.png](pos-plugin-settings2.png)

!!!!! You can create orders which will be automatically saved and finalised as "Comleted" without the need to create shipment and complete payment capture, since there will be no shipment required, and payment already happened in your Point of Sale.

When creating order, the only required fields are customer's e-mail and country, amount of products that were purchased in that order. You can specify customer data either under `address`, or as `shippingAddress` and `billingAddress` separately.

!!!!! Is stock updated automatically?

More information: [Order API - Create order](https://docs.centra.com/reference/stable/order-api/create-order)

#### Example request

```text
POST http://customer.centra.com/api/order-api/order/
```
```json
{
   "address": {
       "email": "example@example.com",
       "country": "SE",
       "firstName": "John",
       "lastName": "Smith",
       "address": "Västra Rönneholmsvägen 62",
       "zipcode": "217 41",
       "city": "Malmö"
   },
   "products": [
       {
           "ean": "ABCDEFGHIJKL",
           "qty": 2
       }
   ]
 }
 ```

#### Example response

TBD
-->


### Webhooks

When the status of a check-first order updates we will send webhooks to the configured endpoint. To receive webhooks, ensure the Centra Webhooks plugin is enabled with the Check First event trigger selected. [Click here for information on setting up webhooks](/plugins/centra-webhook)

In each of the payloads `id` refers to the order number which can be used in the Order API.

#### Create
Create events are emitted when an order using check-first warehouses is created.
The webhook contains the Id for each check-first warehouse being used, and the date at which it will time-out.

```json
{
    "events": [
        {
            "type": "check_first",
            "action": "create",
            "date": "2021-01-11 16:21:00.552288",
            "id": 19,
            "data": {
                "warehouses": [
                    {
                        "warehouseId": 2,
                        "expirationAt": "2021-01-11T15:21:00+01:00"
                    },
                    {
                        "warehouseId": 3,
                        "expirationAt": "2021-01-12T16:21:00+01:00"
                    },
                    {
                        "warehouseId": 4,
                        "expirationAt": "2021-01-12T16:21:00+01:00"
                    }
                ]
            }
        }
    ]
}
```

#### Rejected
Rejected events are emitted whenever the Check-first warehouse has been cancelled on an order.

This can happen either when an individual store rejects the order [by the Order Api](/api-references/order-api/api-reference/update-check-first) or when the "Resume" button is pressed on a check-first order from AMS.

If all are rejected the order will proceed to be processed as a regular order.

```json
{
  "events": [
    {
      "type": "check_first",
      "action": "rejected",
      "date": "2021-01-11 16:21:08.356543",
      "id": 20,
      "data": {
        "warehouseId": 3
      }
    },
    {
      "type": "check_first",
      "action": "rejected",
      "date": "2021-01-11 16:21:08.773921",
      "id": 20,
      "data": {
        "warehouseId": 4
      }
    }
  ]
}
```

#### Accepted
Accepted events are emitted when an order is accepted by a check-first [by the Order Api](/api-references/order-api/api-reference/update-check-first).

After an order is accepted it can not be accepted by any other check-first, and they are automatically rejected.
```json
{
  "events": [
    {
      "type": "check_first",
      "action": "accepted",
      "date": "2021-01-11 16:20:17.752285",
      "id": 18,
      "data": {
        "warehouseId": 4
      }
    }
  ]
}
```

#### Timeout

Timeout events are emitted after a check-first warehouse times out for an order, at the date specified in the [Create](#create) call.

After this time it is no longer possible to accept the order using this warehouse.

```json
{
  "events": [
    {
      "type": "check_first",
      "action": "timeout",
      "date": "2021-01-11 16:20:00.757946",
      "id": 18,
      "data": {
        "warehouseId": 2
      }
    }
  ]
}
```
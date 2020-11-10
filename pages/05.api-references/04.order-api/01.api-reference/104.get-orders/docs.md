---
title: Order API - Get Orders
altTitle: Get Orders
excerpt: Fetching the orders allowed for the plugin being set up.
taxonomy:
  category: docs
---

<!--
```eval_rst
.. _order-api-get-orders:
```
-->

# Get orders

```text
GET  *base*/orders?[&limit=5][&offset=5][&order=83651][&customer_id=1][&xml=1]
```

This will fetch the orders allowed for the plugin being set up.

## Parameters

[parameter data="limit" datatype="int" isRequired=false sublevel=1]
Limit amount of orders returned. Default: 20.
[/parameter]

[parameter data="offset" datatype="int" isRequired=false sublevel=1]
Offset how far in to start returning orders.
[/parameter]

[parameter data="order" datatype="int" isRequired=false sublevel=1]
Return a specific order.
[/parameter]

[parameter data="customer_id" datatype="int" isRequired=false sublevel=1]
Return orders for specified customer id.
[/parameter]

[parameter data="newer_than" datatype="date/datetime" isRequired=false sublevel=1]
Return order newer than date.  Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="newer_than" datatype="date/datetime" isRequired=false sublevel=1]
Return order newer than date.  Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="older_than" datatype="date/datetime" isRequired=false sublevel=1]
Return order newer than date. Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
   GET <base>/orders?newer_than=2019-01-01+12:11:39&limit=10 HTTP/1.1
```

<!--
```eval_rst
.. _get-orders-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="orders" datatype="array" isRequired=true sublevel=1]
Array of orders returned.
[/parameter]

[parameter data="orderId" datatype="string" sublevel=2]
ID of the order.
[/parameter]

[parameter data="orderStatus" datatype="string" sublevel=2]
Status of the order.
[/parameter]

[parameter data="selectionId" datatype="string" sublevel=2]
Selection ID of the order.
[/parameter]

[parameter data="orderDate" datatype="datetime" sublevel=2]
Date when order was created.
[/parameter]

[parameter data="products" datatype="array" sublevel=2]
Products inside the order.
[/parameter]

[parameter data="lineId" datatype="string" sublevel=3]
ID of the specific product item in this order.
[/parameter]

[parameter data="qty" datatype="int" sublevel=3]
Quantity of this specific product item.
[/parameter]

[parameter data="isBundle" datatype="boolean" sublevel=3]
Flag showing if product is bundle
[/parameter]

[parameter data="isPartOfBundle" datatype="int" sublevel=3]
Bundle id
[/parameter]

[parameter data="bundle" datatype="array" sublevel=3]
Array of containing items for bundle
[/parameter]

[parameter data="taxBreakdown" datatype="array" sublevel=2]
Lists all tax rules applied to the order.
[/parameter]

[parameter data="description" datatype="string" sublevel=3]
Text description of tax rule. ex: VAT
[/parameter]

[parameter data="taxPercent" datatype="float" sublevel=3]
Percentage of tax. ex 25
[/parameter]

[parameter data="value" datatype="float" sublevel=3]
How much tax. ex 20
[/parameter]

## Response example

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "status": "ok",
     "orders": [
       {
         "orderId": "83651",
         "selectionId": "7dee9426b07b13ec452f87a3b67aa6be",
         "orderDate": "2012-02-04 15:16:13",
         "cancelDate": "2012-08-04 15:16:13",
         "preferredDeliveryDate": "2012-05-04 15:16:13",
         "estimatedDeliveryDate": "2012-05-04 15:16:13",
         "orderStore": "retail",
         "orderCurrency": "EUR",
         "customerId": "12345",
         "accountId": "",
         "deliveryName": "Someones Name",
         "deliveryCompany": "",
         "deliveryEmail": "deliveries@example.com",
         "deliveryCell": "+4912345678",
         "deliveryTele": "",
         "deliveryAddress": "Examplestreet 1",
         "deliveryCoaddress": "",
         "deliveryZipcode": "12345",
         "deliveryCity": "Somecity",
         "deliveryState": "",
         "deliveryCountry": "DE",
         "billingName": "Someones Name",
         "billingCompany": "",
         "billingEmail": "billing@example.com",
         "billingTele": "",
         "billingAddress": "Examplestreet 1",
         "billingCoaddress": "",
         "billingZipcode": "12345",
         "billingCity": "Somecity",
         "billingState": "",
         "billingCountry": "DE",
         "billingVAT": "",
         "poNumber": "",
         "shippingList": "standard",
         "suspect": 0,
         "internalOrder": 0,
         "hold": 0,
         "shippingValue": 25,
         "voucherValue": 0,
         "grandTotalValue": 3978.75,
         "grandTotalTaxValue": 795.75,
         "taxAdded": 0,
         "taxDeducted": 0,
         "internalComment": "",
         "otherComment": "",
         "marketId": 1,
         "pricelistId": 1,
         "ipAddress": "127.0.0.1",
         "paymentType": "free",
         "paymentDescription": "",
         "defaultCarrier": "",
         "shipments": [
            {
                "shipmentId": "16-1",
                "shippedDate": "0000-00-00 00:00:00",
                "carrier": "",
                "service": "",
                "trackingId": "",
                "trackingUrl": "",
                "returnSlipTracking": "",    
            }
         ],
         "totalItemsPriceTax": -202.88,
         "totalItemsPrice": 811.5,
         "totalItemsWithoutTax": 608.62,
         "taxBreakdown": [
           {
             "description": "VAT",
             "taxPercent": 25,
             "value": 795.75
           }
         ],
         "products": [
           {
             "lineId": "43243",
             "sku": "S123K345U1",
             "variantSku": "",
             "sizeSku": "",
             "ean": "1234567890123",
             "name": "Product #1",
             "variant": "White",
             "brand": "Brand",
             "size": "XS",
             "qty": 1,
             "originalPrice": 500.5,
             "price": 450.5,
             "weight": 2,
             "weightUnit": "kg",
             "countryOfOrigin": "DE",
             "harmCode": "12345",
             "comment": "",
             "otherComment": "",
             "taxPercent": 0,
             "priceDiscount": 50.0,
             "priceDiscountAsPercent": 0,
             "taxValue": 112.63,
             "totalPrice": 450.5,
             "anyDiscount": false,
             "priceEachWithoutTax": 337.87,
             "priceEachReduction": 0,
             "warehouses": [
                {
                    "name": "Default",
                    "itemQty": 1
                }
             ],
            "isBundle": false,
            "isPartOfBundle": "217"
           },
           {
             "lineId": "43244",
             "sku": "S123K345U2",
             "variantSku": "",
             "sizeSku": "",
             "ean": "1234567890124",
             "name": "Product #2",
             "variant": "Blue",
             "brand": "Brand",
             "size": "XS",
             "qty": 2,
             "originalPrice": 200.5,
             "price": 180.5,
             "weight": 1.5,
             "weightUnit": "kg",
             "countryOfOrigin": "CI",
             "harmCode": "12345",
             "comment": "",
             "taxPercent": 25,
             "priceDiscount": 0,
             "priceDiscountAsPercent": 0,
             "taxValue": 90.25,
             "totalPrice": 361,
             "anyDiscount": false,
             "priceEachWithoutTax": 270.75,
             "priceEachReduction": 0,
             "warehouses": [
                {
                    "name": "Default",
                    "itemQty": 2
                }
             ],
             "isBundle": true,
             "bundle": [
               {
                 "lineId": "43243",
                 "sku": "S123K345U1",
                 "variantSku": "",
                 "sizeSku": "",
                 "ean": "1234567890123",
                 "name": "Product #1",
                 "variant": "White",
                 "brand": "Brand",
                 "size": "XS",
                 "qty": 1,
                 "originalPrice": 500.5,
                 "price": 450.5,
                 "weight": 2,
                 "weightUnit": "kg",
                 "countryOfOrigin": "DE",
                 "harmCode": "12345",
                 "comment": "",
                 "otherComment": "",
                 "taxPercent": 0,
                 "priceDiscount": 50.0,
                 "priceDiscountAsPercent": 0,
                 "taxValue": 112.63,
                 "totalPrice": 450.5,
                 "anyDiscount": false,
                 "priceEachWithoutTax": 337.87,
                 "priceEachReduction": 0,
                 "warehouses": [
                    {
                        "name": "Default",
                        "itemQty": 1
                    }
                 ],
                "isBundle": false,
                "isPartOfBundle": "217"
               },
            ]
           }
         ],
         "totalItemsDiscount": 38.11,
         "discounts": {
            "anyDiscount": false,
            "discount": "0.00 USD",
            "discountAsNumber": 0,
            "vouchers": [
              {
                "voucher": "vip123",
                "name": "Some voucher",
                "priceOff": "-150.00 USD",
                "priceOffAsANumber": -150.0,
                "description": "This is VIP code description"
              }
            ],
            "automaticDiscounts": [
              {
                "automaticDiscount": "12345",
                "name": "Some discount",
                "priceOff": "0.00 USD",
                "priceOffAsANumber": 0 
              }
            ]
         }
       }
     ]
   }
```

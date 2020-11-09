---
title: Order API - Get Supplier Delivery
altTitle: Get Supplier Delivery
excerpt: Getting the incoming and not accepted deliveries that are connected to the warehouse this plugin is connected to.
taxonomy:
  category: docs
---

<!--
```eval_rst
.. _order-api-get-supplier-delivery:
```
-->

# Get supplier delivery

```text
GET *base*/supplier-deliveries/*supplierDeliveryId*
```

Get the incoming and not accepted deliveries that are connected to the warehouse this plugin is connected to.

Deliveries will be listed when these requirements are fulfilled:

* Delivery created on a confirmed Supplier Order.
* Supplier order has the Preferred Warehouse set to the "Supplier Delivery Warehouse" in the Plugin.
* Delivery is not accepted yet.
* Delivery has items in it.

## Parameters

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

Both `id` and `deliveryId` from [List supplier deliveries](list-supplier-deliveries) can be used to fetch a supplier delivery.

```http
   GET <base>/supplier-deliveries/*supplierDeliveryId* HTTP/1.1
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="boolean" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="delivery" datatype="object" isRequired=true sublevel=1]
Information about this specific supplier order delivery.
[/parameter]

[parameter data="id" datatype="string" sublevel=2]
Internal ID for the supplier order delivery.
[/parameter]

[parameter data="deliveryId" datatype="string" sublevel=2]
ID of the supplier order delivery. This is the ID communicated externally.
[/parameter]

[parameter data="orderId" datatype="string" sublevel=2]
ID of the supplier order.
[/parameter]

[parameter data="supplierCountry" datatype="string" sublevel=2]
ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).
[/parameter]

[parameter data="created" datatype="datetime" sublevel=2]
The date this supplier order delivery was created.
[/parameter]

[parameter data="ETA" datatype="datetime" sublevel=2]
Estimated time of arrival to the warehouse. This will be used to calculate what orders that should be automatically connected to this specific delivery.
[/parameter]

[parameter data="ETD" datatype="datetime" sublevel=2]
Estimated time of delivery for the customer.
[/parameter]

[parameter data="productsQty" datatype="int" sublevel=2]
The total quantity of products in this supplier order.
[/parameter]

[parameter data="products" datatype="array" sublevel=2]
The product items in this supplier order delivery. Most of the fields are described in the :ref:`Get stock response <order-api-get-stock-response>` but the following ones are specific to supplier order deliveries:
[/parameter]

[parameter data="quantity" datatype="int" sublevel=3]
The amount of product items attached to this delivery.
[/parameter]

[parameter data="cost" datatype="string" sublevel=3]
The cost / pcs for this item.
[/parameter]

[parameter data="costCurrency" datatype="string" sublevel=3]
The currency code for the cost / pcs. ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).
[/parameter]

## Response example

```json
   {
     "status": "ok",
     "delivery": {
       "id": "364",
       "orderId": "957",
       "deliveryId": "957-1",
       "supplierName": "Falca",
       "supplierCountry": "ES",
       "created": "2019-01-28 01:15",
       "ETD": "2019-03-31 15:15",
       "ETA": "2019-04-05 20:15",
       "message": "Text entered by centra admin",
       "productsQty": 20000,
       "products": [
         {
           "sku": "12019005",
           "variantSku": "A",
           "sizeSku": "",
           "brand": "Kronan",
           "collection": "ALL",
           "product": "Bike Lady 0 speed BLACK",
           "variant": "SVART",
           "size": "ONE SIZE",
           "ean": "898989891212",
           "weight": 22,
           "weightUnit": "kg",
           "quantity": 122
           "cost": "9.40",
           "costCurrency": "USD"
         },
         {
           "sku": "12019007",
           "variantSku": "A",
           "sizeSku": "",
           "brand": "Kronan",
           "collection": "ALL",
           "product": "Bike Lady 0 speed BLUE",
           "variant": "BLUE",
           "size": "ONE SIZE",
           "ean": "898989891213",
           "weight": 22,
           "weightUnit": "kg",
           "quantity": 342,
           "cost": "12.40",
           "costCurrency": "EUR"
         }
       ]
     }
   }
```
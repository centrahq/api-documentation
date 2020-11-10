---
title: Order API - Get Supplier Order
altTitle: Get Supplier Order
excerpt: Listing the products inside a supplier order.
taxonomy:
  category: docs
---

# Get supplier order

```text
GET *base*/supplier-orders/*supplierOrderId*
```

List the products inside a supplier order.

## Parameters

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
   GET <base>/supplier-orders/*supplierOrderId* HTTP/1.1
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="boolean" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="order" datatype="object" isRequired=true sublevel=1]
Information about this specific supplier order.
[/parameter]

[parameter data="orderId" datatype="string" isRequired=true sublevel=2]
ID of the supplier order.
[/parameter]

[parameter data="supplierCountry" datatype="string" sublevel=2]
ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).
[/parameter]

[parameter data="created" datatype="datetime" sublevel=2]
The date this supplier order was created.
[/parameter]

[parameter data="ETA" datatype="datetime" sublevel=2]
Estimated time of arrival to the warehouse. This will be used to calculate what orders that fits into a specific delivery window.
[/parameter]

[parameter data="ETD" datatype="datetime" sublevel=2]
Estimated time of delivery for the customer.
[/parameter]

[parameter data="productsQty" datatype="int" sublevel=2]
The total quantity of products in this supplier order.
[/parameter]

[parameter data="products" datatype="array" sublevel=2]
The product items in this supplier order. Most of the fields are described in the :ref:`Get stock response <order-api-get-stock-response>` but the following ones are specific to supplier orders:
[/parameter]

[parameter data="quantity" datatype="int" sublevel=3]
The amount of product items ordered.
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
     "order": {
       "orderId": "957",
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
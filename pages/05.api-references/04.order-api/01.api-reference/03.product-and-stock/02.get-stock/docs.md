---
title: Order API - GET Stock
altTitle: GET Stock
excerpt: Returning product data from Centra with stock info
taxonomy:
  category: docs
---

<!--
```eval_rst
.. _order-api-get-stock:
```
-->

# Get stock

```text
GET *base*/stock
```

This will return product data from Centra with stock info. The values of the stock depends on the connected warehouses for the API-plugin.

## Parameters

[parameter data="sku" datatype="string" isRequired=false sublevel=1]
Get products with a specific SKU.
[/parameter]

[parameter data="modified" datatype="date/datetime" isRequired=false sublevel=1]
Get all products modified after a certain date. Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="stock_modified" datatype="date/datetime" isRequired=false sublevel=1]
Get all products which had stock changes after a certain date. Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="created" datatype="date/datetime" isRequired=false sublevel=1]
Get all products added after a certain date. Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="ean" datatype="string" isRequired=false sublevel=1]
Get a product with specified EAN code.
[/parameter]

[parameter data="productId variantId stockItemId" datatype="int" isRequired=false sublevel=1]
Get a product with specified productId, variantId or stockItemId.
[/parameter]

[parameter data="limit" datatype="int" isRequired=false sublevel=1]
You will get this amount of products, and a "next" parameter in return if there are multiple pages. This will go a lot faster to fetch, instead of fetching all products at once.
[/parameter]

[parameter data="include" datatype="string" isRequired=false sublevel=1]
``include=attributes`` will also make the products include the custom attributes defined for each product and variant.
[/parameter]

[parameter data="exclude" datatype="string" isRequired=false sublevel=1]
``exclude=physicalStock`` will exclude fetching physical stock which will speed up the fetching of the stock values.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
   GET <base>/stock?[&limit=2][&sku=DCG001][&modified=2016-01-01+12:10:11][&created=2011-01-01] HTTP/1.1
```

<!--
```eval_rst
.. _order-api-get-stock-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="products" datatype="array" sublevel=1]
List of the products.
[/parameter]

[parameter data="sku" datatype="string" sublevel=2]
SKU for this product.
[/parameter]

[parameter data="product" datatype="string" sublevel=2]
The internal name for this product.
[/parameter]

[parameter data="productId" datatype="int" sublevel=2]
The ID for this product.
[/parameter]

[parameter data="variantSku" datatype="string" sublevel=2]
SKU for this variant.
[/parameter]

[parameter data="variantId" datatype="int" sublevel=2]
ID for this variant.
[/parameter]

[parameter data="sizeSku" datatype="string" sublevel=2]
SKU for this size.
[/parameter]

[parameter data="stockItemId" datatype="int" sublevel=2]
ID for this specific stock item.
[/parameter]

[parameter data="ean" datatype="string" sublevel=2]
The EAN for this product item size.
[/parameter]

[parameter data="weight" datatype="decimal2 (0.00)" sublevel=2]
The weight specified for this product.
[/parameter]

[parameter data="weightUnit" datatype="string" sublevel=2]
The unit used for the weight.
* ``kg``
* ``lb``
[/parameter]

[parameter data="size" datatype="string" sublevel=2]
Name of the size for this specific product item.
[/parameter]

[parameter data="active" datatype="boolean" sublevel=2]
If the product item is active or not.
[/parameter]

[parameter data="countryOfOrigin" datatype="string" sublevel=2]
ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)
[/parameter]

[parameter data="physicalStock" datatype="int" sublevel=2]
The amount of items in the physical stock. If an order is placed without being shipped, the physical stock of the product does not change. However, as soon as a shipment is completed, the physical stock will decrease.

``physicalStock = allocatedStock + availableStock``
[/parameter]

[parameter data="allocatedStock" datatype="int" sublevel=2]
The amount of items in the physical stock that is currently allocated against orders.
[/parameter]

[parameter data="availableStock" datatype="int" sublevel=2]
The amount of items in the physical stock that is currently available to sell.
[/parameter]

[parameter data="previous" datatype="string" isRequired=false sublevel=1]
Will contain a URL to the previous page.
[/parameter]

[parameter data="next" datatype="string" isRequired=false sublevel=1]
Will contain a URL to the next page.
[/parameter]

## Response example

```json
   {
     "status": "ok",
     "products": [
       {
         "sku": "12019005",
         "productId": 10,
         "variantSku": "A",
         "variantId": 9,
         "sizeSku": "X",
         "brand": "Kronan",
         "collection": "ALL",
         "product": "Bike Lady 0 speed BLACK",
         "variant": "SVART",
         "size": "ONE SIZE",
         "stockItemId": 3131,
         "ean": "1234567890123",
         "weight": 22,
         "weightUnit": "kg",
         "countryOfOrigin": "",
         "harmCode": "87120030",
         "harmDescription": "Cyklar",
         "active": 1,
         "physicalStock": 5,
         "allocatedStock": 1,
         "availableStock": 4
       },
       {
         "sku": "12028008",
         "productId": 11,
         "variantSku": "B",
         "variantId": 10,
         "sizeSku": "Y",
         "brand": "Kronan",
         "collection": "ALL",
         "product": "Bike Man 0 speed BROWN",
         "variant": "BRUN",
         "size": "ONE SIZE",
         "stockItemId": 3132,
         "ean": "9876543210123",
         "weight": 22,
         "weightUnit": "kg",
         "countryOfOrigin": "",
         "harmCode": "87120030",
         "harmDescription": "CYKEL",
         "active": 1,
         "physicalStock": 141,
         "allocatedStock": 10,
         "availableStock": 131
       }
     ],
     "previous": "?limit=2&page=2",
     "next": "?limit=2&page=3"
   }
```
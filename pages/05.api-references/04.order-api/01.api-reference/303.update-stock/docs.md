---
title: Order API -  Update stock
altTitle: Update stock
excerpt: This function is designed for creation and modification of new shipments.
taxonomy:
  category: docs
---

# Update stock

Endpoint: `POST  *base*/stock`  
Authentication: [API Key](/api-references/api-intro#authentication)

This updates the `physicalStock` quantities in Centra. This is the number of products in stock including those that are reserved for orders.

[notice-box=alert]
You cannot set the quantity below the number that is reserved for orders, the value specified in ``allocatedStock`` from :ref:`Get stock <order-api-get-stock>`. In the case the stock update contains a lower amount than the allocated stock, Centra will set the quantity to ``allocatedStock`` which the lowest possible value without affecting any reserved orders.

The request will not return any error message, but an email notification can be sent to a Centra-administrator from the plugin settings.
[/notice-box]


## Parameters

[parameter data="products" datatype="array" isRequired=true sublevel=1]
Array of products to update stock on
[/parameter]

[parameter data="product" datatype="string" isRequired=true sublevel=2]
String to update a product item. Use ``ean`` or a combination of ``sku``, ``variantSku`` and ``sizeSku`` to update the quantity for each product.
[/parameter]

[parameter data="quantity" datatype="int" isRequired=true sublevel=2]
The quantity of the physical stock for the item.
[/parameter]

[parameter data="costPrice" datatype="string" isRequired=false sublevel=2]
The internal cost price for this item.
[/parameter]

[parameter data="costPriceCurrency" datatype="string" isRequired=false sublevel=2]
ISO code for the currency for the cost price. ``USD``, ``EUR``, ``SEK``, etc.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example
The example above uses EAN, this is the same field as the [Get stock](/api-references/order-api/api-reference/get-stock) product field `ean`. The example below uses SKU by combining the [Get stock](/api-references/order-api/api-reference/get-stock) fields `sku`, `variantSku` and `sizeSku`:

```http
POST <base>/stock HTTP/1.1
Content-type: application/json

{
  "products": [
    {
      "product": "1234567890123",
      "quantity": 54
    },
    {
      "product": "9876543210123",
      "quantity": 55
    },
    {
      "product": "5432167890123",
      "quantity": 1
    }
  ]
}
```

Optionally you can also include a cost / pcs value for the items.

```http
POST <base>/stock HTTP/1.1
Content-type: application/json

{
  "products":[
    {
      "product": "1234567890123",
      "quantity": 54,
      "costPrice": 12.54,
      "costPriceCurrency": "SEK"
    },
    {
      "product": "9876543210123",
      "quantity": 55,
      "costPrice": 8.12,
      "costPriceCurrency": "EUR"
    },
    {
      "product": "5432167890123",
      "quantity": 1,
      "costPrice": 54.24,
      "costPriceCurrency": "USD"
    }
  ]
}
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

[parameter data="errors" datatype="object" isRequired=false sublevel=1]
If ``status`` returns ``no``, this object might contain information about products that could not be updated.
[/parameter]

[parameter data="productsNotFound" datatype="array of string" isRequired=false sublevel=2]
This will be an array with the product identifiers that could not be updated from the request.

Like this: ``["43242342", "43243294", "432432232"]``
[/parameter]

[parameter data="productsAreBundles" datatype="array of string" isRequired=false sublevel=2]
This will be an array with the product identifiers that are bundled products. This means that they can not be updated directly, since they are based on products the bundle is connected to.

Like this: ``["43242342", "43243294", "432432232"]``
[/parameter]


## Response example

```json
{
  "status":"ok"
}
```



## Error example

```json
{
  "status": "no",
  "msg": "Some of the products were not updated",
  "errors": {
    "productsNotFound": [
      "9876543210123",
      "5432167890123"
    ]
  }
}
```


---
title: Order API - Update return
altTitle: Update return
excerpt: Update information on Return.
taxonomy:
  category: docs
---

# Update return

Endpoint: `PUT  *base*/returns/*returnId*`  
Authentication: [API Key](/api-references/api-intro#authentication)

Update information on Return.

## Parameters

[parameter data="returnId" datatype="string" isRequired=true sublevel=1]
The ID from ``return`` when creating or updating a return.
[/parameter]

[parameter data="completed" datatype="boolean" isRequired=false sublevel=1]
Set to `true`/`false` to change Return status to Complete/Pending.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
PUT <base>/returns/2 HTTP/1.1
Content-type: application/json

{
  "completed": true
}
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="return" datatype="object" isRequired=true sublevel=1]
Object of fetched return.
[/parameter]

[parameter data="returnId" datatype="int" sublevel=2]
ID of the return.
[/parameter]

[parameter data="completed" datatype="boolean" sublevel=2]
Whether the return was completed or not.
[/parameter]

[parameter data="shipment" datatype="string" sublevel=2]
Number of the shipment
[/parameter]

[parameter data="shipmentId" datatype="int" sublevel=2]
ID of the shipment
[/parameter]

[parameter data="orderId" datatype="int" sublevel=2]
ID of the order
[/parameter]

[parameter data="selectionId" datatype="string" sublevel=2]
Selection ID of the order
[/parameter]

[parameter data="customerId" datatype="int" sublevel=2]
Selection ID of the order
[/parameter]

[parameter data="date" datatype="datetime" sublevel=2]
Date when return was created.
[/parameter]

[parameter data="returnCost" datatype="float" sublevel=2]
Cost of the return.
[/parameter]

[parameter data="shippingCost" datatype="float" sublevel=2]
Cost of shipping returned
[/parameter]

[parameter data="handlingCost" datatype="float" sublevel=2]
Handling cost of the return.
[/parameter]

[parameter data="voucherValue" datatype="float" sublevel=2]
Voucher value included in the return.
[/parameter]

[parameter data="taxValue" datatype="float" sublevel=2]
Tax value of the return, zero if deducted.
[/parameter]

[parameter data="taxDeduction" datatype="float" sublevel=2]
Tax deduction in the return.
[/parameter]

[parameter data="currency" datatype="string" sublevel=2]
Currency code in which order and also return was made.
[/parameter]

[parameter data="baseCurrency" datatype="string" sublevel=2]
Code of the currency used as base in this store.
[/parameter]

[parameter data="baseCurrencyRate" datatype="float" sublevel=2]
Exchange rate between ``currency`` and ``baseCurrency`` above.
[/parameter]

[parameter data="returnToStock" datatype="boolean" sublevel=2]
Whether the return was marked as returned back to stock.
[/parameter]

[parameter data="comment" datatype="string" sublevel=2]
Optional description added to the return.
[/parameter]

[parameter data="createdFrom" datatype="string" sublevel=2]
Informs where this return originated, i.e. "Order API".
[/parameter]

[parameter data="products" datatype="array" sublevel=2]
Products inside the return.
[/parameter]

[parameter data="returnLineId" datatype="int" sublevel=3]
ID of the specific product item in this return.
[/parameter]

[parameter data="shipmentLineId" datatype="int" sublevel=3]
ID of the related shipment line.
[/parameter]

[parameter data="orderLineId" datatype="int" sublevel=3]
ID of the related order line.
[/parameter]

[parameter data="productId" datatype="int" sublevel=3]
ID of the product.
[/parameter]

[parameter data="variantId" datatype="int" sublevel=3]
ID of the product variant.
[/parameter]

[parameter data="productName" datatype="string" sublevel=3]
Name of the product.
[/parameter]

[parameter data="productBrand" datatype="string" sublevel=3]
Brand name of the product.
[/parameter]

[parameter data="variantName" datatype="string" sublevel=3]
Name of the product variant.
[/parameter]

[parameter data="size" datatype="string" sublevel=3]
Size description, if any.
[/parameter]

[parameter data="sku" datatype="string" sublevel=3]
Product SKU.
[/parameter]

[parameter data="variantSku" datatype="string" sublevel=3]
Product variant SKU.
[/parameter]

[parameter data="sizeSku" datatype="string" sublevel=3]
Size SKU
[/parameter]

[parameter data="ean" datatype="string" sublevel=3]
EAN of the item.
[/parameter]

[parameter data="quantity" datatype="int" sublevel=3]
Quantity of this specific product item returned.
[/parameter]

[parameter data="price" datatype="float" sublevel=3]
Unit price as seen on shipment
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response example

```json
{
    "status": "ok",
    "return": {
        "returnId": 18,
        "completed": false,
        "shipment": "44-1",
        "shipmentId": 1142,
        "orderId": 44,
        "selectionId": "be337d27e16564cadad0a340b8bc1fbe",
        "customerId": 31,
        "date": "2020-01-07 17:00:29",
        "returnCost": 5,
        "shippingCost": 5.55,
        "handlingCost": 9,
        "voucherValue": 0,
        "taxValue": 21.91,
        "taxDeduction": 0,
        "currency": "SEK",
        "baseCurrency": "SEK",
        "baseCurrencyRate": 1,
        "returnToStock": false,
        "comment": null,
        "createdFrom": "Order API",
        "products": [
            {
                "returnLineId": 17,
                "shipmentLineId": 2681,
                "orderLineId": 112,
                "productId": 7,
                "variantId": 2460,
                "productName": "Test Product STOCK",
                "productBrand": null,
                "variantName": null,
                "size": null,
                "sku": "TPSTOCK",
                "variantSku": "",
                "sizeSku": "",
                "ean": "StockTestEAN",
                "quantity": 1,
                "price": 100
            }
        ]
    }
}
```

## Error example

```json
{
  "status": "no",
  "msg": "Return with id=100500 does not exist"
}
```

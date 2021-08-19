---
title: Order API - Get Returns
altTitle: Get Returns
excerpt: Fetching all returns.
taxonomy:
  category: docs
---

<!--
```eval_rst
.. _order-api-get-returns:
```
-->

# Get returns

`GET  *base*/returns?[&limit=5][&page=2][&return=23]`
Authentication : [API Key](/api-references/api-intro#authentication)

Will list all returns, newest first.

## Parameters

[parameter data="limit" datatype="int" isRequired=false sublevel=1]
Limit the number of returns returned.
[/parameter]

[parameter data="page" datatype="int" isRequired=false sublevel=1]
Number of page of results to return.
[/parameter]

[parameter data="return" datatype="int" isRequired=false sublevel=1]
Only show a return with given ID.
[/parameter]

[parameter data="shipment" datatype="string" isRequired=false sublevel=1]
Only show a return with given shipment number.
[/parameter]

[parameter data="order" datatype="int" isRequired=false sublevel=1]
Only fetch returns for a specific order.
[/parameter]

[parameter data="selection" datatype="int" isRequired=false sublevel=1]
Only fetch returns for a specific selection.
[/parameter]

[parameter data="customer_id" datatype="int" isRequired=false sublevel=1]
Only fetch returns for a specific customer.
[/parameter]

[parameter data="newer_than" datatype="date/datetime" isRequired=false sublevel=1]
Only fetch returns created after given date or datetime (inclusive). Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="older_than" datatype="date/datetime" isRequired=false sublevel=1]
Only fetch returns created before given date or datetime (exclusive). Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

`GET <base>/returns?limit=2 HTTP/1.1`

<!--
```eval_rst
.. _get-returns-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="returns" datatype="array" isRequired=true sublevel=1]
Array of fetched returns.
[/parameter]

[parameter data="returnId" datatype="int" sublevel=2]
ID of the return.
[/parameter]

[parameter data="completed" datatype="boolean" sublevel=2]
Whether the return was completed or not.
[/parameter]

[parameter data="shipment" datatype="string" sublevel=2]
Number of the shipment.
[/parameter]

[parameter data="shipmentId" datatype="int" sublevel=2]
ID of the shipment.
[/parameter]

[parameter data="orderId" datatype="int" sublevel=2]
ID of the order.
[/parameter]

[parameter data="selectionId" datatype="string" sublevel=2]
Selection ID of the order.
[/parameter]

[parameter data="customerId" datatype="int" sublevel=2]
Customer ID of the order.
[/parameter]

[parameter data="date" datatype="datetime" sublevel=2]
Date when return was created.
[/parameter]

[parameter data="returnCost" datatype="float" sublevel=2]
Cost of the return.
[/parameter]

[parameter data="shippingCost" datatype="float" sublevel=2]
Cost of shipping returned.
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
Size SKU.
[/parameter]

[parameter data="ean" datatype="string" sublevel=3]
EAN of the item.
[/parameter]

[parameter data="quantity" datatype="int" sublevel=3]
Quantity of this specific product item returned.
[/parameter]

[parameter data="price" datatype="float" sublevel=3]
Unit price as seen on shipment.
[/parameter]

## Response example

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "status": "ok",
    "returns": [
        {
            "returnId": 385,
            "completed": false,
            "shipment": "20059-1",
            "shipmentId": 8039,
            "orderId": 20059,
            "selectionId": "8bf93dd57e9ebf9291c8c3a5f0cb63bf",
            "customerId": 416715,
            "date": "2019-07-11 14:34:32",
            "returnCost": 0,
            "shippingCost": 0,
            "handlingCost": 0,
            "voucherValue": 0,
            "taxValue": 21.41,
            "taxDeduction": 0,
            "currency": "EUR",
            "baseCurrency": "SEK",
            "baseCurrencyRate": 10.6453,
            "returnToStock": true,
            "comment": "Godkänd retur",
            "createdFrom": "Order API",
            "products": [
                {
                    "returnLineId": 555,
                    "shipmentLineId": 30672,
                    "orderLineId": 60288,
                    "productId": 159,
                    "variantId": 372,
                    "productName": "Muffin man",
                    "productBrand": "Handcrafted",
                    "variantName": "Big cart",
                    "size": "One Size",
                    "sku": "MUF1042",
                    "variantSku": "",
                    "sizeSku": "",
                    "ean": "7340112910426",
                    "quantity": 1,
                    "price": 124.1
                }
            ]
        },
        {
            "returnId": 384,
            "shipment": "20179-1",
            "shipmentId": 8094,
            "orderId": 20179,
            "selectionId": "ae6eb1befe5d6f850a016932ca4276dc",
            "customerId": 734042,
            "date": "2019-07-11 14:33:56",
            "returnCost": 0,
            "shippingCost": 0,
            "handlingCost": 0,
            "voucherValue": 0,
            "taxValue": 9.08,
            "taxDeduction": 0,
            "currency": "GBP",
            "baseCurrency": "SEK",
            "baseCurrencyRate": 11.61479,
            "returnToStock": true,
            "comment": null,
            "createdFrom": "Order API",
            "products": [
                {
                    "returnLineId": 553,
                    "shipmentLineId": 30800,
                    "orderLineId": 60669,
                    "productId": 196,
                    "variantId": 430,
                    "productName": "Plush Guitar",
                    "productBrand": "",
                    "variantName": "Pink",
                    "size": null,
                    "sku": "PNKG8484",
                    "variantSku": "",
                    "sizeSku": "",
                    "ean": "7340082321862",
                    "quantity": 1,
                    "price": 54.5
                }
            ]
        }
    ]
}
```

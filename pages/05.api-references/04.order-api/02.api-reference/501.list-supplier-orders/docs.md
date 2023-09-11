---
title: Order API - List supplier orders
altTitle: List supplier orders
excerpt: Get all confirmed supplier orders visible by the plugin.
taxonomy:
  category: docs
---

# List supplier orders

Endpoint: `GET *base*/supplier-orders`  
Authentication: [API Key](/api-references/api-intro#authentication)

Get all confirmed supplier orders visible by the plugin.

## Parameters

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

`GET <base>/supplier-orders HTTP/1.1`

<!--
```eval_rst
.. _order-api-list-supplier-deliveries-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="orders" datatype="array" isRequired=required sublevel=1]
Array of orders returned
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


## Response example

```json
{
  "status": "ok",
  "orders": [
    {
      "orderId": "957",
      "supplierName": "Falca",
      "supplierCountry": "ES",
      "created": "2019-01-28 01:15",
      "ETD": "2019-03-31 15:15",
      "ETA": "2019-04-05 20:15",
      "message": "Text entered by centra admin",
      "productsQty": 20000
    },
    {
      "orderId": "957",
      "supplierName": "Falca",
      "supplierCountry": "ES",
      "created": "2019-01-28 01:15",
      "ETD": "2019-03-31 15:15",
      "ETA": "2019-04-05 20:15",
      "message": "Text entered by centra admin",
      "productsQty": 10000
    }
  ]
}
```
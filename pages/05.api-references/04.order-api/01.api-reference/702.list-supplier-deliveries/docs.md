---
title: Order API - List supplier deliveries
altTitle: List supplier deliveries
excerpt: Get the incoming and not accepted deliveries that are connected to the warehouse this plugin is connected to.
taxonomy:
  category: docs
---

# List supplier deliveries

```text
GET *base*/supplier-deliveries
```
Authentication : [API Key](/api-references/api-intro#authentication)

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

```http
   GET <base>/supplier-deliveries HTTP/1.1
```

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

[parameter data="deliveries" datatype="array" isRequired=required sublevel=1]
Array of deliveries returned
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

## Response example

```json
   {
     "status": "ok",
     "deliveries": [
       {
         "id": "364",
         "orderId": "957",
         "deliveryId": "957-1",
         "supplierName": "Falca",
         "supplierCountry": "ES",
         "created": "2019-01-28 01:15",
         "ETD": "2019-03-31 15:15",
         "ETA": "2019-04-05 20:15",
         "message": "Text entered by centra admin",
         "productsQty": 20000
       },
       {
         "id": "365",
         "orderId": "957",
         "deliveryId": "957-2",
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
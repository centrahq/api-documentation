---
title: Order API - GET Voucher
altTitle: GET Voucher
excerpt: Fetching active/inactive voucher by specified ID.
taxonomy:
  category: docs
---

# Get voucher

```text
GET *base*/vouchers/*id*
```

Return active/inactive voucher by specified ID. Cancelled vouchers are ignored. 

## Parameters

[parameter data="id" datatype="int" isRequired=true sublevel=1]
Voucher id.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http request
   GET <base>/vouchers/1 HTTP/1.1
```

<!--
```eval_rst
.. _order-api-get-voucher-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="voucher" datatype="object" isRequired=true sublevel=1]
The voucher object.
[/parameter]

[parameter data="id" datatype="int" sublevel=2]
ID of the voucher.
[/parameter]

[parameter data="name" datatype="string" sublevel=2]
Name for the voucher.
[/parameter]

[parameter data="code" datatype="string" sublevel=2]
Code of the voucher
[/parameter]

[parameter data="startDate" datatype="date" sublevel=2]
The date in ``Y-m-d`` format when the voucher starts being active
[/parameter]

[parameter data="stopDate" datatype="date" sublevel=2]
The date in ``Y-m-d`` format when the voucher stops being active
[/parameter]

[parameter data="type" datatype="string" sublevel=2]
Type of the voucher e.g. `priceoff`, `percentoff`
[/parameter]

[parameter data="value" datatype="float" sublevel=2]
Value of the voucher. Exists for `percentoff` voucher type
[/parameter]

[parameter data="valueByPrcelist" datatype="object" sublevel=2]
Value of the voucher for each price list. Contains id of price list to value. Exists for `priceoff` voucher type
[/parameter]

[parameter data="store" datatype="int" sublevel=2]
Store the voucher is valid for
[/parameter]

[parameter data="markets" datatype="array" sublevel=2]
List of the markets voucher is valid for
[/parameter]

[parameter data="limit" datatype="int" sublevel=2]
The voucher max usage limit
[/parameter]

[parameter data="status" datatype="string" sublevel=2]
Status of the voucher. One of `active`, `inactive`
[/parameter]

[parameter data="priority" datatype="int" sublevel=2]
The voucher priority
[/parameter]

[parameter data="conversionHtml" datatype="string" sublevel=2]
Conversion html for voucher
[/parameter]

[parameter data="createdAt" datatype="datetime" sublevel=2]
The date in ``Y-m-d H-i-s`` format when the voucher was created.
[/parameter]

## Response example

```json
   {
       "status": "ok",
       "voucher": {
           "id": 1,
           "name": "Welcome 10%",
           "code": "welcome10",
           "conversionHtml": "",
           "startDate": "2020-06-26",
           "stopDate": "2020-07-09",
           "type": "percentoff",
           "value": "10",
           "store": 1,
           "markets": [
               1
           ],
           "limit": 1,
           "status": "active",
           "priority": 1,
           "createdAt": "2020-06-25 12:00:00"
       }
   }
```

```json
   {
       "status": "ok",
       "voucher": {
           "id": 1,
           "name": "Welcome 10",
           "code": "welcome10",
           "conversionHtml": "",
           "startDate": "2020-06-26",
           "stopDate": "2020-07-09",
           "type": "priceoff",
           "value": null,
           "valueByPricelist": {
               "1": 10,
               "2": 44,
               "3": 13,
               "4": 130,
           },
           "store": 1,
           "markets": [
               1
           ],
           "limit": 1,
           "status": "active",
           "priority": 1,
           "createdAt": "2020-06-25 12:00:00"
       }
   }
```
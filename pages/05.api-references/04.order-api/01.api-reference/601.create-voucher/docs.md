---
title: Order API - Create Voucher
altTitle: Create Voucher
excerpt: Creating voucher.
taxonomy:
  category: docs
---

# Create voucher

`POST  *base*/voucher`
Authentication : [API Key](/api-references/api-intro#authentication)

This will create a simple voucher of `percentoff` or `priceoff` type

## Parameters

[parameter data="name" datatype="string" isRequired=true sublevel=1]
Name of the voucher.
[/parameter]

[parameter data="code" datatype="string" isRequired=false sublevel=1]
Code of the voucher. Will be generated a random one if not passed.
[/parameter]

[parameter data="startDate" datatype="string" isRequired=false sublevel=1]
Start date of the voucher in `Y-m-d` format. Will be set to current one if not passed.
[/parameter]

[parameter data="stopDate" datatype="string" isRequired=true sublevel=1]
Stop date of the voucher in `Y-m-d` format.
[/parameter]

[parameter data="type" datatype="enum" isRequired=true sublevel=1]
Type of the voucher. One of `percentoff` or `priceoff`
[/parameter]

[parameter data="value" datatype="float" isRequired=false sublevel=1]
Value of the voucher. Is required if `percentoff` is a voucher type
[/parameter]

[parameter data="valueByPricelist" datatype="object" isRequired=false sublevel=1]
Values by pricelist of the voucher, where price list ID is a key and discount is a value. Is required if `priceoff` is a voucher type.
[/parameter]

[parameter data="store" datatype="int" isRequired=true sublevel=1]
Store id for voucher
[/parameter]

[parameter data="markets" datatype="int|array" isRequired=true sublevel=1]
Markets for voucher 
[/parameter]

[parameter data="limit" datatype="int" isRequired=false sublevel=1]
Limit of the voucher usage, where `0` means unlimited. Is `0` if not passes.
[/parameter]

[parameter data="status" datatype="boolean" isRequired=true sublevel=1]
Is voucher `active` or `inactive`
[/parameter]

[parameter data="conversionHtml" datatype="string" isRequired=false sublevel=1]
Conversion html of the voucher
[/parameter]

## Request example

```http
POST <base>/voucher HTTP/1.1

{
    "name": "Welcome 10%",
    "stopDate": "2020-07-09",
    "type": "percentoff",
    "value": 10,
    "store": 1,
    "markets": 1,
    "status": true
}
```

<!--
```eval_rst
.. _order-api-create-voucher-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="voucher" datatype="int" isRequired=false sublevel=1]
ID of a created voucher
[/parameter]

[parameter data="code" datatype="string" isRequired=false sublevel=1]
Code of a created voucher
[/parameter]

## Response example

```json
{
    "status": "ok",
    "voucher": 13,
    "code": "quooquadi_t6uqwecifin"
}
```
## Errors example

Required fields are not passed
```json
{
    "status": "no",
    "msg": {
        "name": "required",
        "stopDate": "required",
        "type": "required",
        "store": "required",
        "markets": "required",
        "status": "required"
    }
}
```

Market does not exist for a provided store
```json
{
    "status": "no",
    "msg": {
        "markets": "Market 2 not found."
    }
}
```

Neither `value` nor `valueByPricelist` provided

```json
{
    "status": "no",
    "msg": {
        "value": "One of 'value' or 'valueByPricelist' should be provided."
    }
}
```

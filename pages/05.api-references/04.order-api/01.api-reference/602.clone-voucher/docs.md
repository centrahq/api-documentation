---
title: Order API - Clone Voucher
altTitle: Clone Voucher
excerpt: Cloning voucher.
taxonomy:
  category: docs
---

# Clone voucher

```text
PUT  *base*/voucher/*id*/clone
```

This will clone a voucher with updated provided information

## Parameters

[parameter data="name" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
Name of the voucher.
[/parameter]

[parameter data="code" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
Code of the voucher. Will be generated a random one if not passed.
[/parameter]

[parameter data="stopDate" datatype="string" isRequired=true storetype="b2b b2c" sublevel=1]
Stop date of the voucher in `Y-m-d` format.
[/parameter]

[parameter data="conversionHtml" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
Conversion html of the voucher
[/parameter]

## Request example

```http
   PUT <base>/voucher/3/clone HTTP/1.1

   {
      "name": "Welcome 10%",
      "code": "new-welcome-10",
      "stopDate": "2022-07-09"
   }
```

## Response

`200` `Content-type: application/json`


[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="voucher" datatype="int" isRequired=false sublevel=1]
Id of a new voucher
[/parameter]

[parameter data="code" datatype="string" isRequired=false sublevel=1]
Code of a new voucher
[/parameter]

## Response example

```json
   {
       "status": "ok",
       "voucher": 4,
       "code": "new-welcome-10"
   }
```
## Errors example

Required fields are not passed
```json
   {
       "status": "no",
       "voucher": "4",
       "msg": {
           "stopDate": "required"
       }
   }
```

Voucher not found
```json
   {
       "status": "no",
       "voucher": "3",
       "msg": {
           "voucher": "Voucher not found"
       }
   }
```

Auto vouchers not supported
```json
   {
       "status": "no",
       "voucher": "3",
       "msg": {
           "voucher": "Auto vouchers not supported"
       }
   }
```

Voucher does not belong to this store
```json
   {
       "status": "no",
       "voucher": "3",
       "msg": {
           "voucher": "Voucher does not belong to this store"
       }
   }
```

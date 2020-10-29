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

<!--
```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: PUT
   :url: *base*/voucher/*id*/clone

.. authentication::
   :api_key: true
```
-->

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

<!--
```eval_rst
.. list-table::
   :widths: auto

   * - ``name``

       .. type:: string
          :required: false

     - Name of the voucher.

   * - ``code``

       .. type:: string
          :required: false

     - Code of the voucher. Will be generated a random one if not passed.

   * - ``conversionHtml``

       .. type:: string
          :required: false

     - Conversion html of the voucher

```
-->

## Request example

```http request
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

<!--
```eval_rst
.. list-table::
   :widths: auto

   * - ``status``

       .. type:: string
          :required: true

     - ``ok`` if success, else ``no``.

   * - ``voucher``

       .. type:: int
          :required: false

     - Id of a new voucher

   * - ``code``

       .. type:: string
          :required: false

     - Code of a new voucher
```
-->

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

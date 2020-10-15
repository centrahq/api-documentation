# Create voucher

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/voucher

.. authentication::
   :api_key: true
```

This will create a simple voucher of `percentoff` or `priceoff` type

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``name``

       .. type:: string
          :required: true

     - Name of the voucher.

   * - ``code``

       .. type:: string
          :required: false

     - Code of the voucher. Will be generated a random one if not passed.

   * - ``startDate``

       .. type:: string
          :required: false

     - Start date of the voucher in `Y-m-d` format. Will be set to current one if not passed.

   * - ``stopDate``

       .. type:: string
          :required: true

     - Stop date of the voucher in `Y-m-d` format.

   * - ``type``

       .. type:: enum
          :required: true

     - Type of the voucher. One of `percentoff` or `priceoff`

   * - ``value``

       .. type:: float
          :required: false

     - Value of the voucher. Is required if `percentoff` is a voucher type

   * - ``valueByPricelist``

       .. type:: object
          :required: false

     - Values by pricelist of the voucher, where price list ID is a key and discount is a value. Is required if `priceoff` is a voucher type. 

   * - ``store``

       .. type:: int
          :required: true

     - Store id for voucher 

   * - ``markets``

       .. type:: int|array
          :required: true

     - Markets for voucher 

   * - ``limit``

       .. type:: int
          :required: false

     - Limit of the voucher usage, where `0` means unlimited. Is `0` if not passes. 

   * - ``status``

       .. type:: boolean
          :required: true

     - Is voucher `active` or `inactive`

   * - ``conversionHtml``

       .. type:: string
          :required: false

     - Conversion html of the voucher

```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

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

```eval_rst
.. _order-api-create-voucher-response:
```

## Response

`200` `Content-type: application/json`

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

     - Id of a created voucher

   * - ``code``

       .. type:: string
          :required: false

     - Code of a created voucher
```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
       "status": "ok",
       "voucher": 13,
       "code": "quooquadi_t6uqwecifin"
   }

```
## Errors example

Required fields are not passed
```eval_rst
.. code-block:: json
   :linenos:

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
```eval_rst
.. code-block:: json
   :linenos:

   {
       "status": "no",
       "msg": {
           "markets": "Market 2 not found."
       }
   }
```

Neither `value` nor `valueByPricelist` provided

```eval_rst
.. code-block:: json
   :linenos:

   {
       "status": "no",
       "msg": {
           "value": "One of 'value' or 'valueByPricelist' should be provided."
       }
   }

```

# Get voucher

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/vouchers/*id*

.. authentication::
   :api_key: true
```

Return active/inactive voucher by specified Id. Cancelled vouchers are ignored. 

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``id``

       .. type:: int
          :required: true

     - Voucher id.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/vouchers/1 HTTP/1.1

```

```eval_rst
.. _order-api-get-voucher-response:
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

       .. type:: object
          :required: true

     - The voucher object.

       .. list-table::
          :widths: auto

          * - ``id``

              .. type:: int

            - ID of the voucher.

          * - ``name``

              .. type:: string

            - Name for the voucher.

          * - ``code``

              .. type:: string

            - Code of the voucher

          * - ``startDate``

              .. type:: date

            - The date in ``Y-m-d`` format when the voucher starts being active
          
          * - ``stopDate``

              .. type:: date

            - The date in ``Y-m-d`` format when the voucher stops being active

          * - ``type``

              .. type:: string

            - Type of the voucher e.g. `priceoff`, `percentoff`

          * - ``value``

              .. type:: float

            - Value of the voucher. Exists for `percentoff` voucher type

          * - ``valueByPrcelist``

              .. type:: object

            - Value of the voucher for each price list. Contains id of price list to value. Exists for `priceoff` voucher type

         * - ``freeShipping``

              .. type:: bool

            - Information if there is a free shipping applied in addition to price or percentage discount; `true` if yes, `false` otherwise.
            
          * - ``store``

              .. type:: int

            - Store the voucher is valid for

          * - ``markets``

              .. type:: array

            - List of the markets voucher is valid for

          * - ``limit``

              .. type:: int

            - The voucher max usage limit

          * - ``status``

              .. type:: string

            - Status of the vaucher. One of `active`, `inactive`

          * - ``priority``

              .. type:: int

            - The voucher priority

          * - ``conversionHtml``

              .. type:: string

            - Conversion html for voucher

          * - ``createdAt``

              .. type:: datetime

            - The date in ``Y-m-d H-i-s`` format when the voucher was created.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

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

```eval_rst
.. code-block:: json
   :linenos:

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

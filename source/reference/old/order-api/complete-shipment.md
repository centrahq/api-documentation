```eval_rst
.. _order-api-complete-shipment:
```

# Complete shipment

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: PUT
   :url: *base*/shipment

.. authentication::
   :api_key: true
```

This will insert back the tracking number and carrier information to Centra. An email will be sent out to the customer with the tracking information.

```eval_rst
.. note:: You can select if you want to capture the order, this is often used if the shipments are already created inside Centra. You will get an error as response if the capture did not go through.
```

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``shipment``

       .. type:: int
          :required: true

     - Shipment ID for the shipment to complete.

   * - ``capture``

       .. type:: boolean

     - Default: ``true``. Try to capture the order. Ignored if the capture was already made earlier for the shipment.

   * - ``carrier``

       .. type:: string
          :required: false

     - Carrier used for shipping.

   * - ``service``

       .. type:: string
          :required: false

     - Service level used for shipping.

   * - ``packages``

       .. type:: int
          :required: false

     - Number of packages in shipment.

   * - ``tracking``

       .. type:: string
          :required: false

     - Tracking number for shipment.

   * - ``internalComment``

       .. type:: string
          :required: false

     - Append some text to internal comment field.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   PUT <base>/shipment HTTP/1.1
   Content-type: application/json

   {
     "shipment": "83651-1",
     "carrier": "Fedex",
     "service": "Express",
     "packages": 1,
     "trackingNumber": "TRTTET5",
     "capture": 1
   }
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

   * - ``order``

       .. type:: int

     - Order ID that was completed.

   * - ``shipment``

       .. type:: string

     - Shipment ID that was completed.

   * - ``msg``

       .. type:: string
          :required: false

     - If ``status`` returns ``no``, this value should send back a message why it failed.
```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "order": 83651,
     "shipment": "83651-1"
   }
```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "capture failed",
     "order": 83651,
     "shipment": "83651-1"
   }
```

```eval_rst
.. _order-api-capture-shipment:
```

# Capture shipment

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: PUT
   :url: *base*/capture

.. authentication::
   :api_key: true
```

This will capture the payment for a shipment. You can use this on a shipment that has `"shouldCapture": true` from [Get shipments](order-api-get-shipments).

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``shipment``

       .. type:: string
          :required: true

     - The ``shipmentId`` from :ref:`Get shipments <order-api-get-shipments>` or :ref:`Create shipment <order-api-create-shipment>`.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   PUT <base>/capture HTTP/1.1
   Content-type: application/json

   {
     "shipment": "83651-1"
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

     - Order ID that was captured.

   * - ``shipment``

       .. type:: string

     - Shipment ID that was captured.

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

# Delete shipment

```eval_rst
.. api-name:: Order API
   :version: soon deprecated

.. endpoint::
   :method: DELETE
   :url: *base*/shipments/*shipmentId*[?xml=1]

.. authentication::
   :api_key: true
```

This will delete the shipment completely. Will only work if the shipment does not have any invoices or credit notes connected to it.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``shipmentId``

       .. type:: string
          :required: false

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

   DELETE <base>/shipments/*shipmentId* HTTP/1.1

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

     - Order ID for the shipment that was deleted.

   * - ``shipment``

       .. type:: string

     - Shipment ID for the shipment that was deleted.

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
     "msg": "shipment removed",
     "order": 8,
     "shipment": "8-1"
   }
```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "shipment has invoices or creditnotes and could not be deleted.",
     "shipment": "3-1"
   }
```

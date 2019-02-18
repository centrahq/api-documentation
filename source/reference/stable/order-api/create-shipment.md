```eval_rst
.. _order-api-create-shipment:
```

# Create shipment

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/shipments

.. authentication::
   :api_key: true
```

This will create a shipment and per default try to capture from the payment provider, shipment will not be created if the capture fails.

```eval_rst
.. warning:: You have the ability to turn off capture to make it possible to edit the shipment after it has been created. However, if you explicitly turn off capture using ``"capture": false``, we will not capture the money for the order automatically, and the :ref:`order-api-complete-shipment` call MUST be made and verified that it was successful until you can ship any products.
```

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``order``

       .. type:: int
          :required: true

     - Order ID to create shipment on.

   * - ``products``

       .. type:: object
          :required: true

     - Key is ``lineID`` from the :ref:`Get orders response <get-orders-response>` and value is the ``quantity``.

       Example: ``{"products":{"1441":2}}`` will create a shipment of 2 products from item ``1441``.

       .. list-table::
          :widths: auto

          * - key in object

              .. type:: string
                 :required: true

            - ``lineID`` from the :ref:`Get orders response <get-orders-response>` referring to a specific product item in the order.

          * - value in object

              .. type:: int
                 :required: true

            - Quantity of the item that should be shipped.

   * - ``gtg``

       .. type:: boolean
          :required: false

     - Default: ``false``. Mark the shipment as good to go.

   * - ``capture``

       .. type:: boolean
          :required: false

     - Default: ``true``. If Centra should capture the shipment amount from the payment provider.

       .. warning:: Should not be turned off unless you are capturing the money somewhere else.

   * - ``shipped``

       .. type:: boolean
          :required: false

     - Default: ``true``. Mark the shipment as sent.

   * - ``carrier``

       .. type:: string
          :required: false

     - Carrier used for shipping. Only used if ``shipped`` is ``true``.

   * - ``service``

       .. type:: string
          :required: false

     - Service level used for shipping. Only used if ``shipped`` is ``true``.

   * - ``packages``

       .. type:: int
          :required: false

     - Number of packages in shipment. Only used if ``shipped`` is ``true``.

   * - ``tracking``

       .. type:: string
          :required: false

     - Tracking number for shipment. Only used if ``shipped`` is ``true``.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/shipments HTTP/1.1
   Content-type: application/json

   {
     "order": 83651,
     "products": {
       "43243": 1,
       "43244": 2
     }
   }
```

```eval_rst
.. _create-shipment-response:
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

     - Order ID that the shipment was created on.

   * - ``shipment``

       .. type:: string

     - The shipment ID for the create shipment.

   * - ``deliveryNote``

       .. type:: string
          :required: false

     - URL to a PDF delivery note for the shipment.

   * - ``proforma``

       .. type:: string
          :required: false

     - URL to a PDF proforma for the shipment.

   * - ``invoice``

       .. type:: string
          :required: false

     - URL to a PDF invoice for the shipment. Will only be set if an invoice exists.

   * - ``msg``

       .. type:: string
          :required: false

     - If ``status`` returns ``no``, this value should send back a message why it failed.

```

## Response example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "status": "ok",
     "order": 83651,
     "shipment": "83651-1",
     "deliveryNote": "http://.../delivery-note.pdf",
     "proforma": "http://.../proforma.pdf",
     "invoice": "http://.../invoice.pdf"
   }
```

## Error examples

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "order does not exist",
     "order": "1337"
   }
```

```eval_rst
.. code-block:: json
   :linenos:

   {
     "msg": "can not capture order",
     "status": "no",
     "order": "5"
   }
```

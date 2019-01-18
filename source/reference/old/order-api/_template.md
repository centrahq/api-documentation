```eval_rst
.. _order-api-template-name:
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

Text

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``invoiceAddress`` ``deliveryAddress`` ``address``

       .. type:: object
          :required: false

     - For B2B the address object is not required as it will then use default address of the B2B-account.  If ``invoiceAddress`` and ``deliveryAddress`` are the same, ``address`` can be used instead.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/order HTTP/1.1
   Content-type: application/json

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

   * - ``msg``

       .. type:: string
          :required: false

     - If ``status`` returns ``no``, this value should send back a message why it failed.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:


```

## Error example

```eval_rst
.. code-block:: json
   :linenos:


```

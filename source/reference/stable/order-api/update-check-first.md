```eval_rst
.. _order-api-update-check-first:
```

# Update Check First

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/check-first

.. authentication::
   :api_key: true
```

This will update the status of a check-first warehouse on an order.  

```eval_rst
.. warning:: Updating a check first for an order is irreversible. Once an order has been accepted or rejected, it can no longer be changed. 
```

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``orderNumber``

       .. type:: int
          :required: true

     - Order ID to update the Check first.

   * - ``warehouseId``

       .. type:: int
          :required: true

     - Warehouse ID associated with the Check first order. 

   * - ``accepted``

       .. type:: boolean
          :required: true

     - Whether to accept or reject the Check First warehouse. ``true`` to accept, ``false`` to reject.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/check-first HTTP/1.1
   Content-type: application/json

   {
     "orderNumber": 123,
     "warehouseId": 321,
     "accepted": true
   }
```

```eval_rst
.. _update-check-first-response:
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

       .. type:: string|object
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
     "status": "ok"
   }
```

## Error examples

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": {
        "orderNumber": "invalid value",
        "warehouseId": "required",
        "accepted": "invalid value"
     }
   }
```

```eval_rst
.. code-block:: json
   :linenos:

   {
     "msg": "order does not exist",
     "status": "no",
   }
```

```eval_rst
.. code-block:: json
   :linenos:

   {
     "msg": "failed to allocate stock",
     "status": "no",
   }
```

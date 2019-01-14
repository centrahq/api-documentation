# Update order

```eval_rst
.. api-name:: Order API
   :version: soon deprecated

.. endpoint::
   :method: PUT
   :url: *base*/orders

.. authentication::
   :api_key: true
```

Update information on the order.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``order``

       .. type:: int
          :required: true

     - Order ID to update.

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

   PUT <base>/orders HTTP/1.1
   Content-type: application/json

   {
     "order": 83651,
     "internalComment": "test"
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

     - Order ID that was updated.

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
     "order": 83651
   }
```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "order in wrong market",
     "order": 83651
   }
```

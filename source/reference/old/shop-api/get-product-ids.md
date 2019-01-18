# Get product IDs

```eval_rst
.. api-name:: Shop API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/product-ids

.. authentication::
   :api_key: true
```

Fetches a list of all product IDs. This is a quicker API operation than [fetching all products](get-products) so it can be useful when e.g. comparing a list of products cached in the frontend to those in Centra.

## Response
`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - array

       .. type:: array of strings
          :required: true

     - Product IDs for all active products in the store.

```

## Response example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   ["123", "124", "125"]
```

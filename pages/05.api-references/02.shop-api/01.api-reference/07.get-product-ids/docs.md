---
title: Shop API - GET Products IDs
altTitle: GET Products IDs
excerpt: Fetching a list of products ids.
taxonomy:
  category: docs
---
# Get product IDs

```text
GET  *base*/product-ids
```

<!--
```eval_rst
.. api-name:: Shop API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/product-ids

.. authentication::
   :api_key: true
```
-->

Fetches a list of all product IDs. This is a quicker API operation than [fetching all products](get-products) so it can be useful when e.g. comparing a list of products cached in the frontend to those in Centra.

## Response
`200` `Content-type: application/json`

[parameter datatype="array" isRequired=true storetype="b2b b2c" sublevel=1]
Product IDs for all active products in the store.
[/parameter]

<!--
```eval_rst
.. list-table::
   :widths: auto

   * - array

       .. type:: array of strings
          :required: true

     - Product IDs for all active products in the store.

```
-->

## Response example

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   ["123", "124", "125"]
```

<!--
```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   ["123", "124", "125"]
```
-->

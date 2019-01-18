# Get brands

```eval_rst
.. api-name:: Shop API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/brands

.. endpoint::
   :method: GET
   :url: *base*/brands/*brandId*

.. authentication::
   :api_key: true
```

Fetches a specific brand referenced by its ID, or the **full** list of brands..

If the `brandId` parameter is specified, one brand is fetched, otherwise **all brands** in the catalog are fetched.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``brandId``

       .. type:: int
          :required: false

     - Brand ID as integer.

```

## Response
`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - object key

       .. type:: brand object
          :required: true

     - The ``brandId`` for the brand object.

       ``"14": {"name": "Brand X"}`` for brand ID 14.

       .. list-table::
          :widths: auto

          * - ``name``

              .. type:: string

            - The name of the brand.

          * - ``brand``

              .. type:: string

            - The ID of the brand.

          * - ``uri``

              .. type:: string

            - The URI for this brand.

          * - ``metaKeywords`` ``metaDescription`` ``metaTitle``

              .. type:: string

            - Meta data about the brand.

```

## Response example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
      "1" : {
         "name" : "Brand Name",
         "brand" : "1",
         "uri" : "brandname",
         "metaKeywords" : "",
         "metaDescription" : "",
         "metaTitle" : ""
      }
   }

```

## Error example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
      "errors" : {
         "brand" : "not found"
      }
   }
```

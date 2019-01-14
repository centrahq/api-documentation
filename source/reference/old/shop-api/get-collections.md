# Get collections

```eval_rst
.. api-name:: Shop API
   :version: soon deprecated

.. endpoint::
   :method: GET
   :url: *base*/collections

.. endpoint::
   :method: GET
   :url: *base*/collections/*collectionId*

.. authentication::
   :api_key: true
```

Fetches a specific collection referenced by its ID, or the **full** list of collections.

If the collection-id parameter is specified, one collection is fetched, otherwise **all collections** in the catalog are fetched.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``collectionId``

       .. type:: int
          :required: false

     - Collection ID as integer.

```

## Response
`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - object key

       .. type:: collection object
          :required: true

     - The ``collectionId`` for the collection object.

       ``"19": {"name": "Collection X"}`` for collection ID 19.

       .. list-table::
          :widths: auto

          * - ``name``

              .. type:: string

            - The name of the collection.

          * - ``collection``

              .. type:: string

            - The ID of the collection.

          * - ``uri``

              .. type:: string

            - The URI for this collection.

```

## Response example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "20": {
       "name" : "AW15",
       "collection" : "20",
       "uri" : "aw15"
     }
   }
```

Fetching a specific collection using `collectionId`:

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
      "name" : "AW15",
      "collection" : "20",
      "uri" : "aw15"
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
         "collection" : "not found"
      }
   }
```

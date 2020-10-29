---
title: Shop API - GET Collections
altTitle: GET Collections
excerpt: Fetching a single or multiple collections.
taxonomy:
  category: docs
---

# Get collections

```text
GET  *base*/collections
```

```text
GET  *base*/collections/*collectionId*
```

<!--
```eval_rst
.. api-name:: Shop API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/collections

.. endpoint::
   :method: GET
   :url: *base*/collections/*collectionId*

.. authentication::
   :api_key: true
```
-->

Fetches a specific collection referenced by its ID, or the **full** list of collections.

If the collection-id parameter is specified, one collection is fetched, otherwise **all collections** in the catalog are fetched.

## Parameters

[parameter data="collectionId" datatype="int" isRequired=false storetype="b2b b2c" sublevel=1]
Collection ID as integer.
[/parameter]

<!--
```eval_rst
.. list-table::
   :widths: auto

   * - ``collectionId``

       .. type:: int
          :required: false

     - Collection ID as integer.

```
-->

## Response
`200` `Content-type: application/json`

[parameter data="collectionId" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
The ``collectionId`` for the collection object.
``"19": {"name": "Collection X"}`` for collection ID 19.
[/parameter]

[parameter data="name" datatype="string" sublevel=2]
The name of the collection.
[/parameter]

[parameter data="collection" datatype="string" sublevel=2]
The ID of the collection.
[/parameter]

[parameter data="uri" datatype="string" sublevel=2]
The URI for this collection.
[/parameter]

<!--
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
-->

## Response example

```http
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

<!--
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
-->

Fetching a specific collection using `collectionId`:

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   {
      "name" : "AW15",
      "collection" : "20",
      "uri" : "aw15"
   }
```

<!--
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
-->

## Error example

```http
   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
      "errors" : {
         "collection" : "not found"
      }
   }
```

<!--
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
-->

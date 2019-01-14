# Get categories

```eval_rst
.. api-name:: Shop API
   :version: soon deprecated

.. endpoint::
   :method: GET
   :url: *base*/categories

.. endpoint::
   :method: GET
   :url: *base*/categories/*categoryId*

.. authentication::
   :api_key: true
```

Fetches a specific category referenced by its ID, or the **full** list of categories.

If the category-id parameter is specified, one category is fetched, otherwise **all categories** in the catalog are fetched.

Note that each returned category may contain nested subcategories in the "categories" attribute.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``categoryId``

       .. type:: int
          :required: false

     - Category ID as integer

```

## Response
`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - object key

       .. type:: category object
          :required: true

     - The ``categoryId`` for the category object.

       ``"18": {"name": "Category X"}`` for category ID 18.

       .. list-table::
          :widths: auto

          * - ``name``

              .. type:: string

            - The name of the category.

          * - ``category``

              .. type:: string

            - The ID of the category.

          * - ``uri``

              .. type:: string

            - The URI for this category.

          * - ``completeUri``

              .. type:: string

            - The complete URI for this category including parent categories.

          * - ``metaKeywords`` ``metaDescription`` ``metaTitle``

              .. type:: string

            - Meta data about the category.

          * - ``localized``

              .. type:: object

            - Information about localized versions of the category information. The key values in the list are the localization URIs, such as ``en``, ``fr``, ``sv`` etc.

              ``"localized": {"sv": {"name": "Byxor"}}`` the Swedish category name is "Byxor".

              .. list-table::
                 :widths: auto

                 * - ``name``

                     .. type:: string

                   - The name of the category in the localized language.

                 * - ``metaKeywords`` ``metaDescription`` ``metaTitle``

                     .. type:: string
                        :required: false

                   - Optional strings that might have a localized translation in the language object.

          * - ``categories``

              .. type:: object

            - A list of nested category objects. The keys in the object is the ``categoryId`` of the nested category.

              The objects in the list has the same parameters as the parent category.

          * - ``products``

              .. type:: array of strings

            - A list of ``productId`` for products in this category.

```

## Response example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "117": {
       "metaTitle" : "",
       "name" : "Category Name",
       "metaDescription" : "",
       "sortString" : "s-1",
       "localized" : {
          "sv" : {
             "name" : "Swedish Category Name",
             "metaTitle" : "Swedish Meta Title"
          },
       },
       "completeUri" : "category-name",
       "metaKeywords" : "",
       "category" : "117",
       "categories" : {
          "... <nested categories> ..."
       },
       "products" : [
          "665",
          "2165",
          "2177",
       ],
       "sortOrder" : "-1",
       "uri" : "category-name"
     }
   }
```

Fetching a specific category using `categoryId`:

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
      "metaTitle" : "",
      "name" : "Category Name",
      "metaDescription" : "",
      "sortString" : "s-1",
      "localized" : {
         "sv" : {
            "name" : "Swedish Category Name",
            "metaTitle" : "Swedish Meta Title"
         },
      },
      "completeUri" : "category-name",
      "metaKeywords" : "",
      "category" : "117",
      "categories" : {
         "... <nested categories> ..."
      },
      "products" : [
         "665",
         "2165",
         "2177",
      ],
      "sortOrder" : "-1",
      "uri" : "category-name"
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
         "category" : "not found"
      }
   }
```

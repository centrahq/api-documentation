# Get packages

```eval_rst
.. api-name:: Subscription API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/subscription/packages

.. authentication::
   :api_key: true
```

Receive a list of all the active packages and their price in the provided pricelist.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``pricelist``

       .. type:: string
          :required: true

     - Name of pricelist to list packages for.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/subscription/packages?pricelist=SEK HTTP/1.1

```

## Response

`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - ``packages``

       .. type:: array
          :required: true

     - List of all packages in the selected currency.

       .. list-table::
          :widths: auto

          * - ``id``

              .. type:: int

            - ID of the package.

          * - ``name``

              .. type:: string

            - Name of the package.

          * - ``price``

              .. type:: string

            - Price amount for the package.

          * - ``currency``

              .. type:: string

            - Currency code for the package. ``SEK``, ``USD``, ``EUR``, etc.

          * - ``products``

              .. type:: array

            - Array of products inside the package.

              .. list-table::
                 :widths: auto

                 * - ``id``

                     .. type:: int

                   - ID of the product.

                 * - ``size``

                     .. type:: string

                   - Size name of the product selected in the package.

                 * - ``variant``

                     .. type:: string

                   - Variant name of the product selected in the package.

                 * - ``product``

                     .. type:: string

                   - Product name.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "packages": [
       {
         "id": 1,
         "name": "Super Package 5000",
         "price": "123.50",
         "currency": "SEK",
         "products": [
           {
             "id": "1",
             "size": "S",
             "variant": "Red",
             "product": "T-shirt"
           }
         ]
       },
       {
         "id": 2,
         "name": "Super Package 10000",
         "price": "246.50",
         "currency": "SEK",
         "products": [
           {
             "id": "1",
             "size": "L",
             "variant": "Red",
             "product": "T-shirt"
           }
         ]
       }
     ]
   }
```

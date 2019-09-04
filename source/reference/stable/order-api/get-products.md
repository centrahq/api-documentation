# Get products

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/products

.. authentication::
   :api_key: true
```

This will return product data from Centra with categories.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``sku``

       .. type:: string
          :required: false

     - Get products with a specific SKU.

   * - ``modified``

       .. type:: date
          :required: false

     - Get all products modified after a certain date.

   * - ``created``

       .. type:: date
          :required: false

     - Get all products added after a certain date.

   * - ``ean``

       .. type:: string
          :required: false

     - Get a product with specified EAN code.

   * - ``productId``, ``variantId``, ``stockItemID``

       .. type:: integer
          :required: false

     - Filter products based on product, variant and stock item IDs.

   * - ``limit``

       .. type:: int
          :required: false

     - You will get this amount of products, and a "next" parameter in return if there are multiple pages. This will go a lot faster to fetch, instead of fetching all products at once.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/products HTTP/1.1
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

   * - ``products``

       .. type:: array

     - List of the products.

       .. list-table::
          :widths: auto

          * - ``sku``

              .. type:: string

            - SKU for this product.

          * - ``product``

              .. type:: string

            - The internal name for this product.

          * - ``productId``

              .. type:: integer

            - ID for this product.

          * - ``name``

              .. type:: string

            - The externally facing name for this product.

          * - ``variantSku``

              .. type:: string

            - SKU for this variant.

          * - ``variantId``

              .. type:: integer

            - ID for this variant.

          * - ``sizeSku``

              .. type:: string

            - SKU for this size.

          * - ``stockItemId``

              .. type:: integer

            - ID for this specific stock item.

          * - ``ean``

              .. type:: string

            - The EAN for this product item size.

          * - ``weight``

              .. type:: decimal2 (0.00)

            - The weight specified for this product.

          * - ``weightUnit``

              .. type:: string

            - The unit used for the weight.

              * ``kg``
              * ``lb``

          * - ``size``

              .. type:: string

            - Name of the size for this specific product item.

          * - ``active``

              .. type:: boolean

            - If the product item is active or not.

          * - ``countryOfOrigin``

              .. type:: string

            - ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)

          * - ``categories``

              .. type:: array of string

            - Array with names of the categories the product belongs to.

              Like this: ``["Collection / Jackets\/Outerwear", "..."]``.

          * - ``images``

              .. type:: array of string

            - URLs with the images connected to this product item.

              Like this: ``["https://xxx.centracdn.net/x/y/z.jpg", "https://..."]``.

          * - ``prices``

              .. type:: array

            - Array of the pricelists for this product.

              .. list-table::
                 :widths: auto

                 * - ``id``

                     .. type:: int

                   - ID of the pricelist.

                 * - ``pricelist``

                     .. type:: string

                   - Name of the pricelist.

                 * - ``price``

                     .. type:: string

                   - Price for the product in this pricelist.

                 * - ``currency``

                     .. type:: string

                   - ISO code of the currency for this pricelist.

                 * - ``campaigns``

                     .. type:: array

                   - List of campaigns this product is connected to in this pricelist.

                     .. list-table::
                        :widths: auto

                        * - ``id``

                            .. type:: int

                          - ID of the campaign.

                        * - ``campaign``

                            .. type:: string

                          - Name of the campaign.

                        * - ``price``

                            .. type:: decimal2 (0.00)

                          - The price when this campaign is applied to the price. Currency will always be the same as in the pricelist.

   * - ``previous``

       .. type:: string
          :required: false

     - Will contain a URL to the previous page.

   * - ``next``

       .. type:: string
          :required: false

     - Will contain a URL to the next page.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "products": [
       {
         "sku": "M411-740",
         "productId": 232,
         "variantSku": "",
         "variantId": 1211,
         "sizeSku": "",
         "brand": "Odd Molly",
         "collection": "Molly Prefall 2011",
         "product": "bakers cross 3\/4 blouse",
         "variant": "LITE ROSE",
         "size": "3",
         "stockItemId": 3424,
         "ean": "",
         "weight": 0.17,
         "weightUnit": "kg",
         "countryOfOrigin": "PT",
         "harmCode": "6206300090",
         "harmDescription": "Cotton - blouse",
         "active": 0,
         "folders": [
            "Folder 1",
            "Folder 2"
         ],
         "name": "Bakers Cross",
         "description": "",
         "shortDescription": "",
         "comment": "",
         "categories": [
           "Collection \/ Jackets\/Outerwear",
           "New Arrivals"
         ],
         "images": [
           "https:\/\/...\/images\/1_0d2f67cd05.jpg",
           "https:\/\/...\/images\/1_318da2ad06.jpg",
           "https:\/\/...\/images\/1_c4e1c20d34.jpg"
         ],
         "prices": [
           {
             "id": "36",
             "price": "329.00",
             "pricelist": "EUR Europe",
             "currency": "EUR",
             "campaigns": [
               {
                 "id": "40",
                 "campaign": "OUTLET 50% NY",
                 "price": 164.5
               }
             ]
           },
           {
             "id": "35",
             "price": "269.00",
             "pricelist": "GBP",
             "currency": "GBP",
             "campaigns": [
               {
                 "id": "40",
                 "campaign": "OUTLET 50% NY",
                 "price": 134.5
               }
             ]
           }
         ]
       },
       {
         "sku": "M411-740",
         "productId": 232,
         "variantSku": "",
         "variantId": 1211,
         "sizeSku": "",
         "brand": "Odd Molly",
         "collection": "Molly Prefall 2011",
         "product": "bakers cross 3\/4 blouse",
         "variant": "LITE ROSE",
         "size": "4",
         "stockItemId": 3425,
         "ean": "",
         "weight": 0.17,
         "weightUnit": "kg",
         "countryOfOrigin": "PT",
         "harmCode": "6206300090",
         "harmDescription": "Cotton - blouse",
         "active": 0,
         "name": "Bakers Cross",
         "description": "",
         "shortDescription": "",
         "comment": "",
         "categories": [
           "Collection \/ Jackets\/Outerwear",
           "New Arrivals"
         ],
         "images": [
           "https:\/\/...\/images\/1_0d2f67cd05.jpg",
           "https:\/\/...\/images\/1_318da2ad06.jpg",
           "https:\/\/...\/images\/1_c4e1c20d34.jpg"
         ]
         "prices": [
           {
             "id": "36",
             "price": "329.00",
             "pricelist": "EUR Europe",
             "currency": "EUR",
             "campaigns": [
               {
                 "id": "40",
                 "campaign": "OUTLET 50% NY",
                 "price": 164.5
               }
             ]
           },
           {
             "id": "35",
             "price": "269.00",
             "pricelist": "GBP",
             "currency": "GBP",
             "campaigns": [
               {
                 "id": "40",
                 "campaign": "OUTLET 50% NY",
                 "price": 134.5
               }
             ]
           }
         ]
       }
     ],
     "previous": "?limit=10&page=2",
     "next": "?limit=10&page=3"
   }
```

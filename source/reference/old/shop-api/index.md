# API Reference

```eval_rst
.. api-name:: Shop API
   :version: 1
```

The following endpoints are documented:

### Product catalog

* [Products: fetch all, or by ID](get-products)
* [Products: fetch filtered list](get-products-filtered)
* [Products: fetch all IDs](get-product-ids)
* [Brands: fetch all, or by ID](get-brands)
* [Categories: fetch all, or by ID](get-categories)
* [Collections: fetch all, or by ID](get-collections)
* [Measurement charts: fetch all, or by ID](get-measurement-charts)

### Campaigns

* [Campaigns: fetch all, or by ID](get-campaigns)
* [Campaign sites: fetch all, or by name](get-campaign-sites)

You can also see the API in the [Swagger UI for Shop API v1](https://docs.centra.com/swagger-ui/?api=ShopAPI).

## API URL and authorization

API access to the Shop API is enabled by activating the Shop API plugin in the System->Stores admin section of Centra. The URI name field in the configuration will be appended to the base URL for the API. For example, if the URI field is set to "shop", the full API will be:

```
http://demo.example.com/store/api/shop
```

All requests to the API need to include a secret key as authorization. The secret key is displayed in the configuration for the Shop API plugin and it should be passed as an HTTP header with each request as follows:

```
API-Authorization: <key>
```

## Parameter passing

Parameters for API requests are either passed as a part of the base URL for GET requests, e.g. `GET <base>/products/1` to fetch the product with ID 1, or as a data body for the request in the case of POST and PUT. In this case, the parameter set should be JSON encoded, for example:

```eval_rst
.. code-block:: json
  :linenos:

   {
      "categories": "117",
      "market": "1"
   }
```

## Data models

All responses from the API are provided as JSON encoded data. Data returned corresponds to the data seen in Centra's admin, and because of this the fields returned for a certain type of object will vary depending on how Centra is configured, which plugins are active, and so on.

```eval_rst
.. _shop-api-product-data-model:
```

## Product data model

```eval_rst
.. list-table::
   :widths: auto

   * - object key

       .. type:: product object
          :required: true

     - The ``product-id`` for the product object.

       ``"13": {"productSku": "ABC123"}`` for product ID 13.

       .. list-table::
          :widths: auto

          * - ``productSku``

              .. type:: string

            - The product SKU.

          * - ``items``

              .. type:: object

            - The list of items for this product. The keys in the object is the item IDs.

              ``"items": {"123": {...}}`` for item ID 123.

              .. list-table::
                 :widths: auto

                 * - ``name``

                     .. type:: string

                   - Name of the product item size.

                 * - ``ean``

                     .. type:: string

                   - EAN code of the item.

                 * - ``sku``

                     .. type:: string

                   - SKU for the item.

                 * - ``stockByMarket``

                     .. type:: object

                   - List with quantities for this item in each market. The keys in the object is the market IDs.

                     .. list-table::
                        :widths: auto

                        * - object value

                            .. type:: int

                          - The amount of items in stock for this market.

                            ``{"stockByMarket": {"23": 12}}`` means 12 items for market ID 23.

          * - ``markets``

              .. type:: object

            - The list of markets for this product. The keys in the object is the market ID.

              ``{"markets": {"23": {"pricesByPricelist": {}}}}`` will show prices for the product in market ID 23.

              .. list-table::
                 :widths: auto

                 * - ``pricesByPricelist``

                     .. type:: object

                   - The list of prices for each pricelist in this market. The keys in the object is the pricelist IDs.

                     ``{"pricesByPricelist": {"15": {"price": 123}}}}`` will show prices for the product in pricelist ID 15.

                     .. list-table::
                        :widths: auto

                        * - ``priceAsNumber``

                            .. type:: decimal2 (0.00)

                          - The price after discounts for this product in this pricelist represented as a number.

                        * - ``price``

                            .. type:: string

                          - The price after discounts for this product in this pricelist represented as a string with the proper currency formatting.

                        * - ``priceBeforeDiscountAsNumber``

                            .. type:: decimal2 (0.00)

                          - The price before discount represented as a number.

                        * - ``priceBeforeDiscount``

                            .. type:: string

                          - The price before discount represented as a string with proper currency formatting.

                        * - ``discountPercent``

                            .. type:: int

                          - The percentage of discount applied on the product price.

                        * - ``priceReductionAsNumber``

                            .. type:: decimal2 (0.00)

                          - The amount that was reduced from the current price represented as a number.

                        * - ``priceReduction``

                            .. type:: string

                          - The amount that was reduced from the current price represented as a string with proper currency formatting.

                        * - ``showAsOnSale``

                            .. type:: boolean

                          - If the product should be listed as currently on sale or not.

                        * - ``newProduct``

                            .. type:: boolean

                          - If the product should be listed as being added recently.


```

### Example response

Example object for a product with ID 12:

```eval_rst
.. code-block:: json
  :linenos:

  {
     "12" : {
        "productSku" : "ABC123",
        "canonicalUri" : "category/subcategory/example-name",
        "measurementChart" : "0",
        "weight" : 0.35,
        "sku" : "ABC123",
        "media" : [
           {
              "sources" : {
                 "thu" : {
                    "height" : 200,
                    "url" : "https://centracdn.net/client/xyz/dynamic/images/497_xyz.jpg",
                    "width" : 200,
                    "mimeType" : "image/jpeg"
                 }
              },
              "type" : "image"
           }
        ],
        "excerpt" : "... description excerpt ...",
        "google_merchant_product_group" : "xyz",
        "metaTitle" : "Example Name - Category",
        "categories" : {
           "138" : {
              "sortOrder" : "1",
              "category" : "138",
              "uri" : "category/subcategory/example-name",
              "name" : "example-name"
           }
        },
        "google_merchant_material" : "xyz",
        "metaDescription" : "... meta description ...",
        "weightUnit" : "kg",
        "canonicalCategory" : 138,
        "silkVariantName" : "",
        "harmCodeDescription" : "Harm code description",
        "items" : {
           "1198-359" : {
              "name" : "One Size",
              "ean" : "1234012340123",
              "stockByMarket" : {
                 "13" : 229,
              },
              "sku" : "ABC123",
              "item" : "1198-359"
           }
        },
        "uri" : "product-name",
        "countryOfOriginName" : "China",
        "brandName" : "brand",
        "measurementChartRows" : {},
        "markets" : {
           "13" : {
              "stockOfAllItems" : 229,
              "pricesByPricelist" : {
                 "47" : {
                    "priceBeforeDiscount" : "175.00 USD",
                    "priceAsNumber" : 175,
                    "price" : "175.00 USD",
                    "discountPercent" : 0,
                    "priceBeforeDiscountAsNumber" : 175,
                    "showAsOnSale" : false,
                    "priceReductionAsNumber" : 0,
                    "newProduct" : false,
                    "priceReduction" : "0.00 USD"
                 },
           }
        },
        "collectionName" : "SS13",
        "localized" : {
           "sv" : {
              "metaDescription" : "... meta desc sv ...",
              "name" : "product name sv",
              "description" : "... desc sv ...",
              "metaKeywords" : "... keywords sv ...",
              "excerpt" : "... excerpt sv ...",
              "metaTitle" : "title sv",
              "categories" : {
                 "138" : {
                    "name" : "name sv"
                 },
              }
           }
        },
        "name" : "Product Name",
        "countryOfOrigin" : "CN",
        "description" : "... description ...",
        "google_merchant_color" : "Beige",
        "harmCode" : "0123 01 01 01",
        "silkProductName" : "Product Name",
        "product" : "1198",
        "stockUnit" : "",
        "collection" : "14",
        "silkProduct" : "497",
        "brand" : "1",
        "silkVariant" : "1933",
        "google_merchant_product_type" : "Category",
        "variantName" : "",
        "metaKeywords" : "",
        "google_merchant_category" : "Category1 > Category2 > Category3"
     }
  }
```

## Selection data model

TBC ...

## Caching

Please note that this API is _not built for real-time querying_ for every pageview on the frontend website. Product catalog queries in particular should be cached locally by the frontend implementation for optimal performance and in order to not overload the Centra API backend. Partial cache invalidation is possible by relying on updates from Centra through the "Push URL" functionality. Checkout operations that rely on real-time information should however of course not be cached.

## Push URL

A "Push URL" can be set in the Shop API plugin configuration inside Centra's admin. Centra will send POST requests to this URL (typically on the frontend) in case certain data is updated in Centra's database and therefore should be refreshed by the frontend. The POST request contains the variable "payload", which is an array that will contain one or many of the following fields, each of them being an array with the entity IDs that have been updated in each section.

```
statics
products
pricelists
markets
maps
giftCertificates
cms
categories
campaignSites
campaigns
affiliates
```

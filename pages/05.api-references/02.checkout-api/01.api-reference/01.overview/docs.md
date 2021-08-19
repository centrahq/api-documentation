---
title: Checkout API - Overview
altTitle: Overview
excerpt: Overview of Checkout API
taxonomy:
  category: docs
---

# API reference

**POST products**

This returns a list of products. You send a JSON body to search and filter the results. Described below.

**GET products/32245**

This returns a single product.

**POST uri**

This returns a list of products in a category, or single product, depending on what the URI leads to.

**GET categories**

Returns a list of categories.


## Products Endpoint

If you use `POST products` without a JSON body, you get all products back. You use the JSON body to filter and search the products, so you get fewer back.

The response object contains these:
```json
{
  "token": "esf1p3tgchfg5ggtpqdpgqjtt6",
  "products": [...],
  "productCount": 344,
  "filter": [...]
}
```
- token: the session token that you always have in this API
- products: an array of products
- productCount: the total number of products without paging. So you can show "page 1 of 7" even if you only fetch 50 at a time.
- filter: is the filter values of the products you are viewing now, also without paging. So you know there are 35 red ones and 12 blue for example.

The request you send can contain these fields, everything is optional:
```json
{
    "skipFirst": 5,
    "limit": 10,
    "categories": [1,2,3],
    "collections": [1,2,3],
    "silkProduct": 123,
    "search": "hello world",
    "products": [1,2,3],
    "relatedProducts": true,
    "brands": [1,2,3],
    "swatch.desc": ["Red", "Blue", "Green"]
    "items.name":["W24\/L30"],
    "onlyAvailable":true,
    "uri":{
        "uri":"jeans\/black",
        "for":["product", "category"]
    }
}
```
- skipFirst + limit: for paging
- categories: you want products in these categories
- search: free text search
- relatedProducts: when a product has relatedProducts and this is true, you get the complete data for those releated products. Otherwise you will get a small subset of the data back: only the media and product id.
- swatch.desc: filtering based on the color swatch (This is a client specific field, and not all Centra instances will have this field)
- items.name: filtering on specific item names
- onlyAvailable: true means you only get back products that are in stock or available for preorder. If you also specify items.name, those items must be available.
- uri: filter on a product or category with a specific URI

If you select more "Product Filter Fields" in the Centra plugin settings, you can send them in the request and also get them back in the response in the "filter".


### Example

```http
POST products?pretty
{
  "limit": 2,
  "skipFirst": 5,
  "search": "som",
  "categories": [709],
  "swatch.desc": ["Red","Blue"]
}
```
(notice `?pretty` in the URL, this will return indented JSON)

This means products must match:

`Free text search for "som" AND category = 709 AND swatch.desc = (Red OR Blue)`

Paging is return 2 products, and skip the first 5.

So how do you know about category 709? Or that swatch.desc can be Red or Blue? This is what the "filter" in the response is for. It contains all possible filtering values, and a count of how many products matches each filtering value in the current set of filtered products and for all products.

Response:

```json
{
  "token": "esf1p3tgchfg5ggtpqdpgqjtt6",
  "products": [
    {
      "variant": "30372",
      "name": "Avery solid mohair beanie ice blue",
      "uri": "avery-solid-mohair-beanie-ice-blue",
      "sku": "SKU1SKU1",
      "productSku": "SKU1SKU1",
      "brand": "1",
      "brandName": "Some Brand",
      "brandUri": "some-brand",
      "collection": "51",
      "collectionName": "Last Season",
      "collectionUri": "last-season",
      "variantName": "smoke",
      "countryOrigin": "CN",
      "excerpt": "",
      "excerptHtml": "",
      "description": "Oversized beanie in a mohair blend",
      "descriptionHtml": "<p>Oversized beanie in a mohair blend.",
      "metaTitle": "Solid Mohair beanie | Some Brand ",
      "metaDescription": "An oversized beanie in a mohair blend.",
      "metaKeywords": "Women\\'s knitted beanie hat",
      "stockUnit": "",
      "category": "709",
      "categoryName": [
        "Women\\'s",
        "Sale"
      ],
      "categoryUri": "womens\/sale",
      "centraProduct": "26453",
      "centraVariant": "22068",
      "itemQuantityMinimum": 1,
      "itemQuantityMultipleOf": 1,
      "price": "150\u00a0SEK",
      "priceAsNumber": 150,
      "discountPercent": 70,
      "priceBeforeDiscount": "500\u00a0SEK",
      "priceBeforeDiscountAsNumber": 500,
      "showAsOnSale": true,
      "itemTable": {
        "x": [
          "onesize"
        ],
        "y": [
          ""
        ],
        "dividerSymbol": "x"
      },
      "items": [
        {
          "item": "22208-126748",
          "itemTableX": 0,
          "itemTableY": 0,
          "name": "onesize",
          "ean": "123123123",
          "sku": "SKU1SKU1"
        }
      ],
      "media": {
        "standard": [
          "https:\/\/example.net\/client\/dynamic\/images\/26453_c80b4e751c-5.jpg"
        ]
      },
      "swatch": {
        "desc": "Blue",
        "hex": "Blue"
      },
      "categories": {
        "709": {
          "category": "709",
          "name": [
            "Women\\'s",
            "Sale"
          ],
          "uri": "womens\/sale"
        }
      },
      "relatedProducts": [
      ]
    },
    {
      "product": "22069",
      "name": "Snapback baseball cap winter white",
      "uri": "snapback-baseball-cap-winter-white",
      "sku": "SKU2SKU2",
      "productSku": "SKU2SKU2",
      "brand": "1",
      "brandName": "Some Brand",
      "brandUri": "some-brand",
      "collection": "51",
      "collectionName": "Last Season",
      "collectionUri": "last-season",
      "variantName": "winter white",
      "countryOrigin": "CN",
      "excerpt": "",
      "excerptHtml": "",
      "description": "ladies\\' baseball cap\n[b]QUALITY:[\/b]\nfurpile synthetic",
      "descriptionHtml": "<p>ladies' baseball cap<br \/>\n<strong>QUALITY:<\/strong><br \/>\nfurpile synthetic<\/p>",
      "metaTitle": "Snapback baseball cap | Some Brand ",
      "metaDescription": "",
      "metaKeywords": "",
      "stockUnit": "",
      "category": "709",
      "categoryName": [
        "Women\\'s",
        "Sale"
      ],
      "categoryUri": "womens\/sale",
      "centraProduct": "26589",
      "centraVariant": "22204",
      "itemQuantityMinimum": 1,
      "itemQuantityMultipleOf": 1,
      "price": "120\u00a0SEK",
      "priceAsNumber": 120,
      "discountPercent": 70,
      "priceBeforeDiscount": "400\u00a0SEK",
      "priceBeforeDiscountAsNumber": 400,
      "showAsOnSale": true,
      "itemTable": {
        "x": [
          "onesize"
        ],
        "y": [
          ""
        ],
        "dividerSymbol": "x"
      },
      "items": [
        {
          "item": "22069-127296",
          "itemTableX": 0,
          "itemTableY": 0,
          "name": "onesize",
          "ean": "234234234",
          "sku": "SKU2SKU2"
        }
      ],
      "media": {
        "standard": [
          "https:\/\/example.net\/client\/dynamic\/images\/26589_e31b009b90-g409647021.jpg"
        ]
      },
      "swatch": {
        "desc": "Red",
        "hex": "ff0000"
      },
      "categories": {
        "709": {
          "category": "709",
          "name": [
            "Women\\'s",
            "Sale"
          ],
          "uri": "womens\/sale"
        }
      },
      "relatedProducts": [
      ]
    }
  ],
  "productCount": 7,
  "filter": [
    {
      "field": "brands",
      "values": [
        {
          "value": "1",
          "count": 7,
          "totalCount": 344,
          "data": {
            "brand": "1",
            "brandName": "Some Brand"
          }
        }
      ]
    },
    {
      "field": "categories",
      "values": [
        {
          "value": "599",
          "count": 0,
          "totalCount": 49,
          "data": {
            "category": "599",
            "name": [
              "Jeans"
            ],
            "uri": "jeans"
          }
        },
        {
          "value": "62",
          "count": 0,
          "totalCount": 23,
          "data": {
            "category": "62",
            "name": [
              "Jeans",
              "T-shirts"
            ],
            "uri": "jeans\/t-shirts",
            "inCategory": "599"
          }
        },
        {
          "value": "14",
          "count": 0,
          "totalCount": 17,
          "data": {
            "category": "14",
            "name": [
              "Jeans",
              "Shirts "
            ],
            "uri": "jeans\/shirts",
            "inCategory": "599"
          }
        },
        {
          "value": "3",
          "count": 7,
          "totalCount": 69,
          "data": {
            "category": "3",
            "name": [
              "Women\\'s"
            ],
            "uri": "womens"
          }
        },
        {
          "value": "320",
          "count": 0,
          "totalCount": 3,
          "data": {
            "category": "320",
            "name": [
              "Women\\'s",
              "Tops"
            ],
            "uri": "womens\/tops",
            "inCategory": "3"
          }
        },
        {
          "value": "709",
          "count": 7,
          "totalCount": 38,
          "data": {
            "category": "709",
            "name": [
              "Women\\'s",
              "Sale"
            ],
            "uri": "womens\/sale",
            "inCategory": "3"
          }
        }
      ]
    },
    {
      "field": "collections",
      "values": [
        {
          "value": "27",
          "count": 0,
          "totalCount": 37,
          "data": {
            "collection": "27",
            "collectionName": "Spring"
          }
        },
        {
          "value": "51",
          "count": 7,
          "totalCount": 95,
          "data": {
            "collection": "51",
            "collectionName": "Last Season"
          }
        }
      ]
    },
    {
      "field": "swatch.desc",
      "values": [
        {
          "value": "Red",
          "count": 1,
          "totalCount": 35,
          "data": {
            "desc": "Red",
            "hex": "ff0000"
          }
        },
        {
          "value": "Green",
          "count": 0,
          "totalCount": 14,
          "data": {
            "desc": "Green",
            "hex": "00ff00"
          }
        },
        {
          "value": "Blue",
          "count": 6,
          "totalCount": 12,
          "data": {
            "desc": "Blue",
            "hex": "Blue"
          }
        }
      ]
    }
  ]
}
```

The "filter" object has values for the field "swatch.desc" at the end of this JSON blob. And the last thing is value "Blue". "count":6 means there are 6 blue products in the current filtered set of products, "totalCount":12 means there are 12 blue products in total without filtering. The "data" object contains the data the frontend should use to display "Blue", it is the same data as the "swatch" on the product itself.

In the filter object, the only thing that changes depending on what you filter on is the "count". If you do not filter on anything count = totalCount.


## Routing

You can post a uri to the **POST products** endpoint to filter out products that have a specific uri or that are in a category with a specific uri:

```http
POST products?pretty
{
  "uri": {
    "uri": "jeans/slim-5-pocket-jeans-white",
    "for": ["category", "product"]
  }
}
```
You will get 1 product back for this, if a product exists with the uri "jeans/slim-5-pocket-jeans-white". The "uri" object is the URI filtering:
- uri.uri is the uri
- uri.for is what the uri is for. It can be "category" and/or "product".

There is a more generic endpoint for this:

#### POST uri
You post a uri, and what the uri can be for. Just like POST products:
```http
POST uri
{
    "uri": "jeans/slim-5-pocket-jeans-white",
    "for": ["category", "product"],
    "limit": 2,
    "skipFirst": 0
}
```
- uri is the uri
- for is what it is for. It can be "product" or "category".
- limit + skipFirst is paging, used when you get an array of products in a category or back to limit the number of products

The response changes depending on what was found. The plan is that we will add new things to this endpoint in the future, maybe CMS articles. You would then be able to POST `"for":["category", "cms"]` and get back CMS articles or a category of products. But you have to explicitly ask for it, you will not get back unknown results.

### Example: URI leads to a product

The response has `"found": "product"` and a `"product"` object:

```http
POST uri
{
    "uri": "jeans/slim-5-pocket-jeans-white",
    "for": ["category", "product"],
    "limit": 2,
    "skipFirst": 0
}
```

Response:

```json
{
  "token": "esf1p3tgchfg5ggtpqdpgqjtt6",
  "found": "product",
  "product": {
    "product": "24379",
    "name": "Slim 5-pocket jeans white",
    "uri": "slim-5-pocket-jeans-white",
    "sku": "",
    "productSku": "",
    "brand": "1",
    "brandName": "Some Brand",
    "brandUri": "some-brand",
    "collection": "55",
    "collectionName": "Summer",
    "collectionUri": "summer",
    "variantName": "white",
    "countryOrigin": "TR",
    "excerpt": "",
    "excerptHtml": "",
    "description": "Classic 5-pocket jeans",
    "descriptionHtml": "<p>Classic 5-pocket jeans<\/p>",
    "metaTitle": "Eddy 5-pocket jeans | Some Brand ",
    "metaDescription": "",
    "metaKeywords": "",
    "stockUnit": "",
    "category": "599",
    "categoryName": [
      "Jeans"
    ],
    "categoryUri": "jeans",
    "centraProduct": "26954",
    "centraVariant": "22775",
    "itemQuantityMinimum": 1,
    "itemQuantityMultipleOf": 1,
    "price": "900\u00a0SEK",
    "priceAsNumber": 900,
    "discountPercent": 0,
    "priceBeforeDiscount": "900\u00a0SEK",
    "priceBeforeDiscountAsNumber": 900,
    "showAsOnSale": false,
    "itemTable": {
      "x": [
        "W28L32",
        "W29L32",
        "W30L32",
        "W31L32",
        "W31L34",
        "W32L32",
        "W32L34",
        "W33L32",
        "W33L34",
        "W34L32",
        "W34L34",
        "W36L32",
        "W36L34",
        "W38L34"
      ],
      "y": [
        ""
      ],
      "dividerSymbol": "x"
    },
    "items": [
      {
        "item": "24379-130563",
        "itemTableX": 0,
        "itemTableY": 0,
        "name": "W28L32",
        "ean": "",
        "sku": "",
        "stock":"yes"
      },
      {
        "item": "24379-130564",
        "itemTableX": 1,
        "itemTableY": 0,
        "name": "W29L32",
        "ean": "",
        "sku": "",
        "stock":"yes"
      },
      {
        "item": "24379-130565",
        "itemTableX": 2,
        "itemTableY": 0,
        "name": "W30L32",
        "ean": "",
        "sku": "",
        "stock":"yes"
      },
      {
        "item": "24379-130566",
        "itemTableX": 3,
        "itemTableY": 0,
        "name": "W31L32",
        "ean": "",
        "sku": "",
        "stock":"yes"
      }
    ],
    "media": {
      "standard": [
        "https:\/\/example.com\/client\/dynamic\/images\/26954_09e21e4415-banner-dress-shirts_1.jpg",
        "https:\/\/example.com\/client\/dynamic\/images\/26954_7e68107548-27295_821558126c-h109916999-original5.jpg",
        "https:\/\/example.com\/client\/dynamic\/images\/26954_a506c5a76b-h105127001_d2.jpg",
        "https:\/\/example.com\/client\/dynamic\/images\/26954_a7a7ad85b3-h105127001_d1.jpg",
        "https:\/\/example.com\/client\/dynamic\/images\/26954_ebfa438d2f-h105127001_d3.jpg"
      ]
    },
    "categories": {
      "599": {
        "category": "599",
        "name": [
          "Jeans"
        ],
        "uri": "jeans"
      }
    }
  }
}
```

### Example: URI leads nowhere, API returns 404

The only difference from the previous example is the request has `"for":["category"]` but we know this uri leads to a product. So no category with that URI is found. The API returns status code 404, and the response has an "errors" object (the rest of the API follows this convention, if there are errors then the response contains an "errors" object).

```http
POST uri
{
    "uri": "jeans/slim-5-pocket-jeans-white",
    "for": ["category"],
    "limit": 2,
    "skipFirst": 0
}
```

Response header:

`HTTP/1.1 404 Not Found`

Response:

```json
{
  "token": "esf1p3tgchfg5ggtpqdpgqjtt6",
  "errors": {
    "uri": "not found"
  }
}
```

### Example: URI leads to a category, API returns a category and list of products
The response contains `"found": "category"`, the `"category"` object with the category name, and just like `POST products` it has `"products"`, `"productCount"` and `"filter"`. The content of these is exactly the same as `POST products`.

```http
POST uri
{
    "uri": "jeans",
    "for": ["category", "product"],
    "limit": 2,
    "skipFirst": 0
}
```

Response (edited to make it shorter):

```json
{
    "token": "esf1p3tgchfg5ggtpqdpgqjtt6",
    "found": "category",
    "category": {
        "category": "599",
        "name": [
            "Jeans"
        ],
        "uri": "jeans"
    },
    "products": [
        {
            "product": "32240",
            ...
        },
        {
            "product": "32245",
            ...
        }
    ],
    "productCount": 49,
    "filter": [...]
}
```

## Categories

**GET categories** returns an array of categories like this:

```json
{
  "token": "esf1p3tgchfg5ggtpqdpgqjtt6",
  "categories": [
    {
      "category": "5",
      "name": [
        "Some category"
      ],
      "uri": "some_category"
    },
    {
      "category": "3",
      "name": [
        "V\u00e4xt"
      ],
      "uri": "vaxt"
    },
    {
      "category": "4",
      "name": [
        "V\u00e4xt",
        "Buske"
      ],
      "uri": "vaxt\/buske",
      "inCategory": "3"
    },
    {
      "category": "2",
      "name": [
        "V\u00e4xt",
        "Buske",
        "Nypon"
      ],
      "uri": "vaxt\/buske\/nypon",
      "inCategory": "4"
    }
  ]
}
```

This array is sorted in the order you set in the Centra admin. Notice that some categories in the array are under-categories of another category. You see this on last two, they have the field `inCategory` with the category id of the category they are a subcategory of. Also notice the `name` array and `uri` of these, they contain the full name and uri, of the main category and under-categories.

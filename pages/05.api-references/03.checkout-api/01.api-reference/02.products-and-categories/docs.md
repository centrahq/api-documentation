---
title: Checkout API - Products and Categories
altTitle: Products and Categories
excerpt: Overview of Products and Categories
taxonomy:
  category: docs
---

## Overview

A **product** has an array of **items**. An item is the thing you buy, what you add to a selection (also called cart, basket). For clothes, the items correspond to sizes of the product, and you would buy a sweater (product) in size M (item).

Products are organized into **categories**. Each category contains a list of products. A category can also contain categories. For example, one category could be "Clothes" and that could contain a category called "Sweaters".

A product object can contain a **relatedProducts** array, this array contains other product objects. These related products are related to the main product in some way, for example, it might be the same product in different colors.

Products and categories have a **URI**. A site normally has routes leading to specific products and categories based on the URIs. A category page should usually display the products in that category. You can ask the API what a specific URI points to, and also request all products in a specific category.

In a product listing (a category page), you would usually list only the main products and maybe indicate that a product has more colors when relatedProducts is not empty. When you view a single product, you would usually display all the related products along with it.

When you filter and search in the API, you are doing that on the main product plus all the related products. For example, if you filter on blue products, you can get back a product that is red but has a blue one in relatedProducts.


## Example product
With one related product

```json
 {
  "product": "3",
  "name": "Tv\u00e5",
  "uri": "tva",
  "sku": "p1v2",
  "productSku": "p1",
  "brand": "1",
  "brandName": "Brand",
  "brandUri": "brand",
  "collection": "1",
  "collectionName": "Min kollektion",
  "collectionUri": "minkollektion",
  "variantName": "V2",
  "countryOrigin": "",
  "excerpt": "Min korta display description",
  "excerptHtml": "<p>Min korta display description<\/p>",
  "description": "Min l\u00e5nga display description!\n\n\nhej\n\n\nhej\n\n\n\nhej",
  "descriptionHtml": "<p>Min l\u00e5nga display description!<\/p>\n<p>hej<\/p>\n<p>hej<\/p>\n<p>hej<\/p>",
  "metaTitle": "min display meta title!",
  "metaDescription": "Min display meta description!",
  "metaKeywords": "Min display meta keywords!",
  "stockUnit": "",
  "category": "4",
  "categoryName": [
    "V\u00e4xt",
    "Buske"
  ],
  "categoryUri": "vaxt\/buske",
  "centraProduct": "1",
  "centraVariant": "2",
  "itemQuantityMinimum": 1,
  "itemQuantityMultipleOf": 1,
  "price": "88.89\u00a0GBP",
  "priceAsNumber": 88.89,
  "priceBeforeDiscount": "88.89\u00a0GBP",
  "discountPercent": 0,
  "showAsOnSale": false,
  "priceBeforeDiscountAsNumber": 88.89,
  "itemTable": {
    "x": [
      ""
    ],
    "y": [
      ""
    ],
    "dividerSymbol": "x"
  },
  "items": [
    {
      "item": "3-2",
      "itemTableX": 0,
      "itemTableY": 0,
      "name": "",
      "ean": "23143657879",
      "sku": "p1v2size",
      "stock": "yes"
    }
  ],
  "categories": {
    "4": {
      "category": "4",
      "name": [
        "V\u00e4xt",
        "Buske"
      ],
      "uri": "vaxt\/buske"
    },
    "3": {
      "category": "3",
      "name": [
        "V\u00e4xt"
      ],
      "uri": "vaxt"
    }
  },
  "available": true,
  "relatedProducts": [
    {
      "product": "38",
      "name": "Tv\u00e5",
      "uri": "tva",
      "sku": "p1v1",
      "productSku": "p1",
      "brand": "1",
      "brandName": "Brand",
      "brandUri": "brand",
      "collection": "1",
      "collectionName": "Min kollektion",
      "collectionUri": "minkollektion",
      "variantName": "V1",
      "countryOrigin": "",
      "excerpt": "Min korta display description",
      "excerptHtml": "<p>Min korta display description<\/p>",
      "description": "Min l\u00e5nga display description!\n\n\nhej\n\n\nhej\n\n\n\nhej",
      "descriptionHtml": "<p>Min l\u00e5nga display description!<\/p>\n<p>hej<\/p>\n<p>hej<\/p>\n<p>hej<\/p>",
      "metaTitle": "min display meta title!",
      "metaDescription": "Min display meta description!",
      "metaKeywords": "Min display meta keywords!",
      "stockUnit": "",
      "category": "4",
      "categoryName": [
        "V\u00e4xt",
        "Buske"
      ],
      "categoryUri": "vaxt\/buske",
      "centraProduct": "1",
      "centraVariant": "1",
      "itemQuantityMinimum": 1,
      "itemQuantityMultipleOf": 1,
      "price": "199.99\u00a0GBP",
      "priceAsNumber": 199.99,
      "priceBeforeDiscount": "199.99\u00a0GBP",
      "discountPercent": 0,
      "showAsOnSale": false,
      "priceBeforeDiscountAsNumber": 199.99,
      "itemTable": {
        "x": [
          ""
        ],
        "y": [
          ""
        ],
        "dividerSymbol": "x"
      },
      "items": [
        {
          "item": "38-1",
          "itemTableX": 0,
          "itemTableY": 0,
          "name": "",
          "ean": "asd",
          "sku": "p1v1",
          "stock": "yes"
        }
      ],
      "media": {
        "s_big": [
          "https:\/\/example.com\/client\/dynamic\/images\/1_aa17ecb525-nypon_frukter-s_big.jpg",
          "https:\/\/example.com\/client\/dynamic\/images\/1_97b96240d4-nypon1-s_big.jpg"
        ]
      },
      "categories": {
        "4": {
          "category": "4",
          "name": [
            "V\u00e4xt",
            "Buske"
          ],
          "uri": "vaxt\/buske"
        },
        "3": {
          "category": "3",
          "name": [
            "V\u00e4xt"
          ],
          "uri": "vaxt"
        }
      },
      "available": true
    }
  ]
}
```

## Item Table
The product data has a `itemTable` with `x` and `y` arrays. This is the x and y axis of a table. And each item in the array of `items` has `itemTableX` and `itemTableX` integer fields.

You can use this to sort and display the items in the correct order in a table.

In the example above, the products have only a single item, so it does not illustrate how this works. This example, with jeans, has more. I have removed most data, only the itemTable and a few items are left:
```json
{
  "product": "3530",
  ...
  "itemTable": {
    "x": [
      "W24",
      "W25",
      "W26",
      "W27",
      "W28",
      "W29",
      "W30",
      "W31",
      "W32",
      "W33",
      "W34",
      "W36",
      "W38"
    ],
    "y": [
      "L30",
      "L32",
      "L34",
      "L36"
    ],
    "dividerSymbol": "\/"
  },
  "items": [
    {
      "item": "4165-32694",
      "itemTableX": 0,
      "itemTableY": 0,
      "name": "W24\/L30",
      "ean": "123123123123",
      "sku": "12345-L30-W24",
      "stock": "yes"
    },
    {
      "item": "4165-32707",
      "itemTableX": 2,
      "itemTableY": 1,
      "name": "W26\/L32",
      "ean": "123123123124",
      "sku": "12345-L32-W26",
      "stock": "yes"
    }
  ]
}
```

You can display this as a table, where 4165-32694 is at `a` and `4165-32707` at `b`
```
W24 W25 W26 W27 W28 W29 W30 W31 W32 W33 W34 W36 W38
L30  a
L32          b
L34
L36
```

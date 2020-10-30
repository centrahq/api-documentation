---
title: Shop API - GET Categories
altTitle: GET Categories
excerpt: Fetching a single or multiple categories.
taxonomy:
  category: docs
---

# Get categories

```text
GET  *base*/categories
```

```text
GET  *base*/categories/*categoryId*
```

Fetches a specific category referenced by its ID, or the **full** list of categories.

If the category-id parameter is specified, one category is fetched, otherwise **all categories** in the catalog are fetched.

Note that each returned category may contain nested subcategories in the "categories" attribute.

## Parameters

[parameter data="categoryId" datatype="int" isRequired=false storetype="b2b b2c" sublevel=1]
Category ID as integer
[/parameter]

## Response
`200` `Content-type: application/json`

[parameter data="categoryId" datatype="int" isRequired=true storetype="b2b b2c" sublevel=1]
The ``categoryId`` for the category object.
``"18": {"name": "Category X"}`` for category ID 18.
[/parameter]

[parameter data="name" datatype="string" sublevel=2]
The name of the category.
[/parameter]

[parameter data="category" datatype="string" sublevel=2]
The ID of the category.
[/parameter]

[parameter data="uri" datatype="string" sublevel=2]
The URI for this category.
[/parameter]

[parameter data="completeUri" datatype="string" sublevel=2]
The complete URI for this category including parent categories.
[/parameter]

[parameter data="metaKeywords metaDescription metaTitle" datatype="string" sublevel=2]
Meta data about the category.
[/parameter]

[parameter data="localized" datatype="object" sublevel=2]
Information about localized versions of the category information. The key values in the list are the localization URIs, such as ``en``, ``fr``, ``sv`` etc.
``"localized": {"sv": {"name": "Byxor"}}`` the Swedish category name is "Byxor".
[/parameter]

[parameter data="name" datatype="string" sublevel=3]
The name of the category in the localized language.
[/parameter]

[parameter data="metaKeywords metaDescription metaTitle" datatype="string" sublevel=3]
Optional strings that might have a localized translation in the language object.
[/parameter]

[parameter data="categories" datatype="string" sublevel=2]
A list of nested category objects. The keys in the object is the ``categoryId`` of the nested category.
The objects in the list has the same parameters as the parent category.
[/parameter]

[parameter data="products" datatype="array of strings" sublevel=2]
A list of ``productId`` for products in this category.
[/parameter]

## Response example

```http
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

```http
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

```http
   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
      "errors" : {
         "category" : "not found"
      }
   }
```
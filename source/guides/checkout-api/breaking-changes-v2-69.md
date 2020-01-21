# Breaking changes in CheckoutAPI v4 v2.69

This release makes some breaking changes due to bugs affecting multi-language structure. This release also adds extended documentation using OAS v3.0.2 to easier connect with the Checkout API. Due to this, some breaking changes are introduced.

Below we describe the changes made. Most of them are properties moved into proper models. The biggest change has been introduced to partners already and was due to a bug in our language transformation: 

[5. Category structure is now consolidated, category name is always an array](#category-structure-is-now-consolidated-category-name-is-always-an-array)

## 1. Moved plugin-specific fields into pluginFields-property

The optional fields added by plugins, `selection.paymentHTML`, `selection.klarnaReplaceSnippet` and `selection.shipwallet` has moved from `selection` into `selection.pluginFields` to be able to make better documentation in OAS/Swagger.

Before:

```
{
  "selection": {
    "shippingMethodName": "SEK",
    "paymentHTML": ""
    "shipwallet": {
      "...": "..."
    },
    "centraCheckoutScript": "CentraCheckout...",
    "...": "..."
}
```

After:

```
{
  "selection": {
    "shippingMethodName": "SEK",
    "pluginFields": {
      "paymentHTML": "",
      "shipwallet": {
        "...": "..."
      },
    },
    "centraCheckoutScript": "CentraCheckout...",
    "...": "..."
}
```

## 2. Changed language to languages in Selection Response

`language` in the Selection Response containing the list of languages is now called `languages`. This is to make sure it looks similar to `GET /languages`:

Before:

```
{
  "selection": {
    "...": "..."
  },
  "language": [
    {
      "language": "en",
      "name": "English"
    },
    "...": "..."
}
```

After:

```
{
  "selection": {
    "...": "..."
  },
  "languages": [
    {
      "language": "en",
      "name": "English",
      "default": true
    },
    "...": "..."
}
```

## 3. Move market/pricelist inside the Location Model

`market` and `pricelist` are now inside the `location`-model instead of direct inside the response, to fully keep all the current session values inside the LocationModel:

Before:

```
{
  "selection": {
    "...": "..."
  },
  "market": 1,
  "pricelist": 12,
  "location": {
    "...": "..."
  }
}
```

After:

```
{
  "selection": {
    "...": "..."
  },
  "location": {
    "market": 1,
    "pricelist": 12,
    "...": "..."
  }
}
```

## 4. Language is now a LanguageModel inside the LocationModel

The `location.language` is now an object with the description of the language as well. This is to make the `location.language` the same LanguageModel like `GET /languages`.

Before:

```
{
  "selection": {
    "...": "..."
  },
  "location": {
    "language": "en"
  }
}
```

After:

```
{
  "selection": {
    "...": "..."
  },
  "location": {
    "country": "SE",
    "language": {
      "language": "en",
      "name": "English",
      "default": true
    }
  }
}
```

## 5. Category structure is now consolidated, category name is always an array

We had a bug pre **v2.69** that depending on if you provided a language or not, the `categoryXxx` and `categories`-data on products had different structure. This is now consolidated into one format only. This format is to support your own separators between nested categories without any string modification. 

**This applies to `/products`, `/selection` (since it contains products), `/uri` and `/categories` so they all look the same. `/categories` did the correct thing always.**

### For `/uri`

Before:

```json
{
  "products": [
    {
      "product": "1",
      ...
      "categoryName": "Grymt!!!", 
      "categories": [
        {
          "uri": "handla/najs/grymt", 
          "name": "Grymt!!!", 
          "category": "4"
        }
      ], 
      ...
    }
  ],
  "found": "category", 
  "category": {
    "uri": "handla/najs/grymt", 
    "name": "Grymt!!!", 
    "category": "4"
  }
}
```

After:

```json
{
  "products": [
    {
      "product": "1",
      ...
      "categoryName": [
        "Shop", 
        "Nice", 
        "Awesome / OK!"
      ], 
      "categories": [
        {
          "uri": "shop/nice/awesome-ok", 
          "name": [
            "Shop", 
            "Nice", 
            "Awesome / OK!"
          ], 
          "category": "4"
        }
      ], 
      ...
    }
  ],
  "found": "category", 
  "category": {
    "uri": "shop/nice/awesome-ok", 
    "name": [
      "Shop", 
      "Nice", 
      "Awesome / OK!"
    ], 
    "category": "4"
  }
}
```

### For `/products`


When not sending language, the proper structure was already set. When sending a `language` in the request, before:

```json
{
  "products": [
    {
      "product": "1",
      ...
      "categoryName": "Awesome / OK!", 
      "categories": [
        {
          "uri": "shop/nice/awesome-ok", 
          "name": "Awesome / OK!", 
          "category": "4"
        }
      ], 
    }
  ]
}
```

After:

```json
{
  "products": [
    {
      "product": "1",
      "...": "...",
      "categoryName": [
        "Shop", 
        "Nice", 
        "Awesome / OK!"
      ], 
      "categories": [
        {
          "uri": "shop/nice/awesome-ok", 
          "name": [
            "Shop", 
            "Nice", 
            "Awesome / OK!"
          ], 
          "category": "4"
        }
      ], 
      "...": "...",
    }
  ]
}
```

### For `/selection`

When listing items, the same logic now applies to the `selection.items[].product`:

Before:

```json
{
  "selection": {
    "items": [
      {
        "item": "1-1",
        "product": {
          "...": "..."
          "categoryName": "Shop",
          "categoryUri": "shop",
          "categories": [
            {
              "name": "Shop",
              "category": "1",
              "uri": "shop"
            }
          ],
          "...": "..."
        }
      }
    ]
  }
}
```

After:

```json
{
  "selection": {
    "items": [
      {
        "item": "1-1",
        "product": {
          "...": "..."
          "categoryName": [
            "Shop"
          ],
          "categoryUri": "shop",
          "categories": [
            {
              "name": [
                "Shop"
              ],
              "category": "1",
              "uri": "shop"
            }
          ],
          "...": "..."
        }
      }
    ]
  }
}
```

### Additional corrections

These should not have any breaking effect, but good for reference:

* When changing to an invalid payment method we returned a 404 with `errors.paymentMethod=not found` but also the current selection. This only returns the `errors` property now. 

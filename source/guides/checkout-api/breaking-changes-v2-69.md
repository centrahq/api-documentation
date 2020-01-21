# Breaking changes in CheckoutAPI v4 v2.69

This release makes some breaking changes due to bugs affecting multi-language structure. This release also adds extended documentation using OAS v3.0.2 to easier connect with the Checkout API. Due to this, some breaking changes are introduced.

**If you're using Checkout API v3 or less you are not affected by these changes.**

Below we describe the changes made. Most of them are properties moved into proper models. The biggest change has been introduced to partners already and was due to a bug in our language transformation: 

[5. Category structure is now consolidated, category name is always an array](#category-structure-is-now-consolidated-category-name-is-always-an-array)

## 1. Moved plugin-specific fields into pluginFields-property

The optional fields added by plugins, `selection.paymentHTML`, `selection.klarnaReplaceSnippet` and `selection.shipwallet` has moved from `selection` into `selection.pluginFields` to be able to make better documentation in OAS/Swagger.

**Before:**

```json
{
  "selection": {
    "shippingMethodName": "SEK",
    "paymentHTML": "",
    "shipwallet": {
      "...": "..."
    },
    "centraCheckoutScript": "CentraCheckout...",
    "...": "..."
}
```

**After:**

```json
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

**Before:**

```json
{
  "selection": {
    "...": "..."
  },
  "language": [
    {
      "language": "en",
      "name": "English"
    },
    { "...": "..." }
  ]
}
```

**After:**

```json
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
    { "...": "..." }
  ]
}
```

## 3. Move market/pricelist inside the Location Model

`market` and `pricelist` are now inside the `location`-model instead of direct inside the response, to fully keep all the current session values inside the LocationModel:

**Before:**

```json
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

**After:**

```json
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

**Before:**

```json
{
  "selection": {
    "...": "..."
  },
  "location": {
    "language": "en"
  }
}
```

**After:**

```json
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

**Before:**

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

**After:**

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


When not sending language, the proper structure was already set. 

When sending a `language` in the request the response has changed slightly.

**Before:**

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

**After:**

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

**Before:**

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

**After:**

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

## 6. No : in error keys for POST /payment

We had errors from `POST /payment` that responded with sub-sections with `:` as a separator. However, some others had `.`. We're now giving back all errors in the same format:

**Before:**

```json
{
  "errors": {
    "address.email": "required",
    "address:vatNumber": "Invalid VAT number"
  }
}
``` 

**After:**

```json
{
  "errors": {
    "address.email": "required",
    "address.vatNumber": "Invalid VAT number"
  }
}
``` 

### Additional corrections

These should not have any breaking effect, but good for reference:

* When changing to an invalid payment method we returned a 404 with `errors.paymentMethod=not found` but also the current selection. This only returns the `errors` property now, both for `POST /payment` and `POST /payment-methods/{paymentMethod}`.
* When changing to an invalid shipping method we never responded if it failed. It now responds with `errors.shippingMethod=not found` if the method could not be found.
* When changing to an invalid voucher we responded with a combination of an error and the current selection. It now responds with `errors.voucher=not found` if the voucher could not be found.
* When removing an invalid voucher we responded with a combination of an error and the current selection. It now responds with `errors.voucher=not found` if the voucher could not be found. However, if the voucher existed and wasn't added to the selection, it will still give back a status 200 OK.
* `PUT /selection/{selectionId}` before would return completed selections as order receipts. This is not possible anymore. Selection will be not found if it's converted into an order.

* When order was completed, there was a static property called `order.message` that always said `Thank you for your order!` and nothing else. This field is removed.
**Before:**

```
{
  "order": {
    "order": "123455",
    "status": "untouched",
    "message": "Thank you for your order!",
    "date": "2020-01-21 23:57:18"
  }
}  
```

**After:**

```
{
  "order": {
    "order": "123455",
    "status": "untouched",
    "date": "2020-01-21 23:57:18"
  }
}  
```
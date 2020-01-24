# Breaking changes in CheckoutAPI v4 v2.69

This release makes some breaking changes due to bugs affecting multi-language structure. This release also adds [extended CheckoutAPI documentation using OAS v3.0.2](https://docs.centra.com/swagger-ui/?api=CheckoutAPI) to easier connect with the Checkout API. Due to this, some breaking changes are introduced.

**If you're using Checkout API v3 or less you are not affected by these changes.**

Below we describe the changes made. We also have code-snippets to be able to support both solutions, before and after this change. We're not planning to do any sort of modifications to existing models after this, since the documentation is now properly in place.

Most of the changes are properties moved into proper models. The biggest change has been introduced to partners already and was due to a bug in our language transformation: 

[5. Category structure is now consolidated, category name is always an array](#category-structure-is-now-consolidated-category-name-is-always-an-array)

There's also a checklist below to use for testing.

## 1. Moved plugin-specific fields into pluginFields-property

The optional fields added by plugins, `selection.paymentHTML`, `selection.klarnaReplaceSnippet`, `selection.shipwallet`, `selection.shipwallet_reload` has moved from `selection` into `selection.pluginFields` to be able to make better documentation in OAS/Swagger.

**Before:**

```json
{
  "selection": {
    "shippingMethodName": "SEK",
    "paymentHTML": "xxx",
    "shipwallet": {
      "...": "..."
    },
    "shipwallet_reload": true,
    "centraCheckoutScript": "CentraCheckout...",
    "...": "..."
  }
}
```

**After:**

```json
{
  "selection": {
    "shippingMethodName": "SEK",
    "pluginFields": {
      "paymentHTML": "xxx",
      "shipwallet": {
        "...": "..."
      },
      "shipwallet_reload": true
    },
    "centraCheckoutScript": "CentraCheckout...",
    "...": "..."
  }
}
```

**Code to support both ways before and after correction:**

```js
let selection = response.selection;

// temporary solution to support proper models
let pluginFields = selection.pluginFields ? 
    selection.pluginFields : selection

let shipwalletObject = pluginFields.shipwallet
let shipwalletReload = pluginFields.shipwallet_reload
let paymentHTML = pluginFields.paymentHTML
```

**When release is done you can change to:**

```js
let selection = response.selection;

let pluginFields = selection.pluginFields ? 
    selection.pluginFields : {}

let shipwalletObject = pluginFields.shipwallet
let shipwalletReload = pluginFields.shipwallet_reload
let paymentHTML = pluginFields.paymentHTML
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

**Code to support both ways before and after correction:**

```js
// temporary solution to support proper models
let languageList = response.languages ?
  response.languages : response.language;
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

**Code to support both ways before and after correction:**

```js
// temporary solution to support proper models
let currentMarket = response.location.market ?
  response.location.market : response.market;
  
let currentPricelist = response.location.pricelist ?
  response.location.pricelist : response.pricelist;
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

**Code to support both ways before and after correction:**

```js
// temporary solution to support proper models
let currentLanguageCode = response.location && 
  response.location.language && 
  typeof response.location.language == 'object' ?
  response.location.language.language
  :
  response.location.language;
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

We had errors from `POST /payment` that responded with sub-sections with `:` as a separator. However, some others had `.`. We're now giving back all errors in the same format. **This only happened on very specific errors, not the normal ones.**

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

* When order is completed using `POST /payment` or `POST /payment-result` or `GET /receipt`, the OrderCreatedModel contained an empty `order.shipments`. This array was always empty and is now removed. The old orders under `GET /orders` for a signed in customer still shows shipments like before in the OrderModel.
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

## Checklist to make sure fixes are working

1. If you're using Ingrid (Shipwallet), make sure it shows up in the checkout properly. If not, that means it's not finding the Ingrid snippet in `selection.pluginFields.shipwallet`, but instead looks inside `selection.shipwallet`. Remember that `pluginFields`-property is optional on the selection object.
2. If you're using languages, make sure switching language works and that the correct language is picked up. If not, this might be because `response.language` is not the list of available languages anymore. It could also be because the current language code is now inside `location.language.language`, since the `location.language` is a LanguageObject.

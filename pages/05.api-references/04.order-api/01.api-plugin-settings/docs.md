---
title: Order API - plugin settings
altTitle: API plugin settings
excerpt: Find out more about specific Order API plugin settings which affect API behaviour
taxonomy:
  category: docs
---

Below you will find detailed descriptions of often used Order API plugin settings.

## Bundles in shipments / Bundles in orders

Decides how bundles will be returned in [GET Shipments](/api-references/order-api/api-reference/get-shipments) and [GET Orders](/api-references/order-api/api-reference/get-orders) endpoints respectively.

* `Only containing items`: The bundle product will not be returned in response, but all of bundle section items will. Item price will reflect the bundle price proportional to that items. For instance if bundle consist of two items costing `200 SEK` and `100 SEK` but there is a fixed price on the bundle `150 SEK`, then item price will be consequtively: `100 SEK` and `50 SEK` – keeping the proportion of item prices while at the same time summing up to bundle price. For example:

```json
"products": [
  {
    ...
    "originalPrice": 200,
    "price": 100,
        ...
    "isBundle": false,
    "isPartOfBundle": "13"
  },
  {
    ...
    "originalPrice": 100,
    "price": 50,
    "isBundle": false,
    "isPartOfBundle": "13"
  }
]
```

* `Containing items in bundles`: The bundle product will be returned in the response. Its price will be as visible on the order page. Additionally bundle items will be listed under `"bundle"` JSON key within the bundle product. Their prices will be presented proportionally (see above). For example:

```json
"products": [
  {
    ...
    "name": "Fixed Static Bundle",
    "originalPrice": 300,
    "price": 150,
    "isBundle": true,
    "bundle": [
      {
        ...
        "originalPrice": 200,
        "price": 100,
        "isBundle": false,
        "isPartOfBundle": "13"
      },
      {
        ...
        "originalPrice": 100,
        "price": 50,
        "isBundle": false,
        "isPartOfBundle": "13"
      }
    ]
  }
]
```

* `Only bundles`: Bundle will be returned with price `0` and original price set to bundle price (in case of static pricing). No containing items. For example:

```json
"products": [
  {
    ...
    "name": "Fixed Static Bundle",
    "originalPrice": 150,
    "price": 0,
    "isBundle": true,
  }
]
```

* `Bundles and containing items`: Both bundle and containing items will be returned as regular order items (under `"products"` key). Bundle price will be reported as `0` and original price as defined in the bundle. Items' prices will be calculated proportionately. For example:

```json
"products": [
  {
    ...
    "name": "Fixed Static Bundle",
    "originalPrice": 150,
    "price": 0,
    "isBundle": true,
  },
  {
    ...
    "originalPrice": 200,
    "price": 100,
        ...
    "isBundle": false,
    "isPartOfBundle": "13"
  },
  {
    ...
    "originalPrice": 100,
    "price": 50,
    "isBundle": false,
    "isPartOfBundle": "13"
  }
]
```

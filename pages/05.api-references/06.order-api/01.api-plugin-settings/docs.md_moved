---
title: Order API - plugin settings
altTitle: API plugin settings
excerpt: Find out more about specific Order API plugin settings which affect API behaviour
taxonomy:
  category: docs
---

Below you will find detailed descriptions of often used Order API plugin settings.

### Markets filtering

The rule here is: Select all that apply. If the market of your order is not selected here, you will not be able to fetch the order or its shipments. If you wish for the plugin to include markets from another store, select that store in `Additional stores` and save the plugin. Then additional markets will be selectable.

### Debug logging

Enable to log all API calls and responses in AMS -> Diagnostics -> API log. Most useful while building the integration. Can be disabled in Prod if you wish other logs to be more visible.

### Primary / Virtual warehouse

The plugin description puts it best:

```
The relation between Primary Warehouse and Virtual Warehouse will be like this:

When Stock is updated, Virtual Warehouse can never increase in value. It can only be filled by internal warehouse deliveries. It can decrease if the value has already emptied out the Primary Warehouse.

When Stock is fetched from the API, they will be calculated together.

Warehouses set as "Stock master: External" cannot be selected as a Virtual Warehouse. If an External warehouse is selected as the Primary Warehouse, Virtual Warehouses will be disabled.
```

In short, one Order API plugin instance can only _update_ stock in the warehouse selected as `Primary warehouse`.

### Get Orders with Status

Again, select all that apply. Most integrations skip Cancelled and Archived orders, as they are not normally processed. Some people choose to skip `Pending` status, especially if `Autoconfirm orders` store setting is enabled.

### Return "waiting for payment" / "On hold" orders

Use with caution. If you process these orders, you may later find out the capture is impossible. Best practice is to ignore these orders until WfP/Hold flag is removed. Unless you have confirmed the payment outside of Centra, then you are welcome to try enabling these.

### Bundles in shipments / Bundles in orders

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

### Allow access to the following endpoints 

It's good practice for you to limit your API plugin instance only to endpoints required by your integration. If you only read order data, there's no reason to let the plugin create shipments. If you only process shipments, but not returns, feel free to disable the latter endpoints. 

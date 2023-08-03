---
title: Integrating Centra with an ERP system 
altTitle: ERP integration (Integration API)
excerpt: Centra can be configured to integrate with your Enterprise Resource Planning system using Integration API (GraphQL). Click here to see how to perform most common operations on Products, Warehouses, Stock, Orders, Shipments and Returns in both DTC and Wholesale.
taxonomy:
  category: docs
---

# Introduction

In this article you’ll get an understanding how an ERP system (or similar) could be integrated with Centra. Keep in mind that this guide is not the absolute truth, but a recommendation on how it could be handled in the specific scenario that product data and inventory is sent to Centra, and that orders are read from Centra and that they’re updated in Centra by the ERP upon fulfillment.

This article goes through how to integrate to Centra step-by-step. If an integration of this kind is to be made for a client that has been running their e-commerce through Centra for some time, a different approach might need to be taken.

## Integration API introduction

All mutations of the API are documented in [Integration API Docs](https://docs.centra.com/graphql).

### Communication

Whether it’s stock updates, product updates or fetching orders. The integration is always initiating the communication. Centra APIs are passive and do not trigger any updates or send information to external systems. Centra, however, has the option to send webhook for Certain events. If that is of interest, more information is available here.

### Prerequisites

An Integration API token with proper access rights. These are set up in Centra AMS.

[notice-box=info]
SOAP API uses its own user and password, which is not related to the AMS users and needs to be set up by Centra staff.
[/notice-box]

### ID Conversion

To make an integration as easy as possible to build and maintain, the Integration API enables interactions with Centra based on IDs in any external integration. This means the integration only has to be aware of its own IDs and not of Centra's IDs. This is very similar to how ID conversion works in SOAP API and other modules, however, we extended it to be manageable through the Integration API directly as part of the Centra core. It also allows to support any custom integrations that are not Centra modules.

You can read and learn how to work with ID Conversion here.

### Events system

Integration GraphQL API exposes a stream of events to the interested parties. When anything in Centra is changed, there will be events you can listen to. This will allow you to:

    know what changed since your last synchronization, so that you can fetch only changed data selectively,

    avoid periodical polling for new data of each type.

For example, when a new order is created by Checkout API or in any other place, there will be an event of “object type” Order and “change type” CREATED, and your integration will see it as soon as the events are fetched by the new query events.

You can read all about the Events system at this page - INSERT LINK

### Special characters and checkout fields limitations

Depending on your ERP, there might be some limitations when it comes to the allowed types of characters, or to the allowed number of characters per field. Centra Admin backend will accept any characters set, and the fields lengths are designed to not be a limiting factor. If your ERP has known limits, e.g. allowing only 20 characters each for the customer's first and last name, you should make sure your front end partner is aware of this and ask them to introduce those limits in the checkout fields. Similarily, if your ERP only accepts ASCII characters, you would probably want to strip them in checkout, so that (for example) "Michael Ständer" is sent as "Michael Stander" into Centra.

***

# Cookbook

## Product data

The first step in this kind of integration, whether the product data is coming directly from the ERP or a PIM system, is to create the products. This needs to be done in order to run tests for orders, stock etc with the correct data.

Before products can be added, size charts must be created in Centra. Sizes for products is a core feature in Centra and must be used, whether the products that will be sold come in sizes or not. One reason for this is that stock is stored on size level. If the products sold only come in a single size, simply create a size chart with a single size that can be used for all products.

A size chart contains a name, and sizes. Size charts can be named in any way and the sizes within a size chart can also be named in any way. It could be a classic size chart named XS-XL which contains the sizes XS, S, M, L, and XL. It could also be a multi-dimensional size charts for pants that can hold both length and width.

It’s also worth noting that you can choose to only activate some of the sizechart sizes for specific products. For example, if you have two products: one selling in sizes between XXS-XXL, and another product which only has sizes S/M/L, they can use the same sizechart - one with sizes XXS, XS, S, M, L, XL, XXL. Then you can configure the second product to only activate sizes S/M/L, and keep stock for those. Other sizes can remain unused, or can be activated at a later time, in case you would start selling different sizes in the future.

Once the size charts are in place, products can be added to Centra. Let’s take a look at how a simple size chart with XS-XL sizes can be created. Remember to store the IDs that are returned upon creation, these are needed when selecting the size chart and its sizes to be used for a product. There are no limitations on how many size charts that can be used. However, there’s no need to create multiple size charts with the XS-XL range, one is enough. It doesn’t matter if it’s for men or women. Measurements are added on product level, with the help of Measurement charts.

### Creating size charts

#### Request: One-size chart

```gql
mutation addSizeChart {
    createSizeChart(
      input: {
        name: "One Size"
        dividerSymbol: "x"  
        horizontalLabels: ["One Size"]
        verticalLabels: []
        displayUnit: ""
        displayDividedBy: 0
      }
    ) {
      sizeChart {
        id
        name
        sizes {id name}
        horizontalLabels
        verticalLabels
        dividerSymbol
      }
      userErrors {
        message
        path
      }
    }
  }
```

#### Response

```json
{
    "data": {
      "createSizeChart": {
        "userErrors": [],
        "sizeChart": {
          "id": 1,
          "name": "One Size",
          "sizes": [
            {
              "id": 1,
              "name": "One Size"
            }
          ],
          "horizontalLabels": [
            "One Size"
          ],
          "verticalLabels": null,
          "dividerSymbol": "x"
        }
      }
    },
    "extensions": {
      "complexity": 121,
      "permissionsUsed": [
        "SizeChart:write",
        "SizeChart:read"
      ]
    }
  }
```

And here’s another example, a size chart that we could use for pants.

#### Request: Multi-dimensional size chart

```gql
mutation addSizeChart {
 createSizeChart(input: {
  name: "Pants sizes"
  horizontalLabels: ["24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "36", "38"]
  verticalLabels: ["26", "28", "30", "32", "34", "36"]
 }) {
   sizeChart {
    id
    sizes {
      id
      name }
   }
  userErrors {
    message
    path
  } 
 }
}
```

#### Response

```json
{
  "data": {
    "createSizeChart": {
      "sizeChart": {
        "id": 43,
        "sizes": [
          {
            "id": 513,
            "name": "24x26"
          },
          {
            "id": 514,
            "name": "24x28"
          },
          {
            "id": 515,
            "name": "24x30"
          },
          {
            "id": 516,
            "name": "24x32"
          },
          {
            "id": 517,
            "name": "24x34"
          },
          {
            "id": 518,
            "name": "24x36"
          },
          {
            "id": 519,
            "name": "25x26"
          },
          {
            "id": 520,
            "name": "25x28"
          },
          {
            "id": 521,
            "name": "25x30"
          },
          {
            "id": 522,
            "name": "25x32"
          },
          {
            "id": 523,
            "name": "25x34"
          },
          {
            "id": 524,
            "name": "25x36"
          },
          {
            "id": 525,
            "name": "26x26"
          },
          {
            "id": 526,
            "name": "26x28"
          },
          {
            "id": 527,
            "name": "26x30"
          },
          {
            "id": 528,
            "name": "26x32"
          },
          {
            "id": 529,
            "name": "26x34"
          },
          {
            "id": 530,
            "name": "26x36"
          },
          {
            "id": 531,
            "name": "27x26"
          },
          {
            "id": 532,
            "name": "27x28"
          },
          {
            "id": 533,
            "name": "27x30"
          },
          {
            "id": 534,
            "name": "27x32"
          },
          {
            "id": 535,
            "name": "27x34"
          },
          {
            "id": 536,
            "name": "27x36"
          },
          {
            "id": 537,
            "name": "28x26"
          },
          {
            "id": 538,
            "name": "28x28"
          },
          {
            "id": 539,
            "name": "28x30"
          },
          {
            "id": 540,
            "name": "28x32"
          },
          {
            "id": 541,
            "name": "28x34"
          },
          {
            "id": 542,
            "name": "28x36"
          },
          {
            "id": 543,
            "name": "29x26"
          },
          {
            "id": 544,
            "name": "29x28"
          },
          {
            "id": 545,
            "name": "29x30"
          },
          {
            "id": 546,
            "name": "29x32"
          },
          {
            "id": 547,
            "name": "29x34"
          },
          {
            "id": 548,
            "name": "29x36"
          },
          {
            "id": 549,
            "name": "30x26"
          },
          {
            "id": 550,
            "name": "30x28"
          },
          {
            "id": 551,
            "name": "30x30"
          },
          {
            "id": 552,
            "name": "30x32"
          },
          {
            "id": 553,
            "name": "30x34"
          },
          {
            "id": 554,
            "name": "30x36"
          },
          {
            "id": 555,
            "name": "31x26"
          },
          {
            "id": 556,
            "name": "31x28"
          },
          {
            "id": 557,
            "name": "31x30"
          },
          {
            "id": 558,
            "name": "31x32"
          },
          {
            "id": 559,
            "name": "31x34"
          },
          {
            "id": 560,
            "name": "31x36"
          },
          {
            "id": 561,
            "name": "32x26"
          },
          {
            "id": 562,
            "name": "32x28"
          },
          {
            "id": 563,
            "name": "32x30"
          },
          {
            "id": 564,
            "name": "32x32"
          },
          {
            "id": 565,
            "name": "32x34"
          },
          {
            "id": 566,
            "name": "32x36"
          },
          {
            "id": 567,
            "name": "33x26"
          },
          {
            "id": 568,
            "name": "33x28"
          },
          {
            "id": 569,
            "name": "33x30"
          },
          {
            "id": 570,
            "name": "33x32"
          },
          {
            "id": 571,
            "name": "33x34"
          },
          {
            "id": 572,
            "name": "33x36"
          },
          {
            "id": 573,
            "name": "34x26"
          },
          {
            "id": 574,
            "name": "34x28"
          },
          {
            "id": 575,
            "name": "34x30"
          },
          {
            "id": 576,
            "name": "34x32"
          },
          {
            "id": 577,
            "name": "34x34"
          },
          {
            "id": 578,
            "name": "34x36"
          },
          {
            "id": 579,
            "name": "36x26"
          },
          {
            "id": 580,
            "name": "36x28"
          },
          {
            "id": 581,
            "name": "36x30"
          },
          {
            "id": 582,
            "name": "36x32"
          },
          {
            "id": 583,
            "name": "36x34"
          },
          {
            "id": 584,
            "name": "36x36"
          },
          {
            "id": 585,
            "name": "38x26"
          },
          {
            "id": 586,
            "name": "38x28"
          },
          {
            "id": 587,
            "name": "38x30"
          },
          {
            "id": 588,
            "name": "38x32"
          },
          {
            "id": 589,
            "name": "38x34"
          },
          {
            "id": 590,
            "name": "38x36"
          }
        ]
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 122,
    "permissionsUsed": [
      "SizeChart:write",
      "SizeChart:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

With size charts and their sizes in place, everything that is needed to create the first product is available.

### Create the first product

Centra’s light-weight PIM can contain a lot of product data with the help of “custom attributes”. In this example, only the basic attributes will be taken into account. Each product in Centra contain three different “sections”. First, there’s the general section where the basic attributes available are such as Product number, Product Name, Collection, Country of Origin, and more. This section needs to be created before the next subset of data can be created in Centra.

Here’s an example of how a query to create the first part (General) of a product can look like. Remember: the id you get back needs to be used in order to update the product at a later stage. Store it somewhere secure.

#### Request: Product creation

```gql
  mutation addProduct {
    createProduct(input: {
      name: "First Product"
      status: ACTIVE
      productNumber: "Prod123"
      brand: { id: 1 }
      collection: { id: 2 }
      folder: { id: 1 }
      countryOfOrigin: { code: "DE" }
      harmonizedCommodityCode: "HCC123"
      harmonizedCommodityCodeDescription: "Harm Code Description"
    }) {
      product { 
        id
        name
        status
        productNumber
        brand { name }
        collection { name }
        folder { name }
        harmonizedCommodityCode
        harmonizedCommodityCodeDescription
      }
      userErrors {
        message
        path
      }
    }
  }
```

#### Response

```json
{
    "data": {
      "createProduct": {
        "product": {
          "id": 1,
          "name": "First Product",
          "status": "ACTIVE",
          "productNumber": "Prod123",
          "brand": {
            "name": "Base Brand"
          },
          "collection": {
            "name": "AW21"
          },
          "folder": {
            "name": "Shop"
          },
          "harmonizedCommodityCode": "HCC123",
          "harmonizedCommodityCodeDescription": "Harm Code Description"
        },
        "userErrors": []
      }
    },
    "extensions": {
      "complexity": 121,
      "permissionsUsed": [
        "Product:write",
        "Product:read",
        "Product.Brand:read",
        "Product.Collection:read",
        "Product.Folder:read"
      ]
    }
  }
  ```

The first part of the product is now created, and it’s also possible to view it in Centra. It cannot be sold until we continue with the rest of its sections. This is also where a new concept will be introduced: Variants.

Much like size charts and their sizes, variants are a core feature in Centra. Each product needs at least one variant. Just as with size charts and sizes, if the product setup doesn’t really have variants, one variant will still need to be created. It’s also at variant level where the size chart to be used is selected. A product can in theory have an unlimited number of variants, while in practice it’s mainly common to have around five variants or less.

A variant has basic attributes and custom attributes. Just as the product’s general section. The most used basic attributes of the variant are Variant number and Variant name. Variant names many times will be the color name of the product, or even material in cases where a product comes in multiple materials rather than colors.

Let’s take a look at the example on how to create a variant. Notice that there’s a product id that needs to be sent with the query. This is the id provided from the creation of the basic product data. A size chart id must also be provided in order to tell Centra which size chart should be assigned to this variant. Just as with the product, this id was returned when the size chart was created.

#### Request: Adding a variant

```gql
mutation createVariant {
    createProductVariant(input: {
      product: { id: 1 }
      name: "First Product"
      status: ACTIVE
      variantNumber: "Var456"
      internalName: "vrnt2"
      unitCost: {   # MonetaryValueInput
        value: 60
        currencyIsoCode: "EUR"
      }
      sizeChart: { id: 2 }
    }) {
      productVariant {
        id
      }
      userErrors {
        message
        path
      }
    }
  }
  ```

#### Response

  ```json
  {
    "data": {
      "createProductVariant": {
        "productVariant": {
          "id": 2
        },
        "userErrors": []
      }
    },
    "extensions": {
      "complexity": 121,
      "permissionsUsed": [
        "ProductVariant:write",
        "ProductVariant:read"
      ]
    }
  }
  ```

Much like with the product, an ID for the variant will be returned. This is needed to update the variant and activate the sizes. Remember to store it.

For each variant that needs to be added, a new mutation needs to be executed.

The last step to be made before the full core set of product data is ready, is to activate the sizes in the size chart select on each variant that was added to the product. To elaborate: when selecting a size chart for the variant, it doesn’t automatically get all sizes activated for the specific variant. The reason for this is that a size chart can contain more sizes than what the specific variant will be available in.

When activating the sizes for the variant, it’s also possible to add some data per size like GTIN and size number. Size number can be a part of the full SKU or the full SKU, depending on the needs for the integration. In the example you can see that the id of the variant will be used. It’s also a must to provide the id of the size, or its name along with the mutation. Each size needs to be activated in its own mutation.

Much like with the product and variant data. An ID will be returned and remember to store this ID as well.

#### Request: Activating sizes

```gql
mutation createOneSize {
    createProductSize(
      input: {
        productVariant: { id: 1 },
        size: { id: 1 },
        gtin: "EAN000111",
        sizeNumber: "111"
      }
    ) {
      productSize {
        id
        GTIN
        sizeNumber
      }
      userErrors {
        message
        path
      }
    }
  }
  ```
#### Response

```json
{
    "data": {
      "createProductSize": {
        "productSize": {
          "id": 279,
          "GTIN": "EAN000111",
          "sizeNumber": "111"
        },
        "userErrors": []
      }
    },
    "extensions": {
      "complexity": 121,
      "permissionsUsed": [
        "ProductVariant:write",
        "ProductSize:read"
      ]
    }
  }
```

### Bundles

Bundles consist of multiple sections, of which each can be selected from a pre-selected list of variants. The price of the bundle can be predefined, or calculated dynamically based on the prices of variants selected in the bundle. In the more complex, flexible bundles, the amount of the products in each section can differ as well.

A bundle is a virtual product, which only has one Variant by design. This variant also needs to be activated on a Display, just like any other Variant. Stock of each Bundle is calculated based on the contained section variants' stock amounts.

It’s possible to create bundles, here’s an example of how that can be done. When creating the bundle you’ll need to use the id provided upon product and variant creation earlier.

The fixed bundle type will work straight away in a client’s storefront as it will appear as any other product. Where the flexible bundle type will require new functionality in the storefront in order to work due to its more complex structure.

#### Request: Fixed bundle

```gql
mutation createFixedBundle {
  createBundle(
    input: {
      product: { 
        name: "Test bundle product"
        status: ACTIVE
        productNumber: "123"
        brand: {id: 1}
        collection: {id: 1}
        countryOfOrigin: {id: 65}
        folder: {id: 1}
        isSerializableProduct: true
        harmonizedCommodityCode: "code"
        harmonizedCommodityCodeDescription: "description"
      }
      type: FIXED
      priceType: STATIC
      sizeChart: {id: 2}
      sizes: [
        {name: "S"},
        {name: "M"}
      ]
      addBundleSections: [
        {
          quantity: 1
          productVariants: [
            {id: 1449}
          ]
        },
        {
          quantity: 2
          productVariants: [
            {id: 1450}
          ]
        }
      ]
    }
  ) {
    userErrors {message path}
    bundle {
       ...bundleFields
    }
  }
}
```


### Warehouses and inventory

All of the core data needed for a product has now been added. Inventory can now be added to the product, let’s take a look on how to handle that.

Centra has an advanced way of allocating inventory to orders named “Allocation rules”, but before that warehouses needs to be created. That’s plural. It’s possible to create as many warehouses as needed in Centra. One common setup is to have a single, or multiple, warehouses for fulfillment of D2C online orders and a warehouse for each brick and mortar store available - in order to display what’s available in stores or even to fulfill the orders from a store.

Warehouses might already be set up in Centra when the integration work starts, but it’s easy to create a warehouse if needed. See an example below. Just as with the product data, remember to store the ID you get back. This will be needed when inventory levels are sent to Centra.

#### Request: Create a warehouse

```gql
mutation createWarehouse {
  createWarehouse(
    input: {
      name: "Default warehouse"
      beforeWarehouse: { id: 1 }
      hideFromStockView: true
      threshold: 1
      stockMasterPolicy: EXTERNAL
      stockOwnershipPolicy: THIRD_PARTY
      allocationPolicy: CHECK_FIRST
      warehouseLocation: { country: { id: 2 }, stateOrProvince: "nevada" }
    }
  ) {
    userErrors {
      message
      path
    }
    warehouse {
      id
      name
      isHiddenFromStockView
      threshold
      stockMaster
      stockOwnership
      allocationPolicy
      isConsignation      
      brickAndMortar {id name}
      country {id name}
      state {id name}  
      zipCode
    }
  }
}
```

#### Response

```json
{
  "data": {
    "createWarehouse": {
      "userErrors": [],
      "warehouse": {
        "id": 22,
        "name": "Default warehouse",
        "isHiddenFromStockView": true,
        "threshold": 1,
        "stockMaster": "EXTERNAL",
        "stockOwnership": "THIRD_PARTY",
        "allocationPolicy": "CHECK_FIRST",
        "isConsignation": false,
        "brickAndMortar": null,
        "country": {
          "id": 2,
          "name": "United States"
        },
        "state": {
          "id": 29,
          "name": "Nevada"
        },
        "zipCode": null
      }
    }
  },
  "extensions": {
    "complexity": 117,
    "permissionsUsed": [
      "Warehouse:write",
      "Warehouse:read",
      "BrickAndMortar:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

With a warehouse in place, it’s easy to send inventory levels to Centra. Keep in mind that Centra keeps track of inventory, there’s no need to send stock updates when an order read from Centra has been fulfilled. It’s only necessary to sync the stock when there’s other types of stock movements made in the external system, like inbound deliveries, internal warehouse transfers etc.

There are two ways to set stock in Centra. You can either set the physical inventory balance (what’s actually sitting on the warehouse shelf, including inventory reserved by unfulfilled orders) or send in changes. Take a look at the examples below.

#### Request: Add inventory (one mutation per size)

```gql
  mutation addStock {
    changeStock (
      input: {
        intoWarehouse: {id: 3}
        description: "New stock"
        productVariants: [
          {
            productVariant: {id: 2}
            unitCost: {
              value: 41
              currencyIsoCode: "EUR"
            }
            sizeChanges: {
              size: {name: "S"}
              deliveredQuantity: 2
            }
          }
        ]
      }
    ) {
      stockChange {id}
      userErrors {message}
    }
  }
```

#### Response

```json
{
    "data": {
      "changeStock": {
        "stockChange": {
          "id": 4284
        },
        "userErrors": []
      }
    },
    "extensions": {
      "complexity": 121,
      "permissionsUsed": [
        "StockChange:write",
        "WarehouseDelivery:read"
      ]
    }
  }
```

#### Request: Removing inventory

```gql
mutation removeStock {
    changeStock (
      input: {
        outFromWarehouse: { id: 1 }
        description: "Remove stock"
        productVariants: [
          {
            productVariant: {id: 1}
            unitCost: {
              value: 41
              currencyIsoCode: "EUR"
            }
            sizeChanges: {
              size: {id: 1}   # One Size
              deliveredQuantity: 5
            }
          }
        ]
      }
    ) {
      stockChange {id}
      userErrors {message}
    }
  }
  ```

#### Response

```json
{
    "data": {
      "changeStock": {
        "stockChange": {
          "id": 4284
        },
        "userErrors": []
      }
    },
    "extensions": {
      "complexity": 121,
      "permissionsUsed": [
        "StockChange:write",
        "WarehouseDelivery:read"
      ]
    }
  }
```

#### Request: Set absolute values

```gql
mutation absoluteStock {
    setStock(input: {
      warehouse: {id: 1}
      description: "A typical stock update"
      stockQuantityType: PHYSICAL
      productVariants: [
        {
          productVariant: {id: 1445}
          sizeStockLevels: [
            {size: {name: "XL"}, quantity: 10},
          ]
        }
      ]
    }) {
      userErrors {
        message
        path
      }
      stockChanges {
        id
      }
    }
  }
```


### Pricelists

With products and inventory in place, there’s some more data needed to be fully able to start selling a product. One of these things are prices. Prices in Centra are set with a price list. A price list in Centra can be in any currency. Multiple price lists with the same currency are also supported.

Prices can be set on variant level, but not size. By default, all variants of the same product share the same price, but you can choose to enable individual variant prices for some or all variants. When creating a price list, there are multiple data points that can be added, but not all of them are mandatory during the creation phase, since some oftentimes are set by the client in Centra. Let’s take a look at what you must send in and an example after that.

- Name: the name of the pricelist. Could be as simple as the currency of the pricelist or something with a longer description
- Store: This is the id of the store that the price list should be added to
- Currency: set with currencyIsoCode. Self-explanatory, the currency of the pricelist

Other fields like Default shipping option, adding countries, can also be done upon creation or by updating the pricelist. But as stated earlier, these are oftentimes set by the client directly in the Centra admin, however the example contains them. Countries are only added for pricelists in a DTC store. In Wholesale, there’s also an option to add RRP prices to the pricelist.

#### Request: Pricelist creation

```gql
mutation CreatePricelist {
  createPricelist(input: {
  name: "Test pricelist SEK"
  status: INACTIVE
  store: {
      id: 1
  }
  currencyIsoCode: "SEK"
  defaultShippingOption: {
    id: 1
  },
  addCountries: [
    {
        code: "SE"
    }
  ]
  }) {
  pricelist {
    id
    name
    status
    store { id name type }
    currency { code }
    assignedToCountries { id name }
    defaultShippingOption { id name }
  }
  userErrors { message path }
  }
}
```

#### Response

```json
{
  "data": {
    "createPricelist": {
      "pricelist": {
        "id": 61,
        "name": "Test pricelist SEK",
        "status": "INACTIVE",
        "store": {
          "id": 1,
          "name": "Retail",
          "type": "DIRECT_TO_CONSUMER"
        },
        "currency": {
          "code": "SEK"
        },
        "assignedToCountries": [
          {
            "id": 6,
            "name": "Sweden"
          }
        ],
        "defaultShippingOption": {
          "id": 1,
          "name": "SEK"
        }
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 125,
    "permissionsUsed": [
      "Pricelist:write",
      "Pricelist:read",
      "Store:read",
      "Country:read",
      "ShippingOption:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

When the price list is created, it’s now time to add the actual prices to the products. As always, use the id for the pricelist that was returned upon its creation. Here’s an example of how setting the prices work:

#### Request

```gql
mutation {
  setPrices(
    input: {
      pricelist: { id: 23 }
      productPrices:[
        {
          product: {id: 2}
          price: { value: 290, currencyIsoCode: "EUR" }
        }
      ]
    }
  )  
  {
    pricelist {
      id
    }
    userErrors { message path }
  }
}
```

#### Response

```json
{
  "data": {
    "setPrices": {
      "pricelist": {
        "id": 23
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "Price:write",
      "Pricelist:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

### Price Alterations

For Wholesale, Centra offers functionality called “Price alteration”. This is a function used to have a different price point for products. This is many times used for carry over products which will see a price increase in a new collection. You can only have one active price alteration object per Wholesale store.

#### Request: Price Alteration

```gql
mutation CreatePriceAlteration {
  createPriceAlteration(
  input: {
    name: "First price alteration"
    status: INACTIVE
    store: {
      id: 2
    }
    startDate: "2024-02-01T00:00:00+0000"
  }
  ) {
  priceAlteration {
    id
    name
    startDate
    status
    store { id }
    deliveryWindows { id }
  }
  userErrors { message path }
  }
}
```

#### Respone

```json
{
  "data": {
    "createPriceAlteration": {
      "priceAlteration": {
        "id": 4,
        "name": "First price alteration",
        "startDate": "2024-02-01",
        "status": "INACTIVE",
        "store": {
          "id": 2
        },
        "deliveryWindows": []
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 133,
    "permissionsUsed": [
      "Price:write",
      "Price:read",
      "Store:read",
      "DeliveryWindow:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

When the Price Alteration is created, the specific prices for the products can also be added. Take a look at the example below to get an understanding on how to handle that.

#### Request

```gql
mutation SetAlteredPrices {
  setAlteredPrices(input: {
  priceAlteration: {
    id: 1
  },
  pricelist: {
    id: 21
  },
  productPrices: [
    {
      product: {
        id: 1
      }
      price: {
        value: 1000
        currencyIsoCode: "SEK"
      }
    }
  ]
  }){
  priceAlteration {
    id
  }
  pricelist {
    id
  }
  products {
    id name
  }
  userErrors {
    message path
  }
  }
}
```

### Product displays

There’s one last thing that needs to be done in order to get products that are fully sellable. They’re called Displays and their function is to connect products to specific categories, assign product images, select for which Market they should be available for, and more. Depending on the project scope, Displays might be handled directly in Centra by the client and that’s why it’s saved for last. However, they can also be created directly through an integration. To make it less abstract, we can call the Display the product presentation layer. Just like in the real world you are not just sending your customers to browse your warehouse, but instead display your products in a way that will entice a sale, Displays in Centra can be used to control how your backend product(s) will look like in your Stores. The beauty of displays is that you can configure one Display per Store, which means you can sell the same products from different stores using different categories, media and metadata, depending on requirements.

Displays are connected to a specific Store and if a client has multiple stores in Centra and wants to sell the product in all stores, a display must be created for each store. Commonly a DTC and Wholesale store.

A Display has a lot of parameters, with most optional. Take a look at the full set below

input DisplayCreateInput {
# basic required fields
store: StoreInput!
product: ProductInput!
name: String!
status: Status!

# basic optional fields
uri: String   (If not provided, it will be auto-generated based on the display name)
minimumOrderQuantity: Int
orderQuantityDenominator: Int
description: String
shortDescription: String
metaTitle: String
metaDescription: String
metaKeywords: String
comment: String
tags: [String!]

# relations to other types
canonicalCategory: CategoryInput
addCategories: [CategoryInput!]
addMarkets: [MarketInput!]
addProductMedia: [ProductMediaAddInput!]
addProductVariants: [ProductVariantAddInput!]
taxGroup: TaxGroupInput
}

Let’s take a look at how to create a basic Display

#### Request: Create a basic display

```gql
mutation create {
  createDisplay(input: {
      name: "New display!"
      status: ACTIVE
      store: {id: 1}
      product: {id: 2}
  }) {
      userErrors {
          message path
      }
      display {
          id
      }
  }
}
```

#### Response

```json
{
  "data": {
    "createDisplay": {
      "userErrors": [],
      "display": {
        "id": 2276
      }
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "Display:write",
      "Display:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

With this query, a display named “New Display!” will be created in the store with ID 1 for a product with ID 2. With the display in place, variant(s) can be added to the display. This is a requirement, as only variants activated on displays will be exposed in the front-end APIs.

The ID which was returned when creating the Display must be used in the mutation along with the ID of the variant connected to the product. Just to make it clear: you can only add a variant to a display which exists on the main product level.


#### Request: Add a variant to the display

```gql
mutation addVariantsToDisplay {
  updateDisplay(
  id: 2276
  input: { addProductVariants: { productVariant: { id: 1446 } } }
  ) {
  userErrors {
    message
    path
  }
  display {
    id
  }
  }
}
```

#### Response

```json
{
  "data": {
    "updateDisplay": {
      "userErrors": [],
      "display": {
        "id": 2276
      }
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "Display:write",
      "Display:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

### Wholesale

With products and price lists in place, products can now be sold in a DTC store (when displays have been created). But for Wholesale we also need Accounts to be created along with Delivery Windows. Let’s go through the setup of an Account in Wholesale and after that the Delivery Window functionality.

#### Account creation

With payment and shipping terms in place, it’s about time to create the first Wholesale Account in Centra. An Account in Centra will hold all of the necessary information like Invoice address, Shipping Address (multiple ship-to addresses available through “Address book”, discounts, and buyers. Note: in order for an Account to be fully functional, at least one Buyer needs to be added to the account. It is Buyers who can access Centra B2B Showroom and place orders for their parent Account.

There’s quite a lot of data that can be added to an Account. Either during its creation or by updating it later. Please see a list below with a short explanation on what these different data sets are and if they’re mandatory or not.

name: The name of the Account.
status: Status, as in active, inactive or canceled.
internalComment: An internal comment field for the Centra client. Optional.
otherComment: Other comments will be visible for the Account. Optional.
websiteUrl: A field for a URL. Optional.
creditLimit: Limit on how much the Account can shop for before settling their outstanding invoices. Optional.
discounts: Discount. General percentage based discount specific for this Account. Can also be set for specific delivery windows. Optional.
applyCreditLimit: If credit limit should be enforced. Optional.
blockIfUnpaidInvoices: Used to block new orders if there are unpaid invoices. Optional.
hasBrandsRestriction: Use to set which brands the Account will be able to see. Optional.
isInternal: Flag an account as an “Internal Account”. Optional. Oftentimes used to place internal orders.
carrierInformation: Fields to store preferred carrier for fulfillment for the Account. Optional.
market: Which market the Account should belong to.
pricelist: The pricelist that the Account will use.
allocationRule: Used to set another than the default Allocation rule. Optional.
paymentTerms: Set the Payment term for the account.
shippingTerms: Set the Shipping term for the account.
salesRepresentative: Set the sales rep for the account. Optional.
taxClass: Set tax class for account. Optional.
documentTemplate: Used to set the Document template that will be used for the Account. Optional.
addBrands: Add new brands that the Account will be able to access. Only used if brands are to be used as a restriction. Optional.
addVisibleForAgents: Add which agents that should have access to the Account. Optional.
accountAddress: Fields for Account address. The account address is the registered address of the company.
shippingAddress: Fields for default Shipping address.
billingAddress: Fields for the billing address (invoice address)

#### Reqeust: Creating an account

```gql
  mutation createAccount {
      createAccount(input: {
          status: INACTIVE
          name: "Test Account"
          market: {id: 2}
          pricelist: {id: 21}
          discounts: {
              generalDiscount: {
                  discountPercent: 14.3
                  isVisible: true
              }
  #           addDeliveryWindowDiscounts: [
  #               {deliveryWindow: {id: 1} discountPercent: 12.3}
  #               {deliveryWindow: {id: 2} discountPercent: 23.4}
  #           ]
          }
      }) {
          userErrors {
              message path
          }
          account {
              id
              discountPercent
              isDiscountVisible
              deliveryWindowDiscounts {
                  deliveryWindow {
                      id
                  }
                  discountPercent
              }
          }
      }
  }
  ```

#### Response

  ```json
  {
  "data": {
    "createAccount": {
      "userErrors": [],
      "account": {
        "id": 132,
        "discountPercent": 14.3,
        "isDiscountVisible": true,
        "deliveryWindowDiscounts": []
      }
    }
  },
  "extensions": {
    "complexity": 142,
    "permissionsUsed": [
      "Account:write",
      "Account:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

#### Adding a buyer

With the Account created, a Buyer for the specific account can be added. As mentioned earlier, at least one Buyer needs to be created for each account.

The mutation for creating a Buyer has below fields

account: This is the ID of the account where the buyer should be created
store: The ID of the store used. It’s not common to run multiple Wholesale stores in one Centra instance, but it can happen.
status: Status of the buyer.
websiteUrl: Field to store a URL
receiveAutoEmails: Boolean to define whether or not the Buyer should receive emails (order confirmation, shipping confirmation etc)
receiveNewsletters: Boolean to define whether ot not the Buyer should be flagged to accept newsletters
billingAddress: Address fields for the buyer. Not commonly used.


#### Request: Adding a Buyer to a Wholesale account

```gql
mutation createBuyer {
    createBuyer(input: {
        store: {id: 2}
        status: ACTIVE
        account: {id: 5}
        websiteUrl: "Example URL"
        receiveAutoEmails: true
        billingAddress: {
            email: "jon.snow@centra.com"
        }
    }) {
        userErrors { message path }
        buyer {
            id
            status
            account { id name }
            receiveAutoEmails
            websiteUrl
            billingAddress {
                email
            }
        }
    }
}
  ```

#### Response

```json
{
  "data": {
    "createBuyer": {
      "userErrors": [],
      "buyer": {
        "id": 1902,
        "status": "ACTIVE",
        "account": {
          "id": 5,
          "name": "Centra 5"
        },
        "receiveAutoEmails": true,
        "websiteUrl": "Example URL",
        "billingAddress": {
          "email": "jon.snow@centra.com"
        }
      }
    }
  },
  "extensions": {
    "complexity": 114,
    "permissionsUsed": [
      "Buyer:write",
      "Buyer:read",
      "Account:read",
      "Buyer.billingAddress:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

#### Delivery windows

Next up are Delivery Windows. Delivery Windows control how goods are sold in Centra Wholesale, and must be created in order to enable sales. Delivery Windows can be configured with different Variant Delivery Types which defines how goods availability is displayed for a Buyer. Let’s take a look at them to get an understanding which to use.

Preorder - The preorder type is a common type used to enable pre orders before inventory is available. For fashion a common use case is to take orders for a new collection. The amount of units available can still be limited with this type.
Stock - The stock type will only show what’s actually available to order right now, based on allocation rules for the Account used by a Buyer. In combination with allowing backorders, it’s still possible to place orders.
Link - Not as commonly used as Preorder and Stock. Link works in conjunction with Centra’s Supplier module, allowing one to sell units still not reserved on incoming Supplier orders.
Stock/Link - A combination of Stock and Link.

When creating a Delivery Window, preorder and atOnce is also to be included, independently from the Variant Delivery Type. Use pre order for Delivery Windows with the Preorder Variant Delivery Type, with this a date range for accepting orders can be set. Use atOnce for Stock type, which is sold - at once.

At least one Market needs to be added to the Delivery Window, use the ID of a Market previously created or fetch Markets to find their IDs.

In below example a Preorder Delivery Window is created

#### Request: Creating a Delivery window

```gql
  mutation createPreorderDelWin {
    createDeliveryWindow(input: {
      name: "First PreOrder DelWin"
      status: ACTIVE
      deliveryDatesVisible: true
      selectableByBuyers: true
      selectedByDefault: false
      defaultVariantDeliveryType: STOCK
      allocationRule: { id: 2 }
      markets: [{ id: 2 }]
   
      # preorder specific fields
      preorder: {
        deliveryDateRange: { from: "2022-08-01", to: "2022-10-31" }
        salesDateRange: { from: "2022-08-01", to: "2022-10-31" }
        allocationOrder: FIFO
      }
    }) {
      userErrors {
        message
        path
      }
      deliveryWindow {
        id
      }
    }
  }
  ```

#### Response

  ```json
  {
  "data": {
    "createDeliveryWindow": {
      "userErrors": [],
      "deliveryWindow": {
        "id": 26
      }
    }
  },
  "extensions": {
    "complexity": 113,
    "permissionsUsed": [
      "DeliveryWindow:write",
      "DeliveryWindow:read"
    ],
    "appVersion": "v0.47.7"
  }
}
```

With a Delivery Window in place, it’s time to add products to it. When it comes to Delivery Windows, it’s a product’s variant(s) that will be added to the delivery window. Use the ID for the variant(s) which was returned during its creation.

#### Request - Adding products to a Delivery Window

```gql
mutation setVariants {
    setDeliveryWindowVariants(input: {
      deliveryWindow: { id: 3 }
      variants: [
        {
          productVariant: { id: 1844 }
          type: STOCK
        },
        {
          productVariant: { id: 1845 }
          type: STOCK
        }
        # Up to 100 variants can be specified in a single mutation
      ]
    }) {
      userErrors {
        message
        path
      }
      deliveryWindow {
        id
      }
    }
```

#### Reponse

```json
{
    "data": {
      "setDeliveryWindowVariants": {
        "userErrors": [],
        "deliveryWindow": {
          "id": 3,
      }
    },
    "extensions": {
      "complexity": 193,
      "permissionsUsed": [
        "DeliveryWindow:write",
        "DeliveryWindow:read",
        "Market:read",
        "Campaign:read",
        "AllocationRule:read",
        "Product:read"
      ],
      "appVersion": "v0.26.0"
    }
  }

### Order processing

With products in place, orders should start pouring in. Let’s go through how to read orders and how to work with fulfillment in Centra.

Before we do that, let’s talk about the standard order flow in Centra. It’s described in detail here:
https://docs.centra.com/overview/orderflow#order-flow


## Order statuses

There are 6 possible order statuses in Centra:

Pending: This order has just been authorized and inserted into Centra. It needs to be confirmed before it can be processed further. You can skip this status by enabling the Store Setting `Autoconfirm orders`, which will automatically put all new orders in Confirmed status. In the past customers used Pending to manually review all new orders, which is only feasible if you have a relatively low number of them every day.

Confirmed: This order has been confirmed, either via API, in AMS backend, or the store setting. Once confirmed, an order confirmation email can be sent to the shopper. Now you are ready to start creating shipments.

Processing: This order has at least one shipment, and at least one of those shipments is not completed. You can also enable Store Setting `Direct to Shipment`, which will automatically create GTG shipments for you, one per order. Each shipment in Centra has 3 sub-statuses:

Good-to-go: Set this boolean once your warehouse staff have collected the order. Good-to-go means all shipment items are packed in a parcel, with address labels attached, and any other documents that might be required. But we are not shipping this parcel just yet.
Paid: This denotes that the shipment has been paid for - the sum of shipped order items and shipping cost have been captured. If you are capturing payments outside of Centra, instead of capturing you can simply mark the shipment as Paid, without triggering a capture. Remember, in some countries it's against regulations to capture money for an un-shipped package, so make sure you know exactly what you’re doing, and when.

Shipped: Once the shipment is good-to-go and paid for, nothing stops you from shipping it - meaning handing it over to the delivery person and obtaining its tracking number. You can add the tracking information at the moment you complete your shipment. Remember, Centra doesn’t track parcel delivery, so from our perspective the shipment is completed as soon as the parcel is out the door and on its way to the shopper.

Completed: All the order items have been shipped (in one or multiple shipments), and the money for order items + shipping cost has been captured (or marked as Paid). As soon as the final shipment is completed, the order will be completed as well. GraphQL calls this order status “SHIPPED”.

Archived: Completed orders can be hidden from the default list view, and possibly from the API responses, when you choose to archive them. Archiving doesn’t trigger any special automations, but you may still be interested in marking an completed order as archived in your ERP, if you wish to.

Canceled: This order will not be completed, it has been canceled either by manual intervention in the AMS, or via the API. Canceling the order also cancels the payment, so this process is irreversible, you won’t be able to capture the order total after you have canceled it. WARNING: It is highly incorrect to cancel the order after it’s been captured. Please only cancel orders before that happens. If payment has already been captured, you should create a Return and refund the money instead.

## Fetching orders

Since the orders are created mostly in front ends (using webshop APIs or Showroom), likely the very first action your integration will take is to read that new order info. You have a number of ways to do it.

First, if you implement Centra Webhooks plugin running in “Integration API” mode, you can configure it to be notified about the new orders and shipments as soon as they are created. The easiest scenario will be when you receive a webhook of “type: order”, “action: insert”, together with the order number. Right when that happens, you can use GraphQL API to fetch this one specific order and sync it with your ERP:

#### Request: Fetching a specific order

```gql
query getOrders {
    orders(where: { number: 14 }) {
      number
      status
      isOnHold
      shippingAddress {
        firstName
        lastName
        city
      }
      ...customerId
    }
  }
  ```

#### Response

  ```json
  {
    "data": {
      "orders": [
        {
          "number": 14,
          "status": "PENDING",
          "isOnHold": false,
          "shippingAddress": {
            "firstName": "Jon",
            "lastName": "Snow",
            "city": "Winterfell"
          },
          "customer": {
            "id": 4,
            "email": "jon.snow@example.com"
          }
        }
      ]
    },
    "extensions": {
      "complexity": 229,
      "permissionsUsed": [
        "Order:read",
        "Order.shippingAddress:read",
        "Purchaser:read"
      ],
      "appVersion": "v0.32.3"
    }
  }
  ```

Depending on the fields you chose to return from the query, you can immediately access all the data relevant to your ERP, like name, address(es), list of ordered products, customer ID and email, order totals, tax breakdown, etc.

#### Locking orders

Depending on your design, there is one function that you might be very interested in: The ability to lock the orders using the API. The idea behind the locking mechanism is that you might want to prevent AMS backend users from editing or processing the orders which should be exclusively handled by the API. Therefore, locking ensures that only your integration will be able to add/cancel order items, create and complete shipments, etc.

#### Request

  ```gql
  mutation lockOrders {
    setOrdersLock(
      input: {
        orders: [{ number: 39514 }, { number: 39515 }]
        isLocked: true }
    ) {
      userErrors {
        message
        path
      }
      orders {
        number
        status
        isLocked
        shippingAddress {
          firstName
          lastName
        }
      }
    }
  }
  ```

#### Response

```json
{
    "data": {
      "setOrdersLock": {
        "userErrors": [],
        "orders": [
          {
            "number": 39514,
            "status": "PROCESSING",
            "isLocked": true,
            "shippingAddress": {
              "firstName": "Pio",
              "lastName": "Sym"
            }
          },
          {
            "number": 39515,
            "status": "PROCESSING",
            "isLocked": true,
            "shippingAddress": {
              "firstName": "Pio",
              "lastName": "Sym"
            }
          }
        ]
      }
    },
    "extensions": {
      "complexity": 131,
      "permissionsUsed": [
        "Order.isLocked:write",
        "Order:read",
        "Order.shippingAddress:read"
      ],
      "appVersion": "v0.30.0"
    }
  }
  ```

## Order updates

Now that we’ve read the order, we can choose what to do with it. First of all, if there were any mistakes, typos in names or addresses or similar, you can update basic order fields using this mutation (similar mutation exists for Wholesale):

#### Request

  ```gql
    mutation updateDtcBasicFields {
    updateDirectToConsumerOrder(
      order: {
        # id: "1497ccf644db871e1e4026d101bde6f3"
        number: 14
      }
      input: {
        shippingAddress: {
          firstName: "Jon"
          lastName: "Snow"
          address1: "Teststr. 1"
          address2: "1b"
          city: "Stockholm"
          zipCode: "12345"
          email: "jon.snow@example.com"
        }
        billingAddress: {
          firstName: "Jon"
          lastName: "Snow"
          address1: "Teststr. 1"
          address2: "1b"
          city: "Stockholm"
          zipCode: "12345"
          email: "jon.snow@example.com"
        }
        customer: {
          id: 4
        }
        customerInfo: {
          firstName: "Jon"
          lastName: "Snow"
          email: "jon.snow@example.com"
        }
        isInternal: false
      }
    ) {
      order {
        ...orderInfo
      }
      userErrors { message path }
    }
  }
  ```

#### Response

  ```json
  {
    "data": {
      "updateDirectToConsumerOrder": {
        "order": {
          "id": "1497ccf644db871e1e4026d101bde6f3",
          "number": 14,
          "isOnHold": false,
          "lines": [
            {
              "id": 68,
              "product": {
                "name": "Basic Jacket"
              },
              "quantity": 10,
              "taxPercent": 25,
              "unitPrice": {
                "value": 675,
                "currency": {
                  "id": 3,
                  "code": "SEK"
                },
                "conversionRate": 1
              },
              "hasAnyDiscount": false,
              "unitOriginalPrice": {
                "value": 675,
                "currency": {
                  "id": 3,
                  "code": "SEK"
                },
                "conversionRate": 1
              },
              "lineValue": {
                "value": 6750,
                "currency": {
                  "id": 3,
                  "code": "SEK"
                },
                "conversionRate": 1
              }
            }
          ],
          "discountsApplied": [
            {
              "value": {
                "value": 0,
                "currency": {
                  "id": 3,
                  "code": "SEK"
                },
                "conversionRate": 1
              },
              "date": "2022-11-09T13:15:11+01:00"
            }
          ],
          "shippingAddress": {
            "firstName": "Jon",
            "lastName": "Snow",
            "address1": "Teststr. 1",
            "address2": "1b",
            "city": "Stockholm",
            "zipCode": "12345",
            "stateOrProvince": null,
            "cellPhoneNumber": null,
            "phoneNumber": "+4684026100",
            "faxNumber": null,
            "email": "jon.snow@example.com",
            "companyName": null,
            "attention": null,
            "vatNumber": null,
            "country": {
              "id": 6,
              "name": "Sweden"
            },
            "state": null
          },
          "billingAddress": {
            "firstName": "Jon",
            "lastName": "Snow",
            "address1": "Teststr. 1",
            "address2": "1b",
            "city": "Stockholm",
            "zipCode": "12345",
            "stateOrProvince": null,
            "cellPhoneNumber": null,
            "phoneNumber": "+4684026100",
            "faxNumber": null,
            "email": "jon.snow@example.com",
            "companyName": null,
            "attention": null,
            "vatNumber": null,
            "country": {
              "id": 6,
              "name": "Sweden"
            },
            "state": null
          },
          "customer": {
            "email": "jon.snow@example.com",
            "firstName": "Jon",
            "lastName": "Snow"
          }
        },
        "userErrors": []
      }
    },
    "extensions": {
      "complexity": 229,
      "permissionsUsed": [
        "Order:write",
        "Order:read",
        "Order.shippingAddress:read",
        "Order.billingAddress:read",
        "Purchaser:read",
        "Product:read"
      ],
      "appVersion": "v0.32.3"
    }
  }
  ```

Next, let’s talk about modifying the order lines, which translates to adding or removing products to/from an order _after_ it has been placed in Centra. The most common use case is canceling an order item which was sold by mistake, when you realize you don’t have the stock to actually fulfill it. If that’s the case, you can cancel this order line, and later ship only available products, while capturing less money that was authorized, so that the customer pays the right total.

#### Request

  ```gql
  mutation updateDtcCancel {
    updateDirectToConsumerOrder(
      order: {
        number: 14
      }
      input: {
        cancelLines: [
          {
            line: {
              id: 68
            }
            quantity: 1
            stockAction: RELEASE_BACK_TO_WAREHOUSE
          }
        ]
        cancellationComment: "Some good reason"
      }
    ) {
      order {
        ...orderInfo
      }
      userErrors { message path }
    }
  }
  ```

#### Response

  ```json
  {
    "data": {
      "updateDirectToConsumerOrder": {
        "order": {
          "id": "1497ccf644db871e1e4026d101bde6f3",
          "number": 14,
          "status": "PENDING",
          "isOnHold": false,
          "lines": [
            {
              "id": 68,
              "product": {
                "name": "Basic Jacket"
              },
              "quantity": 9,
              "taxPercent": 25,
              "unitPrice": {
                "value": 675,
                "currency": {
                  "id": 3,
                  "code": "SEK"
                },
                "conversionRate": 1
              },
              "hasAnyDiscount": false,
              "unitOriginalPrice": {
                "value": 675,
                "currency": {
                  "id": 3,
                  "code": "SEK"
                },
                "conversionRate": 1
              },
              "lineValue": {
                "value": 6075,
                "currency": {
                  "id": 3,
                  "code": "SEK"
                },
                "conversionRate": 1
              }
            }
          ],
          "discountsApplied": [
            {
              "value": {
                "value": 0,
                "currency": {
                  "id": 3,
                  "code": "SEK"
                },
                "conversionRate": 1
              },
              "date": "2022-11-09T13:15:11+01:00"
            }
          ],
          "shippingAddress": {
            "firstName": "Jon",
            "lastName": "Snow",
            "address1": "Teststr. 1",
            "address2": "1b",
            "city": "Stockholm",
            "zipCode": "12345",
            "stateOrProvince": null,
            "cellPhoneNumber": null,
            "phoneNumber": "+4684026100",
            "faxNumber": null,
            "email": "jon.snow@example.com",
            "companyName": null,
            "attention": null,
            "vatNumber": null,
            "country": {
              "id": 6,
              "name": "Sweden"
            },
            "state": null
          },
          "billingAddress": {
            "firstName": "Jon",
            "lastName": "Snow",
            "address1": "Teststr. 1",
            "address2": "1b",
            "city": "Stockholm",
            "zipCode": "12345",
            "stateOrProvince": null,
            "cellPhoneNumber": null,
            "phoneNumber": "+4684026100",
            "faxNumber": null,
            "email": "jon.snow@example.com",
            "companyName": null,
            "attention": null,
            "vatNumber": null,
            "country": {
              "id": 6,
              "name": "Sweden"
            },
            "state": null
          },
          "customer": {
            "email": "jon.snow@example.com",
            "firstName": "Jon",
            "lastName": "Snow"
          }
        },
        "userErrors": []
      }
    },
    "extensions": {
      "complexity": 229,
      "permissionsUsed": [
        "Order:write",
        "Order:read",
        "Order.shippingAddress:read",
        "Order.billingAddress:read",
        "Purchaser:read",
        "Product:read"
      ],
      "appVersion": "v0.32.3"
    }
  }
  ```

When it comes to adding order lines, be very mindful about it. While it’s usually perfectly OK in Wholesale orders, where the order oftentimes will be paid by invoice and there is no payment authorization, please note that adding a product to a DTC order would _increase_ the order total, which would then be higher than the amount that was authorized during purchase. If you do that, you won’t be able to capture more money than was previously authorized.

#### Request

  ```gql
    mutation updateWholesaleAddProducts {
    updateWholesaleOrder(
      order: {
        # id: "c8b6e87b1d9408f845a0440d226696df"
        number: 3957
      }
      input: {
        addLines: [
          {
            display: {
              id: 1
            }
            productSize: {
              id: 1
            }
            quantity: 1
            unitPrice: {
              value: 110.00
              currencyIsoCode: "SEK"
            }
            taxGroup: {
              id: 2
            }
          }
        ]
      }
    ) {
      order {
        ...orderInfo
      }
      userErrors { message path }
    }
  }
  ```

## Confirming an order

Now that our order looks as expected, let’s process it further. First step (possible to skip with Store Settings) is to confirm the order. Once done, an order confirmation email can be sent to the shopper, depending on your setup and mailer of choice.

#### Request

  ```gql
  mutation confirmOrder {
    confirmOrder(
      input: {
        order: {
          number: 14
        }
      }
    ) {
      order {
        number
        status
      }
      userErrors { message path }
    }
  }
  ```

#### Response

  ```json
    {
    "data": {
      "confirmOrder": {
        "order": {
          "number": 14,
          "status": "CONFIRMED"
        },
        "userErrors": []
      }
    },
    "extensions": {
      "complexity": 112,
      "permissionsUsed": [
        "Order:write",
        "Order:read"
      ],
      "appVersion": "v0.32.3"
    }
  }
  ```

## Shipment creation and capture

After the order is confirmed, you can now create shipments and capture the money. You can read more about capture with the Integration API here LINK https://docs.centra.com/api-references/graphql-integration-api/examples/dtc#general-notes-on-payment-captures-in-gql

I mentioned before that captures are most closely related to shipments, and in most cases you should only be capturing money for the items you are about to ship (+ shipping cost). Centra supports split payment captures, if the integration with the PSP allows for it, so you won’t have any problems with that, as long as you remember to only include the shipping cost on one of the shipments.

There is another way, though, which can make things easier in some integrations. In GraphQL we’ve added a mutation which allows you to capture the entire order amount, even before you have shipments created. This might be convenient in some cases, e.g. if you’re selling “virtual” goods, like gift cards, and need to capture the payment immediately to avoid fraud. This might also be a good idea if you expect that the goods will not be shipped for a while (e.g. you’re selling pre-order products), while you only have a specific time available to perform the capture, based on the payment method used (usually 14/30/60 days after auth).

#### Request: Capture an order prior to shipment

```gql
mutation captureOrder {
    captureOrder(order: {id: "05ac658a8e815571fdba2984eb358932"
                         # number: 10 }) {    
      userErrors {
        message 
        path
      }
      paymentHistoryEntry {      
        createdAt
        status
        entryType
        externalReference
        value {value}
        paymentMethod
        paramsJSON
      }
      order {
        id
      }
    }
  }
  ```

If you choose to only capture the money for items that were actually shipped, you can split your shipment processing into 3 stages:

First, let’s create a shipment which is not paid for, only specifying which order lines you would like to include in this shipment.

#### Request: Creating an unpaid shipment

```gql
  mutation createShipment {
    createShipment (
      input: {
        order: { number: 39790 }
        lines: [{ orderLine: { id: 17635 }, quantity: 2 }]
        isGoodToGo: true
        isPaid: false
        createdAt: "2022-06-23 15:47:12"
        shippedAt: null
        sendEmail: false
        additionalMessage: "Additional message"
        allocateDemand: true
      }
    ) {
      userErrors {
        message
        path
      }
      shipment {
        ...shipmentDetails
      }
    }
  }
   
  fragment shipmentDetails on Shipment {  
    id
    number
    createdAt
    updatedAt
    isGoodToGo
    isShipped
    isPaid
    paidAt
    additionalMessage
    isShipped
    shippedAt
    numberOfPackages  
    trackingNumber
    returnTrackingNumber
    internalShippingCost {
      value
    }  
    grandTotal(includingTax: true) {
      value
    }
    carrierInformation {
      carrierName
      serviceName
    }
    adminUser {
      id
    }
    discountsApplied {
      value {
        formattedValue
      }
    }
    lines {
      id
      quantity
      lineValue {
        formattedValue
      }
    }
    shippingAddress {
      firstName
      lastName
      country {
        name
        code
      }
      state {
        name
        code
      }
      address1
      address2
      city
      zipCode
      stateOrProvince
      cellPhoneNumber
      phoneNumber
      faxNumber
      email
    }
    shipmentPlugin {
      id
      status
      name
    }
  }
  ```

#### Response

  ```json
  {
    "data": {
      "createShipment": {
        "userErrors": [],
        "shipment": {
          "id": 345,
          "number": "39790-1",
          "createdAt": "2022-06-23T15:47:12+02:00",
          "updatedAt": "2023-01-16T10:31:34+01:00",
          "isGoodToGo": true,
          "isShipped": false,
          "isPaid": false,
          "paidAt": null,
          "additionalMessage": "Additional message",
          "shippedAt": null,
          "numberOfPackages": 0,
          "trackingNumber": null,
          "returnTrackingNumber": null,
          "internalShippingCost": {
            "value": 0
          },
          "grandTotal": {
            "value": 900
          },
          "carrierInformation": null,
          "adminUser": null,
          "discountsApplied": [],
          "lines": [
            {
              "id": 465,
              "quantity": 2,
              "lineValue": {
                "formattedValue": "700.00 SEK"
              }
            }
          ],
          "shippingAddress": {
            "firstName": "Pio",
            "lastName": "Sym",
            "country": {
              "name": "Sweden",
              "code": "SE"
            },
            "state": null,
            "address1": "Addr 1",
            "address2": null,
            "city": "City",
            "zipCode": "12345",
            "stateOrProvince": "State",
            "cellPhoneNumber": "123456789",
            "phoneNumber": null,
            "faxNumber": null,
            "email": "test@test.com"
          },
          "shipmentPlugin": null
        }
      }
    },
    "extensions": {
      "complexity": 131,
      "permissionsUsed": [
        "Shipment:write",
        "Shipment:read",
        "AdminUser:read",
        "Order:read",
        "Shipment.shippingAddress:read",
        "StorePlugin:read"
      ],
      "appVersion": "v0.34.6"
    }
  }
  ```

Such shipment can later be captured or marked as paid at any point.

#### Request: Capturing a shipment

```gql
mutation captureShipment {
    captureShipment(id: 123) {
      userErrors {
        message 
        path
      }
      paymentHistoryEntry {
        createdAt
        status
        entryType
        externalReference
        value {value}
        paymentMethod
        paramsJSON
      }
      shipment {
        id
        number
        isCaptured
        capturedAt
      }
    }  
  }
  ```

#### Request: Mark a shipment as paid

  ```gql
  mutation updateShipmentMarkPaid {
    updateShipment (
      id: 345
      input: {
        isPaid: true
      }
    ) {
      userErrors {
        message
        path
      }
      shipment {
        ...shipmentDetails
      }
    }
  }
  ```

#### Response

  ```json
  {
    "data": {
      "updateShipment": {
        "userErrors": [],
        "shipment": {
          "id": 345,
          "number": "39790-1",
          "createdAt": "2022-06-23T15:47:12+02:00",
          "updatedAt": "2023-01-16T10:35:35+01:00",
          "isGoodToGo": true,
          "isShipped": false,
          "isPaid": true,
          "paidAt": "2023-01-16T10:35:35+01:00",
          "additionalMessage": "Additional message",
          "shippedAt": null,
          "numberOfPackages": 0,
          "trackingNumber": null,
          "returnTrackingNumber": null,
          "internalShippingCost": {
            "value": 0
          },
          "grandTotal": {
            "value": 900
          },
          "carrierInformation": null,
          "adminUser": null,
          "discountsApplied": [],
          "lines": [
            {
              "id": 465,
              "quantity": 2,
              "lineValue": {
                "formattedValue": "700.00 SEK"
              }
            }
          ],
          "shippingAddress": {
            "firstName": "Pio",
            "lastName": "Sym",
            "country": {
              "name": "Sweden",
              "code": "SE"
            },
            "state": null,
            "address1": "Addr 1",
            "address2": null,
            "city": "City",
            "zipCode": "12345",
            "stateOrProvince": "State",
            "cellPhoneNumber": "123456789",
            "phoneNumber": null,
            "faxNumber": null,
            "email": "test@test.com"
          },
          "shipmentPlugin": null
        }
      }
    },
    "extensions": {
      "complexity": 131,
      "permissionsUsed": [
        "Shipment:write",
        "Shipment:read",
        "AdminUser:read",
        "Order:read",
        "Shipment.shippingAddress:read",
        "StorePlugin:read"
      ],
      "appVersion": "v0.34.6"
    }
  }
  ```

You can combine the two steps above, and create shipments which should be captured immediately upon creation:

#### Request: Creating and capturing a shipment

  ```gql
  mutation createShipmentWithCapturing {
    createShipment(
      input: {
        order: {
          id: "05ac658a8e815571fdba2984eb358932"
          # number: 10
        }
        lines: [
          { orderLine: { id: 10 }, quantity: 1 }
        ]
        capture: true   # this will enable capturing 
      }
    ) {
      userErrors {
        message
        path
      }
      shipment {
        id
        isCaptured
        capturedAt
        order {
          paymentHistory(where: {entryType: [CAPTURE, CAPTURE_REQUEST]}) {
            createdAt
            status
            entryType
            externalReference
            value {value}
            paymentMethod
            paramsJSON
          }
        }
      }
    }
  }
  ```

Once the shipment is Good-to-go and paid for, you can ship it out. This is done by completing the shipment, at which stage you can add the shipment info (like carrier, service and tracking number), set the shipped date and choose whether or not to send out the shipping confirmation email to your shopper. In GraphQL `shipped` parameter is not a boolean, but rather a timestamp of when this shipment was completed. Good news - this timestamp supports the same options as PHP date, so setting it can be as easy as sending `shippedAt: now`. Centra will save the right timestamp on the shipment for you.

Examples of the date could be "yesterday", "21/10/2023", "-1 hour". It cannot be in the future. You can find more information about the PHP date here https://www.google.com/url?q=https://www.php.net/manual/en/datetime.formats.relative.php&sa=D&source=docs&ust=1690884374796624&usg=AOvVaw0ybeIjr3-b_BsSjNMVRzEp

#### Request

  ```gql
  mutation completeShipment {
    completeShipment (
      id: 345
      input: {
        shippedAt: "2023-01-09T15:18:33+01:00"
        sendEmail: true
        shipmentInfo: {
          carrier: "Carrier name"
          service: "Service name"
          packagesNumber: 1
          trackingNumber: "1234trackingcode"
          returnTrackingNumber: "1234returncode"
          internalShippingCost: { currencyIsoCode: "SEK", value: 12 }
        }
      }
    ) {
      userErrors {
        message
        path
      }
      shipment {
        ...shipmentDetails
      }
    }
  }
  ```

#### Response

  ```json
    {
    "data": {
      "completeShipment": {
        "userErrors": [],
        "shipment": {
          "id": 346,
          "number": "39790-1",
          "createdAt": "2022-06-23T15:47:12+02:00",
          "updatedAt": "2023-01-16T10:39:23+01:00",
          "isGoodToGo": true,
          "isShipped": true,
          "isPaid": true,
          "paidAt": "2023-01-16T10:39:17+01:00",
          "additionalMessage": "Additional message",
          "shippedAt": "2023-01-09T15:18:33+01:00",
          "numberOfPackages": 1,
          "trackingNumber": "1234trackingcode",
          "returnTrackingNumber": "1234returncode",
          "internalShippingCost": {
            "value": 12
          },
          "grandTotal": {
            "value": 900
          },
          "carrierInformation": {
            "carrierName": "Carrier name",
            "serviceName": "Service name"
          },
          "adminUser": null,
          "discountsApplied": [],
          "lines": [
            {
              "id": 466,
              "quantity": 2,
              "lineValue": {
                "formattedValue": "700.00 SEK"
              }
            }
          ],
          "shippingAddress": {
            "firstName": "Pio",
            "lastName": "Sym",
            "country": {
              "name": "Sweden",
              "code": "SE"
            },
            "state": null,
            "address1": "Addr 1",
            "address2": null,
            "city": "City",
            "zipCode": "12345",
            "stateOrProvince": "State",
            "cellPhoneNumber": "123456789",
            "phoneNumber": null,
            "faxNumber": null,
            "email": "test@test.com"
          },
          "shipmentPlugin": null
        }
      }
    },
    "extensions": {
      "complexity": 131,
      "permissionsUsed": [
        "Shipment:write",
        "Shipment:read",
        "AdminUser:read",
        "Order:read",
        "Shipment.shippingAddress:read",
        "StorePlugin:read"
      ],
      "appVersion": "v0.34.6"
    }
  }
  ```

## Returns

If products from an order get returned by a customer or packages are delivered back to the warehouse due to delivery issues etc, a return can be created. A return is connected to a specific shipment.

Refunds are currently not supported with the Integration API, but can be handled with Order API (REST) until the mutation is available.

There are three specific options to consider when creating a Return:

releaseItemsBackToWarehouse → the items will be sent back to the warehouse they originally came from
sendItemsToDifferentWarehouse → items will be sent to a warehouse specified by the user
removeItemsFromStock → physical products will not be returned, there will be no increase in stock for any warehouse

Additional costs, such as handling fees, shipping costs, or voucher value, can also be specified in this mutation. These values can not be greater the the remaining value of these costs on shipment.

#### Request: Creating a return

```gql
mutation createreturn {
      createReturn(
      input: {
        shipment: { id: 1338 }
        lines: [
          { shipmentLine: { id: 2943 }, quantity: 2 }
          { shipmentLine: { id: 2944 }, quantity: 2 }
        ]
        returnStockActionPolicy: { releaseItemsBackToWarehouse: true }
        shippingCost: { value: { currencyIsoCode: "SEK", value: 10.00 } }
        voucherValue: { fromShipment: true }
        handlingCost: { fromShipment: true }
        comment: "new comment"
      }
      ) {
      userErrors {
        message
        path
      }
      return {
        id
        lines {
          id
        }
      }
      }
    }
```

If you would like to complete a return using the Integration API you can do it by running completeReturn mutation. First you can query the returns to find the needed id.

#### Request

```gql
query returns {
      returns {
      id
      status
      lines {
        shipmentLine {
          id
        }
      }
      }
    }
```

In the completeReturn mutation you can also pass the information on whether an email with return confirmation should be sent to the customer. You can’t complete a return that already has a completed status.

#### Request

```gql
mutation completereturn {
      completeReturn(
      id: 315
      input: {
        sendEmail:true
      }
      ) {
      userErrors {
        message
        path
      }
      return {
        id
        status
      }
      }
    }
```

You also have the option to un-complete a return if needed.

#### Request

```gql
  mutation uncompletereturn {
      uncompleteReturn(id: 315) {
      userErrors {
        message
        path
      }
      return {
        id
        status
      }
      }
    }
```

If a return was created by mistake and needs to be deleted, you also have that possibility

#### Request

```gql
mutation deleteReturn {
      deleteReturn(id: 436) {
      userErrors {
        message
        path
      }
      return {
        id
        lines {
          id
        }
      }
      }
    }
```

All you need to provide is the return ID. The stock will be re-allocated according to the policy that was selected when creating the return. If the return was created using the releaseItemsBackToWarehouse stock policy, the order and shipment lines will be re-allocated based on the allocation rule assigned to the order.

sendItemsToDifferentWarehouse → the order and shipment lines will be re-allocated, the stock will be re-allocated from the warehouse specified by the user when creating the return.

removeItemsFromStock → the shipment lines quantity will be updated to reflect the change but there will be no re-allocation. The idea is that the items were not added back to stock, the user can decide whether to re-allocate it again.

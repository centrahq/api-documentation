---
title: Integrating Centra with an PIM and/or ERP systems using GraphQL Integration API
altTitle: PIM/ERP integration with GQL
excerpt: Centra can be configured to integrate with your Product Information Management and/or Enterprise Resource Planning systems using GraphQL API. As GQL is still in Beta, this functionality is still under development
taxonomy:
  category: docs
---

In Centra, we strongly believe GraphQL is the future of the APIs, just like REST is the present and SOAP is the past. For that reason, we've been putting a lot of effort into building our GQL API into what we think will be the _last_ integration API you will ever need.

[notice-box=info]
Centra GraphQL API is currently in Beta, so not all the ERP-related functionality is available at the moment. For now you can use it to integrate with your PIM system and get used to GQL in general, additionally we recommend you to sign up for our Newsletter to be notified about updates. Let us know if there's any specific functionality you need with priority and we will look into it. You can always see the latest additions in the [GraphQL API changelog](https://docs.centra.com/graphql/#changelog).
[/notice-box]

## GraphQL API introduction

All queries, mutations and examples are documented in [GraphQL Integration API reference](/api-references/graphql-integration-api).

GraphQL is used to Send a query to Centra API and get exactly what you need, nothing more and nothing less. GraphQL queries always return predictable results. Apps using GraphQL are fast and stable because they control the data they get, not the server.

## Quick note about API tokens

GraphQL is different from other Centra APIs, especially when it comes to authentication. Whereas both SOAP and REST APIs used shared API secret password to authenticate, identical for every API consumer, GQL authentication is based on personal API tokens. Each Production token should be assigned to a specific user name or an API function, and have only enough permissions to run the designed function. In QA, you are welcome to create test tokens will all permissions, but that is _only_ allowed for development purposes. Every time you make a GQL API call, the API response will include a full list of permissions that were used by this call. With this information, once you're done with testing, you can create a Production token with _minimal_ required permissions and re-test.

It is _not allowed_ to use a full-permissions API tokens in Production. This is simply not safe, as GraphQL gives you granular access to almost every part of Centra. It's also not allowed to share your tokens with others - every Centra admin user can create a new test token in a matter of seconds. Centra monitors the usage of those API tokens, so if you abuse those rules, we might contact you and ask that you address it.

For more information about generating and using API tokens, see the [authorization chapter of our GraphQL API docs](/api-references/graphql-integration-api/authorization).

***

# Cookbook

## Connection test - fetch Stores

https://docs.centra.com/graphql/query.html#stores

Before you proceed, follow the instructions above to obtain your own API token. In QA, you can start with an all-permissions token for yourself. To test the connection, we will fetch info about your Stores, since even an empty Centra setup will have at least one configured. This is a read only operation, nothing bad can happen.

[notice-box=alert]
Never use the integration you build towards a production Centra environment before it is thoroughly tested and verified to be working as intended!
[/notice-box]

#### Request

```sh
curl "${BASE_URL}/graphql" \
	    -X POST \
	    -H "Cookie: graphql-access=${ACCESS_TOKEN}" \
	    -H "Content-Type: application/json" \
	    -d '{"query": "{ stores{ id name } }"}'
```

Pretty:

```gql
query getStores {
  stores {
    id
    name
  }
}
```

#### Response

```json
{
  "data": {
    "stores": [
      {
        "id": 1,
        "name": "Retail Store"
      },
      {
        "id": 2,
        "name": "Wholesale"
      }
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Store:read"
    ]
  }
}
```

As you can see, not only does GQL API return _precisely_ the data you asked for, nothing more, it also tells you which permissions were used, so that you know precisely how to configure your Prod API token in the future.

## Markets - read and create

https://docs.centra.com/graphql/query.html#markets

Markets in Centra decide which Products are visible to the API consumer. [Click here to learn more](https://docs.centra.com/overview/centra-overview#market).

### Fetching Markets

#### Request

```gql
query getMarkets {
  markets {
    id
    name
    assignedToCountries {
      code
      name
      isEU
    }
  }
}
```

#### Response

```json
{
  "data": {
    "markets": [
      {
        "id": 1,
        "name": "Sweden",
        "assignedToCountries": [
          {
            "code": "SE",
            "name": "Sweden",
            "isEU": true
          }
        ]
      },
      {
        "id": 2,
        "name": "USA",
        "assignedToCountries": [
          {
            "code": "US",
            "name": "United States",
            "isEU": false
          }
        ]
      },
      {
        "id": 3,
        "name": "World",
        "assignedToCountries": [
          {
            "code": "AX",
            "name": "Aland Islands",
            "isEU": false
          },
          {
            "code": "AL",
            "name": "Albania",
            "isEU": false
          },
          {
            "code": "AD",
            "name": "Andorra",
            "isEU": false
          },
          {
            "code": "AT",
            "name": "Austria",
            "isEU": true
          },

          // ...truncated

          ]
      },
      {
        "id": 4,
        "name": "Amazon",
        "assignedToCountries": []
      },
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Market:read",
      "Market.Country:read"
    ]
  }
}
```

As you can see, not all Markets have to be assigned to Countries. Some are hidden, like VIP sales, others (like Amazon) can be used in other ways.

Please note, reading Markets and reading Market Countries use different permissions. Remember, if your integration doesn't need to know about Market countries, there's no reason to enable that permission in your integration token setup.

### Creating new Markets

[TBD]

## Folders - read and create

https://docs.centra.com/graphql/query.html#folders

Folders are a way to categorise your Products in Centra. Different than Categories, Folders are meant for internal use only. They are also generic for all the Stores you have configured in your Centra, while Categories are configured per-store.

### Creating a new folder

#### 1st folder - Request

Top-level folder.

```gql
mutation addFolder {
  createFolder(input:{
    name: "First folder",
    parent: null
  }){
    folder{
      id
      name
      isTopFolder
    }
  }
}
```

#### 1st folder - Response

```json
{
  "data": {
    "createFolder": {
      "folder": {
        "id": 1,
        "name": "First folder",
        "isTopFolder": true
      }
    }
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Folder:write",
      "Folder:read"
    ]
  }
}
```

#### 2nd folder - Request

Child folder.

```gql
mutation addFolder {
  createFolder(input:{
    name: "Second folder",
    parent: {id: 1}
  }){
    folder{
      id
      name
      isTopFolder
    }
  }
}
```

#### 2nd folder - Response

```json
{
  "data": {
    "createFolder": {
      "folder": {
        "id": 2,
        "name": "Second folder",
        "isTopFolder": false
      }
    }
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Folder:write",
      "Folder:read"
    ]
  }
}
```

### Fetching folders

You can fetch the Folders themselves, or use this query to find the Products in specific folders.

Remember, this is just an example. You can use other [FolderFilter](https://docs.centra.com/graphql/folderfilter.html) inside the `where` clause, and use any other [StringMatch](https://docs.centra.com/graphql/stringmatch.html) when searching by name, for example.

#### Request

```gql
query getFolders{
  folders(where: { name: { contains: "First" } }) {
    id
    name
    isTopFolder
    products{
      ...basicProductFields
    }
  }
}

fragment basicProductFields on Product {
  id
  name
  status
  productNumber
  harmonizedCommodityCode
  harmonizedCommodityCodeDescription
  internalComment
  isBundle
  isSerializableProduct
  createdAt
  updatedAt
}
```

#### Response

We just added this Folder, so it has no Products yet.

```json
{
  "data": {
    "folders": [
      {
        "id": 1,
        "name": "First folder",
        "isTopFolder": true,
        "products": []
      }
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Folder:read",
      "Folder.Product:read"
    ]
  }
}
```

## Brands - read and create

https://docs.centra.com/graphql/query.html#brands

A Brand is a general attribute on product level where you can store the product’s brand. Each product can only belong to a single brand.

### Creating a new brand

In order to fully use a brand, you should enable it in one or more of your Stores.

#### Request

```gql
mutation addBrand {
  createBrand(input: {
    name: "My Brand",
  	uri: "my-brand",
    addToStores: { id: 1 } }
  ) {
    brand {
      id
      name
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
    "createBrand": {
      "brand": {
        "id": 1,
        "name": "My Brand"
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Brand:write",
      "Brand:read"
    ]
  }
}
```

### Fetching brands

#### Request

```gql
query getBrands {
  brands(where: { name: { contains: "My Brand" } } )
  {
    id
    name
  }
}
```

#### Response

```json
{
  "data": {
    "brands": [
      {
        "id": 1,
        "name": "My Brand"
      }
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Brand:read"
    ]
  }
}
```

## Collections - read and create

https://docs.centra.com/graphql/query.html#collections

Collections are mainly a concept seen in fashion, e.g. this could be a spring-summer Collection like `AW21` or `SS22`. If products aren’t set by season and you are selling other appliances, this could e.g. be “Kitchen”. It’s mainly used as a filter option in both Centra and the Centra Showroom.

### Creating a new collection

#### Request

```gql
mutation addCollection {
  createCollection(input: {
    name: "Collection 1",
    status: ACTIVE
  }) {
    collection {
      id
      name
      status      
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
    "createCollection": {
      "collection": {
        "id": 1,
        "name": "Collection 1",
        "status": "ACTIVE"
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Collection:write",
      "Collection:read"
    ]
  }
}
```

### Fetching collections

#### Request

```gql
query getCollections {
  collections(where: { name: { contains: "Col" } } )
  {
    id
    name
  }
}
```

#### Response

```json
{
  "data": {
    "collections": [
      {
        "id": 1,
        "name": "Collection 1"
      }
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Collection:read"
    ]
  }
}
```

## Product Size Charts - read and create

https://docs.centra.com/graphql/query.html#sizeCharts

Size charts define the sizes of each Product Variant in Centra. Creating them should be a one-time action, which you should perform before importing Products into your Centra. Once assigned to a Variant, size chart can not be changed. If a size is used by a variant, especially if those belong to an existing order, you will not be able to remove them for historical (or even legal) reasons.

### Fetching existing size charts and sizes

#### Request

```gql
query getSizeChartsAndSizes {
  sizeCharts{
    id
    name
    sizes {
      id
      name
    }
  }
}
```

#### Response

```json
{
  "data": {
    "sizeCharts": [
      {
        "id": 1,
        "name": "One Size",
        "sizes": [
          {
            "id": 1,
            "name": "One Size"
          }
        ]
      },
      {
        "id": 2,
        "name": "S-XXL",
        "sizes": [
          {
            "id": 2,
            "name": "S"
          },
          {
            "id": 3,
            "name": "M"
          },
          {
            "id": 4,
            "name": "L"
          },
          {
            "id": 5,
            "name": "XL"
          },
          {
            "id": 6,
            "name": "XXL"
          }
        ]
      }
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "SizeChart:read"
    ]
  }
}
```

### Creating new size charts

Here's how you can create a simple 1- or 2-dimensional size chart.

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

#### Response: One-size chart

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

#### Request: SML chart

```gql
mutation addSizeChart {
  createSizeChart(
    input: {
      name: "Shirts SML"
      dividerSymbol: "x"  
      horizontalLabels: ["S", "M", "L"]
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

#### Response: SML chart

```json
{
  "data": {
    "createSizeChart": {
      "userErrors": [],
      "sizeChart": {
        "id": 2,
        "name": "Shirts SML",
        "sizes": [
          {
            "id": 2,
            "name": "S"
          },
          {
            "id": 3,
            "name": "M"
          },
          {
            "id": 4,
            "name": "L"
          }
        ],
        "horizontalLabels": [
          "S",
          "M",
          "L"
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

#### Request: Any size chart

```gql
mutation addSizeChart {
  createSizeChart(
    input: {
      name: "Any size chart"
      dividerSymbol: "x"  
      horizontalLabels: ["X", "Y", "Z"]
      verticalLabels: ["A", "B"]
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

#### Response: Any size chart

```json
{
  "data": {
    "createSizeChart": {
      "userErrors": [],
      "sizeChart": {
        "id": 3,
        "name": "Any size chart",
        "sizes": [
          {
            "id": 5,
            "name": "XxA"
          },
          {
            "id": 6,
            "name": "XxB"
          },
          {
            "id": 7,
            "name": "YxA"
          },
          {
            "id": 8,
            "name": "YxB"
          },
          {
            "id": 9,
            "name": "ZxA"
          },
          {
            "id": 10,
            "name": "ZxB"
          }
        ],
        "horizontalLabels": [
          "X",
          "Y",
          "Z"
        ],
        "verticalLabels": [
          "A",
          "B"
        ],
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

### Modifying size charts (not recommended)

It's usually better and cleaner to create a new size chart, instead of modifying existing ones, especially if they are used in existing records, like orders and shipments.

[TBD]

### Removing size charts

If you have to. It's better than adjusting existing charts, usually.

#### Request

```gql
mutation deleteSizeChart {
  removeSizeChart(
    id: 3
  ) {
    userErrors {
      message
      path
    }
  }
}
```

#### Response

No errors means no problem. :)

```json
{
  "data": {
    "removeSizeChart": {
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "SizeChart:write"
    ]
  }
}
```

## Product Measurement Charts - read and create

https://docs.centra.com/graphql/query.html#measurementCharts

Measurement charts are used to display the measurements of your products. While Size Charts define product sizes (S, M, L, XL, XXL), measurement charts are used to define their measurements, in specific units, for each size. For example, measuremement chart for trousers can consist of leg and waist size, defined in cm or inches, for each defined size.

### Creating a new measurement chart

In this example, we will create a measurements table for our shirt product, defining what measurements each sizes (S, M, L) have.

#### Request

```gql
mutation addMeasurementChart {
  createMeasurementChart(
    input: {
      name: "Shirts"
      horizontalLabels: ["S", "M", "L"]
      verticalLabels: ["Chest", "Sleeve"]
      displayUnit: "cm"
      values: [
        {horizontalLabel: "S", verticalLabel: "Chest", value: "80"},
        {horizontalLabel: "S", verticalLabel: "Sleeve", value: "55"},
        {horizontalLabel: "M", verticalLabel: "Chest", value: "85"},
        {horizontalLabel: "M", verticalLabel: "Sleeve", value: "58"},
        {horizontalLabel: "L", verticalLabel: "Chest", value: "90"},
        {horizontalLabel: "L", verticalLabel: "Sleeve", value: "60"}
      ]
    }
  ) {
    measurementChart {
      id
      name
      horizontalLabels
      verticalLabels
      displayUnit
      contentJSON
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
    "createMeasurementChart": {
      "measurementChart": {
        "id": 5,
        "name": "Shirts",
        "horizontalLabels": [
          "S",
          "M",
          "L"
        ],
        "verticalLabels": [
          "Chest",
          "Sleeve"
        ],
        "displayUnit": "cm",
        "contentJSON": "{\"Chest\":{\"S\":\"80\",\"M\":\"85\",\"L\":\"90\"},\"Sleeve\":{\"S\":\"55\",\"M\":\"58\",\"L\":\"60\"}}"
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "MeasurementChart:write"
    ]
  }
}
```

### Deleting a measurement chart

Just like with other resources - you can only delete a measurement chart when it's not in use. Still, if you created your chart wrong, it's better to remove it and start over, instead of modifying it.

#### Request

```gql
mutation deleteMeasurementChart {
  removeMeasurementChart(id: 5) {
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
    "removeMeasurementChart": {
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "MeasurementChart:write"
    ]
  }
}
```

## Warehouses - read and create

https://docs.centra.com/graphql/query.html#warehouses

[Warehouses](/overview/stock#warehouses-and-allocation-rules) are the logical entities holding product Stock. Warehouse stock items connect directly to each variant size.

### Fetching existing warehouses

Once you've filtered which Warehouses you are interested in, you can fetch any data you need about each of the Warehouses returned. To see other ways of filtering Warehouses, see [WarehouseFilter definition](https://docs.centra.com/graphql/warehousefilter.html) in our documentation.

#### Request

```gql
query getWarehouses {
  warehouses(where: { name: { contains: "Retail" } }, sort: [id_ASC]) {
    id
    name
    status
  }
}
```

#### Response

```gql
{
  "data": {
    "warehouses": [
      {
        "id": 3,
        "name": "Retail",
        "status": "ACTIVE"
      }
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Warehouse:read"
    ]
  }
}
```

### Creating a new warehouse

[TBD]

## Adding Product 1

https://docs.centra.com/graphql/query.html#products

Just the basic Product, without Variants (yet) and no size chart selected.

#### Request

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

## Adding Product 1 Variant 1: A chair

This is a one-size product - which is the size chart you should use for any product variant that doesn't have multiple sizes.

#### Request

```gql
mutation createVariant {
  createProductVariant(input: {
    product: { id: 1 }
    name: "First Product"
    status: ACTIVE
    variantNumber: "Var123"
    internalName: "vrnt"
    unitCost: {   # MonetaryValueInput
      value: 41
      currencyIsoCode: "EUR"
    }
    sizeChart: { id: 1 }
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
        "id": 1
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

## Activating sizes of Product 1 Variant 1: A chair

Once the Product and Variant is created, and the size chart selected, you need to add (activate) the desired variant sizes. This is required, since in Centra you don't need to use _all_ the configured sizes - for instance, you can configure a XXS-XXL size chart and choose it for a product variant, but only activate sizes S-L.

#### Request

You already know your Variant and Size IDs - Centra generated them when you created them. For every variant size you can configure size number (previously known as SKU) and/or GTIN (or EAN) number.

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

As you can see, new `productSize` ID is generated. These are the sizes generated _for this specific variant_, they will be uniquely connected to Stock levels in your Warehouse.

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

## Adding Product 1 Variant 2: A sweater

This example creates or updates a product – in this case a sweater. In our example it will only have a single Variant, which is available in sizes S, M and L.

The only difference from the previous example is using the second size chart this time.

#### Request

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

## Activating sizes of Product 1 Variant 2: A sweater

This is a multi-size Variant, each size needs to be activated separately.

#### Request

You can also match the size by name, instead of an ID. Repeat those mutations for sizes M and L.

```gql
mutation createMultipleSizes {
  createProductSize(
    input: {
      productVariant: { id: 2 },
      size: { name: "S" },
      gtin: "EAN123456789S",
      sizeNumber: "789S"
    }
  )
  {
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
        "id": 281,
        "GTIN": "EAN123456789S",
        "sizeNumber": "789S"
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

## Adding Product 3: A bundle

Bundles consist of multiple sections, of which each can be selected from a pre-selected list of variants. It can have pre-defined price, or calculate the bundle price based on the selected variants' prices. In the more complex, flexible bundles, the amount of the products in each section can differ, too.

Each bundle only has one Variant by design. It also needs to be activated on a Display, just like any other Variant. Stock of each Bundle is calculated based on the contained section variants' prices.

[TBD]

#### Request

```gql
query something {
	placeholder
}
```

#### Response

```gql
query something {
	placeholder
}
```

### Assigning a measurement chart to a product

When creating or editing a Product, you can assign a measurement chart to it.

#### Request

```gql
mutation editProduct {
  updateProduct(id: 1, input: {
      measurementTable: {
          inherited: false
          measurementChart: {id: 6}
      }
  }) {
    product { 
      id
      name
      status
      productNumber
      brand { name }
      collection { name }
      folder { name }
      measurementTable{ chart { name } }
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
    "updateProduct": {
      "product": {
        "id": 1,
        "name": "First Product",
        "status": "ACTIVE",
        "productNumber": "Prod123",
        "brand": {
          "name": "My Brand"
        },
        "collection": {
          "name": "AW20"
        },
        "folder": {
          "name": "Shirts"
        },
        "measurementTable": {
          "chart": {
            "name": "Shirts"
          }
        }
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "Product:write",
      "Product:read",
      "Product.Brand:read",
      "Product.Collection:read",
      "Product.Folder:read",
      "Product.MeasurementTable:read"
    ]
  }
}
```

### Un-assigning a measurement chart from a product

To do this, simply pass `null` as the chart ID.

#### Request

```gql
mutation editProduct {
  updateProduct(id: 1, input: {
      measurementTable: {
          inherited: false
          measurementChart: {id: null}
      }
  }) {
    product { 
      id
      name
      status
      productNumber
      brand { name }
      collection { name }
      folder { name }
      measurementTable{ chart { name } }
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
    "updateProduct": {
      "product": {
        "id": 1,
        "name": "First Product",
        "status": "ACTIVE",
        "productNumber": "Prod123",
        "brand": {
          "name": "My Brand"
        },
        "collection": {
          "name": "AW20"
        },
        "folder": {
          "name": "Shirts"
        },
        "measurementTable": null
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "Product:write",
      "Product:read",
      "Product.Brand:read",
      "Product.Collection:read",
      "Product.Folder:read",
      "Product.MeasurementTable:read"
    ]
  }
}
```

## Pricelists - read and create

When Products are added, you need to add them to Pricelists and set a price if you want them to be purchasable. Setting a price is one of the actions that also works on the inactive Products, allowing you to set up the Products before activating them for sale.

### Fetching existing Pricelists

Once you've filtered which Pricelists you are interested in, you can fetch any data you need about each of the Pricelist returned. To see other ways of filtering Pricelists, see [PricelistFilter definition](https://docs.centra.com/graphql/pricelistfilter.html) in our documentation.

#### Request

```gql
query getPricelists {
  pricelists(where: { name: { contains: "SEK" } }, sort: [id_ASC]) {
    ...pricelistCustomDetails
  }
}

fragment pricelistCustomDetails on Pricelist {
  id
  name
  status
}
```

#### Response

```gql
{
  "data": {
    "pricelists": [
      {
        "id": 1,
        "name": "SEK",
        "status": "ACTIVE"
      },
      {
        "id": 3,
        "name": "VIP-SEK",
        "status": "ACTIVE"
      }
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Pricelist:read"
    ]
  }
}
```

### Creating a new Pricelist

[TBD]

## Fetching Products

Now that Products, Variants and Sizes are created, let's see how the full product looks like. Fetching a product list is best done with pagination and using a reasonable limit - probably between 20 and 100 products per page.

```gql
query productList(
  $status: [ProductStatus!]! = [INACTIVE, ACTIVE]
  $page: Int! = 1
) {
  products(
    where: { status: $status }
    sort: [updatedAt_DESC]
    limit: 10
    page: $page
  ) {
    ...basicProductFields
    variants{
      ...basicVariantFields
      productSizes{
        ...basicSizeFields
      }
    }
  }

  counters {
    products(where: { status: $status })
  }
}

fragment basicProductFields on Product {
  id
  name
  status
  productNumber
  harmonizedCommodityCode
  harmonizedCommodityCodeDescription
  internalComment
  isBundle
  isSerializableProduct
  harmonizedCommodityCode
  harmonizedCommodityCodeDescription
  createdAt
  updatedAt
}

fragment basicVariantFields on ProductVariant {
  id
  name
  status
  variantNumber
  internalName
  unitCost {
    value
    currency {
      code
    }
    formattedValue
  }
  updatedAt(format: "Y-m-d\\TH:i:sO")
}

fragment basicSizeFields on ProductSize {
  id
  description
  sizeNumber
  GTIN
}
```

#### Response

In GraphQL API, SKU field is read-only, it's combined of `productNumber` + `variantNumber` + `sizeNumber`.

```json
{
  "data": {
    "products": [
      {
        "id": 1,
        "name": "First Product",
        "status": "ACTIVE",
        "productNumber": "Prod123",
        "harmonizedCommodityCode": "HCC123",
        "harmonizedCommodityCodeDescription": "Harm Code Description",
        "internalComment": null,
        "isBundle": false,
        "isSerializableProduct": false,
        "createdAt": "2021-12-31T13:44:23+0100",
        "updatedAt": "2022-01-03T11:43:56+0100",
        "variants": [
          {
            "id": 1,
            "name": "First Product",
            "status": "ACTIVE",
            "variantNumber": "Var123",
            "internalName": "vrnt",
            "unitCost": {
              "value": 41,
              "currency": {
                "code": "EUR"
              },
              "formattedValue": "41.00 EUR"
            },
            "updatedAt": "2022-01-03T11:44:02+0100",
            "productSizes": [
              {
                "id": 279,
                "description": "One Size",
                "sizeNumber": "789S",
                "GTIN": "EAN123456789S",
                "SKU": "Prod123Var123789S"
              }
            ]
          },
          {
            "id": 2,
            "name": "First Product",
            "status": "ACTIVE",
            "variantNumber": "Var456",
            "internalName": "vrnt2",
            "unitCost": {
              "value": 60,
              "currency": {
                "code": "EUR"
              },
              "formattedValue": "60.00 EUR"
            },
            "updatedAt": "2022-01-03T11:44:06+0100",
            "productSizes": [
              {
                "id": 280,
                "description": "S",
                "sizeNumber": "789S",
                "GTIN": "EAN123456789S",
                "SKU": "Prod123Var456789S"
              },
              {
                "id": 281,
                "description": "M",
                "sizeNumber": "789M",
                "GTIN": "EAN123456789M",
                "SKU": "Prod123Var456789M"
              },
              {
                "id": 282,
                "description": "L",
                "sizeNumber": "789L",
                "GTIN": "EAN123456789L",
                "SKU": "Prod123Var456789L"
              }
            ]
          }
        ]
      }
    ],
    "counters": {
      "products": 1
    }
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Product:read",
      "Product.InternalComment:read",
      "Product.ProductVariant:read",
      "ProductVariant.InternalName:read"
    ]
  }
}
```

## Product Stock update

https://docs.centra.com/graphql/stock.html

Once Products with Variants are Sizes are activated with Displays, and the Warehouses exist, you can start adding stock amounts of your products in each warehouse. Once those are connected into groups in Warehouses -> Allocation Rules, they will be automatically returned as Stock for customers connecting from specific Markets, closing the part of the configuration required to have your Products available in your Store.

Remember, by default Centra expects you to send your physical stock - the amount you have physically on the shelf of your warehouse. We will calculate the availability based on the existing un-fulfilled orders or incoming Supplier Orders, and serve back the FTA - Free to Allocate - stock amount. This is the amount you can sell right now.

#### Request

Use the previously known Variant, Size and Warehouse ID. You need to iterate through all the sizes.

One size:

```gql
mutation addStockOneSize {
  changeStock (
    input: {
      intoWarehouse: {id: 3}
      description: "New stock"
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

SML sizes (repeat for each size):

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

After you're done, you can verify the stock levels in Centra AMS:

![StockLevels](product-stock-ready.png)

### Fetching Product Stock

You can also read the Stock levels using the API. Remember, "physical" quantity is the amount you have physically on the shelf in your Warehouse, available stock (FTA - Free to Allocate) is calculated by Centra based on existing orders.

#### Request

Stock is stored on the Size level, so you can access it using a `products` call similar to previous examples. Note the `stockTotals` section, which requires additional permissions.

```gql
query productList(
  $status: [ProductStatus!]! = [INACTIVE, ACTIVE]
  $page: Int! = 1
) {
  products(
    where: { status: $status }
    sort: [updatedAt_DESC]
    limit: 10
    page: $page
  ) {
    ...basicProductFields
    variants {
      ...basicVariantFields
      productSizes {
        ...basicSizeFields
        stockTotals{
          availableQuantity
          physicalQuantity
        }
      }
    }
  }
  
  counters {
    products(where: { status: $status })
  }
}
fragment basicProductFields on Product {
  id
  name
  status
  productNumber
  harmonizedCommodityCode
  harmonizedCommodityCodeDescription
  internalComment
  isBundle
  isSerializableProduct
  harmonizedCommodityCode
  harmonizedCommodityCodeDescription
  createdAt
  updatedAt
}
fragment basicVariantFields on ProductVariant {
  id
  name
  status
  variantNumber
  internalName
  unitCost {
    value
    currency {
      code
    }
    formattedValue
  }
  updatedAt(format: "Y-m-d\\TH:i:sO")
}
fragment basicSizeFields on ProductSize {
  id
  description
  sizeNumber
  GTIN
  SKU
}
```

#### Response

```json
{
  "data": {
    "products": [
      {
        "id": 1,
        "name": "First Product",
        "status": "ACTIVE",
        "productNumber": "Prod123",
        "harmonizedCommodityCode": "HCC123",
        "harmonizedCommodityCodeDescription": "Harm Code Description",
        "internalComment": null,
        "isBundle": false,
        "isSerializableProduct": false,
        "createdAt": "2021-12-31T13:44:23+0100",
        "updatedAt": "2022-01-04T11:54:21+0100",
        "variants": [
          {
            "id": 1,
            "name": "Chair",
            "status": "ACTIVE",
            "variantNumber": "Var123",
            "internalName": "vrnt",
            "unitCost": {
              "value": 41,
              "currency": {
                "code": "EUR"
              },
              "formattedValue": "41.00 EUR"
            },
            "updatedAt": "2022-01-03T12:35:25+0100",
            "productSizes": [
              {
                "id": 279,
                "description": null,
                "sizeNumber": "789S",
                "GTIN": "EAN123456789S",
                "SKU": "Prod123Var123789S",
                "stockTotals": {
                  "availableQuantity": 10,
                  "physicalQuantity": 10
                }
              }
            ]
          },
          {
            "id": 2,
            "name": "Shirt",
            "status": "ACTIVE",
            "variantNumber": "Var456",
            "internalName": "vrnt2",
            "unitCost": {
              "value": 60,
              "currency": {
                "code": "EUR"
              },
              "formattedValue": "60.00 EUR"
            },
            "updatedAt": "2022-01-03T12:35:33+0100",
            "productSizes": [
              {
                "id": 280,
                "description": "S",
                "sizeNumber": "789S",
                "GTIN": "EAN123456789S",
                "SKU": "Prod123Var456789S",
                "stockTotals": {
                  "availableQuantity": 4,
                  "physicalQuantity": 4
                }
              },
              {
                "id": 281,
                "description": "M",
                "sizeNumber": "789M",
                "GTIN": "EAN123456789M",
                "SKU": "Prod123Var456789M",
                "stockTotals": {
                  "availableQuantity": 8,
                  "physicalQuantity": 8
                }
              },
              {
                "id": 282,
                "description": "L",
                "sizeNumber": "789L",
                "GTIN": "EAN123456789L",
                "SKU": "Prod123Var456789L",
                "stockTotals": {
                  "availableQuantity": 20,
                  "physicalQuantity": 20
                }
              }
            ]
          }
        ]
      }
    ],
    "counters": {
      "products": 1
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "Product:read",
      "Product.InternalComment:read",
      "Product.ProductVariant:read",
      "ProductVariant.InternalName:read",
      "ProductSize.Stock:read"
    ]
  }
}
```

## Custom Attributes - read and write

[Custom Attributes](/overview/custom-attributes) are used to extend Product / Variant information in Centra. They can be defined in the `config.php` file and later used in Centra AMS and the APIs. Click here to see some [examples](/overview/custom-attributes#examples).

### Fetching Products and Variants with custom attributes

In this guide, we will only cover Product- and Variant-level attributes. For this example, I will use almost identical API call as in [fetching products](#fetching-products), but this time we will add fragment `attributes`, which can be used to read details of attributes of different types. Great thing about this fragment is that it can be used exactly the same way on both Product and Variant level (Centra doesn't have custom size-level attributes).

#### Request

```gql
query productList(
  $status: [ProductStatus!]! = [ACTIVE]
  $page: Int! = 1
) {
  products(
    where: { status: $status }
    sort: [updatedAt_DESC]
    limit: 10
    page: $page
  ) {
    ...basicProductFields
    ...attributes
    variants {
      ...basicVariantFields
      ...attributes
      productSizes {
        ...basicSizeFields
      }
    }
  }

  counters {
    products(where: { status: $status })
  }
}

fragment basicProductFields on Product {
  id
  name
  status
  productNumber
  harmonizedCommodityCode
  harmonizedCommodityCodeDescription
  internalComment
  isBundle
  isSerializableProduct
  harmonizedCommodityCode
  harmonizedCommodityCodeDescription
  createdAt
  updatedAt
}

fragment basicVariantFields on ProductVariant {
  id
  name
  status
  variantNumber
  internalName
  unitCost {
    value
    currency {
      code
    }
    formattedValue
  }
  updatedAt(format: "Y-m-d\\TH:i:sO")
}
fragment basicSizeFields on ProductSize {
  id
  description
  sizeNumber
  GTIN
  SKU
}

fragment attributes on ObjectWithAttributes {
  attributes {
    type {
      name
      isMapped
    }
    description
    objectType
    elements {
      key
      description
      kind
      ... on AttributeStringElement {
        value
      }
      ... on AttributeChoiceElement {
        isMulti
        selectedValue
        selectedValueName
      }
      ... on AttributeFileElement {
        url
      }
      ... on AttributeImageElement {
        url
        width
        height
        mimeType
      }
    }
  }
}
```

#### Response

Please note attributes `Long External Product Name` on the Product level and `Showroom Color Swatch` on the Variant level. Also, additional permissions are required to run this query.

```json
{
  "data": {
    "products": [
      {
        "id": 1,
        "name": "First Product",
        "status": "ACTIVE",
        "productNumber": "Prod123",
        "harmonizedCommodityCode": "HCC123",
        "harmonizedCommodityCodeDescription": "Harm Code Description",
        "internalComment": null,
        "isBundle": false,
        "isSerializableProduct": false,
        "createdAt": "2021-12-31T13:44:23+0100",
        "updatedAt": "2022-01-03T13:03:17+0100",
        "attributes": [
          {
            "type": {
              "name": "pr_long_name",
              "isMapped": false
            },
            "description": "Long External Product Name",
            "objectType": "Product",
            "elements": [
              {
                "key": "text",
                "description": "Long External Product Name",
                "kind": "INPUT",
                "value": "Test 123"
              }
            ]
          }
        ],
        "variants": [
          {
            "id": 1,
            "name": "Chair",
            "status": "ACTIVE",
            "variantNumber": "Var123",
            "internalName": "vrnt",
            "unitCost": {
              "value": 41,
              "currency": {
                "code": "EUR"
              },
              "formattedValue": "41.00 EUR"
            },
            "updatedAt": "2022-01-03T12:35:25+0100",
            "attributes": [
              {
                "type": {
                  "name": "sh_swatch",
                  "isMapped": true
                },
                "description": "Showroom Color Swatch",
                "objectType": "ProductVariant",
                "elements": [
                  {
                    "key": "desc",
                    "description": "Color",
                    "kind": "INPUT",
                    "value": "Blue"
                  },
                  {
                    "key": "hex",
                    "description": "Hex",
                    "kind": "INPUT",
                    "value": "#0000FF"
                  },
                  {
                    "key": "image",
                    "description": "Image",
                    "kind": "IMAGE",
                    "url": "https://sandbox.centraqa.com/client/dynamic/attributes/centra-logo_2064_png.jpg",
                    "width": 50,
                    "height": 50,
                    "mimeType": "image/jpg"
                  }
                ]
              }
            ],
            "productSizes": [
              {
                "id": 279,
                "description": null,
                "sizeNumber": "789S",
                "GTIN": "EAN123456789S",
                "SKU": "Prod123Var123789S"
              }
            ]
          },
          {
            "id": 2,
            "name": "Shirt",
            "status": "ACTIVE",
            "variantNumber": "Var456",
            "internalName": "vrnt2",
            "unitCost": {
              "value": 60,
              "currency": {
                "code": "EUR"
              },
              "formattedValue": "60.00 EUR"
            },
            "updatedAt": "2022-01-03T12:35:33+0100",
            "attributes": [],
            "productSizes": [
              {
                "id": 280,
                "description": "S",
                "sizeNumber": "789S",
                "GTIN": "EAN123456789S",
                "SKU": "Prod123Var456789S"
              },
              {
                "id": 281,
                "description": "M",
                "sizeNumber": "789M",
                "GTIN": "EAN123456789M",
                "SKU": "Prod123Var456789M"
              },
              {
                "id": 282,
                "description": "L",
                "sizeNumber": "789L",
                "GTIN": "EAN123456789L",
                "SKU": "Prod123Var456789L"
              }
            ]
          }
        ]
      }
    ],
    "counters": {
      "products": 1
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "Product:read",
      "Product.InternalComment:read",
      "Product.Attribute:read",
      "Product.ProductVariant:read",
      "ProductVariant.InternalName:read",
      "ProductVariant.Attribute:read",
      "Attribute:read"
    ]
  }
}
```

### Modifying custom attributes

Here's how you can modify the `Long External Product Name` attribute on our test Product.

#### Request

Fragment `attributes` is identical to previous examples.

```gql
mutation editProductAttribute {
  assignAttributes(input: {
    objectType: Product
    objectId: 1
    dynamicAttributes: [
      {
        attributeTypeName: "pr_long_name"
        attributeElementKey: "text"
        attributeElementValue: "A very long name, indeed!"
      }
    ]
  }) {
    userErrors {
      message
      path
    }
    object {
      ...on Product {
        id
        name
        createdAt
        updatedAt
      }
      ...attributes
    }
  }
}

fragment attributes on ObjectWithAttributes {
  attributes {
    type {
      name
      isMapped
    }
    description
    objectType
    elements {
      key
      description
      kind
      ... on AttributeStringElement {
        value
      }
      ... on AttributeChoiceElement {
        isMulti
        selectedValue
        selectedValueName
      }
      ... on AttributeFileElement {
        url
      }
      ... on AttributeImageElement {
        url
        width
        height
        mimeType
      }
    }
  }
}
```

#### Response

```json
{
  "data": {
    "assignAttributes": {
      "userErrors": [],
      "object": {
        "id": 1,
        "name": "First Product",
        "createdAt": "2021-12-31T13:44:23+0100",
        "updatedAt": "2022-01-03T13:03:17+0100",
        "attributes": [
          {
            "type": {
              "name": "pr_long_name",
              "isMapped": false
            },
            "description": "Long External Product Name",
            "objectType": "Product",
            "elements": [
              {
                "key": "text",
                "description": "Long External Product Name",
                "kind": "INPUT",
                "value": "A very long name, indeed!"
              }
            ]
          }
        ]
      }
    }
  },
  "extensions": {
    "complexity": 112,
    "permissionsUsed": [
      "Attribute:write",
      "Product.Attribute:read",
      "Attribute:read"
    ]
  }
}
```

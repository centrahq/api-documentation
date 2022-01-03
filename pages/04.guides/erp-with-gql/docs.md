---
title: Integrating Centra with an ERP system using GraphQL Integration API
altTitle: ERP integration with GQL
excerpt: Centra can be configured to integrate with your Enterprise Resource Planning system using GraphQL API. Click here to see how to perform most common operations on Products, Markets, Warehouses, Stock, Orders, Shipments and Returns in both B2B and B2C sales.
taxonomy:
  category: docs
---

In Centra, we strongly believe GraphQL is the future of the APIs, just like REST is the present and SOAP is the past. For that reason, we've been putting a lot of effort into building our GQL API into what we think will be the _last_ integration API you will ever need.

## GraphQL API introduction

All queries, mutations and examples are documented in [GraphQL Integration API reference](/api-references/graphql-integration-api).

GraphQL is used to Send a query to Centra API and get exactly what you need, nothing more and nothing less. GraphQL queries always return predictable results. Apps using GraphQL are fast and stable because they control the data they get, not the server.

## Quick note about API tokens

GraphQL is different from other Centra APIs, especially when it comes to authentication. Whereas both SOAP and REST APIs used shared API secret password to authenticate, identical for every API consumer, GQL authentication is based on personal API tokens. Each Production token should be assigned to a specific user name or an API function, and have only enough permissions to run the designed function. In QA, you are welcome to create test tokens will all permissions, but that is _only_ allowed for development purposes. Every time you make a GQL API call, the API response will include a full list of permissions that were used by this call. With this information, once you're done with testing, you can create a Production token with _minimal_ required permissions and re-test.

It is _not allowed_ to use a full-permissions API tokens in Production. This is simply not safe, as GraphQL gives you granular access to almost every part of Centra. It's also not allowed to share your tokens with others - every Centra admin user can create a new test token in a matter of seconds. Centra monitors the usage of those API tokens, so if you abuse those rules, we might contact you and ask that you address it.

For more information about generating and using API tokens, see the [authorization chapter of our GraphQL API docs](/api-references/graphql-integration-api/authorization).

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

As you can see, not only does GQL API return _precisely_ the data you asked for, nothing more, it also tells you which permissions were used, so that you know what your future Prod API key needs.

## Markets - read and create

https://docs.centra.com/graphql/query.html#markets

Markets in Centra decide which Products are visible to the API consumer. [Click here to learn more](https://docs.centra.com/overview/centra-overview#market).

### Fetching Markets

#### Request

Compressed:

```sh
curl "${BASE_URL}/graphql" \
	    -X POST \
	    -H "Cookie: graphql-access=${ACCESS_TOKEN}" \
	    -H "Content-Type: application/json" \
	    -d '{"query": "{ markets { id name assignedToCountries { code name isEU } } }"}'
```

Pretty:

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

Folders are a way to categorise your Products in Centra. Other than Categories, Folders are meant for internal use only. They are also generic for all the Stores you have configured in your Centra, while Categories are configured per-store.

### Creating a new folder

#### 1st folder - Request

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

A Brand is a general attribute on product level where you can store the product’s brand. Each product can only belong to a single brand.

### Creating a new brand

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
  collections(where: { name: { contains: "Col"}})
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
            "name": null
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

Still, here you go: [TBD]

### Removing size charts

If you have to. Better than adjust existing, usually.

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

## Warehouses - read and create

[Warehouses](/overview/stock#warehouses-and-allocation-rules) are the logical entities holding product Stock. Warehouse stock items connect directly to each variant size.

### Fetching existing warehouses

Once you've filtered which Warehouses you are interested in, you can fetch any data you need about each of the Warehouses returned. To see other ways of filtering Warehouses, see [WarehouseFilter definition](https://docs.centra.com/graphql/warehousefilter.html) in our documentation.

#### Request

```gql
query getWarehouses {
  warehouses(where: { name: { contains: "Retail" } }, sort: [id_ASC]) {
    ...warehouseCustomDetails
  }
}

fragment warehouseCustomDetails on Warehouse {
  id
  name
  status
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
    unitCost: { # MonetaryValueInput
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

You already know your Variant and Size IDs - Centra generated them when you created them.  For every variant size you can configure size number, SKU and/or GTIN (or EAN) number.

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

This example creates or updates a product – in this case a turtleneck sweater. The product comes in red and blue variants, and each variant is available in sizes S, M and L.

We simply mention the other size chart - and all the right sizes are created automatically.

#### Request

```gql
mutation createVariant {
  createProductVariant(input: {
    product: { id: 1 }
    name: "First Product"
    status: ACTIVE
    variantNumber: "Var456"
    internalName: "vrnt2"
    unitCost: { # MonetaryValueInput
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
                "GTIN": "EAN123456789S"
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
                "GTIN": "EAN123456789S"
              },
              {
                "id": 281,
                "description": "M",
                "sizeNumber": "789M",
                "GTIN": "EAN123456789M"
              },
              {
                "id": 282,
                "description": "L",
                "sizeNumber": "789L",
                "GTIN": "EAN123456789L"
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

Once Products with Variants are Sizes are activated with Displays, and the Warehouses exist, you can start adding stock amounts of your products in each warehouse. Once those are connected into groups in Warehouses -> Allocation Rules, they will be automatically returned as Stock for customers connecting from specific Markets, closing the part of the configuration required to have your Products available in your Store.

Remember, by default Centra expects you to send your physical stock - the amount you have physically on the shelf of your warehouse. We will calculate the availability based on the existing un-fulfilled orders or Supplier Orders, and serve back the FTA - Free to Allocate - stock amount in most places. This is the amount you can sell right now.

#### Request

Use the Variant

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

## Custom Attributes - read and write

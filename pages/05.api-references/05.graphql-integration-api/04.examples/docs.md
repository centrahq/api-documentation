---
title: Examples
excerpt: 
taxonomy:
category: docs
---


### All markets with countries for store ID 1
```gql
{
  markets(where: {storeId: 1}, sort: [id_DESC]) {
    id
    name
    assignedToCountries {
      name
      code
    }
  }
}
```

### All pricelists for store ID 1

```gql
{
  pricelists(where: {storeId: 1}) {
    id
    name
    currency {code}
    assignedToCountries {
      name
      code
    }
  }
}
```

### The whole folder structure

```gql
{
  folders(where: {isTopFolder: true}) {
    id
    name
    childFolders {
      id
      name
      childFolders {
        id
        name
      }
    }
  }
}
```

### The whole catregory structure

Use this query to fetch the Category tree in Centra. We support up to 3 levels of nested categories.

```gql
{
  categories(where: {isTopCategory: true}) {
    id
    name
    uri
    childCategories {
      id
      name
      uri
      childCategories {
        id
        name
        uri
      }
    }
  }
}
```

### List of countries

```gql
{
  countries {
    name
    continent
    isEU
    states {
      name
    }
  }
}
```

### Latest confirmed wholesale orders with account and buyer data
This one uses [Relay connection](https://relay.dev/graphql/connections.htm) format, so you can see `totalCount` and whether there is a previous page (because it's backward pagination):

```gql
{
  orderConnection(last: 10, where: {storeType: WHOLESALE, status: CONFIRMED}, sort: orderDate_ASC) {
    totalCount
    pageInfo {
      hasPreviousPage
      startCursor
    }
    edges {
      node {
        id
        number
        grandTotal { 
          value
          currency { code }
          formattedValue
        }
        orderDate (format: "Y-m-d")
        
        ...on WholesaleOrder {
          account { name }
          buyer { email }
        }
      }
    }
  }
}
```

### One other way to fetch orders
This time for specific dates in D2C:

```gql
{
  orders(where: {createdAt: {from: "2021-10-23 00:00:00", to: "2021-10-23 23:59:59", storeType: DIRECT_TO_CONSUMER}}) {
    number
    lines {
      quantity
      productName
      productVariantName
      productSize {
        id
        description
      }
      product {
        id
        name
      }
      productVariant {
        id
        name
      }
    }
  }
}
```

### Fetching a list of Displays with basic data

Use this query to fetch a list of Displays, filtering by Market.

```gql
{
  displays(where: {marketId: 5}) {
    product {name}
    productVariants {name}
    id
    name
    description
    status
    prices {
      pricelist {
        id
        name
      }
      price {
        value
        currency {code}
      }
    }
  }
}
```

### Fetching Displays with extended data

Use this query to fetch a Display, filtering by id.

```gql
{
  displays(where: {id: 1}) {
    product {name}
    productVariants {name}
    id
    name
    status
    description
    shortDescription
    metaDescription
    metaKeywords
    updatedAt
    prices {
      pricelist{
        id
        name
      }
      price {
        value
        currency{code}
      }
    }
    canonicalCategory {
      name
      metaDescription
    }
    categories {
      name
      metaDescription
    }
    media {
      source(sizeName: "standard") {
        type
        url
      }
    }
  }
}
```

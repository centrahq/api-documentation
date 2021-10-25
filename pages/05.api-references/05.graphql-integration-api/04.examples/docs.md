---
title: Examples
excerpt: 
taxonomy:
category: docs
---


### All markets with countries for store ID 1
```json
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

### The whole folder structure
```json
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

### Latest confirmed wholesale orders with account and buyer data
This one uses [Relay connection](https://relay.dev/graphql/connections.htm) format, so you can see `totalCount` and whether there is a previous page (because it's backward pagination):

```json
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

```json
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

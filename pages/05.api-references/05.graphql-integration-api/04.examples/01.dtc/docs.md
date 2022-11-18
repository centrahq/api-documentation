---
title: Direct to Consumer
excerpt: 
taxonomy:
category: docs
---


### Fetching ALL the data

We hope this query can be used as a basis and inspiration for your new integration, and convince you how powerful GraphQL really is. :)  
For those of you who are looking to re-write their SOAP PIM/ERP integrations, this example would be _somewhat_ similar to how much order details you are used to seeing in your `order` SOAP events. Enjoy!

```GraphQL
query orders ($page: Int) {
  orders (limit: 10, page: $page) {
    id
    number
    store {
      type
      id
    }
    status
    grandTotal {
      value
      currency {
        code
      }
    }
    currencyBaseRate
    createdAt

    ...buyerData
    ...accountData
    ...delwinData

    totals {
      shipping { ...monetary }
      handling { ...monetary }
      taxAdded { ...monetary }
      taxDeducted { ...monetary }
      taxIncluded { ...monetary }
    }
    
    shippingPriceGroup {
      shippingOption {
        name
        uri
        id
      }
    }

    ...vouchers
    ...paymentInfo
    
    lines {
      ...orderLine
    }
    
    shippingAddress {
      ...address
    }
    billingAddress {
      ...address
    }
    
    internalComment
    
    ...on WholesaleOrder {
      purchaseOrderNumber
    }
    
    market { id, name }
    pricelist { id, name }
  }

  baseCurrency: currencies(where: { isBase: true }) {
    code
  }
}

fragment monetary on MonetaryValue {
  value
}

fragment buyerData on WholesaleOrder {
  buyer {
    id
    firstName
    lastName
    email
  }
}

fragment accountData on WholesaleOrder {
  account {
    id
    name
    salesRepresentative {
      id
      email
      name
      commissionPercent
    }
    paymentTerms {
      id
      description
    }
    shippingTerms {
      id
      description
    }
    carrierInformation {
      carrierName
      serviceName
      accountIdentifier
      taxId
    }
    websiteUrl
  }
}

fragment delwinData on WholesaleOrder {
  deliveryWindows {
    id
    name
    __typename
    ... on PreorderDeliveryWindow {
      deliveryStartDate
      deliveryEndDate
    }
  }
}

fragment vouchers on Order {
  discountsApplied {
    value {
      ...monetary 
    }
    ... on AppliedDiscount {
      discount {
        name
        code
        type
      }
    }
  }
}

fragment paymentInfo on Order {
  paymentMethod {
    uri
    plugin
  }

  paymentHistory {
    id
    createdAt
    status
    entryType
    externalReference
    value {
      ...monetary 
    }
    currencyBaseRate
  }
}

fragment orderLine on OrderLine {
  id
  taxPercent
  product { id, name }
  productVariant { id, name }
  productSize { SKU, GTIN, description, preorder }
  brand { id, name }
  unitOriginalPrice { ...monetary }
  unitPrice { ...monetary }
  discountPercent
  quantity
  cancelledQuantity
  lineValue { ...monetary }
  comment
}

fragment address on Address {
  companyName
  attention
  firstName
  lastName
  address1
  address2
  city
  stateOrProvince
  zipCode
  country { name, code }
  email
  phoneNumber
  cellPhoneNumber
  faxNumber
  vatNumber
}
```

### All markets with countries for store ID 1

```GraphQL
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
  orders(where: {createdAt: {from: "2021-10-23 00:00:00", to: "2021-10-23 23:59:59"}, storeType: DIRECT_TO_CONSUMER}) {
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

---

## Post-sale order processing

### Common code fragments

Use those with any and all of the below examples!

```gql
fragment orderInfo on Order {
  id
  number
  status
  isOnHold

  lines(includeFullyCancelled: true) {
    id
    product { name }
    quantity
    taxPercent
    unitPrice {
      ...basicMonetaryFields
    }
    hasAnyDiscount
    unitOriginalPrice {
      ...basicMonetaryFields
    }
    lineValue { 
      ...basicMonetaryFields
    }
  }
  discountsApplied {
    value {
      ...basicMonetaryFields
    }
    date
  }
  shippingAddress { ...fullAddress }
  billingAddress { ...fullAddress }

  ... on DirectToConsumerOrder {
    customer {
      email
      firstName
      lastName
    }
  }
}

fragment customerId on DirectToConsumerOrder {
  customer {
    id
    email
  }
}

fragment fullAddress on Address {
  firstName
  lastName
  address1
  address2
  city
  zipCode
  stateOrProvince
  cellPhoneNumber
  phoneNumber
  faxNumber
  email
  companyName
  attention
  vatNumber

  country { id name }
  state { id name }
}

fragment basicMonetaryFields on MonetaryValue {
  value
  currency { id code }
  conversionRate
}
```

### Getting a specific order

This would likely be the first API call you make in a response to receiving an `order` type webhook with the order number. Remember, the integer order `number` is different from the hash order `id`. You can use them both to uniquely identify the order.

#### Request

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

### Putting order on hold

Before we move forward, remember that you can always put a `Hold` flag on the your order at any order status before it's completed (remember, [Hold is not a status](/overview/orderflow#order-status-explained)), so that you can have a perfectly controllable way of halting/resuming order processing at any stage through your integration. Same order can be resumed either via the API, or by manually clicking the "Resume" button in the AMS order view.

```gql
mutation updateDtcPutOnHold {
  updateDirectToConsumerOrder(
    order: {
      number: 14
    }
    input: {
      isOnHold: true
      holdStatusChangeReason: "Reason to hold, e.g. suspicious payment"
    }
  ) {
    order {
      number
      status
      isOnHold
    }
    userErrors { message path }
  }
}
```

### Updating basic order fields

If you wish to update fields like shipping/billing address (except country), purchaser info and/or `isInternal` flag, you can do so by simply providing those fields in the input. For DTC orders, it is also possible to change customer.

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

### Cancelling lines on an order

It is possible to cancel lines of an order, those that are yet to be shipped, using an update mutation. In this case DTC and wholesale flows are the same. Along with decreasing quantity of a corresponding line, it also unallocates allocated items (according to the selected strategy) and/or unlinks cancelled items from the supplier module. If given quantity is full quantity of the line, it will be cancelled fully, gaining cancelled status and disappearing from certain views. Affected lines must exist and belong to the order, quantities must not be negative or exceed unshipped quantity.

#### Request

If you wish, you can replace `stockAction: RELEASE_BACK_TO_WAREHOUSE` with `REMOVE_FROM_STOCK`.

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

### Confirming the order

This is the only time in Centra when you set the order status directly. Once triggered, order confirmation e-mail will be sent. Next status change will be to Processing when you create the first shipment, and then to Completed, once the final shipment is completed and all order lines items have been either shipped or cancelled. [Click here if you need a refresher on the standard order flow in Centra](/overview/orderflow#order-flow).

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

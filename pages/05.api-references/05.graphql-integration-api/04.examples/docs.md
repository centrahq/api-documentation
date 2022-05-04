---
title: Examples
excerpt: 
taxonomy:
category: docs
---


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

### Creating a B2B Account

[https://docs.centra.com/graphql/account.html](https://docs.centra.com/graphql/account.html)

#### Request

Adding Delivery Window level discounts is optional.

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
        "id": 5,
        "discountPercent": 14.3,
        "isDiscountVisible": true,
        "deliveryWindowDiscounts": []
      }
    }
  },
  "extensions": {
    "complexity": 132,
    "permissionsUsed": [
      "Account:write",
      "Account:read"
    ],
    "appVersion": "unknown"
  }
}
```

### Modifying a B2B Account

Can be used, among others, for changing account status or modifying discounts.

#### Request

```gql
mutation updateAccount {
    updateAccount(id: 5, input: {
        status: ACTIVE
        discounts: {
            generalDiscount: {
                discountPercent: 10.0
                isVisible: true
            }
#            addDeliveryWindowDiscounts: [
#                {deliveryWindow: {id: 1} discountPercent: 12.3}
#            ]
#            removeDeliveryWindowDiscounts: [
#                {id: 2}
#            ]
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
    "updateAccount": {
      "userErrors": [],
      "account": {
        "id": 5,
        "discountPercent": 10,
        "isDiscountVisible": true,
        "deliveryWindowDiscounts": []
      }
    }
  },
  "extensions": {
    "complexity": 132,
    "permissionsUsed": [
      "Account:write",
      "Account:read"
    ],
    "appVersion": "unknown"
  }
}
```

### Creating a B2B buyer

Buyers are created under specific B2B accounts.

#### Request

```gql
mutation createBuyer {
    createBuyer(input: {
        store: {id: 2}
        status: ACTIVE
        account: {id: 5}
        websiteUrl: "Example URL"
        receiveAutoEmails: true
        billingAddress: {
            firstName: "Jon"
            lastName: "Snow"
            address1: "Address 1"
            address2: "Address 2"
            country: {code: "US"}
            stateOrProvince: "Alaska"
            city: "Winterfell"
            zipCode: "54152"
            phoneNumber: "987654321"
            cellPhoneNumber: "246813579"
            faxNumber: "123456789"
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
                firstName
                lastName
                address1
                address2
                country {code}
                stateOrProvince
                city
                zipCode
                phoneNumber
                cellPhoneNumber
                faxNumber
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
        "id": 1257,
        "status": "ACTIVE",
        "account": {
          "id": 5,
          "name": "Test Account"
        },
        "receiveAutoEmails": true,
        "websiteUrl": "Example URL",
        "billingAddress": {
          "firstName": "Jon",
          "lastName": "Snow",
          "address1": "Address 1",
          "address2": "Address 2",
          "country": {
            "code": "US"
          },
          "stateOrProvince": "AK",
          "city": "Winterfell",
          "zipCode": "54152",
          "phoneNumber": "987654321",
          "cellPhoneNumber": "246813579",
          "faxNumber": "123456789",
          "email": "jon.snow@centra.com"
        }
      }
    }
  },
  "extensions": {
    "complexity": 115,
    "permissionsUsed": [
      "Buyer:write",
      "Purchaser:read",
      "Account:read",
      "Purchaser.billingAddress:read"
    ],
    "appVersion": "unknown"
  }
}
```

### Modifying a B2B buyer

Once created, you can modify buyer data, like address or website URL.

#### Request

```gql
mutation editBuyer {
    updateBuyer(id: 1257, input: {
        store: {id: 2}
        status: ACTIVE
        websiteUrl: "Different URL"
        billingAddress: {
            firstName: "Jon"
            lastName: "Snow"
            address1: "Address 1"
            address2: "Address 2"
            country: {code: "US"}
            stateOrProvince: "Alaska"
            city: "TheWall"
            zipCode: "54152"
            phoneNumber: "987654321"
            cellPhoneNumber: "246813579"
            faxNumber: "123456789"
            email: "jon.snow@centra.com"
        }
    }) {
        userErrors { message path }
        buyer {
            id
            status
            account { id name }
            receiveAutoEmails
            billingAddress {
                firstName
                lastName
                address1
                address2
                country {code}
                stateOrProvince
                city
                zipCode
                phoneNumber
                cellPhoneNumber
                faxNumber
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
    "updateBuyer": {
      "userErrors": [],
      "buyer": {
        "id": 1257,
        "status": "ACTIVE",
        "account": {
          "id": 5,
          "name": "Test Account"
        },
        "receiveAutoEmails": true,
        "websiteUrl": "Different URL",
        "billingAddress": {
          "firstName": "Jon",
          "lastName": "Snow",
          "address1": "Address 1",
          "address2": "Address 2",
          "country": {
            "code": "US"
          },
          "stateOrProvince": "AK",
          "city": "TheWall",
          "zipCode": "54152",
          "phoneNumber": "987654321",
          "cellPhoneNumber": "246813579",
          "faxNumber": "123456789",
          "email": "jon.snow@centra.com"
        }
      }
    }
  },
  "extensions": {
    "complexity": 115,
    "permissionsUsed": [
      "Buyer:write",
      "Purchaser:read",
      "Account:read",
      "Purchaser.billingAddress:read"
    ],
    "appVersion": "unknown"
  }
}
```

---

### Fetching ALL the data

We hope this query can be used as a basis and inspiration for your new integration, and convince you how powerful GraphQL really is. :)

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

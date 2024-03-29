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
      conversionRate
    }
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
      conversionRate
    }
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

### Un-allocating order lines

Before the order is shipped, you have the option to unallocate specific order lines with `unallocateOrder` mutation. This mutation does the opposite to `allocateOrder` – it removes allocations, meaning the connections from specific warehouse items to order lines. It can be either a full unallocation, or a selective one: specific order lines with given quantities, and/or specific warehouses only.

Same as when cancelling order lines, you must choose what to do with the stock that will not be allocated anymore. There are three options under `stockActionPolicy`, and exactly one of them must be provided: `removeItemsFromStock`, `releaseItemsBackToWarehouse`, or `sendItemsToDifferentWarehouse`, where you point to a specific warehouse.

#### Request

```gql
mutation unallocate {
  unallocateOrder(input: {
    order: {number: 31351}
    unallocate: [
      {orderLine: {id: 53134}, quantity: 1}
    ]
    warehouses: [{id: 1}]
    stockActionPolicy: {
      releaseItemsBackToWarehouse: true
    }
  }) {
    userErrors { message, path }
    userWarnings { message, path }
    order { ...orderData }
  }
}

fragment orderData on Order {
  id
  number
  lines {
    id
    quantity
    allocations {
      id
      quantity
      warehouse { id, name }
      stockChangeLine { id, deliveredQuantity, freeToAllocateQuantity }
    }
  }
}
```

### Cancelling an order

It is possible to cancel orders that haven't been completed by using an cancel mutation. In this case DTC and wholesale flows are the same. Canceling the order will result in the order having a status `cancelled` set. 
It's important to note that there's a difference between cancelling an entire order vs cancelling specific lines on the order. When you cancel the entire order, order line's quantity remain unchanged and you can still see original order's quantities.

It is also possible to cancel authorization on PSP side, to do this the `cancelAuthorization` param has to be set to: true.
For now, cancelling authorization is supported by following PSP integrations:
* Adyen Drop-In
* Klarna Checkout V3
* Klarna Payments
* Qliro One
* Paypal Commerce

[notice-box=readMore]
You can only cancel authorization for orders that have not been captured or have not been fully refunded.
[/notice-box]

If you specify `cancelAuthorization:true` to request a cancellation with the PSP and the request to the PSP fails, the order cancellation in Centra will still proceed. In such a scenario, a warning will be returned to the user, and a corresponding entry will be made in the payment history.

[notice-box=readMore]
In the case of asynchronous cancellation API (like Adyen Drop-in) cancel request will be followed by cancel webhook.
In this case there would be 2 entries in the payment history: one of `entryType` `CANCEL_REQUEST` and final one for `CANCEL` after async webhook from PSP
[/notice-box]

#### Request

```gql
mutation cancelDTCOrder {
  cancelDirectToConsumerOrder(
    id: "c80521760fe108d56513234f97da4f4a"
    input: {
      comment: "new comment"
      emailOptions: { sendEmail: false }
      stockAction: { removeItemsFromStock: true }
      cancelAuthorization: true
    }
  ) {
    userErrors {
      message
      path
    }
    order {
      id
      status
    }
  }
}
```

#### Response

```json
{
  "data": {
    "cancelDTCOrder": {
      "order": {
        "id": "1497ccf644db871e1e4026d101bde6f3",
        "status": "CANCELLED",
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

### Releasing remaining order authorization

Allows for releasing order authorization in cases when only part of the order is shipped and captured, such as when some items are out of stock.
If you don't plan to perform more captures on the order, you can release the remaining authorization. 

**Validation**

Mutation is only allowed for orders that:
- Are in the following statuses:
  - `PENDING` 
  - `CONFIRMED` 
  - `PROCESSING`

- Have been partially captured 


**Process**

Mutation calculates `remaining authorization amount` which is the difference between authorization amount and amount that has been already captured. 
The remaining authorization amount is sent to PSP to release authorization. If the PSP request fails, the mutation will also fail, leaving the order unchanged.

[notice-box=readMore]
Although it's not mandatory to cancel unshipped lines, it's advised to do so. This ensures that the state of the order in Centra accurately mirrors reality.
[/notice-box]

It is possible to release order authorization with following PSP integrations:

- Adyen Drop-In
- Klarna Checkout V3
- Klarna Payments

[notice-box=readMore]
In the case of asynchronous cancellation API (like Adyen Drop-in) cancel request will be followed by cancel webhook. 
In this case there would be 2 entries in the payment history: one of `entryType` `CANCEL_REQUEST` and final one for `CANCEL` after async webhook from PSP
[/notice-box]

Example flow:

1. Order with 2 order lines is placed and authorized for 1000 SEK
2. One of the order lines is shipped and captured for 500 SEK
3. Second order line cannot be shipped due to being out of stock
4. [Optional] Second order line is cancelled
5. `releaseRemainingOrderAuthorization` mutation is called with order id (remaining order authorization at this point is: 1000 - 500 = 500SEK)
6. Remaining order authorization is released with PSP (500 SEK)

#### Request

```gql
mutation {
  releaseRemainingOrderAuthorization(order: {id: "2a01ef16e1dd02d78bcff6391dc3cd22"}) {
    order {
      id
    }
    paymentHistoryEntry {
      status
      value {
        value
        currency {
          code
        }
      }
      paramsJSON
    }
    userErrors {
      message
      path
    }
    userWarnings {
      message
      path
    }
  }
}
```

#### Response

```gql
{
  "data": {
    "releaseRemainingOrderAuthorization": {
      "order": {
        "id": "c99c50d60f205eec6affab53480b079f"
      },
      "paymentHistoryEntry": {
        "status": "SUCCESS",
        "value": {
          "value": -5,
          "currency": {
            "code": "SEK"
          }
        },
        "paramsJSON": "{\"success\":true,\"isRequest\":false,\"raw\":null}"
      },
      "userErrors": [],
      "userWarnings": []
    }
  },
  "extensions": {
    "complexity": 226,
    "permissionsUsed": [
      "Payment.cancel:write",
      "Order:read",
      "PaymentHistory:read"
    ],
    "appVersion": "v1.1.1",
    "memory": "60.0 MB"
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

## Un-allocating order stock

The `unallocateOrder` mutation does the opposite to `allocateOrder` – it removes allocations, meaning the connections from specific warehouse items to order lines. It can be either a full unallocation, or a selective one: specific order lines with given quantities, and/or specific warehouses only.

Of course, once an item has been shipped, it’s impossible to unallocate it. Only quantities remaining to be shipped are eligible for unallocation. Requesting to unallocate more results in a warning (look at the `userWarnings` field in the response).

Centra must know what to do with the stock that will not be allocated anymore. There are three options under `stockActionPolicy`, and exactly one of them must be provided: `removeItemsFromStock`, `releaseItemsBackToWarehouse`, or `sendItemsToDifferentWarehouse`, where you point to a specific warehouse.

```gql
mutation unallocate {
  unallocateOrder(input: {
    order: {number: 31351}
    unallocate: [
      {orderLine: {id: 53134}, quantity: 1}
    ]
    warehouses: [{id: 1}]
    stockActionPolicy: {
      releaseItemsBackToWarehouse: true
    }
  }) {
    userErrors { message, path }
    userWarnings { message, path }
    order { ...orderData }
  }
}

fragment orderData on Order {
  id
  number
  lines {
    id
    quantity
    allocations {
      id
      quantity
      warehouse { id, name }
      stockChangeLine { id, deliveredQuantity, freeToAllocateQuantity }
    }
  }
}
```

### Shipping Cost Update

Allows for updating the shipping cost of DTC (Direct To Consumer) orders.

**Validation**

Mutation is only allowed for orders that:

- Are of type DTC
- Are in the `CONFIRMED` status

**Cost Constraint**

- The new shipping cost must be a positive number.
- The proposed shipping price should be equal to or less than the current value, or 0.

**History Logging**

Upon successful update, the system logs an entry in the order's history detailing the change, such as:
"Shipping cost changed from {previous value} {order currency} to {new value} {order currency}"

#### Request

```gql
mutation updateDirectToConsumerOrder {
  updateDirectToConsumerOrder(
    order: {
      id: "f8b90249400edc71f30ce1caa6f0b911"
      # number: "12345"  # You can use either order number or ID to identify the order
    },
    input: {
      shippingCost: {
        value: 30.0,
        currencyIsoCode: "SEK"
      }
    }
  ) {
    order {
      id
      number
      totals {
        quantity
        shipping {
          value
          currency {
            code
          }
        }
      }
    }
    userErrors { message path }
  }
}
```

#### Response

```gql
{
  "data": {
    "updateDirectToConsumerOrder": {
      "order": {
        "number": "12345",
        "totals": {
          "quantity": 2,
          "shipping": {
            "value": 30.0,
            "currency": {
              "code": "SEK"
            }
          }
        }
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 150,
    "permissionsUsed": [
      "Order:write",
      "Order:read"
    ],
    "appVersion": "v0.32.3"
  }
}
```

### General notes on payment captures in GQL

Some providers (Adyen and Klarna) use capture requests. It means when any of these mutations capture money, the actual capturing doesn’t happen at that moment. The provider will process the request on its side and then send a webhook to Centra. This process can take time, even up to a few days. There is a chance the provider will reject the capture request and it will result in failed capture on the Centra side.

#### Description of the `PaymentHistoryEntry` type

Most important fields of [PaymentHistoryEntry](https://docs.centra.com/graphql/paymenthistoryentry.html) to look at:  
* `status` - will be:
** `FAILED` for unsuccessful capture or capture request,  
** `PENDING` for successful capture request (Adyen and Klarna),  
** `SUCCESS` for successful capture (the other providers).  
* entryType - it will be  
** `CAPTURE_REQUEST` for capture request (Adyen and Klarna),  
** `CAPTURE` for capture (the others),  
** other types, if the entry is not about capturing.  
* `externalReference` - an identifier of a transaction from the provider side. In many cases, this identifier will be equal to an identifier of an auth entry.  
* `paymentMethod` - by default, it’s a Centra plugin name, but some providers can override this value.  
* `paramsJSON` - contains a raw response from the provider. In particular, all transaction and error details are stored there.

[notice-box=readMore]
If capturing an order or shipment failed, check what information you can find in `paymentHistoryEntry.paramsJSON` - in many cases, the providers tell what was wrong (for example, incorrect currency code or expired authorization). The same information can be found in AMS in the order payment history section.
[/notice-box]

The following payment providers are supported in the GraphQL Integration API:  
* Adyen Drop-In (capture requests)  
* Klarna Checkout V3 (capture requests)  
* Klarna Payments (capture requests)
* Qliro One  
* PayPal Commerce  
* Stripe Checkout  
* Stripe Payments Intents  
* Stripe Wholesale Invoices

All are configurable as plugins in the AMS backend.

### Capturing an entire order amount

If your integration needs to, you have the option to capture the entire order amount upon order creation. This will be required if you sell gift cards, for example. However, the standard flow in Centra is that you create shipment or shipments first, and then capture them once they are being shipped. 

[notice-box=alert]
Remember, that in some countries, especially for DtC orders, you may be legally forbidden from actually capturing the money before you ship the items. Be really cautios about the moment you perform payment captures, and if required - split the code between integrations capturing order totals vs integrations capturing individual shipments.
[/notice-box]

#### Request

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

When the order has an already captured amount not assigned to any shipment, all these mutations will try to assign this amount to a shipment. For example, the order was created and captured with `captureOrder`, then if a new shipment is added to the order with `capture: true`, it will automatically be completely captured. What’s important in this case is that no requests to providers will be sent, so no real capturing will happen because it was done at `captureOrder`.

[notice-box=info]
Note: If the capture fails, the mutation will fail as well. Nothing else about the order will change in this case, other than the new log in `paymentHistory`.
[/notice-box]

### Creating an unpaid shipment

In order to complete the order, all the order lines must be shipped, and each shipment must be marked as Paid. You can choose to split those order lines over multiple shipments, but in this example we will simply ship both order items in a single shipment.

#### Request

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

### Creating and capturing a shipment

Useful if you are creating completed shipments. In this case you do not specify the `paid` parameter, but instead instruct GQL API to trigger the payment capture to the external PSP.

[notice-box=alert]
Please be warned, the main point of `createShipment` mutation is to create a shipment, the ability to capture at the same time is a convenience method. Therefore, a failed capture will not prevent the shipment from being created. Your capture may fail if the authorization was not completed, if it was already captured before, or if there's a problem with the payment plugin, to give some examples.

You must ensure to always fetch `userWarnings`, where you will find out if and why your capture failed. If it did, you should re-try capture later using [captureShipment mutation](#capturing-a-shipment).
[/notice-box]

Please remember that there's a difference between shipment ID and number. The shipment "number" is the human-friendly name including order number and shipment prefix. The ID is a unique integer, and should be used to identify the shipment in the API:

```text
  "id": 345,
  "number": "39790-1",
```

#### Request

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
    userWarnings {
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

If capture fails, it won’t fail the whole mutation so the shipment can still be created, also `shipment.isCaptured` will be `false`. If capture goes successfully, `shipment.isCaptured` will be `true`. Use this flag to make sure the shipment was successfully captured.

`shipment.order.paymentHistory` contains a result of capturing, read below the description of the `PaymentHistoryEntry` type. 

`paymentHistory(where: {entryType: [CAPTURE, CAPTURE_REQUEST]})` means this element will only contain history entries related to capturing. An order can have more of them (e.g. `AUTH`) and we don't need to fetch them after capturing to see whether it went successfully or not.

Please note, there is no `capture` field for `updateShipment` mutation. Instead, use `captureShipment` on existing shipments.

### Updating a shipment - marking as Paid

Use this if your integration performs payment capture outside Centra.

#### Request

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

Note the shipment is now `"isPaid": true`.

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

### Capturing a shipment

Use it when a shipment can be created without capturing and needs to be captured later. Most commonly in DtC you would capture the shipment upon its completion in Centra - when the package is actually handled to the shipping company.

[notice-box=alert]
Remember to always check `userWarnings`, in case your capture request fails for some reason. In that case, you may want to re-try it later.
[/notice-box]

#### Request

```gql
mutation captureShipment {
  captureShipment(id: 123) {
    userErrors {
      message 
      path
    }
    userWarnings {
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

[notice-box=info]
Other than the `createShipment` mutation with `capture: true`, here a failed capturing will fail the mutation.
[/notice-box]

### Completing a shipment

Now that the shipment is paid for and good to go, we can hand it over to the shipping company and complete the shipment in Centra, while adding optional tracking info and triggering a shipping confirmation e-mail.

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

### Creating a Return

If you have a shipment that you wish to return you can do it by running the mutation below. You will have to specify the shipment, shipment lines and the stock policy which will affect how the items will be relocated. There are three possible options:

- `releaseItemsBackToWarehouse` → the items will be sent back to the warehouse they originally came from  
- `sendItemsToDifferentWarehouse` → items will be sent to a warehouse specified by the user  
- `removeItemsFromStock` → physical products will not be returned, there will be no increase in stock for any warehouse  

Additional costs, such as handling fees, shipping costs, or voucher value, can also be specified in this mutation.These values can not be greater the the remaining value of these costs on shipment.

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

### Completing a return

If you would like to complete a return using the Integration API you can do it by running `completeReturn` mutation. First you can query the returns to find the needed id.

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

In the `completeReturn` mutation you can also pass the information on whether an email with return confirmation should be sent to the customer. You can’t complete a return that already has a `completed` status.

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

### Un-completing a return

If you wish to un-do the previously described mutation you can do it by running this mutation:

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

### Deleting a return

If you wish to delete a return you can do it by running this mutation:

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

All you need to provide is the return ID. The stock will be re-allocated according to the policy that was selected when creating the return. If the return was created using the `releaseItemsBackToWarehouse` stock policy, the order and shipment lines will be re-allocated based on the allocation rule assigned to the order.

`sendItemsToDifferentWarehouse` → the order and shipment lines will be re-allocated, the stock will be re-allocated from the warehouse specified by the user when creating the return.

`removeItemsFromStock` → the shipment lines quantity will be updated to reflect the change but there will be no re-allocation. The idea is that the items were not added back to stock, the user can decide whether to re-allocate it again.

---
title: Wholesale
excerpt: 
taxonomy:
category: docs
---

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

## Creating and modifying B2B Delivery Windows

If you are unfamiliar with the subject, you can start by reading the [delwin documentation in our Support page](https://support.centra.com/centra-sections/wholesale-b2b/setup/creating-delivery-windows).

Common GQL fragments for all following queries:

```gql
# atOnce type specific fields
fragment atOnceFields on AtOnceDeliveryWindow {
  daysFromNow
  selectableDate
}

# preorder typ specific fields
fragment preorderFields on PreorderDeliveryWindow {
  allocationOrder
  deliveryStartDate
  deliveryEndDate
  salesStartDate
  salesEndDate
}

# All fields, common for both types and those from fragments above
fragment delWinFields on DeliveryWindow {
  id
  name
  status
  markets { id, name }
  campaigns { id, name }
  allocationRule { id, name }
  defaultVariantDeliveryType
  deliveryDatesVisible
  deliveryWindowVariants {
    limit { value, on, type }
    type
    product { id, name }
  }
  selectableByBuyers
  selectedByDefault

  ...atOnceFields
  ...preorderFields
}
```

### Finding your Store, Market and Allocation Rule IDs

You will need to know all those to create a delwin. This guide assumes those parts of Centra are previously set up.

#### Request - Wholesale Stores

```gql
query listB2BStores {
  stores (where: {type: WHOLESALE}){
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
        "id": 2,
        "name": "Wholesale"
      }
    ]
  },
  "extensions": {
    "complexity": 193,
    "permissionsUsed": [
      "Store:read"
    ],
    "appVersion": "v0.26.0"
  }
}
```

#### Request - store Markets

```gql
query findMarkets {
  markets (where: {storeId: 2}){
    id
    name
    store { id name }
  }
}
```

#### Response

```json
{
  "data": {
    "markets": [
      {
        "id": 2,
        "name": "A",
        "store": {
          "id": 2,
          "name": "Wholesale"
        }
      },
      {
        "id": 12,
        "name": "VIP",
        "store": {
          "id": 2,
          "name": "Wholesale"
        }
      }
    ]
  },
  "extensions": {
    "complexity": 193,
    "permissionsUsed": [
      "Market:read",
      "Store:read"
    ],
    "appVersion": "v0.26.0"
  }
}
```

#### Request - Allocation Rules

```gql
query findAllocationRules{
  allocationRules {
    id
    name
  }
}
```

#### Response

```json
{
  "data": {
    "allocationRules": [
      {
        "id": 2,
        "name": "B2B default"
      },
      {
        "id": 3,
        "name": "Another AR"
      },
      {
        "id": 28,
        "name": "Retail default"
      }
    ]
  },
  "extensions": {
    "complexity": 193,
    "permissionsUsed": [
      "AllocationRule:read"
    ],
    "appVersion": "v0.26.0"
  }
}
```

### Listing your current delwins

At any stage you can use it to verify the delwin you've created. Remember to also include the generic fragments mentioned above.

#### Request - list of delwins

```gql
query delWinList {
  deliveryWindows(limit: 10, page: 1) {
    ...delWinFields
  }
}
```

### Request - specific delwin

```gql
query delwin {
  deliveryWindows(where: { id: 1 }) {
    ...delWinFields
  }
}
```

### Creating an "AtOnce" delwin

This type of delivery window uses your current stock. To see all list of params and their possible values, see [DeliveryWindowCreateInput](https://docs.centra.com/graphql/deliverywindowcreateinput.html)

#### Request

This delwin begins immediately. To control that, change the `daysFromNow` param to how many days from now it should become active.

```gql
mutation createAtOnceDelWin {
  createDeliveryWindow(input: {
    name: "First AtOnce DelWin"
    status: ACTIVE
    deliveryDatesVisible: true
    selectableByBuyers: true
    selectedByDefault: false
    defaultVariantDeliveryType: STOCK
    allocationRule: { id: 12 }
    markets: [{ id: 2 }]
    
    # atOnce specific fields:
    atOnce: {
      daysFromNow: 0
      selectableDate: true
    }
  }) {
    userErrors {
      message
      path
    }
    deliveryWindow {
      ...delWinFields
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
        "id": 3,
        "name": "First AtOnce DelWin",
        "status": "ACTIVE",
        "markets": [
          {
            "id": 2,
            "name": "A"
          },
          {
            "id": 12,
            "name": "VIP"
          }
        ],
        "campaigns": [],
        "allocationRule": {
          "id": 2,
          "name": "Warehouse"
        },
        "defaultVariantDeliveryType": "STOCK",
        "deliveryDatesVisible": true,
        "deliveryWindowVariants": [],
        "selectableByBuyers": true,
        "selectedByDefault": false,
        "daysFromNow": null,
        "selectableDate": true
      }
    }
  },
  "extensions": {
    "complexity": 193,
    "permissionsUsed": [
      "DeliveryWindow:write",
      "DeliveryWindow:read",
      "Market:read",
      "Campaign:read",
      "AllocationRule:read"
    ],
    "appVersion": "v0.26.0"
  }
}
```

### Creating a "PreOrder" delwin

This type allows people to preorder product variants based on stock that will become available in the future.

#### Request

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
      ...delWinFields
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
        "id": 4,
        "name": "First PreOrder DelWin",
        "status": "ACTIVE",
        "markets": [
          {
            "id": 2,
            "name": "A"
          }
        ],
        "campaigns": [],
        "allocationRule": {
          "id": 2,
          "name": "B2B default"
        },
        "defaultVariantDeliveryType": "STOCK",
        "deliveryDatesVisible": true,
        "deliveryWindowVariants": [],
        "selectableByBuyers": true,
        "selectedByDefault": false,
        "allocationOrder": "FIFO",
        "deliveryStartDate": "2022-08-01T00:00:00+02:00",
        "deliveryEndDate": "2022-10-31T00:00:00+01:00",
        "salesStartDate": "2022-08-01T00:00:00+02:00",
        "salesEndDate": "2022-10-31T00:00:00+01:00"
      }
    }
  },
  "extensions": {
    "complexity": 193,
    "permissionsUsed": [
      "DeliveryWindow:write",
      "DeliveryWindow:read",
      "Market:read",
      "Campaign:read",
      "AllocationRule:read"
    ],
    "appVersion": "v0.26.0"
  }
}
```

### Modifying a delwin

#### Request - remove one of the selected markets

```gql
mutation updateDelWin {
  updateDeliveryWindow(id: 3, input: {
    name: "First AtOnce DelWin"
    status: ACTIVE
    defaultVariantDeliveryType: STOCK
    markets: [{ id: 2 }]
  }) {
    userErrors {
      message
      path
    }
    deliveryWindow {
      ...delWinFields
    }
  }
}
```

#### Response

```json
{
  "data": {
    "updateDeliveryWindow": {
      "userErrors": [],
      "deliveryWindow": {
        "id": 3,
        "name": "First AtOnce DelWin",
        "status": "ACTIVE",
        "markets": [
          {
            "id": 2,
            "name": "A"
          }
        ],
        "campaigns": [],
        "allocationRule": {
          "id": 2,
          "name": "B2B default"
        },
        "defaultVariantDeliveryType": "STOCK",
        "deliveryDatesVisible": true,
        "deliveryWindowVariants": [],
        "selectableByBuyers": true,
        "selectedByDefault": false,
        "daysFromNow": null,
        "selectableDate": true
      }
    }
  },
  "extensions": {
    "complexity": 193,
    "permissionsUsed": [
      "DeliveryWindow:write",
      "DeliveryWindow:read",
      "Market:read",
      "Campaign:read",
      "AllocationRule:read"
    ],
    "appVersion": "v0.26.0"
  }
}
```

#### Request - cancel the existing pre-order delwin

```gql
mutation cancelDelWin {
  updateDeliveryWindow(id: 4, input: {
    status: CANCELLED
  }) {
    userErrors {
      message
      path
    }
    deliveryWindow {
      ...delWinFields
    }
  }
}
```

#### Response

```json
{
  "data": {
    "updateDeliveryWindow": {
      "userErrors": [],
      "deliveryWindow": {
        "id": 4,
        "name": "First PreOrder DelWin",
        "status": "CANCELLED",
        "markets": [
          {
            "id": 2,
            "name": "A"
          }
        ],
        "campaigns": [],
        "allocationRule": {
          "id": 2,
          "name": "B2B default"
        },
        "defaultVariantDeliveryType": "STOCK",
        "deliveryDatesVisible": true,
        "deliveryWindowVariants": [],
        "selectableByBuyers": true,
        "selectedByDefault": false,
        "allocationOrder": "FIFO",
        "deliveryStartDate": "2022-08-01T00:00:00+02:00",
        "deliveryEndDate": "2022-10-31T00:00:00+01:00",
        "salesStartDate": "2022-08-01T00:00:00+02:00",
        "salesEndDate": "2022-10-31T00:00:00+01:00"
      }
    }
  },
  "extensions": {
    "complexity": 193,
    "permissionsUsed": [
      "DeliveryWindow:write",
      "DeliveryWindow:read",
      "Market:read",
      "Campaign:read",
      "AllocationRule:read"
    ],
    "appVersion": "v0.26.0"
  }
}
```

### Adding products variants to a delwin

This guide assumes you know how to find products, variants and their IDs. You can search your products if you don't.

#### Request - search products and find variant IDs

```gql
query findProduct {
  products(where: {name: {contains: "Basketball"}}){
    name
    id
    variants { id name }
  }
}
```

#### Response

```json
{
  "data": {
    "products": [
      {
        "name": "Basketball",
        "id": 342,
        "variants": [
          {
            "id": 1844,
            "name": "Outdoor hobby ball"
          },
          {
            "id": 1845,
            "name": "Official game ball"
          }
        ]
      }
    ]
  },
  "extensions": {
    "complexity": 220,
    "permissionsUsed": [
      "Product:read",
      "ProductVariant:read"
    ],
    "appVersion": "v0.26.0"
  }
}
```

#### Request - add both variants to the AtOnce delwin

```gql
mutation setVariants {
  setDeliveryWindowVariants(input: {
    deliveryWindow: { id: 3 }
    variants: [
      {
        productVariant: { id: 1844 }
        type: STOCK
        limit: { value: 100, type: HIGH, on: ProductVariant }
      },
      {
        productVariant: { id: 1845 }
        type: STOCK
        limit: { value: 100, type: HIGH, on: ProductVariant }
      }
      # Up to 100 variants can be specified in a single mutation
    ]
  }) {
    userErrors {
      message
      path
    }
    deliveryWindow {
      ...delWinFields
    }
  }
}
```

#### Response

Note how the `deliveryWindowVariants` array is not empty anymore.

```json
{
  "data": {
    "setDeliveryWindowVariants": {
      "userErrors": [],
      "deliveryWindow": {
        "id": 3,
        "name": "First AtOnce DelWin",
        "status": "ACTIVE",
        "markets": [
          {
            "id": 2,
            "name": "A"
          }
        ],
        "campaigns": [],
        "allocationRule": {
          "id": 2,
          "name": "Warehouse"
        },
        "defaultVariantDeliveryType": "STOCK",
        "deliveryDatesVisible": true,
        "deliveryWindowVariants": [
          {
            "limit": {
              "value": 100,
              "on": "ProductVariant",
              "type": "HIGH"
            },
            "type": "STOCK",
            "product": {
              "id": 342,
              "name": "Basketball"
            }
          },
          {
            "limit": {
              "value": 100,
              "on": "ProductVariant",
              "type": "HIGH"
            },
            "type": "STOCK",
            "product": {
              "id": 342,
              "name": "Basketball"
            }
          }
        ],
        "selectableByBuyers": true,
        "selectedByDefault": false,
        "daysFromNow": null,
        "selectableDate": true
      }
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
```

### Removing variants from a delwin

Simply provide the list of variant IDs you'd like to remove from a delwin. We will remove one of those.

#### Request

```gql
mutation unsetVariants {
  unsetDeliveryWindowVariants(input: {
    deliveryWindow: { id: 3 }
    productVariants: [
      { id: 1845 }
      # More variants can be specified
    ]
  }) {
    userErrors {
      message
      path
    }
    deliveryWindow {
      ...delWinFields
    }
  }
}
```

#### Response

```json
{
  "data": {
    "unsetDeliveryWindowVariants": {
      "userErrors": [],
      "deliveryWindow": {
        "id": 3,
        "name": "First AtOnce DelWin",
        "status": "ACTIVE",
        "markets": [
          {
            "id": 2,
            "name": "A"
          }
        ],
        "campaigns": [],
        "allocationRule": {
          "id": 2,
          "name": "Warehouse"
        },
        "defaultVariantDeliveryType": "STOCK",
        "deliveryDatesVisible": true,
        "deliveryWindowVariants": [
          {
            "limit": {
              "value": 100,
              "on": "ProductVariant",
              "type": "HIGH"
            },
            "type": "STOCK",
            "product": {
              "id": 342,
              "name": "Basketball"
            }
          }
        ],
        "selectableByBuyers": true,
        "selectedByDefault": false,
        "daysFromNow": null,
        "selectableDate": true
      }
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
```

## Locking and unlocking orders

Locked orders are not possible to modify in the AMS, they should only be handled via the API.

### Lock one or more orders

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

### Un-lock one or more orders

#### Request

```gql
mutation lockOrders {
  setOrdersLock(
    input: {
      orders: [{ number: 39514 }, { number: 39515 }]
      isLocked: false }
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
          "isLocked": false,
          "shippingAddress": {
            "firstName": "Pio",
            "lastName": "Sym"
          }
        },
        {
          "number": 39515,
          "status": "PROCESSING",
          "isLocked": false,
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

## Putting the orders on "Hold"

The "Hold" is a flag that can be applied to any in-completed order. An order that is on hold will display in orange in Centra AMS, and won't be returned by Centra APIs by default.

Changing the "Hold" flag doesn't change the order status. After removing "Hold", order is returned to its previous state. [Click here to learn more about order statuses](https://docs.centra.com/overview/orderflow#order-flow).

### Put one or more orders on Hold

#### Request

```gql
mutation orderOnHold {
  updateWholesaleOrder(
    order: { number: 39266 }
    input: { isOnHold: true, holdStatusChangeReason: "Message logged in order history." }
  ) {
    userErrors {
      message
      message
    }
    order {
      number
      status
      isOnHold
    }
  }
}

```

#### Response

```json
{
  "data": {
    "updateWholesaleOrder": {
      "userErrors": [],
      "order": {
        "number": 39266,
        "status": "PROCESSING",
        "isOnHold": true
      }
    }
  },
  "extensions": {
    "complexity": 12,
    "permissionsUsed": [
      "Order:write",
      "Order:read"
    ],
    "appVersion": "v0.31.0"
  }
}
```

### Remove Hold flag from order(s)

#### Request

```gql
mutation orderOnHold {
  updateWholesaleOrder(
    order: { number: 39266 }
    input: { isOnHold: false, holdStatusChangeReason: "Different message logged in order history." }
  ) {
    userErrors {
      message
      message
    }
    order {
      number
      status
      isOnHold
    }
  }
}

```

#### Response

```json
{
  "data": {
    "updateWholesaleOrder": {
      "userErrors": [],
      "order": {
        "number": 39266,
        "status": "PROCESSING",
        "isOnHold": false
      }
    }
  },
  "extensions": {
    "complexity": 12,
    "permissionsUsed": [
      "Order:write",
      "Order:read"
    ],
    "appVersion": "v0.31.0"
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
  orders(where: { number: 3957 }) {
    number
    status
    isOnHold
    shippingAddress {
      companyName
      attention
      city
    }
  }
}
```

#### Response

```json
{
  "data": {
    "orders": [
      {
        "number": 3957,
        "status": "PENDING",
        "isOnHold": false,
        "shippingAddress": {
          "companyName": "CENTRA",
          "attention": "Johan",
          "city": "City"
        }
      }
    ]
  },
  "extensions": {
    "complexity": 229,
    "permissionsUsed": [
      "Order:read",
      "Order.shippingAddress:read"
    ],
    "appVersion": "v0.32.3"
  }
}
```

### Updating basic order fields

If you wish to update fields like shipping/billing address (except country) and/or `isInternal` flag, you can do so by simply providing those fields in the input.

#### Request

```gql
mutation updateWholesaleBasicFields {
  updateWholesaleOrder(
    order: {
      # id: "c8b6e87b1d9408f845a0440d226696df"
      number: 3957
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
      buyerInfo: {
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
    "updateWholesaleOrder": {
      "order": {
        "id": "c8b6e87b1d9408f845a0440d226696df",
        "number": 3957,
        "status": "PENDING",
        "isOnHold": false,
        "lines": [
          {
            "id": 17231,
            "product": {
              "name": "90's boot leg "
            },
            "quantity": 2,
            "taxPercent": 0,
            "unitPrice": {
              "value": 1500,
              "currency": {
                "id": 3,
                "code": "SEK"
              },
              "conversionRate": 1
            },
            "hasAnyDiscount": false,
            "unitOriginalPrice": {
              "value": 1500,
              "currency": {
                "id": 3,
                "code": "SEK"
              },
              "conversionRate": 1
            },
            "lineValue": {
              "value": 3000,
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
              "value": 30,
              "currency": {
                "id": 3,
                "code": "SEK"
              },
              "conversionRate": 1
            },
            "date": "2021-03-04T09:05:52+01:00"
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
          "phoneNumber": "123456789",
          "faxNumber": null,
          "email": "jon.snow@example.com",
          "companyName": "CENTRA",
          "attention": "Johan",
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
          "phoneNumber": "123456789",
          "faxNumber": null,
          "email": "jon.snow@example.com",
          "companyName": "CENTRA",
          "attention": "Johan",
          "vatNumber": null,
          "country": {
            "id": 6,
            "name": "Sweden"
          },
          "state": null
        }
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 228,
    "permissionsUsed": [
      "Order:write",
      "Order:read",
      "Order.shippingAddress:read",
      "Order.billingAddress:read",
      "Product:read"
    ],
    "appVersion": "v0.32.3"
  }
}
```

### Adding lines to an order

It is possible to add new lines to an order via an update mutation. The logic is really simple: either a completely new line is added, or an existing one is updated (quantity increased) if given item is already present in the order. Like in other integration APIs, unit to add is defined by display and product size. Here's an example:

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

### Cancelling lines on an order

It is possible to cancel lines of an order, those that are yet to be shipped, using an update mutation. Along with decreasing quantity of a corresponding line, it also unallocates allocated items (according to the selected strategy) and/or unlinks cancelled items from the supplier module. If given quantity is full quantity of the line, it will be cancelled fully, gaining cancelled status and disappearing from certain views. Affected lines must exist and belong to the order, quantities must not be negative or exceed unshipped quantity.

#### Request

If you wish, you can replace `stockAction: RELEASE_BACK_TO_WAREHOUSE` with `REMOVE_FROM_STOCK`. Below mutation will decrease the first order line quantity by 1.

```gql
mutation updateWholesaleCancel {
  updateWholesaleOrder(
    order: {
      # id: "c8b6e87b1d9408f845a0440d226696df"
      number: 3957
    }
    input: {
      cancelLines: [
        {
          line: {
            id: 17231
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
    "updateWholesaleOrder": {
      "order": {
        "id": "c8b6e87b1d9408f845a0440d226696df",
        "number": 3957,
        "status": "PENDING",
        "isOnHold": false,
        "lines": [
          {
            "id": 17231,
            "product": {
              "name": "90's boot leg "
            },
            "quantity": 1,
            "taxPercent": 0,
            "unitPrice": {
              "value": 1500,
              "currency": {
                "id": 3,
                "code": "SEK"
              },
              "conversionRate": 1
            },
            "hasAnyDiscount": false,
            "unitOriginalPrice": {
              "value": 1500,
              "currency": {
                "id": 3,
                "code": "SEK"
              },
              "conversionRate": 1
            },
            "lineValue": {
              "value": 1500,
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
              "value": 30,
              "currency": {
                "id": 3,
                "code": "SEK"
              },
              "conversionRate": 1
            },
            "date": "2021-03-04T09:05:52+01:00"
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
          "phoneNumber": "123456789",
          "faxNumber": null,
          "email": "jon.snow@example.com",
          "companyName": "CENTRA",
          "attention": "Johan",
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
          "phoneNumber": "123456789",
          "faxNumber": null,
          "email": "jon.snow@example.com",
          "companyName": "CENTRA",
          "attention": "Johan",
          "vatNumber": null,
          "country": {
            "id": 6,
            "name": "Sweden"
          },
          "state": null
        }
      },
      "userErrors": []
    }
  },
  "extensions": {
    "complexity": 228,
    "permissionsUsed": [
      "Order:write",
      "Order:read",
      "Order.shippingAddress:read",
      "Order.billingAddress:read",
      "Product:read"
    ],
    "appVersion": "v0.32.3"
  }
}
```

### Confirming the order

This is the only time in Centra when you set the order status directly. Once triggered, order confirmation e-mail will be sent. Next status change will be to Processing when you create the first shipment, and then to Completed, once the final shipment is completed and all order lines items have been either shipped or cancelled. [Click here if you need a refresher on the standard order flow in Centra](/overview/orderflow#order-flow).

[notice-box=info]
You can skip this step and status by enabling the Store Setting `Autoconfirm orders`.
[/notice-box]

#### Request

```gql
mutation confirmOrder {
  confirmOrder(
    input: {
      order: {
        # id: "c8b6e87b1d9408f845a0440d226696df"
        number: 3957
      }
    }
  ) {
    order {
      number
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
    "confirmOrder": {
      "order": {
        "number": 3957,
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

### Creating a shipment

If you have an order that you wish to expedite you can proceed to create a shipment for it. The order has to be confirmed and can not be locked or on hold.

#### Request

In this example, we will create a single shipment for all remaining order lines and quantities of our example B2B order. If you wish to create partial shipments, simply skip some of the order lines and quantities you are not prepared to ship at this time.

```gql
mutation createShipment {
  createShipment (
    input: {
      order: { number: 3957 }
      lines: [{ orderLine: { id: 17231 }, quantity: 1 }]
      shipmentInfo: {
        carrier: "Carrier name"
        service: "Service name"
        packagesNumber: 1
        trackingNumber: "1234trackingcode"
        returnTrackingNumber: "1234returncode"
        internalShippingCost: { currencyIsoCode: "SEK", value: 12 }
      }
      isGoodToGo: true
      isPaid: false
      createdAt: "2022-06-23 15:47:12"
      shippedAt: null
      sendEmail: false
      additionalMessage: "Additional message"
      allocateDemand: true
      shipmentMethod: { pluginId: 47 }
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
        "id": 314,
        "number": "3957-1",
        "createdAt": "2022-06-23T15:47:12+02:00",
        "updatedAt": "2022-11-09T14:55:27+01:00",
        "isGoodToGo": true,
        "isShipped": false,
        "isPaid": false,
        "paidAt": null,
        "additionalMessage": "Additional message",
        "shippedAt": null,
        "numberOfPackages": 1,
        "trackingNumber": "1234trackingcode",
        "returnTrackingNumber": "1234returncode",
        "internalShippingCost": {
          "value": 12
        },
        "grandTotal": {
          "value": 1500
        },
        "carrierInformation": {
          "carrierName": "Carrier name",
          "serviceName": "Service name"
        },
        "adminUser": null,
        "discountsApplied": [],
        "lines": [
          {
            "id": 410,
            "quantity": 1,
            "lineValue": {
              "formattedValue": "1 500.00 SEK"
            }
          }
        ],
        "shippingAddress": {
          "firstName": "Jon",
          "lastName": "Snow",
          "country": {
            "name": "Sweden",
            "code": "SE"
          },
          "state": null,
          "address1": "Teststr. 1",
          "address2": "1b",
          "city": "Stockholm",
          "zipCode": "12345",
          "stateOrProvince": null,
          "cellPhoneNumber": null,
          "phoneNumber": "123456789",
          "faxNumber": null,
          "email": "jon.snow@example.com"
        },
        "shipmentPlugin": null
      }
    }
  },
  "extensions": {
    "complexity": 111,
    "permissionsUsed": [
      "Shipment:write",
      "Shipment:read",
      "AdminUser:read",
      "Order:read",
      "Shipment.shippingAddress:read",
      "StorePlugin:read"
    ],
    "appVersion": "v0.32.3"
  }
}
```

### Updating a shipment - mark as paid

We assume you've collected the payment outside Centra.

#### Request

```gql
mutation updateShipmentMarkPaid {
  updateShipment (
    id: 314
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
        "id": 314,
        "number": "3957-1",
        "createdAt": "2022-06-23T15:47:12+02:00",
        "updatedAt": "2022-11-09T15:15:33+01:00",
        "isGoodToGo": true,
        "isShipped": false,
        "isPaid": true,
        "paidAt": "2022-11-09T15:15:33+01:00",
        "additionalMessage": "Additional message",
        "shippedAt": null,
        "numberOfPackages": 1,
        "trackingNumber": "1234trackingcode",
        "returnTrackingNumber": "1234returncode",
        "internalShippingCost": {
          "value": 12
        },
        "grandTotal": {
          "value": 1500
        },
        "carrierInformation": {
          "carrierName": "Carrier name",
          "serviceName": "Service name"
        },
        "adminUser": null,
        "discountsApplied": [],
        "lines": [
          {
            "id": 410,
            "quantity": 1,
            "lineValue": {
              "formattedValue": "1 500.00 SEK"
            }
          }
        ],
        "shippingAddress": {
          "firstName": "Jon",
          "lastName": "Snow",
          "country": {
            "name": "Sweden",
            "code": "SE"
          },
          "state": null,
          "address1": "Teststr. 1",
          "address2": "1b",
          "city": "Stockholm",
          "zipCode": "12345",
          "stateOrProvince": null,
          "cellPhoneNumber": null,
          "phoneNumber": "123456789",
          "faxNumber": null,
          "email": "jon.snow@example.com"
        },
        "shipmentPlugin": null
      }
    }
  },
  "extensions": {
    "complexity": 111,
    "permissionsUsed": [
      "Shipment:write",
      "Shipment:read",
      "AdminUser:read",
      "Order:read",
      "Shipment.shippingAddress:read",
      "StorePlugin:read"
    ],
    "appVersion": "v0.32.3"
  }
}
```

### Completing a shipment

Finally, when shipment is good to go and paid for, you can complete it - logically, it means the package left your warehouse. This is also the right moment to trigger a shipment confirmation e-mail to your purchaser.

#### Request

```gql
mutation completeShipment {
  completeShipment (
    id: 314
    input: {
      shippedAt: "2022-11-09T15:18:33+01:00"
      sendEmail: true
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
        "id": 314,
        "number": "3957-1",
        "createdAt": "2022-06-23T15:47:12+02:00",
        "updatedAt": "2022-11-09T15:19:26+01:00",
        "isGoodToGo": true,
        "isShipped": true,
        "isPaid": true,
        "paidAt": "2022-11-09T15:15:33+01:00",
        "additionalMessage": "Additional message",
        "shippedAt": "2022-11-09T15:18:33+01:00",
        "numberOfPackages": 1,
        "trackingNumber": "1234trackingcode",
        "returnTrackingNumber": "1234returncode",
        "internalShippingCost": {
          "value": 12
        },
        "grandTotal": {
          "value": 1500
        },
        "carrierInformation": {
          "carrierName": "Carrier name",
          "serviceName": "Service name"
        },
        "adminUser": null,
        "discountsApplied": [],
        "lines": [
          {
            "id": 410,
            "quantity": 1,
            "lineValue": {
              "formattedValue": "1 500.00 SEK"
            }
          }
        ],
        "shippingAddress": {
          "firstName": "Jon",
          "lastName": "Snow",
          "country": {
            "name": "Sweden",
            "code": "SE"
          },
          "state": null,
          "address1": "Teststr. 1",
          "address2": "1b",
          "city": "Stockholm",
          "zipCode": "12345",
          "stateOrProvince": null,
          "cellPhoneNumber": null,
          "phoneNumber": "123456789",
          "faxNumber": null,
          "email": "jon.snow@example.com"
        },
        "shipmentPlugin": null
      }
    }
  },
  "extensions": {
    "complexity": 111,
    "permissionsUsed": [
      "Shipment:write",
      "Shipment:read",
      "AdminUser:read",
      "Order:read",
      "Shipment.shippingAddress:read",
      "StorePlugin:read"
    ],
    "appVersion": "v0.32.3"
  }
}
```

### Deleting a shipment

You can only do that if the shipment is not yet shipped and paid for. Otherwise, the shipment should be returned.

#### Request

```gql
mutation deleteShipment {
  deleteShipment(id: 312) {
    userErrors {
      message
      path
    }
  }
}
```

### Fetching a B2B invoice

In B2B, GraphQL allows you to find invoices and mark them as paid. Here's a simple example of how to do it:

#### Request

```gql
query invoices {
  invoices (where: {type: INVOICE, number: 1004}) {
    id
    number
    type
    store {name}
    grandTotal { formattedValue }
    orders { number }
    shipments { number }
    payments {
      id
      invoice { id }
      value { formattedValue }
      paymentDate
      type
    }
  }
}
```

#### Response

```json
{
  "data": {
    "invoices": [
      {
        "id": 16,
        "number": 1004,
        "type": "INVOICE",
        "store": {
          "name": "Wholesale"
        },
        "grandTotal": {
          "formattedValue": "0.00 SEK"
        },
        "orders": [],
        "shipments": [],
        "payments": []
      }
    ]
  },
  "extensions": {
    "complexity": 1060,
    "permissionsUsed": [
      "Invoice:read",
      "Store:read",
      "Order:read",
      "Shipment:read"
    ],
    "appVersion": "v0.36.1"
  }
}
```

### Marking an invoice as paid

Use the invoice ID returned in the previous call. Remember, invoice numbers can be changed, while their IDs can not.

#### Request

```gql

```

#### Response

```json

```


<!--
#### Request

```gql

```

#### Response

```json

```
-->

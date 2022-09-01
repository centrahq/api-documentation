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


<!--
#### Request

```gql

```

#### Response

```json

```
-->

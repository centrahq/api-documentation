---
title: Introduction
excerpt: 
taxonomy:
category: docs
---

## GraphQL Access Token

An access token is a credential that is bound to certain set of permissions. The set of permissions
is decided during token generation. It is not bound to any specific user by the application,
but it might be issued with specific user in mind.

Access token has an obligatory expiration time after which it will no longer authorize any requests.

## Obtaining Access Token via AMS

For GraphQL access you need user token with correct permissions. This could be done in the backend AMS. Navigate to `System -> Api Tokens` and then add a new token by clicking `+ Integration API TOKEN` button.

Here we are able to provide restrictions, select permissions, and expiration time.
Requirements for generating token are:
- Providing description (it is a good practice to provide a description that allows unambiguous token identification)
- At least one permission

Expiration time is optional - the default value equals 30 days.

## Token Revocation

Access tokens can be revoked in the AMS when necessary. Navigate to `System -> Api Tokens` and select the token that you want to invalidate.
This is the moment when good practice of naming tokens unambiguously pays off. When token
details are displayed use the `X Revoke` button.

## Authorizing Requests

### Header

One way to authorize the request is to provide an `Authorization` header:

```http
POST *base*/graphql

Authorization: Bearer <access token>
```

CURL example:

```bash
curl "${BASE_URL}/graphql" \
    -X POST \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H "Content-Type: application/json" \
    -d '{"query":"{ __schema { types { name } } }"}'
```

### Cookie

Another way to authorize request to GraphGL API is to add a cookie named `graphql-access` with only the access token as value.

```http
POST *base*/graphql

Cookie: graphql-access=<access token>
```

CURL example:

```bash
curl "${BASE_URL}/graphql" \
    -X POST \
    -H "Cookie: graphql-access=${ACCESS_TOKEN}" \
    -H "Content-Type: application/json" \
    -d '{"query":"{ __schema { types { name } } }"}'
```

For instructions on how to attach a header or cookie in your API client refer to the client's documentation.

## Permissions
The list of permissions is changing as new permissions are added to match new queries and mutations.

[notice-box=info]
During your integration's initial tests in QA, it's worth to note all the information returned in `extensions.permissionsUsed`, so that you know exactly which permissions are required for use cases covered in your integration. This way you can later use API tokens with minimal permissions when you move to Production, which we highly recommend. Running Production integrations on tokens with full admin permissions is considered bad practice, and a potential security vulnerability.
[/notice-box]

If you call the API without required permissions, you will be informed about this explicitly:

Request:

```gql
{
  orderConnection(
    last: 10, before: "bnVtYmVyOjE2Ng==", where: {storeType: WHOLESALE}
  )
  {
    totalCount
    pageInfo{hasPreviousPage, hasNextPage, startCursor, endCursor}
    edges{
      node{
        number
        status
        grandTotal{
          value
          currency {code}
        }
        orderDate
      }
      cursor
    }
  }
}
```

Response:

```gql
{
  "errors": [
    {
      "message": "You need Order:read permission to access orderConnection.",
      "extensions": {
        "category": "authorization"
      },
      "locations": [
        {
          "line": 6,
          "column": 3
        }
      ],
      "path": [
        "orderConnection"
      ]
    }
  ],
  "extensions": {
    "complexity": 50,
    "permissionsUsed": [
      "Order:read"
    ]
  }
}
```

## New, simplified permissions

In the upcoming Centra 3.7 version we will release changes simplifying permissions in Integration API (GraphQL).

### Previous convention

Most of the main types have a permission associated with it, like `Product:read` and `Product:write`. On top of that, relations between types were also secured separately. For example, `Product.Brand:read` would allow you to read brands associated with a product, but wouldn’t affect your ability to read other brands – for that there was `Brand:read`. This convention resulted in many granular permissions.

### Why and what we change

Reason 1: Such granularity is not actually needed. If a token is granted permission to `Account:read`, it should be enough to read accounts from `Invoice.account`, `Return.account`, or `SalesRepresentative.accounts`. Thus instead of `Invoice.Account:read`, `Return.Account:read` and `SalesRepresentative.Account:read` there will be the only permission `Account:read`. It will significantly reduce the number of permissions used, and therefore their management will be simplified.

Reason 2: Inconsistency of sub-permissions. Sometimes scalar fields are guarded, sometimes sub-types are guarded, but they look the same: `Product.InternalComment:read` (scalar) `Product.Attribute:read` (type).  
The new release will use a field name instead of a return type. The aforementioned permissions will become `Product.attributes:read` and `Product.internalComment:read` for `attributes` and `internalComment`.  
It would also make it clear, which field it is about when there are two fields with the same return type. For example, different addresses `PurchaseOrder.shippingAddress:read` and `PurchaseOrder.supplierAddress:read` instead of `PurchaseOrder.Address:read` for both. And make it clear that `Purchaser.Order:read` is actually about `Purchaser.totalOrders:read`.

Reason 3: Currently, it’s not possible to secure the same type with separate permissions. The changes will enable this possibility as for `shippingAddress` and `supplierAddress`.

### New convention

Nested permissions will be used only for:

* Attributes  
* Internal comments  
* Stock  
* Addresses  
* Other sensitive information, like `AdminUser.email`

The second part of nested permissions will always match the field name.

### Deprecated permission handling

The old permissions will still work for now but will be marked as deprecated. In case of using a deprecated permission, a new section in responses will appear: `extensions` > `deprecatedPermissionsUsed`.

We will monitor the usage of the deprecated permissions to make sure they are not used, before we delete them completely.

### How to prepare

Recommended actions:  
* Run all GQL queries, which are in use, towards updated QA servers,  
* Note down all (new) permissions used, then add them to your tokens.

### Roadmap

* 21.03.2022 – release of the new + deprecated permissions on QA servers  
* 04.04.2022 – release on production servers  
* 16.05.2022 – release of removing deprecated permissions on QA servers  
* 30.05.2022 – release on production servers

### Additional notes

Please note, some types have new sub-permissions, and using top type permissions on them is marked as deprecated. It only means the usage of this permission is deprecated for this specific field, but the permission itself could be still active and it will be clearly stated in the new `deprecatedPermissionsUsed` section. For example, the query

```gql
{
  invoices(limit: 1) {
    billingAddress {city}
  }
}
```

...will tell `Invoice:read` is deprecated but it’s only for `Invoice.billingAddress`. `Invoice:read` is still an active permission.

```gql
    "permissionsUsed": [
      "Invoice:read",
      "Invoice.billingAddress:read"
    ],
    "deprecatedPermissionsUsed": [
      "Field: Invoice.billingAddress, deprecated: Invoice:read, current: Invoice.billingAddress:read"
    ],
```

## Deprecations in the latest GQL API versions

We're making some changes to our GraphQL Integration API because we want it to reflect business concepts better and need to align the naming.

We are doing our best not to introduce breaking changes so that existing queries still work, but you can switch to using new names at any time. For example, when a field is renamed, a new field is added, and the old one still works. When a returned type changes, the old type is turned into an interface so that fragments explicitly specifying types are not broken.

Moreover, we are now returning a list of deprecated fields used under extensions, so you can see exactly whether your queries use deprecated fields and when they will be deleted.

Example response:
```json
{
  "data": {
     ...
  },
  "extensions": {
    "deprecatedFieldsUsed": [
      "Field: Query.displays, reason: Use ObjectWithTranslations instead of Localizable, date of removal: 2023-09-04",
      "Field: Display.localized, reason: Renamed localized to translations, date of removal: 2023-09-04",
      "Field: LanguageTranslation.translations, reason: Renamed to fields, date of removal: 2023-09-04"
    ],
  }
}
```

These are the changes that will be made:

### Date and time scalars

All input and output fields using dates and date-times have been changed to using custom scalar types: `Date` and (in most cases) `DateTimeTz`. This change was announced in October 2022 and required us to disable strict type checks of variables until all partners stop type-hinting dates as `String`.

Before:

```gql
query lastOrders($fromDate: String!) {
  orders(where: {orderDate: {from: $fromDate}}) {
    ...
  }
}
```

After:

```gql
query lastOrders($fromDate: DateTimeTz!) {
  orders(where: {orderDate: {from: $fromDate}}) {
    ...
  }
}
```

### Rename of WarehouseDelivery to StockChange

Due to the fact that `WarehouseDelivery` does not cover all use cases that are available and that will come in the future. There are multiple ways stock balance can be changed, where only some are warehouse deliveries (a.k.a inbound deliveries). Thus, `WarehouseDelivery` will be renamed to `StockChange`.

Before:

```gql
query stockChanges($filter: WarehouseDeliveryFilter!) {
  warehouseDeliveryConnection(where: $filter, last: 10) {
    ...
  }
}
```

After:

```gql
query stockChanges($filter: StockChangeFilter!) {
  stockChangeConnection(where: $filter, last: 10) {
    ...
  }
}
```

### Rename Localization to Translation

As localization is much more of a general term that includes time zones, currency, etc., we've decided to rename `Localization` to `Translation`. This will also be consistent with naming in Centra's admin panel.

Before:

```gql
query displayTranslations {
  displays {
    id
    name
    ...translations
  }
}

fragment translations on Localizable { # deprecated interface
  localized {
    language { code }
    translations {
      field
      value
    }
  }
}
```

After:

```gql
query displayTranslations {
  displays {
    id
    name
    ...translations
  }
}

fragment translations on ObjectWithTranslations {
  translations {
    language { code }
    fields {
      field
      value
    }
  }
}
```

### Separation of Customer and Buyer - Purchaser will be deprecated

Centra has two different "customer" types. One in DTC, called `Customer`, and one in Wholesale, called `Buyer` (which is connected to `Account`). Because the two types have mostly the same fields, they have been grouped under a common interface named `Purchaser`. This, after communication with several parties, has been deemed to be somewhat confusing, and therefore it's been decided to deprecate `Purchaser`.

Since `Purchaser` will no longer be there, types referencing it are now split into DTC and Wholesale subtypes: `Shipment` is now an interface shared by `DirectToConsumerShipment` and `WholesaleShipment`. Similarly, `Return`, `Invoice`, `OrderHistoryEntry`, and `EmailHistoryEntry` are now interfaces with two implementations each.

Before:

```gql
query returns {
  returns(where: {purchaserId: 1, storeType: DIRECT_TO_CONSUMER}) {
    id
    purchaser {
      email
    }
  }
}
```

After:

```gql
query returns {
  returns(where: {customerId: 1, storeType: DIRECT_TO_CONSUMER}) {
    id
    ...on DirectToConsumerReturn {
      customer {
        email
      }
    }
  }
}
```

### Discount renamed to Voucher

Discounts can be given in multiple ways in Centra. For example, campaigns discount product prices, but also a manual discount on an order line may be given by a Centra admin user. In order to create less confusion, `Discount`, which represents vouchers in Centra, will be renamed to `Voucher`.

Before:

```gql
mutation addVoucher($input: DiscountCreateInput!) {
	createDiscount(input: $input) {
    discount {
      id
    }
    userErrors { message, path }
  }
}
```

After:

```gql
mutation addVoucher($input: VoucherCreateInput!) {
	createVoucher(input: $input) {
    voucher {
      id
    }
    userErrors { message, path }
  }
}
```

### Additional changes

These fields were deprecated before but now received a concrete date of removal:  
* `AllocationRule.warehouses` – warehouses are now under geo-priorities; there may be a different set of warehouses depending on the country
* `Address.otherPhoneNumber` – renamed to `phoneNumber`
* `Purchaser/Buyer/Customer.otherPhoneNumber` – also renamed to `phoneNumber`
* `Customer.sex` – renamed to `gender`
* `Shipment.emailSentAt` – use `shippedAt`, which contains the same date
* `SizeChart.isEnabled` – will always return `true` since we don’t disable size charts
* `Mutation.removeProductMedia` – renamed to `deleteProductMedia`
* `Currency.shippingOptions` – this direct relation is not supported anymore; one can filter `shippingOptions` by `currencyId` instead
* `Size.productSizes` – this relation is also not supported anymore; one can filter `productSizes` by `sizeId`
* `Store.totalPurchasers` – this can be achieved with `Query.counters.customers` filtered by `storeId`
* `Store.totalOrders` – similarly, this is also available from `Query.counters.orders` filtered by `storeId`
* `graphQLAccessTokenCount` - use `counters.graphQLAccess` instead
* `removeSizeChart` - use deleteSizeChart instead
* `removeMeasurementChart` - use `deleteMeasurementChart` instead
* `removeCampaign` - use `deleteCampaign` instead
* `ProductSizeUpdateInput` - `GTIN` has been renamed to `EAN`, `UPC` was added as a separate field
* `ProductSizeCreateInput` - same as the above
* `ProductSizeFilter` - same
* `ProductSize.GTIN` - same
* `Return.account`- moved from the `Return` interface to `WholesaleReturn`
* `DirectToConsumerReturn.account` - moved from the `Return` interface to `WholesaleReturn`

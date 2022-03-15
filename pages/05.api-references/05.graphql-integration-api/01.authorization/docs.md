---
title: Authorization
excerpt: 
taxonomy:
category: docs
---

## GraphQL Access Token

An access token is a credential that is bound to certain set of permissions. The set of permissions
is decided during token generation. It is not bound to any specific user by the application,
but it might be issued with specific user in mind.

Access token has an obligatory expiration time after which it will no longer authorize any requests.

## Obtaining Access Token

For GraphQL access you need user token with correct permissions. This could be done in two ways:
- Via AMS
- Via GraphQL (using admin token)

### Obtaining token via AMS
Navigate to `System -> Api Tokens` and then add a new token by clicking `+ Integration API TOKEN` button.

Here we are able to provide restrictions, select permissions, and expiration time.
Requirements for generating token are:
- Providing description (it is a good practice to provide a description that allows unambiguous token identification)
- At least one permission

Expiration time is optional - the default value equals 30 days.

### Obtaining token via GraphQL (using admin token)

Admin auth token for creating user for fetching data
To fetch token, we need to go to `Diagnostics -> SysInfo` and then select `GraphQL Access`.
If there is no token generate a random one and save it. Keep in mind that this token never expires
and therefore should never be disclosed to API clients. Use the admin token only to generate
new API tokens.

To create a new access token issue a request to the GraphQL API and authorize it using the obtained admin token.
Use the `generateToken` mutation and provide the same token parameters as with AMS token generation.

CURL example:

```bash
curl "${BASE_URL}/graphql" \
    -X POST \
    -H "Authorization: Bearer ${ADMIN_TOKEN}" \
    -H "Content-Type: application/json" \
    -d '{"query": "mutation { generateToken( user: { name: \"Example\", permissions: [\"Product:read\"] }, ttl: 3600 ) { token isValid expiresAt } }" }'
```

You can now use the token from the response:

```json
{
    "data": {
        "generateToken": {
            "token": "abcd............zyx",
            "isValid": true,
            "expiresAt": "2025-12-31T23:59:59+0000"
        }
    }
}
```

## Token Revocation

Access tokens can be revoked in two ways when necessary - similarly to obtaining:
- Via AMS
- Via GraphQL

### Revoke token via AMS

Navigate to `System -> Api Tokens` and select the token that you want to invalidate.
This is the moment when good practice of naming tokens unambiguously pays off. When token
details are displayed use the `X Revoke` button.

### Revoke token via GraphQL

Request to revoke an access token should be authorized using the admin token (see `Obtaining token via GraphQL`).
In order to invalidate token use the `revokeAccess` mutation.

```bash
curl "${BASE_URL}/graphql" \
    -X POST \
    -H "Authorization: Bearer ${ADMIN_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{\"query\": \"mutation { revokeAccess( token: \\\"${ACCESS_TOKEN}\\\" ) { token isValid expiresAt } }\" }"
```


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

For complete list of permissions query the GraphQL API using admin token:

```bash
curl "${BASE_URL}/graphql" \
    -X POST \
    -H "Authorization: Bearer ${ADMIN_TOKEN}" \
    -H "Content-Type: application/json" \
    -d '{"query": "{ permissionNames }"}'
```
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

### Full list of permissions

| Permission  |  Status  | Comment  |
|:------------|:--------:|:---------|
| ``Account:read`` | &#10004; |  |
| ``Account.AddressBook:read`` | &#10060; | Address book is part of Account, use ``Account:read`` |
| ``Account.AllocationRule:read`` | &#10060; | Use ``AllocationRule:read`` |
| ``Account.Attribute:read`` | &#10060; | Use ``Account.attributes:read`` |
| ``Account.attributes:read`` | &#10071; | New permission, use instead of ``Account.Attribute:read`` |
| ``Account.Brand:read`` | &#10060; | Use ``Brand:read`` |
| ``Account.DeliveryWindowDiscount:read`` | &#10060; | DeliveryWindowDiscount is a part of Account model, use ``Account:read`` |
| ``Account.EmailHistory:read`` | &#10060; | Use ``EmailHistory:read`` |
| ``Account.InternalComment:read`` | &#10060; | Use ``Account.internalComment:read`` |
| ``Account.internalComment:read`` | &#10071; | New permission, use instead of ``Account.InternalComment:read`` |
| ``Account.Invoice:read`` | &#10060; | Use ``Invoice:read`` |
| ``Account.Market:read`` | &#10060; | Use ``Market:read`` |
| ``Account.Order:read`` | &#10060; | Use ``Order:read`` |
| ``Account.PaymentTerms:read`` | &#10060; | Use ``PaymentTerms:read`` |
| ``Account.Pricelist:read`` | &#10060; | Use ``Pricelist:read`` |
| ``Account.Purchaser:read`` | &#10060; | Use ``Purchaser:read`` |
| ``Account.Return:read`` | &#10060; | Use ``Return:read`` |
| ``Account.SalesRepresentative:read`` | &#10060; | Use ``SalesRepresentative:read`` |
| ``Account.ShippingTerms:read`` | &#10060; | Use ``ShippingTerms:read`` |
| ``Account.TaxClass:read`` | &#10060; | Use ``TaxClass:read`` |
| ``Account.Warehouse:read`` | &#10060; | Use ``Warehouse:read`` |
| ``Account:write`` | &#10004; |  |
| ``AddressBook:read`` | &#10060; | AddressBook is a part of Account, use ``Account:read`` |
| ``AdminDiscount.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``AdminUser:read`` | &#10004; |  |
| ``AdminUser.Account:read`` | &#10060; | Use ``Account:read`` |
| ``AdminUser.Brand:read`` | &#10060; | Use ``Brand:read`` |
| ``AdminUser.Email:read`` | &#10060; | Use ``AdminUser.email:read`` |
| ``AdminUser.email:read`` | &#10071; | New permission, use instead of ``AdminUser.Email:read`` |
| ``AdminUser.Market:read`` | &#10060; | Use ``Market:read`` |
| ``AdminUser.Pricelist:read`` | &#10060; | Use ``Pricelist:read`` |
| ``AdminUser.SalesRepresentative:read`` | &#10060; | Use ``SalesRepresentative:read`` |
| ``Affiliate:read`` | &#10004; |  |
| ``Affiliate.Order:read`` | &#10060; | Use ``Order:read`` |
| ``Affiliate.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Allocation:read`` | &#10004; |  |
| ``AllocationRule:read`` | &#10004; |  |
| ``AllocationRule.Account:read`` | &#10060; | Use ``Account:read`` |
| ``AllocationRule.DeliveryWindow:read`` | &#10060; | Use ``DeliveryWindow:read`` |
| ``AllocationRule.GeographyAllocationPriority:read`` | &#10060; | GeographyAllocationPriority is a part of AllocationRule model, use ``AllocationRule:read`` |
| ``AllocationRule.Market:read`` | &#10060; | Use ``Market:read`` |
| ``AllocationRule.Store:read`` | &#10060; | Use ``Store:read`` |
| ``AllocationRule.Warehouse:read`` | &#10060; | Use ``Warehouse:read`` |
| ``AppliedDiscount.Discount:read`` | &#10060; | Use ``Discount:read`` |
| ``AppliedDiscount.Order:read`` | &#10060; | Use ``Order:read`` |
| ``Attribute:read`` | &#10004; |  |
| ``Attribute:write`` | &#10004; |  |
| ``Brand:read`` | &#10004; |  |
| ``Brand.Product:read`` | &#10060; | Use ``Product:read`` |
| ``Brand.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Brand:write`` | &#10004; |  |
| ``BrickAndMortar:read`` | &#10004; |  |
| ``BrickAndMortar.AllocationRule:read`` | &#10060; | Use ``AllocationRule:read`` |
| ``BrickAndMortar.Store:read`` | &#10060; | Use ``Store:read`` |
| ``BrickAndMortar.Warehouse:read`` | &#10060; | Use ``Warehouse:read`` |
| ``Bundle:read`` | &#10004; |  |
| ``Bundle.SizeChart:read`` | &#10060; | Use ``SizeChart:read`` |
| ``Bundle:write`` | &#10004; |  |
| ``Campaign:read`` | &#10004; |  |
| ``Campaign.CampaignVariant:read`` | &#10060; | Use ``CampaignVariant:read`` |
| ``Campaign.DeliveryWindow:read`` | &#10060; | Use ``DeliveryWindow:read`` |
| ``Campaign.Market:read`` | &#10060; | Use ``Market:read`` |
| ``Campaign.Pricelist:read`` | &#10060; | Use ``Pricelist:read`` |
| ``Campaign.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Campaign:write`` | &#10004; |  |
| ``CampaignVariant.Campaign:read`` | &#10060; | Use ``Campaign:read`` |
| ``CampaignVariant:read`` | &#10060; | CampaignVariant is a part of Campaign, use ``Campaign:read`` |
| ``Category:read`` | &#10004; |  |
| ``Category.Display:read`` | &#10060; | Use ``Display:read`` |
| ``Category.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Collection:read`` | &#10004; |  |
| ``Collection.totalProducts:read`` | &#10071; | New permission |
| ``Collection.Product:read`` | &#10060; | Use ``Product:read`` |
| ``Collection:write`` | &#10004; |  |
| ``Commission:read`` | &#10004; |  |
| ``Commission.Invoice:read`` | &#10060; | Use ``Invoice:read`` |
| ``Commission.Order:read`` | &#10060; | Use ``Order:read`` |
| ``Commission.SalesRepresentative:read`` | &#10060; | Use ``SalesRepresentative:read`` |
| ``Country:read`` | &#10004; |  |
| ``Currency.Pricelist:read`` | &#10060; | Use ``Pricelist:read`` |
| ``Currency.ShippingOption:read`` | &#10060; | Use ``ShippingOption:read`` |
| ``Currency:read`` | &#10004; |  |
| ``Customer.Attribute:read`` | &#10060; | Use ``Purchaser.Attribute:read`` |
| ``Customer.EmailHistory:read`` | &#10060; | Use ``EmailHistory:read`` |
| ``DeliveryWindow:read`` | &#10004; |  |
| ``DeliveryWindow.AllocationRule:read`` | &#10060; | Use ``AllocationRule:read`` |
| ``DeliveryWindow.Campaign:read`` | &#10060; | Use ``Campaign:read`` |
| ``DeliveryWindow.DeliveryWindowVariant:read`` | &#10060; | Use ``DeliveryWindowVariant:read`` |
| ``DeliveryWindow.Market:read`` | &#10060; | Use ``Market:read`` |
| ``DeliveryWindow:write`` | &#10004; |  |
| ``DeliveryWindowDiscount:read`` | &#10060; | DeliveryWindowDiscount is a part of Account model, use ``Account:read`` |
| ``DeliveryWindowDiscount.Account:read`` | &#10060; | Use ``Account:read`` |
| ``DeliveryWindowDiscount.DeliveryWindow:read`` | &#10060; | Use ``DeliveryWindow:read`` |
| ``DeliveryWindowVariant:read`` | &#10060; | DeliveryWindowVariant is a part of DeliveryWindow model, use ``DeliveryWindow:read`` |
| ``DeliveryWindowVariant.DeliveryWindow:read`` | &#10060; | Use ``DeliveryWindow:read`` |
| ``DeliveryWindowVariant.Product:read`` | &#10060; | Use ``Product:read`` |
| ``DeliveryWindowVariant.ProductVariant:read`` | &#10060; | Use ``ProductVariant:read`` |
| ``DeliveryWindowVariant:write`` | &#10060; | DeliveryWindowVariant is a part of DeliveryWindow model, use ``DeliveryWindow:write`` |
| ``Discount:read`` | &#10004; |  |
| ``Discount.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``Discount.AppliedDiscount:read`` | &#10060; | AppliedDiscount is a part of Order model, use ``Order:read`` |
| ``Discount.GiftCertificateGenerator:read`` | &#10060; | Use ``GiftCertificateGenerator:read`` |
| ``Discount.Market:read`` | &#10060; | Use ``Market:read`` |
| ``Discount.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Display:read`` | &#10004; |  |
| ``Display.Attribute:read`` | &#10060; | Unused |
| ``Display.CampaignVariant:read`` | &#10060; | Use ``CampaignVariant:read`` |
| ``Display.Category:read`` | &#10060; | Use ``Category:read`` |
| ``Display.Comment:read`` | &#10060; | Use ``Display.comment:read`` |
| ``Display.comment:read`` | &#10071; | New permission, use instead of ``Display.Comment:read`` |
| ``Display.DisplayRelation:read`` | &#10060; | DisplayRelation is a part of Display model, use ``Display:read`` |
| ``Display.Market:read`` | &#10060; | use ``Market:read`` |
| ``Display.Price:read`` | &#10060; | Use ``Price:read`` |
| ``Display.Product:read`` | &#10060; | Use ``Product:read`` |
| ``Display.ProductMedia:read`` | &#10060; | Use ``ProductMedia:read`` |
| ``Display.ProductVariant:read`` | &#10060; | Use ``ProductVariant:read`` |
| ``Display.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Display.TaxGroup:read`` | &#10060; | Use ``TaxGroup:read`` |
| ``Display:write`` | &#10004; |  |
| ``DisplayRelation:write`` | &#10060; | DisplayRelation is a part of Display model, use ``Display:write`` |
| ``DocumentTemplate:read`` | &#10004; |  |
| ``EmailHistory:read`` | &#10004; |  |
| ``EmailHistory.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``EmailHistory.Order:read`` | &#10060; | Use ``Order:read`` |
| ``EmailHistory.Purchaser:read`` | &#10060; | Use ``Purchaser:read`` |
| ``Folder:read`` | &#10004; |  |
| ``Folder.Product:read`` | &#10060; | Use ``Product:read`` |
| ``Folder:write`` | &#10004; |  |
| ``GeographyAllocationPriority:read`` | &#10060; | GeographyAllocationPriority is a part of AllocationRule model, use ``AllocationRule:read`` |
| ``GiftCertificateGenerator:read`` | &#10004; |  |
| ``GiftCertificateGenerator.Discount:read`` | &#10060; | Use ``Discount:read`` |
| ``GiftCertificateGenerator.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Invoice:read`` | &#10004; |  |
| ``Invoice.billingAddress:read`` | &#10071; | New permission |
| ``Invoice.shippingAddress:read`` | &#10071; | New permission |
| ``Invoice.Account:read`` | &#10060; | Use ``Account:read`` |
| ``Invoice.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``Invoice.Commission:read`` | &#10060; | Use ``Commission:read`` |
| ``Invoice.PaymentTerms:read`` | &#10060; | Use ``PaymentTerms:read`` |
| ``Invoice.Purchaser:read`` | &#10060; | Use ``Purchaser:read`` |
| ``Invoice.ShippingTerms:read`` | &#10060; | Use ``ShippingTerms:read`` |
| ``Invoice.Store:read`` | &#10060; | Use ``Store:read`` |
| ``InvoiceLine.countryOfOrigin:read`` | &#10071; | New permission |
| ``InvoiceLine.OrderLine:read`` | &#10060; | Use ``Order:read`` |
| ``InvoiceLine.Product:read`` | &#10060; | Use ``Product:read`` |
| ``InvoiceLine.ProductVariant:read`` | &#10060; | Use ``ProductVariant:read`` |
| ``InvoiceLine.ShipmentLine:read`` | &#10060; | Use ``ShipmentLine:read`` |
| ``Language:read`` | &#10004; |  |
| ``Language.Country:read`` | &#10060; | Use ``Country:read`` |
| ``Localization:read`` | &#10004; |  |
| ``Localization:write`` | &#10004; |  |
| ``Market:read`` | &#10004; |  |
| ``Market.AllocationRule:read`` | &#10060; | Use ``AllocationRule:read`` |
| ``Market.Campaign:read`` | &#10060; | Use ``Campaign:read`` |
| ``Market.Comment:read`` | &#10060; | Use ``Market.comment:read`` |
| ``Market.comment:read`` | &#10071; | New permission, use instead of ``Market.Comment:read`` |
| ``Market.Country:read`` | &#10060; | Use ``Country:read`` |
| ``Market.Store:read`` | &#10060; | Use ``Store:read`` |
| ``MeasurementChart:read`` | &#10004; |  |
| ``MeasurementChart:write`` | &#10004; |  |
| ``MediaBatch:read`` | &#10004; |  |
| ``MediaBatch:write`` | &#10004; |  |
| ``NewsletterSubscription:read`` | &#10004; |  |
| ``NewsletterSubscription.Country:read`` | &#10060; | Use ``Country:read`` |
| ``NewsletterSubscription.ProductSize:read`` | &#10060; | Use ``ProductSize:read`` |
| ``NewsletterSubscription.ProductVariant:read`` | &#10060; | Use ``ProductVariant:read`` |
| ``NewsletterSubscription.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Order:read`` | &#10004; |  |
| ``Order.Account:read`` | &#10060; | Use ``Account:read`` |
| ``Order.Affiliate:read`` | &#10060; | Use ``Affiliate:read`` |
| ``Order.Attribute:read`` | &#10060; | Use ``Order.attributes:read`` |
| ``Order.attributes:read`` | &#10071; | New permission |
| ``Order.billingAddress:read`` | &#10071; | New permission |
| ``Order.Commission:read`` | &#10060; | Use ``Commission:read`` |
| ``Order.DeliveryWindow:read`` | &#10060; | Use ``DeliveryWindow:read`` |
| ``Order.Discount:read`` | &#10060; | Use ``Discount:read`` |
| ``Order.EmailHistory:read`` | &#10060; | Use ``EmailHistory:read`` |
| ``Order.InternalComment:read`` | &#10060; | Use ``Order.internalComment:read`` |
| ``Order.internalComment:read`` | &#10071; | New permission, use  instead of ``Order.InternalComment:read`` |
| ``Order.Market:read`` | &#10060; | Use ``Market:read`` |
| ``Order.OrderDocument:read`` | &#10060; | Use ``Order:read`` |
| ``Order.OrderHistory:read`` | &#10060; | Use ``OrderHistory:read`` |
| ``Order.PaymentHistory:read`` | &#10060; | Use ``PaymentHistory:read`` |
| ``Order.PaymentMethod:read`` | &#10060; | Use ``PaymentMethod:read`` |
| ``Order.PaymentTerms:read`` | &#10060; | Use ``PaymentTerms:read`` |
| ``Order.Pricelist:read`` | &#10060; | Use ``Pricelist:read`` |
| ``Order.Purchaser:read`` | &#10060; | Use ``Purchaser:read`` |
| ``Order.Return:read`` | &#10060; | Use ``Return:read`` |
| ``Order.SalesRepresentative:read`` | &#10060; | Use ``SalesRepresentative:read`` |
| ``Order.Shipment:read`` | &#10060; | Use ``Shipment:read`` |
| ``Order.shippingAddress:read`` | &#10071; | New permission |
| ``Order.ShippingPriceGroup:read`` | &#10060; | Use ``ShippingPriceGroup:read`` |
| ``Order.ShippingTerms:read`` | &#10060; | Use ``ShippingTerms:read`` |
| ``Order.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Order.userIP:read`` | &#10071; | New permission |
| ``OrderHistory:read`` | &#10004; |  |
| ``OrderHistory.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``OrderHistory.Purchaser:read`` | &#10060; | Use ``Purchaser:read`` |
| ``OrderLine.Brand:read`` | &#10060; | Use ``Brand:read`` |
| ``OrderLine.Campaign:read`` | &#10060; | Use ``Campaign:read`` |
| ``OrderLine.Category:read`` | &#10060; | Use ``Category:read`` |
| ``OrderLine.Collection:read`` | &#10060; | Use ``Collection:read`` |
| ``OrderLine.DeliveryWindow:read`` | &#10060; | Use ``DeliveryWindow:read`` |
| ``OrderLine.Discount:read`` | &#10060; | Unused |
| ``OrderLine.Display:read`` | &#10060; | Use ``Display:read`` |
| ``OrderLine.Folder:read`` | &#10060; | Use ``Folder:read`` |
| ``OrderLine.GiftCertificateGenerator:read`` | &#10060; | Use ``GiftCertificateGenerator:read`` |
| ``OrderLine.InvoiceLine:read`` | &#10060; | Use ``InvoiceLine:read`` |
| ``OrderLine.Product:read`` | &#10060; | Use ``Product:read`` |
| ``OrderLine.ProductVariant:read`` | &#10060; | Use ``ProductVariant:read`` |
| ``OrderLine.TaxGroup:read`` | &#10060; | TaxGroup is a group of TaxRules, use ``TaxRule:read`` |
| ``PaymentHistory:read`` | &#10004; |  |
| ``PaymentHistoryEntry.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``PaymentHistoryEntry.StorePlugin:read`` | &#10060; | Use ``StorePlugin:read`` |
| ``PaymentTerms:read`` | &#10004; |  |
| ``Price:read`` | &#10004; |  |
| ``Price:write`` | &#10004; |  |
| ``Pricelist:read`` | &#10004; |  |
| ``Pricelist.Campaign:read`` | &#10060; | Use ``Campaign:read`` |
| ``Pricelist.Comment:read`` | &#10060; | Use ``Pricelist.comment:read`` |
| ``Pricelist.comment:read`` | &#10071; | New permission, use instead of ``Pricelist.Comment:read`` |
| ``Pricelist.Country:read`` | &#10060; | Use ``Country:read`` |
| ``Pricelist.Price:read`` | &#10060; | Use ``Price:read`` |
| ``Pricelist.ShippingOption:read`` | &#10060; | Use ``ShippingOption:read`` |
| ``Pricelist.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Product:read`` | &#10004; |  |
| ``Product.Attribute:read`` | &#10060; | Use ``Product.attributes:read`` |
| ``Product.attributes:read`` | &#10071; | New permission, use instead of ``Product.Attribute:read`` |
| ``Product.Attribute:write`` | &#10060; | Use ``Product.attributes:write`` |
| ``Product.attributes:write`` | &#10071; | New permission, use instead of ``Product.Attribute:write`` |
| ``Product.Brand:read`` | &#10060; | Use ``Brand:read`` |
| ``Product.Bundle:read`` | &#10060; | Use ``Bundle:read`` |
| ``Product.Collection:read`` | &#10060; | Use ``Collection:read`` |
| ``Product.CountryOfOrigin:read`` | &#10060; | Use ``Product.countryOfOrigin:read`` |
| ``Product.countryOfOrigin:read`` | &#10071; | New permission, use instead of ``Product.CountryOfOrigin:read`` |
| ``Product.Display:read`` | &#10060; | Use ``Display:read`` |
| ``Product.Folder:read`` | &#10060; | Use ``Folder:read`` |
| ``Product.InternalComment:read`` | &#10060; | Use ``Product.internalComment:read`` |
| ``Product.internalComment:read`` | &#10071; | New permission, use instead of ``Product.InternalComment:read`` |
| ``Product.MeasurementTable:read`` | &#10060; | Use ``MeasurementChart:read`` |
| ``Product.ProductMedia:read`` | &#10060; | Use ``ProductMedia:read`` |
| ``Product.ProductVariant:read`` | &#10060; | Use ``ProductVariant:read`` |
| ``Product:write`` | &#10004; |  |
| ``ProductMedia:read`` | &#10004; |  |
| ``ProductMedia.Product:read`` | &#10060; | Use ``Product:read`` |
| ``ProductMedia:delete`` | &#10060; | Use ``ProductMedia:write`` |
| ``ProductMedia:write`` | &#10004; |  |
| ``ProductSize:read`` | &#10004; |  |
| ``ProductSize.ProductVariant:read`` | &#10060; | Use ``ProductVariant:read`` |
| ``ProductSize.PurchaseOrder:read`` | &#10060; | Use ``PurchaseOrder:read`` |
| ``ProductSize.PurchaseOrderDelivery:read`` | &#10060; | Use ``PurchaseOrderDelivery:read`` |
| ``ProductSize.Stock:read`` | &#10060; | Use ``ProductSize.stock:read`` and/or ``ProductSize.stockTotals:read`` |
| ``ProductSize.stock:read`` | &#10071; | New permission, use instead of ``ProductSize.Stock:read`` |
| ``ProductSize.stockTotals:read`` | &#10071; | New permission, use instead of ``ProductSize.Stock:read`` |
| ``ProductSize.WarehouseDeliveryLine:read`` | &#10060; | Use ``WarehouseDelivery:read`` |
| ``ProductVariant:read`` | &#10004; |  |
| ``ProductVariant.Attribute:read`` | &#10060; | Use ``ProductVariant.attributes:read`` |
| ``ProductVariant.attributes:read`` | &#10071; | New permission, use instead of ``ProductVariant.Attribute:read`` |
| ``ProductVariant.Attribute:write`` | &#10060; | Use ``ProductVariant.attributes:write`` |
| ``ProductVariant.attributes:write`` | &#10071; | New permission, use instead of ``ProductVariant.Attribute:write`` |
| ``ProductVariant.CampaignVariant:read`` | &#10060; | CampaignVariant is a part of Campaign, use ``Campaign:read`` |
| ``ProductVariant.Display:read`` | &#10060; | Use ``Display:read`` |
| ``ProductVariant.InternalName:read`` | &#10060; | Use ``ProductVariant.internalName:read`` |
| ``ProductVariant.internalName:read`` | &#10071; | New permission, use instead of ``ProductVariant.InternalName:read`` |
| ``ProductVariant.Product:read`` | &#10060; | Use ``Product:read`` |
| ``ProductVariant.ProductMedia:read`` | &#10060; | Use ``ProductMedia:read`` |
| ``ProductVariant.ProductVariantSupply:read`` | &#10060; | Use ``ProductVariantSupply:read`` |
| ``ProductVariant.PurchaseOrder:read`` | &#10060; | Use ``PurchaseOrder:read`` |
| ``ProductVariant.PurchaseOrderDelivery:read`` | &#10060; | Use ``PurchaseOrderDelivery:read`` |
| ``ProductVariant.SizeChart:read`` | &#10060; | Use ``SizeChart:read`` |
| ``ProductVariant.Stock:read`` | &#10060; | Use ``ProductVariant.stock:read`` and/or ``ProductVariant.stockTotals:read`` |
| ``ProductVariant.stock:read`` | &#10071; | New permission, use instead of ``ProductVariant.Stock:read`` |
| ``ProductVariant.stockTotals:read`` | &#10071; | New permission, use instead of ``ProductVariant.Stock:read`` |
| ``ProductVariant:write`` | &#10004; |  |
| ``ProductVariantSupply:read`` | &#10004; |  |
| ``ProductVariantSupply.PurchaseOrder:read`` | &#10060; | Use ``PurchaseOrder:read`` |
| ``ProductVariantSupply.PurchaseOrderDelivery:read`` | &#10060; | Use ``PurchaseOrderDelivery:read`` |
| ``PurchaseOrder:read`` | &#10004; |  |
| ``PurchaseOrder.Address:read`` | &#10060; | Use ``PurchaseOrder.shippingAddress:read`` and/or ``PurchaseOrder.supplierAddress:read`` |
| ``PurchaseOrder.InternalComment:read`` | &#10060; | Use ``PurchaseOrder.internalComment:read`` |
| ``PurchaseOrder.internalComment:read`` | &#10071; | New permission, use instead of ``PurchaseOrder.InternalComment:read`` |
| ``PurchaseOrder.PaymentTerms:read`` | &#10060; | Use ``PaymentTerms:read`` |
| ``PurchaseOrder.PurchaseOrderDelivery:read`` | &#10060; | Use ``PurchaseOrderDelivery:read`` |
| ``PurchaseOrder.shippingAddress:read`` | &#10071; | New permission, use instead of ``PurchaseOrder.Address:read`` |
| ``PurchaseOrder.ShippingTerms:read`` | &#10060; | Use ``ShippingTerms:read`` |
| ``PurchaseOrder.Supplier:read`` | &#10060; | Use ``Supplier:read`` |
| ``PurchaseOrder.supplierAddress:read`` | &#10071; | New permission, use instead of ``PurchaseOrder.Address:read`` |
| ``PurchaseOrder.Warehouse:read`` | &#10060; | Use ``Warehouse:read`` |
| ``PurchaseOrderDelivery:read`` | &#10004; |  |
| ``PurchaseOrderDelivery.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``PurchaseOrderDelivery.PurchaseOrder:read`` | &#10060; | Use ``PurchaseOrder:read`` |
| ``PurchaseOrderDelivery.Supplier:read`` | &#10060; | Use ``Supplier:read`` |
| ``PurchaseOrderDelivery.Warehouse:read`` | &#10060; | Use ``Warehouse:read`` |
| ``PurchaseOrderDelivery.WarehouseDelivery:read`` | &#10060; | Use ``WarehouseDelivery:read`` |
| ``PurchaseOrderDeliveryLine.OrderLine:read`` | &#10060; | Use ``Order:read`` |
| ``PurchaseOrderDeliveryLine.Product:read`` | &#10060; | Use ``Product:read`` |
| ``PurchaseOrderDeliveryLine.ProductSize:read`` | &#10060; | Use ``ProductSize:read`` |
| ``PurchaseOrderDeliveryLine.ProductVariant:read`` | &#10060; | Use ``ProductVariant:read`` |
| ``PurchaseOrderLine.OrderLine:read`` | &#10060; | Use ``Order:read`` |
| ``PurchaseOrderLine.Product:read`` | &#10060; | Use ``Product:read`` |
| ``PurchaseOrderLine.ProductSize:read`` | &#10060; | Use ``ProductSize:read`` |
| ``PurchaseOrderLine.ProductVariant:read`` | &#10060; | Use ``ProductVariant:read`` |
| ``Purchaser:read`` | &#10004; |  |
| ``Purchaser.Account:read`` | &#10060; | Use ``Account:read`` |
| ``Purchaser.attributes:read`` | &#10071; | New permission, use instead of ``Customer.Attribute:read`` |
| ``Purchaser.billingAddress:read`` | &#10071; | New permission |
| ``Purchaser.EmailHistory:read`` | &#10060; | Use ``EmailHistory:read`` |
| ``Purchaser.Market:read`` | &#10060; | Use ``Market:read`` |
| ``Purchaser.NewsletterSubscription:read`` | &#10060; | Use ``NewsletterSubscription:read`` |
| ``Purchaser.Order:read`` | &#10060; | Use ``Order:read`` |
| ``Purchaser.Pricelist:read`` | &#10060; | Use ``Pricelist:read`` |
| ``Purchaser.Return:read`` | &#10060; | Use ``Return:read`` |
| ``Purchaser.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Purchaser.TaxClass:read`` | &#10060; | Use ``TaxClass:read`` |
| ``Purchaser.TotalOrder:read`` | &#10060; | Use ``Purchaser.totalOrders:read`` |
| ``Purchaser.totalOrders:read`` | &#10071; | New permission, use instead of ``Purchaser.TotalOrder:read`` |
| ``Return:read`` | &#10004; |  |
| ``Return.Account:read`` | &#10060; | Use ``Account:read`` |
| ``Return.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``Return.Comment:read`` | &#10060; | Use ``Return.comment:read`` |
| ``Return.comment:read`` | &#10071; | New permission, use instead of ``Return.Comment:read`` |
| ``Return.Order:read`` | &#10060; | Use ``Order:read`` |
| ``Return.OrderDiscount:read`` | &#10060; | Use ``Order:read`` |
| ``Return.Purchaser:read`` | &#10060; | Use ``Purchaser:read`` |
| ``Return.Shipment:read`` | &#10060; | Use ``Shipment:read`` |
| ``Return.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Return.Warehouse:read`` | &#10060; | Use ``Warehouse:read`` |
| ``ReturnLine.OrderLine:read`` | &#10060; | Use ``Order:read`` |
| ``ReturnLine.ShipmentLine:read`` | &#10060; | Use ``Shipment:read`` |
| ``SalesRepresentative:read`` | &#10004; |  |
| ``SalesRepresentative.Account:read`` | &#10060; | Use ``Account:read`` |
| ``SalesRepresentative.Commission:read`` | &#10060; | Use ``Commission:read`` |
| ``Shipment:read`` | &#10004; |  |
| ``Shipment.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``Shipment.Invoice:read`` | &#10060; | Use ``Invoice:read`` |
| ``Shipment.Order:read`` | &#10060; | Use ``Order:read`` |
| ``Shipment.OrderDiscount:read`` | &#10060; | Use ``Order:read`` |
| ``Shipment.Return:read`` | &#10060; | Use ``Return:read`` |
| ``Shipment.ShipmentPlugin:read`` | &#10060; | Use ``StorePlugin:read`` |
| ``Shipment.shippingAddress:read`` | &#10071; | New permission |
| ``Shipment.Store:read`` | &#10060; | Use ``Store:read`` |
| ``ShipmentLine.InvoiceLine:read`` | &#10060; | Use ``Invoice:read`` |
| ``ShipmentLine.OrderLine:read`` | &#10060; | Use ``Order:read`` |
| ``ShippingOption:read`` | &#10004; |  |
| ``ShippingOption.Comment:read`` | &#10060; | Use ``ShippingOption.comment:read`` |
| ``ShippingOption.comment:read`` | &#10071; | New permission, use instead of ``ShippingOption.Comment:read`` |
| ``ShippingOption.Market:read`` | &#10060; | Use ``Market:read`` |
| ``ShippingOption.ShippingPriceGroup:read`` | &#10060; | ShippingPriceGroup is a part of ShippingOption, use ``ShippingOption:read`` |
| ``ShippingOption.Store:read`` | &#10060; | Use ``Store:read`` |
| ``ShippingPriceGroup:read`` | &#10060; | ShippingPriceGroup is a part of ShippingOption, use ``ShippingOption:read`` |
| ``ShippingTerms:read`` | &#10004; |  |
| ``Size:read`` | &#10004; |  |
| ``Size.ProductSize:read`` | &#10060; | Use ``ProductSize:read`` |
| ``Size.SizeChart:read`` | &#10060; | Use ``SizeChart:read`` |
| ``SizeChart:read`` | &#10004; |  |
| ``SizeChart:write`` | &#10004; |  |
| ``StockChange:write`` | &#10004; |  |
| ``Store:read`` | &#10004; |  |
| ``Store.Affiliate:read`` | &#10060; | Use ``Affiliate:read`` |
| ``Store.AllocationRule:read`` | &#10060; | Use ``AllocationRule:read`` |
| ``Store.Brand:read`` | &#10060; | Use ``Brand:read`` |
| ``Store.Campaign:read`` | &#10060; | Use ``Campaign:read`` |
| ``Store.Category:read`` | &#10060; | Use ``Category:read`` |
| ``Store.Market:read`` | &#10060; | Use ``Market:read`` |
| ``Store.Order:read`` | &#10060; | Use ``Order:read`` |
| ``Store.Pricelist:read`` | &#10060; | Use ``Pricelist:read`` |
| ``Store.ShippingOption:read`` | &#10060; | Use ``ShippingOption:read`` |
| ``Store.StorePlugin:read`` | &#10060; | Use ``StorePlugin:read`` |
| ``Store.TaxGroup:read`` | &#10060; | TaxGroup is a group of TaxRules, use ``TaxRule:read`` |
| ``Store.TotalOrder:read`` | &#10060; | Deleted, Store.totalOrders is deprecated |
| ``Store.TotalPurchaser:read`` | &#10060; | Deleted, Store.totaPurchasers is deprecated |
| ``StorePlugin:read`` | &#10004; |  |
| ``StorePlugin.Store:read`` | &#10060; | Use ``Store:read`` |
| ``Subscription:read`` | &#10004; |  |
| ``Subscription.internalComment:read`` | &#10071; | New permission |
| ``SubscriptionPlan:read`` | &#10004; |  |
| ``SubscriptionPlan.internalComment:read`` | &#10071; | New permission |
| ``SubscriptionPlan:write`` | &#10004; |  |
| ``Supplier:read`` | &#10004; |  |
| ``Supplier.Address:read`` | &#10060; | Use ``Supplier.address:read`` |
| ``Supplier.address:read`` | &#10071; | New permission, use instead of ``Supplier.Address:read`` |
| ``Supplier.Comment:read`` | &#10060; | Use ``Supplier.comment:read`` |
| ``Supplier.comment:read`` | &#10071; | New permission, use instead of ``Supplier.Comment:read`` |
| ``Supplier.PaymentTerms:read`` | &#10060; | Use ``PaymentTerms:read`` |
| ``Supplier.ProductVariantSupply:read`` | &#10060; | Use ``ProductVariantSupply:read`` |
| ``Supplier.PurchaseOrder:read`` | &#10060; | Use ``PurchaseOrder:read`` |
| ``Supplier.PurchaseOrderDelivery:read`` | &#10060; | Use ``PurchaseOrderDelivery:read`` |
| ``Supplier.ShippingTerms:read`` | &#10060; | Use ``ShippingTerms:read`` |
| ``Supplier.Warehouse:read`` | &#10060; | Use ``Warehouse:read`` |
| ``TaxClass:read`` | &#10004; |  |
| ``TaxGroup:read`` | &#10060; | TaxGroup is a group of TaxRules, use ``TaxRule:read`` |
| ``TaxGroup.Store:read`` | &#10060; | Use ``Store:read`` |
| ``TaxGroup.TaxRule:read`` | &#10060; | Use ``TaxRule:read`` |
| ``TaxRule:read`` | &#10004; |  |
| ``Warehouse:read`` | &#10004; |  |
| ``Warehouse.AllocationRule:read`` | &#10060; | Use ``AllocationRule:read`` |
| ``Warehouse.Stock:read`` | &#10060; | Use ``Warehouse.stock:read`` and/or ``Warehouse.stockTotals:read`` |
| ``Warehouse.stock:read`` | &#10071; | New permission, use instead of ``Warehouse.Stock:read`` |
| ``Warehouse.stockTotals:read`` | &#10071; | New permission, use instead of ``Warehouse.Stock:read`` |
| ``Warehouse.WarehouseDelivery:read`` | &#10060; | Use ``WarehouseDelivery:read`` |
| ``WarehouseDelivery:read`` | &#10004; |  |
| ``WarehouseDelivery.AdminUser:read`` | &#10060; | Use ``AdminUser:read`` |
| ``WarehouseDeliveryLine.ShipmentLine:read`` | &#10060; | Use ``Shipment:read`` |
| ``WarehouseDeliveryLine.Warehouse:read`` | &#10060; | Use ``Warehouse:read`` |
| ``WarehouseDeliveryLine.WarehouseDelivery:read`` | &#10060; | Use ``WarehouseDelivery:read`` |


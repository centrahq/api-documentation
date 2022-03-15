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
* &#9989; ``Account:read``
* &#10060; ``Account.AddressBook:read`` – Address book is part of Account, use ``Account:read`` 
* &#10060; ``Account.AllocationRule:read`` – Use ``AllocationRule:read`` 
* &#10060; ``Account.Attribute:read`` – Use ``Account.attributes:read`` 
* &#10071; ``Account.attributes:read`` – New permission, use instead of ``Account.Attribute:read`` 
* &#10060; ``Account.Brand:read`` – Use ``Brand:read`` 
* &#10060; ``Account.DeliveryWindowDiscount:read`` – DeliveryWindowDiscount is a part of Account model, use ``Account:read`` 
* &#10060; ``Account.EmailHistory:read`` – Use ``EmailHistory:read`` 
* &#10060; ``Account.InternalComment:read`` – Use ``Account.internalComment:read`` 
* &#10071; ``Account.internalComment:read`` – New permission, use instead of ``Account.InternalComment:read`` 
* &#10060; ``Account.Invoice:read`` – Use ``Invoice:read`` 
* &#10060; ``Account.Market:read`` – Use ``Market:read`` 
* &#10060; ``Account.Order:read`` – Use ``Order:read`` 
* &#10060; ``Account.PaymentTerms:read`` – Use ``PaymentTerms:read`` 
* &#10060; ``Account.Pricelist:read`` – Use ``Pricelist:read`` 
* &#10060; ``Account.Purchaser:read`` – Use ``Purchaser:read`` 
* &#10060; ``Account.Return:read`` – Use ``Return:read`` 
* &#10060; ``Account.SalesRepresentative:read`` – Use ``SalesRepresentative:read`` 
* &#10060; ``Account.ShippingTerms:read`` – Use ``ShippingTerms:read`` 
* &#10060; ``Account.TaxClass:read`` – Use ``TaxClass:read`` 
* &#10060; ``Account.Warehouse:read`` – Use ``Warehouse:read`` 
* &#9989; ``Account:write``
* &#10060; ``AddressBook:read`` – AddressBook is a part of Account, use ``Account:read`` 
* &#10060; ``AdminDiscount.AdminUser:read`` – Use ``AdminUser:read`` 
* &#9989; ``AdminUser:read``
* &#10060; ``AdminUser.Account:read`` – Use ``Account:read`` 
* &#10060; ``AdminUser.Brand:read`` – Use ``Brand:read`` 
* &#10060; ``AdminUser.Email:read`` – Use ``AdminUser.email:read`` 
* &#10071; ``AdminUser.email:read`` – New permission, use instead of ``AdminUser.Email:read`` 
* &#10060; ``AdminUser.Market:read`` – Use ``Market:read`` 
* &#10060; ``AdminUser.Pricelist:read`` – Use ``Pricelist:read`` 
* &#10060; ``AdminUser.SalesRepresentative:read`` – Use ``SalesRepresentative:read`` 
* &#9989; ``Affiliate:read``
* &#10060; ``Affiliate.Order:read`` – Use ``Order:read`` 
* &#10060; ``Affiliate.Store:read`` – Use ``Store:read`` 
* &#9989; ``Allocation:read``
* &#9989; ``AllocationRule:read``
* &#10060; ``AllocationRule.Account:read`` – Use ``Account:read`` 
* &#10060; ``AllocationRule.DeliveryWindow:read`` – Use ``DeliveryWindow:read`` 
* &#10060; ``AllocationRule.GeographyAllocationPriority:read`` – GeographyAllocationPriority is a part of AllocationRule model, use ``AllocationRule:read`` 
* &#10060; ``AllocationRule.Market:read`` – Use ``Market:read`` 
* &#10060; ``AllocationRule.Store:read`` – Use ``Store:read`` 
* &#10060; ``AllocationRule.Warehouse:read`` – Use ``Warehouse:read`` 
* &#10060; ``AppliedDiscount.Discount:read`` – Use ``Discount:read`` 
* &#10060; ``AppliedDiscount.Order:read`` – Use ``Order:read`` 
* &#9989; ``Attribute:read``
* &#9989; ``Attribute:write``
* &#9989; ``Brand:read``
* &#10060; ``Brand.Product:read`` – Use ``Product:read`` 
* &#10060; ``Brand.Store:read`` – Use ``Store:read`` 
* &#9989; ``Brand:write``
* &#9989; ``BrickAndMortar:read``
* &#10060; ``BrickAndMortar.AllocationRule:read`` – Use ``AllocationRule:read`` 
* &#10060; ``BrickAndMortar.Store:read`` – Use ``Store:read`` 
* &#10060; ``BrickAndMortar.Warehouse:read`` – Use ``Warehouse:read`` 
* &#9989; ``Bundle:read``
* &#10060; ``Bundle.SizeChart:read`` – Use ``SizeChart:read`` 
* &#9989; ``Bundle:write``
* &#9989; ``Campaign:read``
* &#10060; ``Campaign.CampaignVariant:read`` – Use ``CampaignVariant:read`` 
* &#10060; ``Campaign.DeliveryWindow:read`` – Use ``DeliveryWindow:read`` 
* &#10060; ``Campaign.Market:read`` – Use ``Market:read`` 
* &#10060; ``Campaign.Pricelist:read`` – Use ``Pricelist:read`` 
* &#10060; ``Campaign.Store:read`` – Use ``Store:read`` 
* &#9989; ``Campaign:write``
* &#10060; ``CampaignVariant.Campaign:read`` – Use ``Campaign:read`` 
* &#10060; ``CampaignVariant:read`` – CampaignVariant is a part of Campaign, use ``Campaign:read`` 
* &#9989; ``Category:read``
* &#10060; ``Category.Display:read`` – Use ``Display:read`` 
* &#10060; ``Category.Store:read`` – Use ``Store:read`` 
* &#9989; ``Collection:read``
* &#10071; ``Collection.totalProducts:read`` – New permission 
* &#10060; ``Collection.Product:read`` – Use ``Product:read`` 
* &#9989; ``Collection:write``
* &#9989; ``Commission:read``
* &#10060; ``Commission.Invoice:read`` – Use ``Invoice:read`` 
* &#10060; ``Commission.Order:read`` – Use ``Order:read`` 
* &#10060; ``Commission.SalesRepresentative:read`` – Use ``SalesRepresentative:read`` 
* &#9989; ``Country:read``
* &#10060; ``Currency.Pricelist:read`` – Use ``Pricelist:read`` 
* &#10060; ``Currency.ShippingOption:read`` – Use ``ShippingOption:read`` 
* &#9989; ``Currency:read``
* &#10060; ``Customer.Attribute:read`` – Use ``Purchaser.Attribute:read`` 
* &#10060; ``Customer.EmailHistory:read`` – Use ``EmailHistory:read`` 
* &#9989; ``DeliveryWindow:read``
* &#10060; ``DeliveryWindow.AllocationRule:read`` – Use ``AllocationRule:read`` 
* &#10060; ``DeliveryWindow.Campaign:read`` – Use ``Campaign:read`` 
* &#10060; ``DeliveryWindow.DeliveryWindowVariant:read`` – Use ``DeliveryWindowVariant:read`` 
* &#10060; ``DeliveryWindow.Market:read`` – Use ``Market:read`` 
* &#9989; ``DeliveryWindow:write``
* &#10060; ``DeliveryWindowDiscount:read`` – DeliveryWindowDiscount is a part of Account model, use ``Account:read`` 
* &#10060; ``DeliveryWindowDiscount.Account:read`` – Use ``Account:read`` 
* &#10060; ``DeliveryWindowDiscount.DeliveryWindow:read`` – Use ``DeliveryWindow:read`` 
* &#10060; ``DeliveryWindowVariant:read`` – DeliveryWindowVariant is a part of DeliveryWindow model, use ``DeliveryWindow:read`` 
* &#10060; ``DeliveryWindowVariant.DeliveryWindow:read`` – Use ``DeliveryWindow:read`` 
* &#10060; ``DeliveryWindowVariant.Product:read`` – Use ``Product:read`` 
* &#10060; ``DeliveryWindowVariant.ProductVariant:read`` – Use ``ProductVariant:read`` 
* &#10060; ``DeliveryWindowVariant:write`` – DeliveryWindowVariant is a part of DeliveryWindow model, use ``DeliveryWindow:write`` 
* &#9989; ``Discount:read``
* &#10060; ``Discount.AdminUser:read`` – Use ``AdminUser:read`` 
* &#10060; ``Discount.AppliedDiscount:read`` – AppliedDiscount is a part of Order model, use ``Order:read`` 
* &#10060; ``Discount.GiftCertificateGenerator:read`` – Use ``GiftCertificateGenerator:read`` 
* &#10060; ``Discount.Market:read`` – Use ``Market:read`` 
* &#10060; ``Discount.Store:read`` – Use ``Store:read`` 
* &#9989; ``Display:read``
* &#10060; ``Display.Attribute:read`` – Unused 
* &#10060; ``Display.CampaignVariant:read`` – Use ``CampaignVariant:read`` 
* &#10060; ``Display.Category:read`` – Use ``Category:read`` 
* &#10060; ``Display.Comment:read`` – Use ``Display.comment:read`` 
* &#10071; ``Display.comment:read`` – New permission, use instead of ``Display.Comment:read`` 
* &#10060; ``Display.DisplayRelation:read`` – DisplayRelation is a part of Display model, use ``Display:read`` 
* &#10060; ``Display.Market:read`` – use ``Market:read`` 
* &#10060; ``Display.Price:read`` – Use ``Price:read`` 
* &#10060; ``Display.Product:read`` – Use ``Product:read`` 
* &#10060; ``Display.ProductMedia:read`` – Use ``ProductMedia:read`` 
* &#10060; ``Display.ProductVariant:read`` – Use ``ProductVariant:read`` 
* &#10060; ``Display.Store:read`` – Use ``Store:read`` 
* &#10060; ``Display.TaxGroup:read`` – Use ``TaxGroup:read`` 
* &#9989; ``Display:write``
* &#10060; ``DisplayRelation:write`` – DisplayRelation is a part of Display model, use ``Display:write`` 
* &#9989; ``DocumentTemplate:read``
* &#9989; ``EmailHistory:read``
* &#10060; ``EmailHistory.AdminUser:read`` – Use ``AdminUser:read`` 
* &#10060; ``EmailHistory.Order:read`` – Use ``Order:read`` 
* &#10060; ``EmailHistory.Purchaser:read`` – Use ``Purchaser:read`` 
* &#9989; ``Folder:read``
* &#10060; ``Folder.Product:read`` – Use ``Product:read`` 
* &#9989; ``Folder:write``
* &#10060; ``GeographyAllocationPriority:read`` – GeographyAllocationPriority is a part of AllocationRule model, use ``AllocationRule:read`` 
* &#9989; ``GiftCertificateGenerator:read``
* &#10060; ``GiftCertificateGenerator.Discount:read`` – Use ``Discount:read`` 
* &#10060; ``GiftCertificateGenerator.Store:read`` – Use ``Store:read`` 
* &#9989; ``Invoice:read``
* &#10071; ``Invoice.billingAddress:read`` – New permission 
* &#10071; ``Invoice.shippingAddress:read`` – New permission 
* &#10060; ``Invoice.Account:read`` – Use ``Account:read`` 
* &#10060; ``Invoice.AdminUser:read`` – Use ``AdminUser:read`` 
* &#10060; ``Invoice.Commission:read`` – Use ``Commission:read`` 
* &#10060; ``Invoice.PaymentTerms:read`` – Use ``PaymentTerms:read`` 
* &#10060; ``Invoice.Purchaser:read`` – Use ``Purchaser:read`` 
* &#10060; ``Invoice.ShippingTerms:read`` – Use ``ShippingTerms:read`` 
* &#10060; ``Invoice.Store:read`` – Use ``Store:read`` 
* &#10071; ``InvoiceLine.countryOfOrigin:read`` – New permission 
* &#10060; ``InvoiceLine.OrderLine:read`` – Use ``Order:read`` 
* &#10060; ``InvoiceLine.Product:read`` – Use ``Product:read`` 
* &#10060; ``InvoiceLine.ProductVariant:read`` – Use ``ProductVariant:read`` 
* &#10060; ``InvoiceLine.ShipmentLine:read`` – Use ``ShipmentLine:read`` 
* &#9989; ``Language:read``
* &#10060; ``Language.Country:read`` – Use ``Country:read`` 
* &#9989; ``Localization:read``
* &#9989; ``Localization:write``
* &#9989; ``Market:read``
* &#10060; ``Market.AllocationRule:read`` – Use ``AllocationRule:read`` 
* &#10060; ``Market.Campaign:read`` – Use ``Campaign:read`` 
* &#10060; ``Market.Comment:read`` – Use ``Market.comment:read`` 
* &#10071; ``Market.comment:read`` – New permission, use instead of ``Market.Comment:read`` 
* &#10060; ``Market.Country:read`` – Use ``Country:read`` 
* &#10060; ``Market.Store:read`` – Use ``Store:read`` 
* &#9989; ``MeasurementChart:read``
* &#9989; ``MeasurementChart:write``
* &#9989; ``MediaBatch:read``
* &#9989; ``MediaBatch:write``
* &#9989; ``NewsletterSubscription:read``
* &#10060; ``NewsletterSubscription.Country:read`` – Use ``Country:read`` 
* &#10060; ``NewsletterSubscription.ProductSize:read`` – Use ``ProductSize:read`` 
* &#10060; ``NewsletterSubscription.ProductVariant:read`` – Use ``ProductVariant:read`` 
* &#10060; ``NewsletterSubscription.Store:read`` – Use ``Store:read`` 
* &#9989; ``Order:read``
* &#10060; ``Order.Account:read`` – Use ``Account:read`` 
* &#10060; ``Order.Affiliate:read`` – Use ``Affiliate:read`` 
* &#10060; ``Order.Attribute:read`` – Use ``Order.attributes:read`` 
* &#10071; ``Order.attributes:read`` – New permission 
* &#10071; ``Order.billingAddress:read`` – New permission 
* &#10060; ``Order.Commission:read`` – Use ``Commission:read`` 
* &#10060; ``Order.DeliveryWindow:read`` – Use ``DeliveryWindow:read`` 
* &#10060; ``Order.Discount:read`` – Use ``Discount:read`` 
* &#10060; ``Order.EmailHistory:read`` – Use ``EmailHistory:read`` 
* &#10060; ``Order.InternalComment:read`` – Use ``Order.internalComment:read`` 
* &#10071; ``Order.internalComment:read`` – New permission, use  instead of ``Order.InternalComment:read`` 
* &#10060; ``Order.Market:read`` – Use ``Market:read`` 
* &#10060; ``Order.OrderDocument:read`` – Use ``Order:read`` 
* &#10060; ``Order.OrderHistory:read`` – Use ``OrderHistory:read`` 
* &#10060; ``Order.PaymentHistory:read`` – Use ``PaymentHistory:read`` 
* &#10060; ``Order.PaymentMethod:read`` – Use ``PaymentMethod:read`` 
* &#10060; ``Order.PaymentTerms:read`` – Use ``PaymentTerms:read`` 
* &#10060; ``Order.Pricelist:read`` – Use ``Pricelist:read`` 
* &#10060; ``Order.Purchaser:read`` – Use ``Purchaser:read`` 
* &#10060; ``Order.Return:read`` – Use ``Return:read`` 
* &#10060; ``Order.SalesRepresentative:read`` – Use ``SalesRepresentative:read`` 
* &#10060; ``Order.Shipment:read`` – Use ``Shipment:read`` 
* &#10071; ``Order.shippingAddress:read`` – New permission 
* &#10060; ``Order.ShippingPriceGroup:read`` – Use ``ShippingPriceGroup:read`` 
* &#10060; ``Order.ShippingTerms:read`` – Use ``ShippingTerms:read`` 
* &#10060; ``Order.Store:read`` – Use ``Store:read`` 
* &#10071; ``Order.userIP:read`` – New permission 
* &#9989; ``OrderHistory:read``
* &#10060; ``OrderHistory.AdminUser:read`` – Use ``AdminUser:read`` 
* &#10060; ``OrderHistory.Purchaser:read`` – Use ``Purchaser:read`` 
* &#10060; ``OrderLine.Brand:read`` – Use ``Brand:read`` 
* &#10060; ``OrderLine.Campaign:read`` – Use ``Campaign:read`` 
* &#10060; ``OrderLine.Category:read`` – Use ``Category:read`` 
* &#10060; ``OrderLine.Collection:read`` – Use ``Collection:read`` 
* &#10060; ``OrderLine.DeliveryWindow:read`` – Use ``DeliveryWindow:read`` 
* &#10060; ``OrderLine.Discount:read`` – Unused 
* &#10060; ``OrderLine.Display:read`` – Use ``Display:read`` 
* &#10060; ``OrderLine.Folder:read`` – Use ``Folder:read`` 
* &#10060; ``OrderLine.GiftCertificateGenerator:read`` – Use ``GiftCertificateGenerator:read`` 
* &#10060; ``OrderLine.InvoiceLine:read`` – Use ``InvoiceLine:read`` 
* &#10060; ``OrderLine.Product:read`` – Use ``Product:read`` 
* &#10060; ``OrderLine.ProductVariant:read`` – Use ``ProductVariant:read`` 
* &#10060; ``OrderLine.TaxGroup:read`` – TaxGroup is a group of TaxRules, use ``TaxRule:read`` 
* &#9989; ``PaymentHistory:read``
* &#10060; ``PaymentHistoryEntry.AdminUser:read`` – Use ``AdminUser:read`` 
* &#10060; ``PaymentHistoryEntry.StorePlugin:read`` – Use ``StorePlugin:read`` 
* &#9989; ``PaymentTerms:read``
* &#9989; ``Price:read``
* &#9989; ``Price:write``
* &#9989; ``Pricelist:read``
* &#10060; ``Pricelist.Campaign:read`` – Use ``Campaign:read`` 
* &#10060; ``Pricelist.Comment:read`` – Use ``Pricelist.comment:read`` 
* &#10071; ``Pricelist.comment:read`` – New permission, use instead of ``Pricelist.Comment:read`` 
* &#10060; ``Pricelist.Country:read`` – Use ``Country:read`` 
* &#10060; ``Pricelist.Price:read`` – Use ``Price:read`` 
* &#10060; ``Pricelist.ShippingOption:read`` – Use ``ShippingOption:read`` 
* &#10060; ``Pricelist.Store:read`` – Use ``Store:read`` 
* &#9989; ``Product:read``
* &#10060; ``Product.Attribute:read`` – Use ``Product.attributes:read`` 
* &#10071; ``Product.attributes:read`` – New permission, use instead of ``Product.Attribute:read`` 
* &#10060; ``Product.Attribute:write`` – Use ``Product.attributes:write`` 
* &#10071; ``Product.attributes:write`` – New permission, use instead of ``Product.Attribute:write`` 
* &#10060; ``Product.Brand:read`` – Use ``Brand:read`` 
* &#10060; ``Product.Bundle:read`` – Use ``Bundle:read`` 
* &#10060; ``Product.Collection:read`` – Use ``Collection:read`` 
* &#10060; ``Product.CountryOfOrigin:read`` – Use ``Product.countryOfOrigin:read`` 
* &#10071; ``Product.countryOfOrigin:read`` – New permission, use instead of ``Product.CountryOfOrigin:read`` 
* &#10060; ``Product.Display:read`` – Use ``Display:read`` 
* &#10060; ``Product.Folder:read`` – Use ``Folder:read`` 
* &#10060; ``Product.InternalComment:read`` – Use ``Product.internalComment:read`` 
* &#10071; ``Product.internalComment:read`` – New permission, use instead of ``Product.InternalComment:read`` 
* &#10060; ``Product.MeasurementTable:read`` – Use ``MeasurementChart:read`` 
* &#10060; ``Product.ProductMedia:read`` – Use ``ProductMedia:read`` 
* &#10060; ``Product.ProductVariant:read`` – Use ``ProductVariant:read`` 
* &#9989; ``Product:write``
* &#9989; ``ProductMedia:read``
* &#10060; ``ProductMedia.Product:read`` – Use ``Product:read`` 
* &#10060; ``ProductMedia:delete`` – Use ``ProductMedia:write`` 
* &#9989; ``ProductMedia:write``
* &#9989; ``ProductSize:read``
* &#10060; ``ProductSize.ProductVariant:read`` – Use ``ProductVariant:read`` 
* &#10060; ``ProductSize.PurchaseOrder:read`` – Use ``PurchaseOrder:read`` 
* &#10060; ``ProductSize.PurchaseOrderDelivery:read`` – Use ``PurchaseOrderDelivery:read`` 
* &#10060; ``ProductSize.Stock:read`` – Use ``ProductSize.stock:read`` and/or ``ProductSize.stockTotals:read`` 
* &#10071; ``ProductSize.stock:read`` – New permission, use instead of ``ProductSize.Stock:read`` 
* &#10071; ``ProductSize.stockTotals:read`` – New permission, use instead of ``ProductSize.Stock:read`` 
* &#10060; ``ProductSize.WarehouseDeliveryLine:read`` – Use ``WarehouseDelivery:read`` 
* &#9989; ``ProductVariant:read``
* &#10060; ``ProductVariant.Attribute:read`` – Use ``ProductVariant.attributes:read`` 
* &#10071; ``ProductVariant.attributes:read`` – New permission, use instead of ``ProductVariant.Attribute:read`` 
* &#10060; ``ProductVariant.Attribute:write`` – Use ``ProductVariant.attributes:write`` 
* &#10071; ``ProductVariant.attributes:write`` – New permission, use instead of ``ProductVariant.Attribute:write`` 
* &#10060; ``ProductVariant.CampaignVariant:read`` – CampaignVariant is a part of Campaign, use ``Campaign:read`` 
* &#10060; ``ProductVariant.Display:read`` – Use ``Display:read`` 
* &#10060; ``ProductVariant.InternalName:read`` – Use ``ProductVariant.internalName:read`` 
* &#10071; ``ProductVariant.internalName:read`` – New permission, use instead of ``ProductVariant.InternalName:read`` 
* &#10060; ``ProductVariant.Product:read`` – Use ``Product:read`` 
* &#10060; ``ProductVariant.ProductMedia:read`` – Use ``ProductMedia:read`` 
* &#10060; ``ProductVariant.ProductVariantSupply:read`` – Use ``ProductVariantSupply:read`` 
* &#10060; ``ProductVariant.PurchaseOrder:read`` – Use ``PurchaseOrder:read`` 
* &#10060; ``ProductVariant.PurchaseOrderDelivery:read`` – Use ``PurchaseOrderDelivery:read`` 
* &#10060; ``ProductVariant.SizeChart:read`` – Use ``SizeChart:read`` 
* &#10060; ``ProductVariant.Stock:read`` – Use ``ProductVariant.stock:read`` and/or ``ProductVariant.stockTotals:read`` 
* &#10071; ``ProductVariant.stock:read`` – New permission, use instead of ``ProductVariant.Stock:read`` 
* &#10071; ``ProductVariant.stockTotals:read`` – New permission, use instead of ``ProductVariant.Stock:read`` 
* &#9989; ``ProductVariant:write``
* &#9989; ``ProductVariantSupply:read``
* &#10060; ``ProductVariantSupply.PurchaseOrder:read`` – Use ``PurchaseOrder:read`` 
* &#10060; ``ProductVariantSupply.PurchaseOrderDelivery:read`` – Use ``PurchaseOrderDelivery:read`` 
* &#9989; ``PurchaseOrder:read``
* &#10060; ``PurchaseOrder.Address:read`` – Use ``PurchaseOrder.shippingAddress:read`` and/or ``PurchaseOrder.supplierAddress:read`` 
* &#10060; ``PurchaseOrder.InternalComment:read`` – Use ``PurchaseOrder.internalComment:read`` 
* &#10071; ``PurchaseOrder.internalComment:read`` – New permission, use instead of ``PurchaseOrder.InternalComment:read`` 
* &#10060; ``PurchaseOrder.PaymentTerms:read`` – Use ``PaymentTerms:read`` 
* &#10060; ``PurchaseOrder.PurchaseOrderDelivery:read`` – Use ``PurchaseOrderDelivery:read`` 
* &#10071; ``PurchaseOrder.shippingAddress:read`` – New permission, use instead of ``PurchaseOrder.Address:read`` 
* &#10060; ``PurchaseOrder.ShippingTerms:read`` – Use ``ShippingTerms:read`` 
* &#10060; ``PurchaseOrder.Supplier:read`` – Use ``Supplier:read`` 
* &#10071; ``PurchaseOrder.supplierAddress:read`` – New permission, use instead of ``PurchaseOrder.Address:read`` 
* &#10060; ``PurchaseOrder.Warehouse:read`` – Use ``Warehouse:read`` 
* &#9989; ``PurchaseOrderDelivery:read``
* &#10060; ``PurchaseOrderDelivery.AdminUser:read`` – Use ``AdminUser:read`` 
* &#10060; ``PurchaseOrderDelivery.PurchaseOrder:read`` – Use ``PurchaseOrder:read`` 
* &#10060; ``PurchaseOrderDelivery.Supplier:read`` – Use ``Supplier:read`` 
* &#10060; ``PurchaseOrderDelivery.Warehouse:read`` – Use ``Warehouse:read`` 
* &#10060; ``PurchaseOrderDelivery.WarehouseDelivery:read`` – Use ``WarehouseDelivery:read`` 
* &#10060; ``PurchaseOrderDeliveryLine.OrderLine:read`` – Use ``Order:read`` 
* &#10060; ``PurchaseOrderDeliveryLine.Product:read`` – Use ``Product:read`` 
* &#10060; ``PurchaseOrderDeliveryLine.ProductSize:read`` – Use ``ProductSize:read`` 
* &#10060; ``PurchaseOrderDeliveryLine.ProductVariant:read`` – Use ``ProductVariant:read`` 
* &#10060; ``PurchaseOrderLine.OrderLine:read`` – Use ``Order:read`` 
* &#10060; ``PurchaseOrderLine.Product:read`` – Use ``Product:read`` 
* &#10060; ``PurchaseOrderLine.ProductSize:read`` – Use ``ProductSize:read`` 
* &#10060; ``PurchaseOrderLine.ProductVariant:read`` – Use ``ProductVariant:read`` 
* &#9989; ``Purchaser:read``
* &#10060; ``Purchaser.Account:read`` – Use ``Account:read`` 
* &#10071; ``Purchaser.attributes:read`` – New permission, use instead of ``Customer.Attribute:read`` 
* &#10071; ``Purchaser.billingAddress:read`` – New permission 
* &#10060; ``Purchaser.EmailHistory:read`` – Use ``EmailHistory:read`` 
* &#10060; ``Purchaser.Market:read`` – Use ``Market:read`` 
* &#10060; ``Purchaser.NewsletterSubscription:read`` – Use ``NewsletterSubscription:read`` 
* &#10060; ``Purchaser.Order:read`` – Use ``Order:read`` 
* &#10060; ``Purchaser.Pricelist:read`` – Use ``Pricelist:read`` 
* &#10060; ``Purchaser.Return:read`` – Use ``Return:read`` 
* &#10060; ``Purchaser.Store:read`` – Use ``Store:read`` 
* &#10060; ``Purchaser.TaxClass:read`` – Use ``TaxClass:read`` 
* &#10060; ``Purchaser.TotalOrder:read`` – Use ``Purchaser.totalOrders:read`` 
* &#10071; ``Purchaser.totalOrders:read`` – New permission, use instead of ``Purchaser.TotalOrder:read`` 
* &#9989; ``Return:read``
* &#10060; ``Return.Account:read`` – Use ``Account:read`` 
* &#10060; ``Return.AdminUser:read`` – Use ``AdminUser:read`` 
* &#10060; ``Return.Comment:read`` – Use ``Return.comment:read`` 
* &#10071; ``Return.comment:read`` – New permission, use instead of ``Return.Comment:read`` 
* &#10060; ``Return.Order:read`` – Use ``Order:read`` 
* &#10060; ``Return.OrderDiscount:read`` – Use ``Order:read`` 
* &#10060; ``Return.Purchaser:read`` – Use ``Purchaser:read`` 
* &#10060; ``Return.Shipment:read`` – Use ``Shipment:read`` 
* &#10060; ``Return.Store:read`` – Use ``Store:read`` 
* &#10060; ``Return.Warehouse:read`` – Use ``Warehouse:read`` 
* &#10060; ``ReturnLine.OrderLine:read`` – Use ``Order:read`` 
* &#10060; ``ReturnLine.ShipmentLine:read`` – Use ``Shipment:read`` 
* &#9989; ``SalesRepresentative:read``
* &#10060; ``SalesRepresentative.Account:read`` – Use ``Account:read`` 
* &#10060; ``SalesRepresentative.Commission:read`` – Use ``Commission:read`` 
* &#9989; ``Shipment:read``
* &#10060; ``Shipment.AdminUser:read`` – Use ``AdminUser:read`` 
* &#10060; ``Shipment.Invoice:read`` – Use ``Invoice:read`` 
* &#10060; ``Shipment.Order:read`` – Use ``Order:read`` 
* &#10060; ``Shipment.OrderDiscount:read`` – Use ``Order:read`` 
* &#10060; ``Shipment.Return:read`` – Use ``Return:read`` 
* &#10060; ``Shipment.ShipmentPlugin:read`` – Use ``StorePlugin:read`` 
* &#10071; ``Shipment.shippingAddress:read`` – New permission 
* &#10060; ``Shipment.Store:read`` – Use ``Store:read`` 
* &#10060; ``ShipmentLine.InvoiceLine:read`` – Use ``Invoice:read`` 
* &#10060; ``ShipmentLine.OrderLine:read`` – Use ``Order:read`` 
* &#9989; ``ShippingOption:read``
* &#10060; ``ShippingOption.Comment:read`` – Use ``ShippingOption.comment:read`` 
* &#10071; ``ShippingOption.comment:read`` – New permission, use instead of ``ShippingOption.Comment:read`` 
* &#10060; ``ShippingOption.Market:read`` – Use ``Market:read`` 
* &#10060; ``ShippingOption.ShippingPriceGroup:read`` – ShippingPriceGroup is a part of ShippingOption, use ``ShippingOption:read`` 
* &#10060; ``ShippingOption.Store:read`` – Use ``Store:read`` 
* &#10060; ``ShippingPriceGroup:read`` – ShippingPriceGroup is a part of ShippingOption, use ``ShippingOption:read`` 
* &#9989; ``ShippingTerms:read``
* &#9989; ``Size:read``
* &#10060; ``Size.ProductSize:read`` – Use ``ProductSize:read`` 
* &#10060; ``Size.SizeChart:read`` – Use ``SizeChart:read`` 
* &#9989; ``SizeChart:read``
* &#9989; ``SizeChart:write``
* &#9989; ``StockChange:write``
* &#9989; ``Store:read``
* &#10060; ``Store.Affiliate:read`` – Use ``Affiliate:read`` 
* &#10060; ``Store.AllocationRule:read`` – Use ``AllocationRule:read`` 
* &#10060; ``Store.Brand:read`` – Use ``Brand:read`` 
* &#10060; ``Store.Campaign:read`` – Use ``Campaign:read`` 
* &#10060; ``Store.Category:read`` – Use ``Category:read`` 
* &#10060; ``Store.Market:read`` – Use ``Market:read`` 
* &#10060; ``Store.Order:read`` – Use ``Order:read`` 
* &#10060; ``Store.Pricelist:read`` – Use ``Pricelist:read`` 
* &#10060; ``Store.ShippingOption:read`` – Use ``ShippingOption:read`` 
* &#10060; ``Store.StorePlugin:read`` – Use ``StorePlugin:read`` 
* &#10060; ``Store.TaxGroup:read`` – TaxGroup is a group of TaxRules, use ``TaxRule:read`` 
* &#10060; ``Store.TotalOrder:read`` – Deleted, Store.totalOrders is deprecated 
* &#10060; ``Store.TotalPurchaser:read`` – Deleted, Store.totaPurchasers is deprecated 
* &#9989; ``StorePlugin:read``
* &#10060; ``StorePlugin.Store:read`` – Use ``Store:read`` 
* &#9989; ``Subscription:read``
* &#10071; ``Subscription.internalComment:read`` – New permission 
* &#9989; ``SubscriptionPlan:read``
* &#10071; ``SubscriptionPlan.internalComment:read`` – New permission 
* &#9989; ``SubscriptionPlan:write``
* &#9989; ``Supplier:read``
* &#10060; ``Supplier.Address:read`` – Use ``Supplier.address:read`` 
* &#10071; ``Supplier.address:read`` – New permission, use instead of ``Supplier.Address:read`` 
* &#10060; ``Supplier.Comment:read`` – Use ``Supplier.comment:read`` 
* &#10071; ``Supplier.comment:read`` – New permission, use instead of ``Supplier.Comment:read`` 
* &#10060; ``Supplier.PaymentTerms:read`` – Use ``PaymentTerms:read`` 
* &#10060; ``Supplier.ProductVariantSupply:read`` – Use ``ProductVariantSupply:read`` 
* &#10060; ``Supplier.PurchaseOrder:read`` – Use ``PurchaseOrder:read`` 
* &#10060; ``Supplier.PurchaseOrderDelivery:read`` – Use ``PurchaseOrderDelivery:read`` 
* &#10060; ``Supplier.ShippingTerms:read`` – Use ``ShippingTerms:read`` 
* &#10060; ``Supplier.Warehouse:read`` – Use ``Warehouse:read`` 
* &#9989; ``TaxClass:read``
* &#10060; ``TaxGroup:read`` – TaxGroup is a group of TaxRules, use ``TaxRule:read`` 
* &#10060; ``TaxGroup.Store:read`` – Use ``Store:read`` 
* &#10060; ``TaxGroup.TaxRule:read`` – Use ``TaxRule:read`` 
* &#9989; ``TaxRule:read``
* &#9989; ``Warehouse:read``
* &#10060; ``Warehouse.AllocationRule:read`` – Use ``AllocationRule:read`` 
* &#10060; ``Warehouse.Stock:read`` – Use ``Warehouse.stock:read`` and/or ``Warehouse.stockTotals:read`` 
* &#10071; ``Warehouse.stock:read`` – New permission, use instead of ``Warehouse.Stock:read`` 
* &#10071; ``Warehouse.stockTotals:read`` – New permission, use instead of ``Warehouse.Stock:read`` 
* &#10060; ``Warehouse.WarehouseDelivery:read`` – Use ``WarehouseDelivery:read`` 
* &#9989; ``WarehouseDelivery:read``
* &#10060; ``WarehouseDelivery.AdminUser:read`` – Use ``AdminUser:read`` 
* &#10060; ``WarehouseDeliveryLine.ShipmentLine:read`` – Use ``Shipment:read`` 
* &#10060; ``WarehouseDeliveryLine.Warehouse:read`` – Use ``Warehouse:read`` 
* &#10060; ``WarehouseDeliveryLine.WarehouseDelivery:read`` – Use ``WarehouseDelivery:read`` 


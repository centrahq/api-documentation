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

Please note, some fields don’t have permissions on nested fields yet (e.g. `Invoice.billingAddress`), they are accessible through the top type permission (e.g. `Invoice:read`). In the upcoming changes such fields will receive explicit permissions and the previous top type permissions will be marked as deprecated. It will only mean the permission is deprecated for this specific field, but the permission itself could be still active and it will be clearly stated in the new `deprecatedPermissionsUsed` section. For example, the query

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

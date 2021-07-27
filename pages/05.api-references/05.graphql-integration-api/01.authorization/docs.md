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

```
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

```
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
The list of permissions is changing as new permissions are added to match
new queries and mutations.

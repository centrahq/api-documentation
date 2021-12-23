---
title: Integrating Centra with an ERP system using GraphQL Integration API
altTitle: ERP integration with GQL
excerpt: Centra can be configured to integrate with your Enterprise Resource Planning system using GraphQL API. Click here to see how to perform most common operations on Products, Markets, Warehouses, Stock, Orders, Shipments and Returns in both B2B and B2C sales.
taxonomy:
  category: docs
---

In Centra, we strongly believe GraphQL is the future of the APIs, just like REST is the present and SOAP is the past. For that reason, we've been putting a lot of effort into building our GQL API into what we think will be the _last_ integration API you will ever need.

## GraphQL API introduction

All queries, mutations and examples are documented in [GraphQL Integration API reference](/api-references/graphql-integration-api).

GraphQL is used to Send a query to Centra API and get exactly what you need, nothing more and nothing less. GraphQL queries always return predictable results. Apps using GraphQL are fast and stable because they control the data they get, not the server.

## Quick note about API tokens

GraphQL is different from other Centra APIs, especially when it comes to authentication. Whereas both SOAP and REST APIs used shared API secret password to authenticate, identical for every API consumer, GQL authentication is based on personal API tokens. Each Production token should be assigned to a specific user name or an API function, and have only enough permissions to run the designed function. In QA, you are welcome to create test tokens will all permissions, but that is _only_ allowed for development purposes. Every time you make a GQL API call, the API response will include a full list of permissions that were used by this call. With this information, once you're done with testing, you can create a Production token with _minimal_ required permissions and re-test.

It is _not allowed_ to use a full-permissions API tokens in Production. This is simply not safe, as GraphQL gives you granular access to almost every part of Centra. It's also not allowed to share your tokens with others - every Centra admin user can create a new test token in a matter of seconds. Centra monitors the usage of those API tokens, so if you abuse those rules, we might contact you and ask that you address it.

For more information about generating and using API tokens, see the [authorization chapter of our GraphQL API docs](/api-references/graphql-integration-api/authorization).

# Cookbook

## Connection test - fetch Stores

https://docs.centra.com/graphql/query.html#stores

Before you proceed, follow the instructions above to obtain your own API token. In QA, you can start with an all-permissions token for yourself. To test the connection, we will fetch info about your Stores, since even an empty Centra setup will have at least one configured. This is a read only operation, nothing bad can happen.

[notice-box=alert]
Never use the integration you build towards a production Centra environment before it is thoroughly tested and verified to be working as intended!
[/notice-box]

#### Request

```sh
curl "${BASE_URL}/graphql" \
	    -X POST \
	    -H "Cookie: graphql-access=${ACCESS_TOKEN}" \
	    -H "Content-Type: application/json" \
	    -d '{"query": "{ stores{ id name } }"}'
```

Pretty:

```gql
{
  stores {
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
        "id": 1,
        "name": "Retail Store"
      },
      {
        "id": 2,
        "name": "Wholesale"
      }
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Store:read"
    ]
  }
}
```

As you can see, not only does GQL API return _precisely_ the data you asked for, nothing more, it also tells you which permissions were used, so that you know what your future Prod API key needs.

## Markets - read and create

https://docs.centra.com/graphql/query.html#markets

Markets in Centra decide which Products are visible to the API consumer. [Click here to learn more](https://docs.centra.com/overview/centra-overview#market).

### Fetching Markets

#### Request

```sh
curl "${BASE_URL}/graphql" \
	    -X POST \
	    -H "Cookie: graphql-access=${ACCESS_TOKEN}" \
	    -H "Content-Type: application/json" \
	    -d '{"query": "{ markets { id name assignedToCountries { code name isEU } } }"}'
```

Pretty:

```gql
{
  markets {
    id
    name
    assignedToCountries {
      code
      name
      isEU
    }
  }
}
```

#### Response

```json
{
  "data": {
    "markets": [
      {
        "id": 1,
        "name": "Sweden",
        "assignedToCountries": [
          {
            "code": "SE",
            "name": "Sweden",
            "isEU": true
          }
        ]
      },
      {
        "id": 2,
        "name": "USA",
        "assignedToCountries": [
          {
            "code": "US",
            "name": "United States",
            "isEU": false
          }
        ]
      },
      {
        "id": 3,
        "name": "World",
        "assignedToCountries": [
          {
            "code": "AX",
            "name": "Aland Islands",
            "isEU": false
          },
          {
            "code": "AL",
            "name": "Albania",
            "isEU": false
          },
          {
            "code": "AD",
            "name": "Andorra",
            "isEU": false
          },
          {
            "code": "AT",
            "name": "Austria",
            "isEU": true
          },

          // ...truncated

          ]
      },
      {
        "id": 4,
        "name": "Amazon",
        "assignedToCountries": []
      },
    ]
  },
  "extensions": {
    "complexity": 121,
    "permissionsUsed": [
      "Market:read",
      "Market.Country:read"
    ]
  }
}
```

As you can see, not all Markets have to be assigned to Countries. Some are hidden, like VIP sales, others (like Amazon) can be used in other ways.

Please note, reading Markets and reading Market Countries use different permissions. Remember, if your integration doesn't need to know about Market countries, there's no reason to enable that permission in your integration token setup.

### Creating new Markets

[TBD]

## Product Size Charts - read and create


---
title: Integration API (GraphQL)
---



> **Note**
>
> The GraphQL Integration API is still in Beta.


Integration API uses GraphQL for querying and manipulating data.

## What is GraphQL?
GraphQL is a trending alternative to RESTful APIs that pulls
all requested data for multiple entities with a single request.
It improves client-server interactions and reduces the latency that makes the
app much more responsive to the user.

GraphQL is used to Send a query to Centra API and get exactly what you need,
nothing more and nothing less. GraphQL queries always return predictable results.
Apps using GraphQL are fast and stable because they control the data they get,
not the server.

## Content Type

GraphQL Operates on JSON objects and therefore such content type should also be
used for requests' payload:

```http
POST *base*/graphql

Content-Type: application/json
```

## Requirements
- Live Centra
- Authentication token (see section `Authorization` how to obtain one)
- Correct permissions

## Read more

We recommend a further reading before starting using the GraphQL API:

- <a href="https://graphql.org" target="_blank">https://graphql.org/</a> - Official GraphQL website. A canonical source of knowledge.
- <a href="https://www.howtographql.com/" target="_blank">https://www.howtographql.com/</a> - Alternative introduction to GraphQL.
- <a href="https://relay.dev/graphql/connections.htm" target="_blank">https://relay.dev/graphql/connections.htm</a> - One of approaches for handling pagination in GraphQL (used by this API).

---
title: Shop API - Get Products IDs
altTitle: Get Products IDs
excerpt: Fetching a list of products ids.
taxonomy:
  category: docs
---
# Get product IDs

`GET  *base*/product-ids`

Fetches a list of all product IDs. This is a quicker API operation than [fetching all products](get-products) so it can be useful when e.g. comparing a list of products cached in the frontend to those in Centra.

## Response
`200` `Content-type: application/json`

[parameter datatype="array" isRequired=true storetype="b2b b2c" sublevel=1]
Product IDs for all active products in the store.
[/parameter]

## Response example

```http
HTTP/1.1 200 OK
Content-type: application/json

["123", "124", "125"]
```

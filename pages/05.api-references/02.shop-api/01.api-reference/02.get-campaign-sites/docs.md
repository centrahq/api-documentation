---
title: Shop API - Get Campaign Sites
altTitle: Get Campaign Sites
excerpt: Fetching a single or multiple campaign sites.
taxonomy:
  category: docs
---

# Get campaign sites

```text
GET  *base*/campaign-sites
```

```text
GET  *base*/campaign-sites/*campaignSiteURI*
```

Fetches a specific campaign site referenced by its name, or the **full** campaign sites list.

If the `campaignSiteURI` parameter is specified, one campaign site is fetched, otherwise **all campaign sites** are fetched.

## Parameters

[parameter data="campaignSiteURI" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
Campaign Site URI, unique key for this campaign site.
[/parameter]

## Response
`200` `Content-type: application/json`

[parameter data="campaignSiteURI" datatype="campaign site object" isRequired=false sublevel=1]
Campaign Site URI, unique key for this campaign site.
``"canada": {"name": "Canada"}`` for campaign site with URI ``canada``.
[/parameter]

[parameter data="name" datatype="string" sublevel=2]
The name of the campaign site.
[/parameter]

[parameter data="market" datatype="string" sublevel=2]
The market ID that should be set for the customer.
[/parameter]

[parameter data="goTo" datatype="string" sublevel=2]
The URL the customer should be redirected to after the market has been set.
[/parameter]

[parameter data="campaignSite" datatype="string" sublevel=2]
The URI for this campaign site.
[/parameter]

## Response example

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   {
      "canada" : {
         "market" : "16",
         "name" : "canada",
         "goTo" : "",
         "campaignSite" : "canada"
      }
   }
```

## Error example

```http
   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
      "errors" : {
         "campaignSite" : "not found"
      }
   }
```

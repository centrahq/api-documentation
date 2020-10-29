---
title: Shop API - GET Campaign Sites
altTitle: GET Campaign Sites
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

<!--
```eval_rst
.. api-name:: Shop API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/campaign-sites

.. endpoint::
   :method: GET
   :url: *base*/campaign-sites/*campaignSiteURI*

.. authentication::
   :api_key: true
```
-->

Fetches a specific campaign site referenced by its name, or the **full** campaign sites list.

If the `campaignSiteURI` parameter is specified, one campaign site is fetched, otherwise **all campaign sites** are fetched.

## Parameters

[parameter data="campaignSiteURI" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
Campaign Site URI, unique key for this campaign site.
[/parameter]

<!--
```eval_rst
.. list-table::
   :widths: auto

   * - ``campaignSiteURI``

       .. type:: string
          :required: false

     - Campaign Site URI, unique key for this campaign site.

```
-->

## Response
`200` `Content-type: application/json`

[parameter data="campaignSiteURI" datatype="campaign site object" isRequired=false storetype="b2b b2c" sublevel=1]
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

<!--
```eval_rst
.. list-table::
   :widths: auto

   * - object key

       .. type:: campaign site object
          :required: true

     - The ``campaignSiteURI`` for the campaign site object.

       ``"canada": {"name": "Canada"}`` for campaign site with URI ``canada``.

       .. list-table::
          :widths: auto

          * - ``name``

              .. type:: string

            - The name of the campaign site.

          * - ``market``

              .. type:: string

            - The market ID that should be set for the customer.

          * - ``goTo``

              .. type:: string

            - The URL the customer should be redirected to after the market has been set.

          * - ``campaignSite``

              .. type:: string

            - The URI for this campaign site.
```
-->


## Response example

```http request
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

<!--
```eval_rst
.. code-block:: http
   :linenos:

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
-->

## Error example

```http request
   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
      "errors" : {
         "campaignSite" : "not found"
      }
   }
```

<!--
```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
      "errors" : {
         "campaignSite" : "not found"
      }
   }
```
-->

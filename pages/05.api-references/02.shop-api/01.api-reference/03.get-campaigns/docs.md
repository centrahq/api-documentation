---
title: Shop API - GET Campaigns
altTitle: GET Campaigns
excerpt: Fetching a single or multiple campaigns.
taxonomy:
  category: docs
---

# Get campaigns

```text
GET  *base*/campaigns
```

```text
GET  *base*/campaigns/*campaignId*
```

<!--
```eval_rst
.. api-name:: Shop API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/campaigns

.. endpoint::
   :method: GET
   :url: *base*/campaigns/*campaignId*

.. authentication::
   :api_key: true
```
-->

Fetches a specific campaign referenced by its ID, or the **full** campaigns list.

If the `campaignId` parameter is specified, one campaign is fetched, otherwise **all campaigns** are fetched.

## Parameters

[parameter data="campaignId" datatype="int" isRequired=false storetype="b2b b2c" sublevel=1]
Campaign ID as integer.
[/parameter]

<!--
```eval_rst
.. list-table::
   :widths: auto

   * - ``campaignId``

       .. type:: int
          :required: false

     - Campaign ID as integer.

```
-->

## Response
`200` `Content-type: application/json`

[parameter data="campaignId" datatype="string" isRequired=true storetype="b2b b2c" sublevel=1]
The ``campaignId`` for the campaign object.
``"15": {"name": "Campaign X"}`` for campaign ID 15.
[/parameter]

[parameter data="name" datatype="string" sublevel=2]
The name of the campaign.
[/parameter]

[parameter data="campaign" datatype="string" sublevel=2]
The ID of the campaign.
[/parameter]

[parameter data="markets" datatype="object" sublevel=2]
A list of markets enabled for this campaign. The key values in the list are the market IDs.
``"markets": {"16": {...}}`` means an object for market ID 16.
[/parameter]

[parameter data="pricelists" datatype="object" sublevel=3]
A list of pricelists in the market activated in this campaign. The key values in the list are the pricelist IDs.
``"pricelists": {"17": {...}}`` means an object for pricelist ID 17.
[/parameter]

[parameter data="productsOnSale" datatype="array" sublevel=4]
An array with ``productIds`` currently in the campaign.
``"20": {"productsOnSale": ["123", "124"]}`` means the products with ID 123 and 124 is in a campaign for pricelist ID 20.
[/parameter]

<!--
```eval_rst
.. list-table::
   :widths: auto

   * - object key

       .. type:: brand object
          :required: true

     - The ``campaignId`` for the campaign object.

       ``"15": {"name": "Campaign X"}`` for campaign ID 15.

       .. list-table::
          :widths: auto

          * - ``name``

              .. type:: string

            - The name of the campaign.

          * - ``campaign``

              .. type:: string

            - The ID of the campaign.

          * - ``markets``

              .. type:: object

            - A list of markets enabled for this campaign. The key values in the list are the market IDs.

              ``"markets": {"16": {...}}`` means an object for market ID 16.

              .. list-table::
                 :widths: auto

                 * - ``pricelists``

                     .. type:: object

                   - A list of pricelists in the market activated in this campaign. The key values in the list are the pricelist IDs.

                     ``"pricelists": {"17": {...}}`` means an object for pricelist ID 17.

                     .. list-table::
                        :widths: auto

                        * - ``productsOnSale``

                            .. type:: array

                          - An array with ``productIds`` currently in the campaign.

                            ``"20": {"productsOnSale": ["123", "124"]}`` means the products with ID 123 and 124 is in a campaign for pricelist ID 20.

```
-->

## Response example

Fetching a list of campaigns:

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "5": {
        "name" : "Outlet",
        "campaign" : "5",
        "markets" : {
           "16" : {
              "pricelists" : {
                 "47" : {
                    "productsOnSale" : [
                       "2194",
                       "2172",
                       "1639",
                    ]
                 }
              }
           }
        }
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
     "5": {
        "name" : "Outlet",
        "campaign" : "5",
        "markets" : {
           "16" : {
              "pricelists" : {
                 "47" : {
                    "productsOnSale" : [
                       "2194",
                       "2172",
                       "1639",
                    ]
                 }
              }
           }
        }
     }
   }
```
-->

Fetching a specific campaign using `campaignId`:

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   {
      "name" : "Outlet",
      "campaign" : "5",
      "markets" : {
         "16" : {
            "pricelists" : {
               "47" : {
                  "productsOnSale" : [
                     "2194",
                     "2172",
                     "1639",
                  ]
               }
            }
         }
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
      "name" : "Outlet",
      "campaign" : "5",
      "markets" : {
         "16" : {
            "pricelists" : {
               "47" : {
                  "productsOnSale" : [
                     "2194",
                     "2172",
                     "1639",
                  ]
               }
            }
         }
      }
   }
```
-->

## Error example

```http
   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
       "errors" : {
          "campaign" : "not found"
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
          "campaign" : "not found"
       }
    }
```
-->

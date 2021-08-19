---
title: Order API - List customers
altTitle: List customers
excerpt: Return list of the customers.
taxonomy:
  category: docs
---

# List Customers

`GET *base*/customers`
Authentication : [API Key](/api-references/api-intro#authentication)

Return list of the customers.

## Parameters

[parameter data="limit" datatype="int" isRequired=false sublevel=1]
Limit amount of customers returned.
[/parameter]

[parameter data="offset" datatype="int" isRequired=false sublevel=1]
Offset how far in to start returning customers.
[/parameter]

[parameter data="email" datatype="string" isRequired=false sublevel=1]
Return a specific customer.
[/parameter]

[parameter data="created" datatype="date/datetime" isRequired=false sublevel=1]
Get all customers added after a certain date. Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="modified" datatype="date/datetime" isRequired=false sublevel=1]
Get all customers modified after a certain date. Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

`GET <base>/customers?limit=5&offset=5 HTTP/1.1`

<!--
```eval_rst
.. _order-api-list-customers-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="customers" datatype="array" isRequired=required sublevel=1]
Array of customers returned. 
[/parameter]


## Response example

```json
{
    "status": "ok",
    "customers": [
        {
            "customerId": "1",
            "email": "max.buch@example.com",
            "firstName": "Max",
            "lastName": "Buch",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "SE",
            "phoneNumber": "",
            "newsletter": true,
            "gender": "",
            "registered": false,
            "consents": [
                {
                    "key": "test_key1",
                    "name": "Consent1",
                    "consented": false,
                    "text": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley ",
                    "language": "",
                    "version": "",
                    "created": "2018-03-15 20:42:59",
                    "modified": "2018-03-15 20:42:59"
                }
            ],
            "created": "2018-03-15 20:42:59",
            "modified": "2018-03-15 20:42:59"
        },
        {
            "customerId": "6",
            "email": "felix.parker@example.com",
            "firstName": "Felix",
            "lastName": "Parker",
            "address1": "",
            "address2": "Forest st. 102",
            "zipCode": "95131",
            "city": "San Jose",
            "state": "CA",
            "country": "US",
            "phoneNumber": "",
            "newsletter": false,
            "gender": "",
            "registered": true,
            "consents": [],
            "created": "2018-03-15 20:42:59",
            "modified": "2018-03-15 20:42:59"
        }
    ]
}
```
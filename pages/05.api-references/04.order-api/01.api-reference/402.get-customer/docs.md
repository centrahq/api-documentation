---
title: Order API - Get Customer
altTitle: Get Customer
excerpt: Returning customer by specified ID
taxonomy:
  category: docs
---

# Get customer

`GET  *base*/customers/*customerId*`
Authentication : [API Key](/api-references/api-intro#authentication)

Return customer by specified ID.

## Parameters

[parameter data="customerId" datatype="int" isRequired=true sublevel=1]
The ``customerID`` from :ref:`List customers <order-api-list-customers>`.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
GET <base>/customers/4234 HTTP/1.1
```

<!--
```eval_rst
.. _order-api-get-customer-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="customer" datatype="object" isRequired=true sublevel=1]
The customer object.
[/parameter]

[parameter data="customerId" datatype="string" sublevel=2]
ID of the customer.
[/parameter]

[parameter data="email" datatype="string" sublevel=2]
Email for the customer.
[/parameter]

[parameter data="address1 address2 zipCode city state" datatype="string" sublevel=2]
The address of the customer
[/parameter]

[parameter data="country" datatype="string" sublevel=2]
The country of the customer. ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).
[/parameter]

[parameter data="consents" datatype="array" sublevel=2]
List of consents the customer has accepted. These consents are mostly created from external systems that can select their own data in these fields.
[/parameter]

[parameter data="key" datatype="string" sublevel=3]
The key for this specific consent.
[/parameter]

[parameter data="name" datatype="string" sublevel=3]
Name of consent.
[/parameter]

[parameter data="consented" datatype="boolean" sublevel=3]
If the customer has consented to this or not.
[/parameter]

[parameter data="text" datatype="string" sublevel=3]
The description of this consent.
[/parameter]

[parameter data="language" datatype="string" sublevel=3]
The language for this consent. No restrictions on the format of the language code.
[/parameter]

[parameter data="created" datatype="datetime" sublevel=2]
Date when the customer was created.
[/parameter]

[parameter data="newsletter" datatype="boolean" sublevel=2]
If the customer has opt-ed in for newsletters.
[/parameter]

[parameter data="modified" datatype="datetime" sublevel=2]
Date when the customer was modified.
[/parameter]

[parameter data="registered" datatype="boolean" sublevel=2]
If the customer was registered, which means it is allowed to sign in.
[/parameter]

## Response example

```json
{
    "status": "ok",
    "customer": {
        "customerId": "4",
        "email": "jon.snow@example.com",
        "firstName": "Jon",
        "lastName": "Snow",
        "address1": "Time Square 55",
        "address2": "",
        "zipCode": "2456",
        "city": "Tampa",
        "state": "LA",
        "country": "US",
        "phoneNumber": "096456192",
        "newsletter": true,
        "gender": "",
        "registered": false,
        "consents": [
            {
                "key": "test_key1",
                "name": "Consent1",
                "consented": true,
                "text": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley ",
                "language": "",
                "version": "1",
                "created": "2018-03-15 20:40:36",
                "modified": "2018-03-15 20:40:36"
            },
            {
                "key": "test_key2",
                "name": "Consent2",
                "consented": false,
                "text": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley ",
                "language": "EN",
                "version": "",
                "created": "2018-03-15 20:41:14",
                "modified": "2018-03-15 20:41:14"
            }
        ],
        "created": "2018-03-15 20:42:59",
        "modified": "2018-03-15 20:42:59"
    }
}
```

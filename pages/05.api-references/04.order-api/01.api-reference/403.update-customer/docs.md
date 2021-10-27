---
title: Order API - Update customer
altTitle: Update customer
excerpt: Update customer information.
taxonomy:
  category: docs
---

# Update customer

Endpoint: `PUT  *base*/customers/*customerId*`  
Authentication: [API Key](/api-references/api-intro#authentication)

Update customer information.

## Parameters

[parameter data="customerId" datatype="int" isRequired=true sublevel=1]
The ``customerID`` from :ref:`List customers <order-api-list-customers>`.
[/parameter]

[parameter data="firstName lastName ..." datatype="customer object"  sublevel=1]
The customer object 
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
PUT <base>/customers/4234 HTTP/1.1
Content-type: application/json

{
    "firstName": "Benjamin",
    "lastName": "Simon",
    "address1": "",
    "address2": "New Address2",
    "zipCode": "10500",
    "city": "BRIGHTON",
    "country": "US",
    "state": "CA",
    "phoneNumber": "9004505123",
    "gender": "",
    "consents": [
      {
        "key": "firts_con",
        "consented": true
      },
      {
        "key": "second_con",
        "consented": false,
        "version": "1.0",
        "language": "EN"
      }
    ]
}
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="customer" datatype="object" isRequired=true sublevel=1]
Customer object. The customer object is explained in :ref:`Get Customer Parameters <order-api-get-customer-response>`.
[/parameter]

## Response example

```json
{
  "status": "ok",
  "customer": {
      "customerId": "1",
      "email": "benjamin.simon@example.com",
      "firstName": "Benjamin",
      "lastName": "Simon",
      "address1": "",
      "address2": "New Address2",
      "zipCode": "10500",
      "city": "BRIGHTON",
      "state": "CA",
      "country": "US",
      "phoneNumber": "9004505123",
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
          },
          {
              "key": "firts_con",
              "name": "",
              "consented": true,
              "text": "",
              "language": "",
              "version": "",
              "created": "2018-03-21 12:17:54",
              "modified": "2018-03-21 12:17:54"
          },
          {
              "key": "second_con",
              "name": "",
              "consented": false,
              "text": "",
              "language": "EN",
              "version": "1.0",
              "created": "2018-03-21 12:17:54",
              "modified": "2018-03-21 12:17:54"
          }
      ],
      "created": "2018-03-15 20:42:59",
      "modified": "2018-03-15 20:42:59"
  }
}
```

## Error example

```json
{
  "status": "no",
  "msg": "The customer was not found."
}
```

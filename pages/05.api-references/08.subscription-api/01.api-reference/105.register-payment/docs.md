---
title: Subscription API - Register payment
altTitle: Register payment
excerpt: This will complete the subscription. Often called when user comes back to payment_url from /subscription/order. All GET/POST-params sent by the payment plugin needs to be attached to this call.
taxonomy:
  category: docs
---

# Register payment

```text
POST  *base*/subscription/payment
```

This will complete the subscription. Often called when user comes back to payment_url from /subscription/order. All GET/POST-params sent by the payment plugin needs to be attached to this call.

## Parameters

[parameter data="id" datatype="string" isRequired=true sublevel=1]
The subscription ID from :doc: [Create Subscription](/api-references/subscription-api/api-reference/create-subscription)
[/parameter]

[parameter data="payment" datatype="string" isRequired=true sublevel=1]
URI of payment plugin to be used. Needs to be set up before as a payment plugin for the store.
[/parameter]

[parameter data="all provider GET/POST params " datatype="any" isRequired=true sublevel=1]
Attach all GET/POST parameters sent from the payment provider to the ``payment_url`` from :doc: [Create Subscription](/api-references/subscription-api/api-reference/create-subscription). These will be used to validate if the payment was successful.
[/parameter]

## Request example

```http
    POST <base>/subscription/payment HTTP/1.1
    Content-Type: application/x-www-form-urlencoded
    
    id=3&payment=nets&[+all GET/POST params sent by payment provider]

```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
 ``ok`` if success, else a message explaining what went wrong.
[/parameter]

[parameter data="id" datatype="int" isRequired=true sublevel=1]
The ID of the subscription that was created.
[/parameter]

[parameter data="amount" datatype="decimal2 (0.00)" isRequired=true sublevel=2]
The total value of the subscription.
[/parameter]

[parameter data="shipping" datatype="decimal2 (0.00)" sublevel=2]
The shipping value for the first order of the subscription.
[/parameter]

[parameter data="itemCount" datatype="int" sublevel=2]
The total amount of products in the subscription.
[/parameter]

[parameter data="currency" datatype="string" sublevel=2]
The currency that the subscription was registered with, ``SEK``, ``USD``, ``EUR``, etc.
[/parameter]

[parameter data="address" datatype="object" sublevel=2]
An address object with the customer information.
[/parameter]

[parameter data="firstName lastName" datatype="string" sublevel=3]
The name of the customer.
[/parameter]

[parameter data="address coaddress city state zipcode phoneNumber" datatype="string" sublevel=3]
The customer's address information.
[/parameter]

[parameter data="country" datatype="string" sublevel=3]
The country of the customer. ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)
[/parameter]

[parameter data="createdAt" datatype="string" sublevel=2]
The date in ``Y-m-d H-i-s`` format when the subscription was created.
[/parameter]

[parameter data="startDate" datatype="string" sublevel=2]
The date in ``Y-m-d`` format when the subscription starts.
[/parameter]

[parameter data="nextOrderDate" datatype="string" sublevel=2]
The date in ``Y-m-d`` format when the subscription has next shipping.
[/parameter]

[parameter data="interval" datatype="int" sublevel=2]
The interval between each subscription. Depending on `intervaltype` it will be months or days.
[/parameter]

[parameter data="intervalType" datatype="string" sublevel=2]
The type of interval for the subscription
* ``Month`` interval is in months.
* ``Day`` interval is in days.        
[/parameter]

[parameter data="receipt" datatype="string" sublevel=2]
Html snippet that contains a receipt for a subscription payment. Is not null for Klarna payments.  
[/parameter]

[parameter data="error" datatype="boolean" sublevel=2]
If ``true``, the payment was not successful. The ``status`` should contain information on why. 
[/parameter]

## Response examples

```http
   HTTP/1.1 200 OK
   Content-type: application/json

      {
         "status": "ok",
         "id": 3,
         "amount": "900.00",
         "shipping": "20.00",
         "itemCount": 2,
         "currency": "SEK",
         "address": {
           "firstName": "Kalle",
           "lastName": "Anka",
           "phoneNumber": "+4687203333",
           "address1": "Malarvarvsbacken 8",
           "address2": "c/o Young Skilled AB",
           "zipCode": "11733",
           "city": "Stockholm",
           "state": "",
           "country": "SE"
         },
         "createdAt": "2020-05-05 15:00:00",
         "startDate": "2020-05-05",
         "nextOrderDate": "2020-05-06",
         "interval": 14,
         "intervalType": "Day",
         "receipt": "<div>...</div>"
       }
```

## Error example

```http
   HTTP/1.1 200 OK
   Content-type: application/json

    {
      "status": "Could not register customer",
      "error": true
    }
```
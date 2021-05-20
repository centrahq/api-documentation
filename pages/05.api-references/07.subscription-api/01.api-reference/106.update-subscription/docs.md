---
title: Subscription API - Update subscription
altTitle: Update subscription
excerpt: Update a subscription.
taxonomy:
  category: docs
---

# Update subscription

```text
PUT  *base*/subscription/subscription/*id*
```
Authentication : [API Key](/api-references/api-intro#authentication)

Update a subscription.

## Parameters

[parameter data="status" datatype="enum" isRequired=false sublevel=1]
Subscription status
       * ``active`` Subscription is active.
       * ``paused`` Subscription is paused.
       * ``cancelled`` Subscription is cancelled.
[/parameter]

## Request example

```http
    PUT *base*/subscription/subscription/*id* HTTP/1.1
    Content-Type: application/x-www-form-urlencoded
    
    status=active
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else a message explaining what went wrong.
[/parameter]

[parameter data="subscriptions" datatype="array" isRequired=true sublevel=1]
List of subscriptions
[/parameter]

[parameter data="status" datatype="string" isRequired=true sublevel=2]
The status of the subscription.
[/parameter]

[parameter data="id" datatype="int" isRequired=true sublevel=2]
The ID of the subscription.
[/parameter]

[parameter data="amount" datatype="decimal2 (0.00)" isRequired=true sublevel=2]
The total value of the subscription.
[/parameter]

[parameter data="shipping" datatype="decimal2 (0.00)" sublevel=2]
The shipping value of the subscription.
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

[parameter data="createdAt" datatype="string" sublevel=3]
The date in ``Y-m-d H-i-s`` format when the subscription was created.
[/parameter]

[parameter data="startDate" datatype="string" sublevel=3]
The date in ``Y-m-d`` format when the subscription starts.
[/parameter]

[parameter data="nextOrderDate" datatype="string" sublevel=3]
The date in ``Y-m-d`` format when the subscription has next shipping.
[/parameter]

[parameter data="interval" datatype="int" sublevel=3]
The interval between each subscription. Depending on `intervaltype` it will be months or days.
[/parameter]

[parameter data="intervalType" datatype="string" sublevel=3]
The type of interval for the subscription
* ``Month`` interval is in months.
* ``Day`` interval is in days.        
[/parameter]

[parameter data="pricelist" datatype="string" sublevel=3]
Subscription price list id.      
[/parameter]

[parameter data="packages" datatype="array" sublevel=3]
List of subscription packages. Contains packages IDs.   
[/parameter]

[parameter data="customer" datatype="string" sublevel=3]
Subscription customer id   
[/parameter]

## Response examples

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "status": "ok",
     "subscriptions": [
       {
         "status": "active",
         "id": 3,
         "amount": "900.00",
         "shipping": "20.00",
         "itemCount": 2,
         "currency": "SEK",
         "createdAt": "2020-05-05 15:00:00",
         "startDate": "2020-05-05",
         "nextOrderDate": "2020-05-06",
         "interval": 14,
         "intervalType": "Day",
         "pricelist": "19",
         "packages": ["1"],
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
         "customer": "132"
       }
     ]  
   }
```

## Error example

Subscription not found:

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "status": "Subscription not found",
     "error": true
   }
```

Invalid subscription status:

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "status": "Invalid status provided",
     "error": true
   }
```

Restore cancelled subscription error:

```http
   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "status": "Cannot restore cancelled subscription",
     "error": true
   }
```
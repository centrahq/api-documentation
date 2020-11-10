---
title: Subscription API - Create subscription
altTitle: Create subscription
excerpt: Add a subscription with payment details, will not be completed/registered as a completed subscription until `subscription/payment` has been called.
taxonomy:
  category: docs
---

# Create subscription

```text
POST  *base*/subscription/order
```

Add a subscription with payment details, will not be completed/registered as a completed subscription until `subscription/payment` has been called.
## Parameters

[parameter data="name sname" datatype="string" isRequired=true sublevel=1]
First and last name of the customer
[/parameter]

[parameter data="email" datatype="string" isRequired=true sublevel=1]
Customer e-mail
[/parameter]

[parameter data="address coaddress city state zipcode phoneNumber" datatype="string" isRequired=false sublevel=1]
Address information for the customer
[/parameter]

[parameter data="language" datatype="string" isRequired=false sublevel=1]
The language code for created customer.
[/parameter]

[parameter data="country" datatype="string" isRequired=true  sublevel=1]
The country of the customer. ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)
[/parameter]

[parameter data="package" datatype="array" isRequired=true sublevel=1]
Array with Package IDs for each package you want in the subscription.

For example: ``package[]=3232&package[]=4344``
[/parameter]

[parameter data="payment" datatype="string" isRequired=true sublevel=1]
URI of payment plugin to be used. Needs to be set up before as a payment plugin for the store.

.. note:: There are only a few payment plugins that supports subscription services. Please make sure the payment plugin you set up allows it.
[/parameter]

[parameter data="payment_url" datatype="string" isRequired=false sublevel=1]
A url where the customer should be redirected to when payment is completed.
[/parameter]

[parameter data="pnr" datatype="string" isRequired=false sublevel=1]
The social security number for the user, used for some payment plugins to invoice the customer.
[/parameter]

[parameter data="sendNewsletter" datatype="boolean" isRequired=false sublevel=1]
If the user opted in to a newsletter subscription.
[/parameter]

[parameter data="startdate" datatype="datetime" isRequired=false sublevel=1]
Default ``today``. The date when the subscription should start. The first order will be created first after this date.
[/parameter]

[parameter data="interval" datatype="int" isRequired=false sublevel=1]
Default ``14``. The interval between each subscription. Depending on `intervaltype` it will be months or days.
[/parameter]

[parameter data="intervaltype" datatype="enum" isRequired=false sublevel=1]
Default ``D``. The type of interval for the subscription.

* ``M`` interval is in months.
* ``D`` interval is in days.
[/parameter]

[parameter data="consent" datatype="object" isRequired=false sublevel=1]
A list of consents the customer agreed to. The ``key`` of each item in the object is the key for the consent. If the consent key does not exists already, it will be added automatically.

For example like this: ``consent[newsletter_consent][consent_name]=boop``
[/parameter]

[parameter data="consent_name" datatype="string" sublevel=2]
The name of the consent.
[/parameter]

[parameter data="consent_text" datatype="string" sublevel=2]
The description of the consent.
[/parameter]

[parameter data="consent_version" datatype="string" sublevel=2]
The version of the consent.
[/parameter]

[parameter data="consent_language" datatype="string" sublevel=2]
The language of the consent. No validation is made on this field for the formatting of the language code.
[/parameter]


## Request example

```http
    POST <base>/subscription/order HTTP/1.1
    Content-Type: application/x-www-form-urlencoded
    
    name=Kalle&sname=Anka&address=Paradisäppelvägen+9&
    coaddress=&city=Ankeborg&state=&zipcode=12345&
    country=SE&email=kalle.anka@example.com&package[]=1&package[]=3&
    payment=nets[&pnr=880101-7845]&
    language=SV
```

Example Request with consents:

```http
    POST <base>/subscription/order? HTTP/1.1
    Content-Type: application/x-www-form-urlencoded
    
    name=Kalle&sname=Anka&address=Paradisäppelvägen+9&coaddress=&
    city=Ankeborg&state=&zipcode=12345&country=SE&
    email=kalle.anka@example.com&package[]=1&package[]=3&
    payment=nets[&payment_url=https://...][&pnr=880101-7845]&
    language=SV&
    consent[direct_marketing]=1&
    consent_name[direct_marketing]=Direct%20Marketing&
    consent_version[direct_marketing]=1.1&
    consent[newsletter]=1&consent_name[newsletter]=Newsletter&
    consent_version[newsletter]=v2&consent_language[newsletter]=sv_SE
```
## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
 ``ok`` if success, else a message explaining what went wrong.
[/parameter]

[parameter data="id" datatype="int" isRequired=true sublevel=1]
The ID of the subscription that was created.
[/parameter]

[parameter data="payment" datatype="object" sublevel=1]
A payment object with information on how finalize the payment.
[/parameter]

[parameter data="url" datatype="string" sublevel=2]
A URL to redirect the user to. This could be to an external payment provider depending on the payment plugin.
[/parameter]

[parameter data="value" datatype="string" sublevel=2]
The total value of the subscription.
[/parameter]

[parameter data="currency" datatype="string" sublevel=2]
The currency that the subscription was registered with, ``SEK``, ``USD``, ``EUR``, etc.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response examples

```http
   HTTP/1.1 200 OK
   Content-type: application/json

    {
     "status": "ok",
     "id": 3,
     "payment": {
       "url": "https://...",
       "value": "123.50",
       "currency": "SEK"
     }
    }
```

## Error example

```json
   {
     "status": "Could not register customer",
     "error": true,
     "errors": [
       "email",
       "payment"
     ]
   }
```

Bad payment method:

```json
   {
        "status": "Bad Payment Method",
        "error": true,
        "message": "Error message"
  }
```


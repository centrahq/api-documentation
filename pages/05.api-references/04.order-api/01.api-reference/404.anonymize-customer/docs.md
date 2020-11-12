---
title: Order API - Anonymize Customer
altTitle: Anonymize Customer
excerpt: Anonymizing all personal data for a customer identifed by the customer id.
taxonomy:
  category: docs
---

# Anonymize customer

```text
PUT  *base*/anonymize-customer/*customerId*
```
Authentication : [API Key](/api-references/api-intro#authentication)

This endpoint will anonymize all personal data for a customer identifed by the customer id.

[notice-box=alert]This is irrevocable. Personal data will be permanently deleted. This may include financial data. Invoices due to legal requirements will NOT be anonymized.[/notice-box]

## Parameters

[parameter data="customerId" datatype="int" isRequired=true storetype="b2b b2c" sublevel=1]
The ``customerID`` from :ref:`List customers <order-api-list-customers>`.
[/parameter]

## Request example

```http
   PUT <base>/anonymize-customer/123 HTTP/1.1
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
The response if the anonymization was successful or an error if ``status`` is ``no``.
[/parameter]

## Response example

```json
   {
     "status": "ok",
     "msg": "The personal data has been anonymized."
   }
```

## Error example

If the customer was not found:

```json
   {
     "status": "no",
     "msg": "The customer was not found."
   }
```

If the customer was already anonymized:

```json
   {
     "status": "no",
     "msg": "The personal data was already anonymized."
   }
```

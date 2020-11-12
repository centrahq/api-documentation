---
title: Order API -  Update order
altTitle: Update order
excerpt: Update information on the order.
taxonomy:
  category: docs
---

# Update order

```text
PUT  *base*/orders
```
Authentication : [API Key](/api-references/api-intro#authentication)

Update information on the order.

## Parameters

[parameter data="order" datatype="int" isRequired=true sublevel=1]
Order ID to update
[/parameter]

[parameter data="internalComment" datatype="string" isRequired=false sublevel=1]
Append some text to internal comment field.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
   PUT <base>/orders HTTP/1.1
   Content-type: application/json

   {
     "order": 83651,
     "internalComment": "test"
   }
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="order" datatype="int" isRequired=true sublevel=1]
Order ID that was updated
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response example

```json
  {
     "status": "ok",
     "order": 83651
   }
```



## Error example

```json
{
     "status": "no",
     "msg": "order in wrong market",
     "order": 83651
   }
```

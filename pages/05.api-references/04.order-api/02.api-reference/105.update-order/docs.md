---
title: Order API -  Update order
altTitle: Update order
excerpt: Update information on the order.
taxonomy:
  category: docs
---

# Update order

Endpoint: `PUT  *base*/orders`  
Authentication: [API Key](/api-references/api-intro#authentication)

Update information on the order.

## Parameters

[parameter data="order" datatype="int" isRequired=true sublevel=1]
Order ID to update.
[/parameter]

[parameter data="internalComment" datatype="string" isRequired=false sublevel=1]
Append some text to the internal comment field.
[/parameter]

[parameter data="replaceInternalComment" datatype="boolean" isRequired=false sublevel=1]
Default `false`. Replace the full content of the internal comment field with the `internalComment`.
[/parameter]

[parameter data="comment" datatype="string" isRequired=false sublevel=1]
Append some text to the comment field.
[/parameter]

[parameter data="replaceComment" datatype="boolean" isRequired=false sublevel=1]
Default `false`. Replace the full content of the comment field with the `comment`.
[/parameter]

[parameter data="extraAttributes" datatype="object" isRequired=false sublevel=1]
Object for sending in custom order attributes.
[/parameter]

[parameter data="attributeName_elementName" datatype="any" isRequired=false sublevel=2]
List of key-value pairs for every attribute element you want to set. Send it as an empty string to remove the current content.
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

---
title: Order API - Update check first
altTitle: Update check first
taxonomy:
  category: docs
---

# Update Check First

Endpoint: `POST *base*/check-first`  
Authentication: [API Key](/api-references/api-intro#authentication)

This will update the status of a check-first warehouse on an order.

[notice-box=alert]
Updating a check first for an order is irreversible. Once an order has been accepted or rejected, it can no longer be changed.
[/notice-box]

## Parameters

[parameter data="orderNumber" datatype="int" isRequired=true sublevel=1]
Order ID to update the Check first.
[/parameter]
[parameter data="warehouseId" datatype="int" isRequired=true sublevel=1]
Warehouse ID associated with the Check first order.
[/parameter]
[parameter data="accepted" datatype="bool" isRequired=true sublevel=1]
Whether to accept or reject the Check First warehouse. ``true`` to accept, ``false`` to reject.
[/parameter]

## Request example

```http
POST <base>/check-first HTTP/1.1
Content-type: application/json

{
   "orderNumber": 123,
   "warehouseId": 321,
   "accepted": true
}
```

## Response

`200` `Content-type: application/json`
[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]
[parameter data="msg" datatype="string|object" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]
[parameter data="orderNumber" datatype="string" isRequired=false sublevel=2]
Error message describing an issue with the provided order number.
[/parameter]
[parameter data="warehouseId" datatype="string" isRequired=false sublevel=2]
Error message describing an issue with the provided warehouse id.
[/parameter]
[parameter data="accepted" datatype="string" isRequired=false sublevel=2]
Error message describing an issue with the provided accepted value.
[/parameter]

## Response example

```http
HTTP/1.1 200 OK
Content-type: application/json

{
   "status": "ok"
}
```
## Error examples

```json
{
   "status": "no",
   "msg": {
      "orderNumber": "invalid value",
      "warehouseId": "required",
      "accepted": "invalid value"
   }
}
```

```json
{
   "msg": "order does not exist",
   "status": "no"
}
```

```json
{
   "msg": "failed to allocate stock",
   "status": "no"
}
```
---
title: Order API - Update allocation request
altTitle: Update allocation request
taxonomy:
  category: docs
---

# Update allocation request

Endpoint: `PUT *base*/allocation-request`  
Authentication: [API Key](/api-references/api-intro#authentication)

This will update the status of an allocation request, which is pending for approval or rejection.

[notice-box=alert]
In Order API Plugin settings `Allow access to the following endpoints` Order API should have access to `Update allocation request (PUT /allocation-request)` endpoint.
[/notice-box]

[notice-box=alert]
Updating allocation request for an order is irreversible. Once an order has been accepted or rejected, it can no longer be changed.
[/notice-box]

## Parameters

[parameter data="id" datatype="int" isRequired=true sublevel=1]
Allocation request ID.
[/parameter]
[parameter data="status" datatype="string" isRequired=true sublevel=1]
Whether to accept or reject the allocation request for warehouse. 
Accepted values:``confirmed`` to accept, ``rejected`` to reject.
[/parameter]

## Request example

```http
PUT <base>/allocation-request HTTP/1.1
Content-type: application/json

{
    "id": 67,
    "status": "confirmed"
}
```

## Response

`200` `Content-type: application/json`
[parameter data="status" datatype="string" isRequired=true sublevel=1]
``true`` if success. ``false`` if failed.
[/parameter]
[parameter data="errorMessages" datatype="array" isRequired=false sublevel=1]
If ``status`` returns ``false``, this value will be not empty with a message why it failed.
[/parameter]

## Response example

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "success": true,
    "errorMessages": []
}
```
## Error examples

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "success": false,
    "errorMessages": [
        "You can't update allocation request, which is in status confirmed."
    ]
}
```
```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "success": false,
    "errorMessages": [
        "You can't update allocation request, which is in status rejected."
    ]
}
```

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "success": false,
    "errorMessages": [
        "Allocation request not found"
    ]
}
```

```json
{
    "success": false,
    "errorMessages": [
        "Warehouse doesn't have sufficient stock to allocate the request."
    ]
}
```

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "success": false,
    "errorMessages": [
        "Failed to allocate stock from the warehouse."
    ]
}
```

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "success": false,
    "errorMessages": {
        "status": "invalid value, expected 'confirmed' or 'rejected'"
    }
}
```

Missing access to endpoint: 
```http
HTTP/1.1 403 Forbidden
Content-type: application/json

{
  "status": "Not Allowed"
}
```

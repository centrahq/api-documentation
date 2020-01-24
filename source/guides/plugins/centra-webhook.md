# Centra Webhook

The Centra Webhook plugin allows you to create webhooks for certain events whenever data changes in Centra. This allows you to be notified and fetch data only when it is actually added or modified.

## Setup

You can find the webhook plugin under Webhooks in the plugin list.

These are the settings available for the webhook:

```eval_rst
.. image:: images/centra-webhook.png
   :scale: 50 %
```

We only allow the Webhook notification to be posted to HTTP or HTTPS using the ports 80 and 443.

You are allowed to set an Endpoint-secret to be able to validate that the webhooks are originating from Centra, you're also able to decide if we should validate your SSL-certificate or not.

## Webhook version

The first version released is webhooks aimed for when using the CheckoutAPI. The data inside the events sent as webhooks if formatted to simplify integration with the Checkout API.

For example: Whenever a product or a variant is modified in Centra, the webhook will actually send the Product Display Item ID for the items changed. 

If a product is not available or used at all in the store the plugin is installed on, there will be no webhook call at all. This makes it possible to use multiple stores and only get webhook events for the products in the store the plugin is installed in.

## Event triggers

In the webhook plugin set up, there's a list with event triggers that you can select. We will only send webhook notifications for the events you have subscribed to.

```eval_rst
.. image:: images/centra-webhook-event-triggers.png
   :scale: 50 %
```

For each event trigger there's a "Field Name", this is the key used in the payload as you will see below.

## Format

The webhook is sent as a regular POST-request using a urlencoded `payload`-parameter containing the JSON, like this:

```
POST /url HTTP/1.1
Host: example.com
X-Centra-Signature: t=15798...
Content-Type: application/x-www-form-urlencoded

payload=%7B%22products%22%3A...
```

The format of the webhook looks like this:

```json
{
  "products": ["52"],
  "categories": ["14", "16"],
  "anotherType": ["1"]
}
```

The webhook can send multiple updates for multiple types at the same time. It will always send an array of ID:s for each type. The key inside the JSON correlates with the "Field Name" in each event trigger in the webhook set up to receive.

Some modifications in Centra will trigger multiple types at the same time. If you for example sort products inside a category, when the new order is saved, the webhook will contain both the products that got their sorting changed, but also the category the sorting was changed in, like this:

```json
{
  "products": ["1","6","7"],
  "categories":["1"]
}
```

This allows you to write logic in your end depending on how you cache your data. In this case, you might want to recache the whole category, by fetching all products inside the category:

```sh
curl -X POST -H "Content-type: application/json" \
  -d '{"categories":["1"]}' \
  "https://example.centra.com/api/checkout/products"
```

## Signature verification

The endpoint secret inside the webhook plugin settings is used to generate a signature header called `X-Centra-Signature`. This signature can be used to validate that the webhook is actually sent by Centra and no one else.

This signature header contains two parameters, like this:

```
t=1579866370,v1=340a5be9321ad1b83dec05455650b6e174797a7267f48703ccdb7f251a8ba6c9
```

The timestamp is used to make sure a replay attack cannot be done, if someone would be able to get a valid signature. The `v1` contains a **HMAC-SHA256** based on the timestamp and the request body separated with a dot `.`.

You can parse this header value by splitting it on `,` and then splitting each value with `=`. The key `v1` contains the signature of the following values (with a dot `.` as the separator):

```
{timestamp}.{requestBody}
```

This means, if your endpoint signature was: `test123`, the timestamp inside `t` was `12345678` and the request body would look like this:

```
payload=%7B%22x%22%3A%22test%22%7D
```

The signature would be made of:

```
12345678.payload=%7B%22x%22%3A%22test%22%7D
```

And the header would look like this:

```
X-Centra-Signature: t=12345678,
  v1=0b9cd84f5d583e5e1aadfb9f160aa8080b51d5b85ff85808d6b75bdac356c549
```
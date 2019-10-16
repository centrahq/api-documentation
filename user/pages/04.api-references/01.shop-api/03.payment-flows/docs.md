---
title: Shop API payment flows
altTitle: Payment flows
excerpt: Learn how to properly implement payment flows in your webshop
taxonomy:
  category: docs
---

Since all payment plugins work differently we have a few scenarios when the website needs to handle to support all payment methods. These cases can occur when calling the `{selection}/payment` endpoint.

The basic logic for `{selection}/payment` is as follows:
* Check if `errors` is set, if so, something failed and a `message`-property should be there. If not, it’s a generic error.
* If no `errors`, there should be an `action` with either `redirect`, `form` or `success`.
* If `success`, the order is completed directly.

[notice-box=info]To make sure the proper user IP address is saved on the order, and to make the payment smoother in terms of fraud detection, it is highly recommended that you send your customer’s IPv4 address as ipAddress parameter in the /payment step. In case the end-user uses IPv6, but your store uses CloudFlare’s “Pseudo IPv4” functionality, you can instead use the IPv4 address provided by CloudFlare in Cf-Pseudo-IPv4 header.[/notice-box]

Here are the different methods and their properties depending on the type of payment method:

### Redirect to URL

We send:

```json
{
    "action": "redirect",
    "url": "https://example.com"
}
```

Website is supposed to redirect the user completely to this URL.

### Form POST

We send:
```json
{
    "action": "form",
    "formHtml": "<form method='post' action='https://example.com'><input type='hidden' name='field1' value='x' /></form><script>(autosubmit-code)</script>",
    "formFields": {"field1": "x", "field2": "y"},
    "formUrl": "https://example.com"
}
```

Website is supposed to inject the form or build it up with the params we send and auto submit it, which will redirect the user with the POST-data to the payment provider.

In some cases, the formHTML can be a HTML-widget, for example in Klarna Checkout. It will not actually submit a form, but showing a payment-iframe, in those cases, only action and formHTML is sent.

### Direct Success

We send:

```json
{
    "action": "success",
    "order": "12",
    "status": "untouched",
    "statusDescription": "Pending",
    ...
    "affiliateHtml": "<img src=pixel><script>...</script>"
}
```

Website is either supposed to show the receipt directly (since all information is attached) or redirect to the receipt and make a new call to `{selection}/receipt` to receive the same information again, like so:

```json
{
  "order": "12",
  "status": "untouched",
  "statusDescription": "Pending",
  ...
}
```

The `affiliateHtml` is supposed to be injected for the customer to run Google Analytics tracking and other custom scripts that the client needs to run on the receipt.

### Error

We send:

```json
{
  "messages": [
    "Always Fail! Could not connect with payment method."
  ],
  "errors": {
    "paymentMethod": "failed"
  }
}
```

Website is supposed to show a failed payment page, and also, if we sent a message-parameter, show the error message(s) to the customer.

### Payment result types

When the customer comes back to the website from the payment method, the website is supposed to send all variables it got to our API at `{selection}/payment-result`. We will then respond in different ways depending on the fields we get.

The basic logic for `{selection}/payment-result` is as follows:

* Check if errors is set, if so, something failed, a message-property should be there, if not it’s a generic error.
* If no errors, there might be an action which could contain only redirect (see below).
* Else, order should be set and the order is completed successfully.

Here are the following scenarios for `{selection}/payment-result`:

#### Success

We send the newly created order back in the response to show the receipt:

```json
{
  "order": "14",
  "status": "untouched",
  "statusDescription": "Pending",
  ...
}
```

Website is supposed to show the receipt directly or redirect the user to a receipt-page and make a call to `{selection}/receipt` which will show the same response.

#### Error

This is when we deny the payment before completing the order for some reason. Take paypal as an example; in order to streamline it nicely for the customer and show the proper amount directly, we need to validate that the country we got from Paypal is the same one as we have on the order. We send:

```json
{
  "code": "COUNTRY_MISMATCH",
  "message": "Please checkout with the same country as in Paypal.",
  "messages": [
    "Please checkout with the same country as in Paypal."
  ],
  "errors": {
    "paymentMethod": "COUNTRY_MISMATCH"
  }
}
```

We might also give a generic error, like this:

```json
{
  "message": "Sorry. Always fail.",
  "messages": [
    "Sorry. Always fail."
  ],
  "errors": {
    "paymentMethod": "failed"
  }
}
```

Website is supposed to show the message field to the customer. We also append the code so they can use a fixed field to identify what type of error it was (for example to highlight the country-selector).

#### Special case: redirect back to payment

This case was added lately when we noticed an error we got just as we were completing the order in Paypal (Error 10486). They actually even wrote an article just about this error and how to recover from it. In this case, we are able to return an action with redirect even on `{selection}/payment-result`. We’ve made this an Opt-In on the Paypal plugin for now, since we know that most of our integration partners do not yet support this, and since it’s really specific to the Paypal-API. (This might not be a problem in the new Express Checkout for Paypal.) We send:

```json
{
  "action": "redirect",
  "url": "http://..."
}
```

Website is supposed to redirect back to the URL, which will tell them they need to select a different payment method since the one they used did not work properly.

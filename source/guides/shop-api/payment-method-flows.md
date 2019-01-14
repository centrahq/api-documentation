# Payment method flows

Since all payment plugins works differently we have a few scenarios the website needs to handle to support all payment methods. These cases can occur when calling the `{selection}/payment`-endpoint.

The basic logic for `{selection}/payment` should be built like this:

1. Check if `errors` is set, if so, something failed, a `message`-property should be there, if not it's a generic error.
2. If no `errors`, there should be an `action` with either `redirect`, `form` or `success`.
3. If `success`, the order is completed directly.

Here are the different methods and their properties depending on the type of payment method:

### 1. Redirect to URL
We send:

```json
{
    "action": "redirect",
    "url": "https://example.com"
}
```

Website is supposed to redirect the user completely to this URL.

### 2. Form POST

We send:

```eval_rst
.. code-block:: json
   :linenos:

   {
       "action": "form",
       "formHtml": "<form method='post' action='https://example.com'><input type='hidden' name='field1' value='x' /></form><script>(autosubmit-code)</script>",
       "formFields": {"field1": "x", "field2": "y"},
       "formUrl": "https://example.com"
   }
```

Website is supposed to inject the form or build it up with the params we send and auto submit it, which will redirect the user with the POST-data to the payment provider.

In some cases, the formHTML can be a HTML-widget, for example on Klarna Checkout. It will not actually submit a form, but showing a payment-iframe, in those cases, only action and formHTML is sent.

### 3. Direct Success

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

Website is either supposed to show the receipt directly (since all information is attached) or redirect to the receipt and make a new call to `{selection}/receipt` to receive the same information again, like this:

```json
{
  "order": "12",
  "status": "untouched",
  "statusDescription": "Pending",
  ...
}
```

The `affiliateHtml` is supposed to be injected for the customer for running Google Analytics tracking and other custom script the client needs to run on the receipt.

### 4. Error

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

When the customer comes back to the website from the payment method, the website is supposed to send all variables it got to our API at `{selection}/payment-result`. Depending on the fields we get we will respond in different ways.

The basic logic for `{selection}/payment-result` should be built like this:

1. Check if `errors` is set, if so, something failed, a `message`-property should be there, if not it's a generic error.
2. If no `errors`, there might be an `action` which could contain only `redirect` (see below).
3. Else, `order` should be set and the order is completed successfully.

Here are the following scenarios for `{selection}/payment-result`:

#### 1. Success

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

#### 2. Error

This is when we for some reason will deny the payment before completing the order for some reason. For example, in Paypal, to streamline it nicely for the customer and to show the proper amount directly, we need to validate that the country we got from Paypal is the same one as we have on the order.
We send:

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

#### 3. Special case: redirect back to payment
This case was added lately when we noticed that one error we got just when we should complete the order in Paypal (Error 10486). They actually even wrote an article just about this error and how to recover from it.
In this case, we are able to return a action with redirect even on `{selection}/payment-result`. We have made this an Opt-In on the Paypal plugin for now, since we know that most of our integration partners do not yet support this, and since it's really specific to the Paypal-API. (This might not be a problem in the new Express Checkout for Paypal).
We send:

```json
{
  "action": "redirect",
  "url": "http://..."
}
```

Website is supposed to redirect back to the URL, which will tell them they need to select a different payment method since the one they used did not work properly.

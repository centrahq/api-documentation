---
title: QuickPay
altTitle: QuickPay
excerpt: Learn how to use QuickPay payment plugin.
taxonomy:
    category: docs
---

This is information about the plugin using QuickPay Payment Protocol v10. In Centra, the plugin is called "QuickPay v3".

### Gather information from QuickPay

![quickpay.png](quickpay.png)

You need the following data:

* The merchant ID in your account
* The private key for your merchant
* The agreement ID for your Payment Window
* The API-key for your Payment Window

In QuickPay, you will find this information under Settings / Integration:

![quickpay-menu.png](quickpay-menu.png)

And you will see both Merchant ID and Agreement ID, clicking the buttons will reveal the Private Key and the API-key:

![quickpay-settings.png](quickpay-settings.png)

### Create the plugin in Centra

Add `QuickPay v3` to your store you want to use it for. Insert the data gathered above and place it in the following fields:

![quickpay-centra-settings.png](quickpay-centra-settings.png)

Select if you want to pricelist/market/country restrict the plugin, then save.

The Payment Plugin will now show up as an option for the customers having the proper market/pricelist/country set.

The `/payment`-endpoint will respond with a `action=form` with a HTML-form to be submitted automatically when completing the order. You can also build up the form yourself using the `formFields` and `formUrl`-parameters.

```json
{
   "action": "form",
   "formHtml": "<form id=\"form-abc123\" action='https://payment.quickpay.net'>...",
   "formFields": {
       "version": "v10",
       "type": "payment",
       "merchant_id": "12345",
       "agreement_id": "654321",
       "language": "en",
       "order_id": "00033",
       "amount": 10000,
       "currency": "SEK",
       "continueurl": "https://yoursite.com/success",
       "cancelurl": "https://yoursite.com/fail",
       "callbackurl": "https://centra.com/xxx",
       "autocapture": "0",
       "autofee": "0",
       "payment_methods": "",
       "description": "",
       "checksum": "228202d7afacd0ecad5e42c16e032d120d1e752e754127d7be128c1a7dd85fb0"
   },
   "formUrl": "https://payment.quickpay.net"
}
```

The customer will either be redirected to the `paymentReturnPage` or the `paymentFailedPage` depending on the success of the payment.

### Testing

To test the flow, you first need to enable "Allow Test transactions" in QuickPay:

![quickpay-test.png](quickpay-test.png)

You also need enable Test Mode in the Centra-plugin. This is the only way to get test-payments approved.

[notice-box=alert]You will need to disable test-mode for the plugin in Centra when you run it in production.[/notice-box]

You can then use the [test-cards provided by QuickPay](https://learn.quickpay.net/tech-talk/appendixes/test/) to place test orders.

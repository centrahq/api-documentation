---
title: Using Centra CheckoutScript to update active KCO and Ingrid sessions
altTitle: Centra CheckoutScript
excerpt: Centra CheckoutScript, or an elegant way to handle event signalling between Centra and its plugins.
taxonomy:
  category: docs
---

## What is Centra CheckoutScript?

In the selection response, if Klarna Checkout or Ingrid are active on the selection, Centra will return an element called `centraCheckoutScript`. It registers an event for events triggered by the widgets which need to be passed down to Centra, and convenience functions for suspension and resume of the widgets. If you get the `centraCheckoutScript` in the selection response, you should add it to your page so that it's picked up.

### Events

Embed the script onto your page. You will also need to add an eventlistener for `centra_checkout_callback`, the job of that is to send the events it picks up back to Centra.

Below is an example of how the EventListener can look, where `var url` is your endpoint which sends the data as:
* `PUT {api-url}/selections/{selection}/checkout-fields` in Shop API, or
* `PUT {api-url}/payment-fields` in Checkout API.

```js
document.addEventListener('centra_checkout_callback', function(origdata) {
    var url = '{your-endpoint-which-does-PUT-checkout/payment-fields}'
    $.ajax(url, {
        method:"POST",
        data: origdata.detail,
        success: function(data) {
            // Ajax update data from response
            CentraCheckout.resume(origdata.detail.additionalFields.suspendIgnore);
        }
    });
});
```

### Suspend() and Resume()

When you change the selection in the checkout whilst Klarna Checkout or Ingrid plugin is loaded, they need to get updated with the same data Centra has, while Centra does most of the heavy lifting here, like sending data to the Klarna and Ingrid. Your website, however, needs to suspend and resume the widgets. The `CentraCheckout` object has functions for suspending and resuming both Klarna Checkout and Ingrid, depending on which are loaded from Centra. They are `CentraCheckout.suspend()` and `CentraCheckout.resume()` respectively.

Here's an example:

```js
// Perform quantity change of an selection line using ajax
function updateSelectionLine(lineID, data) {
	CentraCheckout.suspend() //suspend Klarna and Shipwallet
	$.ajax({my-endpoint}, { 
        method:"POST",
        data: origdata.detail,
        success: function(data) {
            updateCheckout(data) // Ajax update data from response
            CentraCheckout.resume();
        }
    });
}
```

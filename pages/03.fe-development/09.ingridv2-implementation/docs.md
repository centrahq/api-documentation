---
title: How to implement Ingrid v2 in your Checkout
altTitle: Ingrid v2 implementation
excerpt: Ingrid v2 provides the ability to present a shipping option widget in the checkout. Here is how to implement it.
taxonomy:
category: docs
---

Ingrid is a shipping platform that can be used together with Centra in order to present your shoppers with rich shipping options, including a number of delivery providers, address searching, support for free shipping vouchers and more.

In version 2 of Ingrid integration, it also comes with an optional address form feature which is used for collecting customer addresses and customer information required for delivery processing purposes. 
Built-in address form is designed to handle and validate regional address formats.

In order to enable address form feature on Ingrid side you should contact Ingrid support.

## Setting up the Ingrid plugin in Centra

To set up the Ingrid plugin, head to SYSTEM->STORES and choose the store you want to use Ingrid in. The minimum requirements for the plugin to work are the following:

1. A private key in the proper format (non-base64 encoded) is supplied,
2. A default locale is selected,
3. The plugin is active.

Also make sure that you are setting the `Test-Mode` option accordingly.

The settings in the plugin affect the integration in the following way:

- **Test**: If set to `yes` Centra will connect to Ingrid's `stage` environment, if set to `no` Centra will connect to Ingrid's `production` environment.
- **Default Locale**: The locale (language) the widget will be shown in by default, if a proper locale is set on the selection Centra will tell Ingrid to try to use the selection's language instead. If Ingrid doesn't support the locale on the selection, the default locale will be used.
- **Is address form feature enabled**: This feature is enabled by default - set to Yes. It signifies your confirmation that the address feature is activated for your Ingrid merchant account. Its function is to present an address form in the Ingrid widget, where customers can provide their address and information required for delivery processing purposes. Updates of the address information are sent to Centra using the Centra CheckoutScript, which handles client-side events.

[notice-box=info]
Before activating the plugin, please contact Ingrid support to enable this function on Ingrid's side.
[/notice-box]

- **Is Billing Form Feature Enabled**: This is set to No by default. If set to yes, it signifies your confirmation that the billing form feature is activated in Centra. To activate it in your Ingrid merchant account, please reach out to Ingrid.  Its function is to present a “Billing to” section and a “Same as delivery” checkbox in the Ingrid widget. If the checkbox is selected, it indicates that the billing address is the same as the delivery address. If the checkbox is unmarked, a separate billing form will be presented for customers to provide specific billing information. Updates to the address information are sent to Centra using the Centra CheckoutScript, which handles client-side events.

[notice-box=info]
Before enabling billing form feature setting in the plugin, please contact Ingrid support to enable it on Ingrid's side.
[/notice-box]

- **Suspend Ingrid widget on shipping option changed**: If set to `yes` Ingrid's widget will be put into a "loading state" whenever the shipping option is changed by the user until Centra has recevied the update. It is important that your front end picks up those changes and resumes the widget when ready.
- **Restrict pricelists**: Only use this plugin instance for the selected pricelist(s), empty means it's available for all.
- **Restrict markets**: Only use this plugin instance for the selected market(s), empty means it's available for all.
- **Restrict countries**: Only use this plugin instance for the selected shipping countries, empty means it's available for all.
- **Restrict locale**: Only use this plugin instance for the selected locale(s), empty means it's available for all.

![IngridPluginSettings](ingrid-v2-plugin.png)

Functionality of integration between Centra and Ingrid's Delivery Checkout v2 API:

- Presenting a widget in the checkout
- Optionally displaying address form and collecting customer addresses (enabled by default)
- The widget allows customer to select the preferred shipping option for the order
- Centra handles server side session with Ingrid via Delivery Checkout v2 API and saves completed Ingrid session attributes as Custom attributes on the order, needed for the merchant to be able to fulfill the order correctly based on the selected options

## Integration workflow

### Session initialization prerequisites

1. The Ingrid v2 plugin is configured on the same store the selection belongs to and activated
2. Selection is not empty and has at least one line
3. The requirements of locale, market, pricelist and country configured in the plugin are fulfilled

Centra will save the ID of the initialized Ingrid session, and update the shipping price according to the setup in Ingrid.

### When does Centra update Ingrid?

- All selection item and voucher updates are send as Ingrid session updates from Centra 
- Centra will update the shipping cost of the selection with the cost returned by Ingrid after the update.
- [*When address feature is disabled*] Address updates on the selection are only sent to Ingrid if they are made by the [PUT payment-fields](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/4.%20selection%20handling%2C%20checkout%20flow/put_payment_fields) endpoint in Centra's CheckoutAPI (or [PUT /selections/{selection}/checkout-fields](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/put_selections__selection__checkout_fields) in ShopAPI) and if the `Update address in Ingrid's widget from address stored on basket in Centra:` option in the Ingrid plugin is set to `On address pre-fill (default)`. This is to prevent Centra from overriding any choice made in the Ingrid widget by the user, which could cause a change of Shipping option, depending on the setup. If Centra already has address data at the time when the Ingrid session is created, this will be sent to Ingrid (since there is nothing to override).
- When Ingrid address form is updated and events are forwarded from Frontend to Centra
- On country / state change.
- All data is sent to Ingrid after the order is placed in Centra, including the final cart and customer address. Centra saves the data returned from Ingrid as `Custom Attributes` on the order.

### When does Ingrid update Centra?

In the checkout process, Centra checkout script listens to events emitted by the Ingrid widget and forwards them to Centra.

#### Events Tracked by Centra's Checkout Script

1. **"summary_changed" Event:** Triggered whenever there are updates in the summary details, such as changes in the delivery or billing addresses. On detecting this event, Centra's script sends an `ingrid_v2_address_change` event request to Centra to reflect these changes.

2. **"data_changed" Event:** Fires when there are modifications in the checkout data.
Centra's script scans for updates in several key attributes including: 
   - `delivery_type_changed`,
   - `external_method_id_changed`, 
   - `price_changed`, 
   - `search_address_changed`, 
   - `shipping_method_changed`

If any of these attributes have changes, an `ingrid_v2_shipping_option_changed` event request is sent to Centra.

## Fallback Form During Ingrid API Service Unavailability

Centra provides a fallback form when the Ingrid API service is unavailable under certain circumstances. This ensures the continuity of the customer checkout experience without interruption.

### Scenarios for Fallback Form Usage

The fallback form is presented in the following situations when the Ingrid API service is unavailable:

1. When a customer adds an item to an empty selection.
2. When a customer updates their selection.
3. When a customer changes their shipping/billing address.
4. When a customer changes their shipping option.

During these scenarios, Centra includes visible `address` and `shippingAddress` fields in the `paymentFields` response. The frontend implementation should use these fields to construct the fallback form.

### Error Response Indicating Fallback Form Usage

In response, the `selection.pluginFields` property contains the following object:

```json
"pluginFields": {
  "ingrid": {
    "version": 2,
    "error": "No Ingrid-session created",
    "deliveryOptionsAvailable": false
  }
}
```
This response indicates that the Ingrid widget is unavailable, which prompts the frontend to construct a fallback form. Frontend implementation should check for existence of `error` property in returned dictionary and if truthy, should fallback to a standard shipping form. Consequently, customers can continue with their checkout experience smoothly, even when the Ingrid API service is temporarily unavailable.

## Frontend implementation

#### Scenario 1: Address form feature in Ingrid enabled

1. Load Ingrid widget on the frontend
2. Customer fills in address in the widget or address is pre-filled by Ingrid automatically if it was stored in Ingrid's address book in the past
3. Address update is sent to Centra 

In this configuration address from Ingrid will be the one that is saved on the order in Centra.

#### Scenario 2: Address form feature in Ingrid enabled + "Address after payment" (Paypal / KCO / Qliro)

In `Address after payment` mode which is explained [here](https://docs.centra.com/fe-development/payments/handling-0-payments) the address on the order in Centra is the one that is filled in by customer in the PSP widget.
For Paypal this would be the customer's address coming from Paypal, for other solutions like KCO or Qliro, if any address has been entered to Ingrid - Centra will try to pre-fill PSP widget with address information.


[notice-box=alert]
Operating in this mode can cause different addresses on the order in Centra and Ingrid, as there is usually no way to control customer's input in the PSP widget's address form.
(with the exception of Qliro's `Lock customer information` option)
[/notice-box]

The example flow is following:

1. Ingrid widget is loaded on the frontend
2. Customer fills in address in the widget or address is pre-filled by Ingrid automatically if it was stored in Ingrid's address book in the past
3. Address update is sent from Ingrid to Centra (via client side events and Centra CheckoutScript)
4. Centra initiates KCO session and pre-fills address coming from Centra
5. Customer submits the address in KCO
6. Customer finalizes the payment in KCO
7. Order lands in Centra with address information from KCO

In this configuration address is propagated in following way: Ingrid -> Centra -> KCO
Note that if customer changes the address in KCO, then this updated address from Klarna will be the one visible on Centra order.

### Sending updates from Ingrid's widget to Centra

The Ingrid widget exposes a client side API for reacting to changes that happen in the widget.

In both Checkout API and Shop API Centra provides a `centraCheckoutScript` which wraps these and exposes them as Events that you should listen to and forward to Centra. This script is exposed as `selection.centraCheckoutScript` in CheckoutAPI and as `centraCheckoutScript` in the SelectionResponse in ShopAPI. If this script is present in the response you should embed it into the DOM on your Checkout page. After this you can access it via `window.CentraCheckout`

[notice-box=alert]
Important: Make sure that the widget you are interacting with has loaded properly before trying to initiate it, since the widget's exposed object on the browser's window must be present.
[/notice-box]

In addition to that you need to register an eventListener for `centra_checkout_callback`, where the callback should forward the `event.detail` data to [PUT payment-fields](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/4.%20selection%20handling%2C%20checkout%20flow/put_payment_fields).

```javascript
const sendEventToCentra = async (e) => {
  const res = await api.paymentFields.paymentFieldsUpdate(e.detail.detail, {
    token: getToken(),
    cancelToken: "paymentField-request",
  });
  window.CentraCheckout.resume(e.detail.additionalFields.suspendIgnore);
};

document.addEventListener("centra_checkout_callback", sendEventToCentra);
```

## Reflecting backend updates in the Ingrid widget

As Centra sends all cart updates to Ingrid the widget needs to know when it should load the lastest data from its backend. The same API that exposes the event listeners also provides a mechanism for suspending it and resuming the widget while a backend update happens: `window.centraCheckout.suspend()` and `window.centraCheckout.resume()` which should be called before and after a call to Centra has been made that modifies the cart.

Cart modifications are the following:

- Modifying the order items (changing quantity / removing) in the checkout,
- Adding a "cross-sell product" to cart in the checkout,
- Adding / removing a voucher in the checkout,
- Updating the address via [PUT payment-fields](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/4.%20selection%20handling%2C%20checkout%20flow/put_payment_fields), if the address form is used to initiate a payment widget.

Example:

```javascript

const itemUpdate = async (item, quantity) => {
    window.centraCheckout.suspend();
    await api.lines.linesUpdate(
        {
    		item,
    		quantity
        },
        token: getToken(),
    );
    window.centraCHeckout.resume();
}
```

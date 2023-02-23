---
title: How to implement Ingrid v2 in your Checkout
altTitle: Ingrid v2 implementation
excerpt: Ingrid v2 provides the ability to present a shipping option widget in the checkout. Here is how to implement it.
taxonomy:
category: docs
---

Ingrid is a shipping platform that can be used together with Centra in order to present your shoppers with rich shipping options, including a number of delivery providers, address searching, support for free shipping vouchers and more.
In version 2 of Ingrid integration, it also comes with address form feature which is used for collecting customer addresses and customer information required for delivery processing purposes. 
Built-in address form is designed to handle and validate regional address formats. 

## Setting up the Ingrid plugin in Centra

To set up the Ingrid plugin, head to SYSTEM->STORES and choose the store you want to use Ingrid in. The minimum requirements for the plugin to work are the following:

1. A private key in the proper format (non-base64 encoded) is supplied,
2. A default locale is selected,
3. The plugin is active.

Also make sure that you are setting the `Test-Mode` option accordingly.

The settings in the plugin affect the integration in the following way:

- **Test**: If set to `yes` Centra will connect to Ingrid's `stage` environment, if set to `no` Centra will connect to Ingrid's `production` environment.
- **Default Locale**: The locale (language) the widget will be shown in by default, if a proper locale is set on the selection Centra will tell Ingrid to try to use the selection's language instead. If Ingrid doesn't support the locale on the selection, the default locale will be used.
- **Is address feature enabled**: If set to `yes` Ingrid's widget will be put into a "loading state" whenever the shipping option is changed by the user until Centra has recevied the update. It is important that your front end picks up those changes and resumes the widget when ready.
- **Suspend Ingrid widget on shipping option changed**: If set to `yes` Ingrid's widget will be put into a "loading state" whenever the shipping option is changed by the user until Centra has recevied the update. It is important that your front end picks up those changes and resumes the widget when ready.
- **Update address in Ingrid's widget from address stored on basket in Centra**:
  [notice-box=info]
  Search address will not be used when address form is enabled (`Is address feature enabled=yes`). Following setting is only relevant when address form feature is disabled.
  [/notice-box]
  Centra will always try to populate the Ingrid widget with the selection address if Centra has received it before Ingrid, however other address updates will depend on this setting.
    - If set to `On address pre-fill (default)` the address the widget uses to present the shipping options will be updated from Centra on the [PUT /payment-fields endpoint](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/4.%20selection%20handling%2C%20checkout%20flow/put_payment_fields)
    - If set to `Only if Ingrid does not have an address set on the session` - prevents the [PUT /payment-fields endpoint](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/4.%20selection%20handling%2C%20checkout%20flow/put_payment_fields) from updating the address in the Ingrid session.
- **Restrict pricelists**: Only use this plugin instance for the selected pricelist(s), empty means it's available for all.
- **Restrict markets**: Only use this plugin instance for the selected market(s), empty means it's available for all.
- **Restrict countries**: Only use this plugin instance for the selected shipping countries, empty means it's available for all.
- **Restrict locale**: Only use this plugin instance for the selected locale(s), empty means it's available for all.

![IngridPluginSettings](ingrid-v2-plugin.png)

# Klarna Checkout v3 Payment Plugin

This is information about the plugin using Klarna Checkout v3.

## Gather information from Klarna Checkout

You need the following data:

* The E-Store ID for your Klarna store.
* The Shared Secret for your Klarna store.
* What region your account in Klarna is setup in, either EU or NA.

## Create the plugin in Centra

Add `Klarna Checkout v3` to your store you want to use it for. Insert the data gathered above and place it in the following fields:

```eval_rst
.. image:: images/klarna-keys.png
   :scale: 50 %
```

You can start testing the plugin using Test-Mode. Remember to also make sure the Endpoint of the plugin points to your region, and use `EU TEST` or `NA TEST` if you want to use the Test-Mode:

```eval_rst
.. image:: images/klarna-region.png
   :scale: 50 %
```

## Setup options

There are a lot of options in the Klarna Checkout plugin.

### Allow organizations to place orders

By enabling "Organization" you can allow businesses to also place orders using Klarna Checkout: 

```eval_rst
.. image:: images/klarna-person-types.png
   :scale: 50 %
```

### Allow separate shipping address

This allows the shipping address to be separate from what is used in Klarna.

```eval_rst
.. warning:: Only enable this if you are validating fraud outside of Klarna, as Klarna does not cover fraudulent orders if you bypass their shipping address for the customer.
```

```eval_rst
.. image:: images/klarna-shipping-address.png
   :scale: 50 %
```

### Send product images and URLs

You can enable product images and URLs to be sent to Klarna. Select the preferred image size to send to Klarna.

If you want URLs to the products, you can either provide the URL to the product when the product is added to the selection in the APIs, your you can define a `Frontend prefix` which will be combined with the category URI and display URI of the product from Centra.

```eval_rst
.. image:: images/klarna-product-urls.png
   :scale: 50 %
```

### Add external payment methods to Klarna

We currently only support Paypal to be added as an external payment option.

Since you can have multiple Klarna Checkout plugins based on different regions, each plugin you have created connects to a another specific payment plugin. This means, if you need Klarna Checkout to use different Paypal payment plugins for different regions, you need to create market/pricelist/country restricted plugins for Klarna that connects to different Paypal plugins.

```eval_rst
.. image:: images/klarna-external-payment-option.png
   :scale: 50 %
```

You can also make sure that Paypal does not show up as a separate payment, if it will be used inside Klarna Checkout.

```eval_rst
.. warning:: When using Klarna Checkout in test mode, you need to make sure the PayPal plugin you're using with it is configured to "Sandbox mode". Once your testing is done, you can disable test/sandbox mode on both plugins.
```

### Geo-restrictions

As with all payment plugins if you want to pricelist/market/country restrict the plugin you have the ability to select this in the bottom of the setup.

### Customization of Klarna Checkout widget

You are able to customize colors in Klarna Checkout widget - you are able to set colors of
- background of a button - setting "Color Button"
- text inside a button - setting "Color Button Text"
- background of a checkbox - setting "Color Checkbox"
- checkmark in a checkbox - setting "Color Checkbox Checkmark"
- headers - setting "Color Header"
- links - setting "Color Link"

```eval_rst
.. image:: images/klarna-colors-customization.png
   :scale: 50 %
```

### Testing

To test the flow, you first need to make sure the `Test-Mode` is enabled and that the `Klarna Endpoint` points to either `EU TEST` or `NA TEST` based on your Klarna Region setup.

```eval_rst
.. warning:: You will need to disable test-mode for the plugin in Centra when you run it in production.
```

You can then use the [test-users provided by Klarna](https://developers.klarna.com/en/testing/invoice-and-account) to place test orders.


### Required configuration

To make sure that your Klarna Checkout v3 plugin will work, please make sure that the following configuration fields are filled:
- E-Store ID
- Secret 
- Klarna Endpoint
- Default Locale
- Terms & Conditions-URL

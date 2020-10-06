# Adyen Checkout

The Adyen Checkout-plugin is a bit different from the existing Adyen-plugin in Centra.
<br />Adyen Checkout looks like this:
```eval_rst
.. image:: images/adyen-preview.png
   :scale: 30 %
```

### Flow

The flow works like this:

1. Customer fills in address information on the website.
2. When the customer is done, they can select a payment option.
3. If Adyen Checkout is selected (Most likely by showing the Credit Card-logos/Swish/Klarna or similar as the payment option) a call should be made to Centra using `POST /payment`.
4. Centra will initiate a Adyen Checkout-session and give back a HTML-snippet together with an indication that you actually got `adyen-checkout` in the response.
5. The website renders the HTML.
6. The customer fills in the information, or selects what payment method they want to use.
7. Adyen Checkout will decide itself between the following scenarios:
	* Finalize the payment and send the customer directly to the `paymentReturnPage` with parameters in the URL.
	* Finalize the payment and send the customer directly to the `paymentReturnPage` with POST-parameters.
	* Fail the payment and redirect the user to `paymentFailedPage`
	* Redirect to Adyen HPP (Hosted Payment Page) for payments that needs to be hosted on Adyen. After success, either redirected to `paymentReturnPage` or `paymentFailedPage` depending on the outcome. This includes any 3D-secure enabled payment methods.

### Implementation

The implementation requires Adyen Checkout only to be initiated after address information is collected by the website itself. The reason is the new [SCA (Strong Customer Authentication) ruling](https://stripe.com/docs/strong-customer-authentication) launching in September 2019.

This means that the `POST /payment` needs to happen after the address has been changed and after products have been decided. If the customer wants to modify their information or the cart, another `POST /payment` must be made after this is done. The reason we cannot modify it from Centra's side whenever the cart is modified is because the session-data coming back from Adyen to launch the Adyen Checkout contains all payment information inside the session-data for launching the Adyen Checkout itself.

If the customer tries to trick the checkout, by opening another tab to modify the cart, as soon as Centra gets the server notification call from Adyen, it will mark the order as "Payment mismatch" and set the order to "Hold". This is to prevent the order from ever being fulfilled if the payment amount does not match between the order and the payment from Adyen.

### Server communication

The Adyen Checkout needs its own Server Communication URL set up in Adyen. It will not use the same one as the old Adyen. If you use multiple Merchant Accounts in Adyen, you need one per Merchant Account pointing to one of the Adyen Checkout plugins inside Centra. If the Server Communication URL is not set up, all orders in Centra will never go out of "Waiting for Payment"-status and will be set as "Hold".

### Set up

**You need to contact Adyen Support at `support@adyen.com` to make sure they have activated Adyen Checkout for your Merchant Account before you begin.**

To validate that you are able to use the Adyen Checkout, go to Accounts -> API Credentials, look at your user called `ws@Company.[YourCompanyAccount]` and make sure that this role is enabled:

```eval_rst
.. image:: images/adyen-role.png
   :scale: 30 %
```

If it's not in the list, you need to contact Adyen to make them enable it.


First, create the plugin inside Centra. Select `Adyen Checkout` and set your own name for it. Also define a `uri`. This is the keyword used in the API to select it. You can have multiple plugins pointing to Adyen Checkout with the same `uri` if they are market/pricelist/country/language restricted for example, you can make sure you always use the same `uri` anyway.

```eval_rst
.. image:: images/adyen-setup.png
   :scale: 30 %
```

The `Merchant Account` should be set for the Merchant Account you want to use for this plugin.

The `API Username` and `API Password` should be for the Web Service user called `ws@Company.[YourCompanyAccount]` at:

* Adyen Test: `https://ca-test.adyen.com/ca/ca/config/api_credentials.shtml`
* Adyen Live: `https://ca-live.adyen.com/ca/ca/config/api_credentials.shtml`

The `API key` previously used for CSE (Client Side Encryption) is now also used for Adyen Checkout. [There's an article in Adyen Docs](https://docs.adyen.com/user-management/how-to-get-the-api-key/) on how to get it. 

```eval_rst
.. note:: It will be the same user and API-key for all your merchant accounts if you have more than one.
```

The `Notification URL` is used for the Server Communication from Adyen.

```eval_rst
.. warning:: You should set a Server communication URL for each Merchant Account you have. Make sure you have selected a Merchant Account in Adyen before you add it on the "Server Communication"-page.
```

```eval_rst
.. image:: images/adyen-merchant.png
   :scale: 50 %
```

To add a new Service Communication URL in Adyen, go to `Account` and then select `Server Communication`. Make sure that you have a Merchant Account selected (You should see "No merchant selected" in the top right of Adyen if you have not selected one) before you click `Add` on the "Standard Notification".

Enter the URL from the Adyen Checkout-plugin from Centra. If you are creating a new plugin, please save the plugin once and open it again to see the Notification URL.

The Notification URL should look something like this:

```
https://x.centra.com/api/adyen-checkout/1/?access-key=AABBCCDD
```

Make sure that:

1. It's using HTTPS
2. It's using your `*.centra.com`-subdomain (To make sure we can guarantee that it works).
3. It has a notification key that is complicated, use the auto generated one to make sure it's secure enough.

Now, copy the Notification URL into Adyen by selecting "Standard Notification":

```eval_rst
.. image:: images/adyen-notification.png
   :scale: 30 %
```

Make sure that:

1. You set it to `Active`
2. You select `HTTP POST`

Under "Authentication" you should write anything you like in "User Name" and "Password". We're currently using the `Notification Key` as the shared secret. *NB: This might change in the future, we'll let you know.*

Now, press "Test Configuration" to verify we respond successfully. After that you can press "Save Configuration".

Repeat this step for the Merchant Accounts you use with Centra and make sure each "Service Communication URL" you use points to a plugin with the same Merchant Account set. Also make sure that your Server Communication URL points to an active or inactive Adyen Checkout-plugin in Centra. If the plugin is disabled (red), the notification will not work.

### Live endpoint

Adyen Checkout uses unique domains for talking with their API both for the Checkout, but also for capturing, cancelling and refunding the payments, the format will be `[random]-[company name]`. [More info in Adyen Docs](https://docs.adyen.com/development-resources/live-endpoints/)

The live endpoint prefix is something you find inside your [Adyen-live account here](https://ca-live.adyen.com/ca/ca/config/accountapi.shtml):

```eval_rst
.. image:: images/adyen-urls.png
   :scale: 30 %
```

And it will look something like this:

```
7ff08825ff786a90-CentraCompany
```

You will define this for both Checkout and the standard payments endpoints in the plugin. These does only affect when Test Mode is off, in Test-Mode, the domains are the same for all customers.

```eval_rst
.. image:: images/adyen-live-endpoints.png
   :scale: 50 %
```

```eval_rst
.. warning:: Going live with Adyen Checkout is not possible unless you have the Live endpoint prefix set up. Payments and Adyen Checkout initialization will always fail.
```

#### Other configurations

You can decide other settings on the plugin as well:

```eval_rst
.. image:: images/adyen-additional-settings.png
   :scale: 30 %
```

The `Default Locale` defines which language it should use. `Send Billing Address`, `Send Delivery Address` and `Send Invoice Items` defines if we should send the information to Adyen. This should help for fraud detection.

You can also define if Adyen Checkout should be allowed for buying gift cards (if this is supported by the website). The gift cards are not being fulfilled by the warehouse, but directly issued and emailed to the customer if the payment goes through.

#### Market/Pricelist/Country/Language restrictions

You can also restrict the Adyen Checkout to only work for specified markets, pricelists, countries or languages. This is good if you want to use different Locales for the Adyen Checkout. You can use the same `uri` for the Adyen Checkout plugin using different restrictions.

### API

The Adyen Checkout plugin will show up in the API as a payment method:

```json
"adyen-checkout": {
    "paymentMethod": "adyen-checkout",
    "name": "Adyen Checkout",
    "useForDigitalContent": true,
    "providesCustomerAddressAfterPayment": false,
    "addressRequiredFields": [
        "email",
        "firstName",
        "lastName",
        "address1",
        "city",
        "zipCode",
        "country"
    ],
    "hasTermsAndConditionsAgreement": false,
    "clientSide": {
        "externalScript": "https://checkoutshopper-test.adyen.com/checkoutshopper/assets/js/sdk/checkoutSDK.1.9.5.min.js"
    }
},
```

The `clientSide->externalScript` is not needed, but if you want to load it before the Checkout, we still give you information about it here.

When you select the payment option, you make a `POST /selection/payment`. This step will validate that you have sent in the address information correctly. If everything is successful, the following information will be returned:

```json
{
    "action": "form",
    "formType": "adyen-checkout",
    "formFields": {
        "adyenSession": "eyJjaGVja291dHNob3BwZXJCYXNl..."
    },
    "formHtml": "<div id="adyen-checkout-container-v3123..."
}
```

You can decide here if you want either to initiate the Adyen Checkout by listening on the `formType`-field saying `adyen-checkout` and initiate your own Adyen Checkout using the `clientSide->externalScript` defined earlier, or render the `formHtml`.

The `formHTML` looks similar to this:

```html
<div id="adyen-checkout-container-RANDOM" class="adyen-checkout-container"></div>
<script id="adyen-session-RANDOM" data-return-url="RETURN-URL" type="application/json">SESSIONDATA</script>
<script>
function loadAdyenCheckout() {
    var newScript = document.createElement('script');
    newScript.async = true;
    newScript.src = 'https://checkoutshopper-test.adyen.com/...';
    newScript.onload = adyenCheckoutInit;
    document.children[0].appendChild(newScript);
}
function adyenCheckoutInit() {
    var randomId = 'RANDOM';
    var configurationObject = window.adyenCheckoutConfig || {
        autoFocusOnLoad: true,
        consolidateCards: true,
        context: 'test',
        initialPMCount: 5,
        paymentMethods: {
            card: {
                separateDateInputs: false,
                placeholders: {
                    encryptedSecurityCode: '1111',
                    encryptedExpiryDate: '02/12'
                }
            }
        }
    };
    var scriptObject = document.getElementById('adyen-session-' + randomId);
    var data = JSON.parse(scriptObject.textContent);
    var returnUrl = scriptObject.dataset.returnUrl;
    var checkout = chckt.checkout(data.paymentSession, '#adyen-checkout-container-RANDOM', configurationObject);
    chckt.hooks.beforeComplete = function (node, paymentData) {
        var f = document.createElement('form');
        f.method = 'post';
        f.action = returnUrl;
        f.style = 'position:absolute;left:-100px;top:-100px;';
        document.body.appendChild(f);
        var i = document.createElement('input');
        i.type = 'hidden';
        i.name = 'payload';
        i.value = paymentData.payload;
        f.appendChild(i);
        f.submit();
        return false;
    };
}
loadAdyenCheckout();
</script>
```

The form will:

1. Load the same script from Adyen specified in `clientSide->externalScript`.
2. When the script has loaded, launch the Adyen Checkout using settings from `window.adyenCheckoutConfig` or the predefined JSON.
3. When the checkout is completed by the customer, it will post a FORM-object to the `paymentReturnPage` with the encrypted blob payload.
4. The `paymentReturnPage` should always collect all URL-parameters from both the query string in the URL and the POST-data and send it to Centra. This is the way to validate if the payment went through successfully or not.

You need to make sure you insert the HTML into your DOM, and also make sure you evaluate the javascript from the response. One solution to do this in React is to inject the HTML into the DOM, then run the following code on it:

Insert HTML into DOM
```js
const checkoutContainer = document.getElementById('adyenCheckoutContainer'); // Reference to element already on page
checkoutContainer.innerHTML = data.formHtml;
evaluate($checkoutContainer);
```

Execute Javascript
```js
export const evaluate = (subtree: any, context: {} = window) => {
  function getSnippetType(script: any) {
    return script.type || '';
  }
  function getRawSnippet(script: any) {
    return script.text || script.textContent || script.innerHTML || '';
  }

  if (subtree) {
    try {
      const scripts = subtree.getElementsByTagName('script');
      const scriptsAsArray = Array.from(scripts).filter(script => getSnippetType(script) !== 'application/json');

      scriptsAsArray.forEach((script) => {
        const unescaped = getRawSnippet(script).replace(/\\/gi, '');
        eval.call(context, unescaped);
      });
    } catch (error) {
      // tslint:disable-next-line:no-console
      console.error('Catched error in evaluate function:', error);
    }
  }
};
```

This will make sure that:

1. You do not evaluate `type=application/json` blobs from Centra.
2. The proper snippet will run after the DOM has changed.

### Configuration of Adyen Checkout

As you see above, we use our own standard look of Adyen Checkout. If you like to have other settings, you can set the `window.adyenCheckoutConfig`-property in your DOM to override our suggested settings. [Here you can find information about what options you can set for Adyen Checkout Web SDK](https://docs.adyen.com/checkout/web-sdk/customization/).

### Capturing with Adyen Checkout

Capturing the payment with Adyen Checkout works a bit differently than the old Adyen plugin. Whenever you capture, the Payment Transaction-list in Centra will contain a `capture-request` instead. This is because Centra is actually waiting for the notification from Adyen to mark the order as captured successfully or not.

```eval_rst
.. note:: Remember, if you have `Capture Delay` in Adyen set to `immediate`, capture will ALWAYS fail in Centra. Our recommendation is that Centra should capture the payment instead. Please change the Capture Delay setting in Adyen by going to `Account` then select "Configure->Settings" and make sure you select the Merchant Account. In the settings page you will see `Capture Delay`. Set it to `Manual` or `7 days` to make sure Centra will control the capture event.
```

#### Capturing Swish payments

Due to the way Adyen API communicates with ours, you may encounter an issue of Swish payments not being correctly captured. In this scenario we send a capture request to Adyen, they respond with a message saying "Please reserve the order", but then never send us a message about the order being successfully completed. As a result, the order ends up in Centra with a "Waiting for payment" status.

```eval_rst
.. image:: images/order-wfp.png
   :scale: 30 %
```

```eval_rst
.. warning:: You should never process orders with status "Waiting for payment"!
```

These incomplete orders will likely never be properly captured. If they stay this way for a few hours, or a day, they should be manually cancelled in Centra. Centra admin should then decide on the follow-up action with the store user.

### Testing

To test the flow, you first need to make sure the `Test-Mode` is enabled and that the credentials inside the Centra plugin are taken from `ca-test.adyen.com` instead of `ca-live.adyen.com`.

```eval_rst
.. warning:: You will need to disable test-mode for the plugin in Centra when you run it in production.
```

You can then use the [test-cards provided by Adyen](https://docs.adyen.com/developers/development-resources/test-cards/test-card-numbers) to place test orders.

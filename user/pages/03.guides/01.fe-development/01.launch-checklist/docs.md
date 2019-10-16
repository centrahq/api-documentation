---
title: Webshop launch checklist
altTitle: Launch checklist
excerpt: Double-check the details and configs required (or recommended) when launching your webshop
taxonomy:
  category: docs
---

Here is a list of things to consider and make sure work when testing the site before going live using Shop or Checkout API.

### Needed from the Client

| Where | What |
| ---:| --- |
| Currencies | What currencies will the client use? |
| Payment Plugins | What payment methods will the client use? |
| | Are the payment plugins set up inside Centra? |
| | Are the payment plugins prepared for the currencies the client wants to sell with? |
| | Credentials for all payment plugins will be needed inside Centra. |
| Languages | Will the client translate their page from the start or later on? Or will they use an external Partner for this such as Translate.com? |
| Category structure | What type of category structure will the client use? |
| Filtering in frontend | Will the client use product filtering in the frontend? What should it filter on? |
| Modules | What modules will the client use? CMS? Google Map locator? |
| Integrations | What type of integrations will be used by the client in frontend? |
| | Customer loyalty (Abalon, Nosto etc?) |
| | Newsletter subscription (Rulemailer, Apsis, Carma?) |
| | Social Media (Storify, Instagram etc?) |

### Designs needed before launch

| Where | What |
| ---:| --- |
| Design | Make sure there is design for error message handling and 404s |
| | Any hosted payment pages that needs customization (Adyen, DIBS?) |

### Tests needed before launch

| Where | What | How |
| ---:| --- | --- |
| General | If a currency selector exists. | Verify that it works and that it is changing the currency. |
| General | If a language selector exists. | Verify that it works and that it is changing the language properly. Depending on the setup this might also change the currency. |
| | | Verify that it’s following the expected scenario for currency linking. |
| General | If a country selector exists. | Verify that changing country works. |
| | | See that it is changing the pricelist and the shipping country in the checkout. |
| | | Also verify that countries which are not present in the shipping lists are not present in the country selector. |
| | | You should not be able to place orders to countries that don’t exist in the shipping list and these contries don’t need to show up in the country selector. |
| Checkout | Verify that additional errors show up. | Make sure errors sent when using /selection/payment are visually shown in the checkout. |
| Checkout | Verify that the country selector works. | Verify that the shipping values and currency changes when switching country. |
| | | Also verify that the country selector is hiding countries that are not present in any active shipping list. If they are present anyway, they should be showing the customer an error message telling them that the country is not available to place orders for at the moment. |
| Checkout | Verify that default payment plugin works. | Customer should not be required to select a payment plugin if one is already selected. One should preferably be selected when customer visits the checkout the first time. |
| Checkout | Selecting a Payment Plugin. | Clicking the icon and text of the payment plugin should switch to that payment option. (You should not be limited to only press the radio button for each payment option). |
| Checkout | Selection listing removal check. | If you press the Remove item-button for the last item in the order, you should be presented with an “You’re about to clear your basket”-confirmation popup. |
| Checkout | Selection listing removal check. | If you lower the items for the last products to 0, you should get an “You’re about to clear your basket”-confirmation popup. |
| Checkout | Selection listing linking. | Products in the checkout and on the receipt should link back to the product. |
| Checkout | Payment option selection. | Verify that the customer can select different payment options, sometimes depending on the currency/country. Check in Centra under SYSTEM / STORES to verify what payment plugins that are available. Change the country in the checkout so you can see that the correct payment methods show up for that country. |
| | | Verify that you will be redirected correctly to each payment option and that correct payment methods are removed if a country which does not have them available is selected. |
| Checkout | Payment production settings. | Make sure all payment credentials exist for the production account for the client. Sometimes the payment provider needs to validate the checkout before going live (Klarna, Adyen CSE), make sure this is done so nothing prevents the site from going live. |
| Checkout | Verify that Geo-IP works as it should. | Verify that you get the country you are browsing from. |
| | | Verify that the language, shipping and pricelist settings are correct. |
| Checkout | Verify that country selector does not empty out the other address fields. | When changing country inside the Checkout, please check that the other fields are not being emptied out. This information should be unchanged when changing to another country. |
| Checkout | Payment failed-page. | When cancelling a payment at the payment method, you will get back to a payment failed Page, this one should at least have a “Back to checkout”-link on it. |
| Checkout | Payment failed-page back URL. | Verify that link back to checkout works. |
| Checkout | Verify changing country to another market (when the client is using multiple markets for different regions). | When changing country with a different market, some products might not be available in the new market. The customer should be notified that some items has changed in their selection. |
| Checkout | Verify that the shipping and pricelist settings are correct. | Do all of the active pricelists have a shipping list connected to them? |
| | | Is there a country in multiple shipping lists for multiple currencies? A country should mostly only be present in one shipping list since you want to control what currency a country can buy from. |
| Checkout | Do all of the active pricelists have a shipping list connected to them? | Is there a country in multiple shipping lists for multiple currencies? A country should mostly only be present in one shipping list since you want to control what currency a country can buy from. |
| Checkout | Saving data in fields when posting. | Is the address information inside the checkout still there when you go to a payment plugin and cancel that payment which redirects you back to the checkout? |
| Checkout | Google analytics and/or GTM + conversion are installed. | Make sure that conversions are registered in the analytics when orders are placed. |
| Product Page | Color select size memory. | Make sure that if a size is selected and you change color, that the selected size is remembered, but only if that size exists in the new color, else select none. |
| Product Page | Don’t need to select size on one-size-products. | If there’s only one size, remove the size selector completely, or make it selected per default. |
| Product Page | Different variant prices. | If there is different variant prices, is the price changed when a different variant is selected? |
| Product Page | Sold out size. | Is there any visual indication that a size is sold out? |
| Product Page | Selected size. | Is there any visual indication of what size is currently selected? |
| Product Page | Selected variant/color. | Is there any visual indication of what variant is currently selected? |
| Product Page | Adding of products. | When you’ve added a product, are you able to select and add another size for the same product? |
| Product Page | Adding of products. | When you’ve added a product, are you able to select and add another color for the same product? |

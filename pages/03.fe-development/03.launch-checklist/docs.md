---
title: Webshop launch checklist
altTitle: Launch checklist
excerpt: Double-check the details and configs required (or recommended) when launching your webshop.
taxonomy:
  category: docs
---

Here is a list of things to consider and make sure work when testing the site before going live using Shop or Checkout API.

### Needed from the Client

| Where | What |
| --- | --- |
| Currencies | What currencies will the client use? |
| Markets | How many Markets will be used? Are they all country-based, or are there any secret / VIP Markets to test, too? |
| Pricelists | How many Pricelists will be used? Is there just one or more Pricelists per Currency? |
| Payment Plugins | What payment methods will the client use? |
| | Are the payment plugins set up inside Centra? |
| | Are the payment plugins prepared for the countries the client wants to sell in? |
| | Are the payment plugins prepared for the currencies the client wants to sell with? |
| | Credentials for all payment plugins will be needed inside Centra. |
| Languages | Will the client translate their page from the start or later on? Or will they use an external Partner for this such as Translate.com? |
| Category structure | What type of category structure will the client use? |
| Filtering in frontend | Will the client use product filtering in the frontend? What should it filter on? |
| Modules | What modules will the client use? SOAP? Google Map locator? |
| Integrations | What type of integrations will be used by the client in frontend? |
| | Customer loyalty (Abalon, Nosto etc?) |
| | Newsletter subscription (Rulemailer, MailChimp, Apsis?) |
| | Social Media (Storify, Instagram etc?) |
| Media | What is the format of the Product images? How many image sizes will be used on the website? |
| Product feeds | Will you be integrating either with Google or Facebook feeds? |

### Designs needed before launch

| Where | What |
| --- | --- |
| Design | Make sure there is design for error message handling and 404s |
| | Any hosted payment pages that needs customization (Adyen, DIBS?) |
| | Will you offer 100% discounts? Does your payment setup support [payments with 0 total](/fe-development/payments/handling-0-payments)? Have you tested it? |
| Redirects | If a previous version of the webstore exists, should old URLs redirect to the new website? |

### Tests needed before launch

| Where | What | How |
| ---:| --- | --- |
| Product Catalog | Products active | Verify all desired Products are active on all levels (Product / Variant / Display) |
| | Images active | Verify all images are added to Products. If required, verify if all images are connected to appropriate Variants |
| | Prices set | Verify all Products have prices set in all appropriate Pricelists |
| | Stock available | Verify all Products have Stock levels set to values actually available in your Warehouse(s) |

| General | Currency selector | Verify that it works and that it is changing the currency. |
| | Language selector | Verify that it works and that it is changing the language properly. |
| | Country selector | Verify that changing country works. |
| | | See that it is changing the pricelist and the shipping country in the checkout. |
| | | Also verify that countries which are not present in the shipping lists are not present in the country selector. |
| | | You should not be able to place orders to countries that don’t exist in the shipping list and these contries don’t need to show up in the country selector. |
| Checkout | Verify that additional errors show up | Make sure errors sent when using /selection/payment are visually shown in the checkout. |
| | Verify that the country selector works | Verify that the shipping values and currency changes when switching country. |
| | | Also verify that the country selector is hiding countries that are not present in any active shipping list. If they are present anyway, they should be showing the customer an error message telling them that the country is not available to place orders for at the moment. |
| | Verify that default payment plugin works | Customer should not be required to select a payment plugin if one is already selected. One should preferably be selected when customer visits the checkout the first time. |
| | Selecting a Payment Plugin | Clicking the icon and text of the payment plugin, not just the radio button, should switch to that payment option. |
| | Selection listing removal check | If you press the Remove item-button for the last item in the order, you should be presented with an “You’re about to clear your basket”-confirmation popup. |
| | | If you lower the items for the last products to 0, you should get an “You’re about to clear your basket”-confirmation popup. |
| | Selection listing linking | Products in the checkout and on the receipt should link back to the product. |
| | Payment option selection | Verify that the customer can select different payment options, sometimes depending on the currency/country. Check in Centra under SYSTEM / STORES to verify what payment plugins that are available. Change the country in the checkout so you can see that the correct payment methods show up for that country. |
| | | Verify that you will be redirected correctly to each payment option and that correct payment methods are removed if a country which does not have them available is selected. |
| | Payment production settings | Make sure all payment credentials exist for the production account for the client. Sometimes the payment provider needs to validate the checkout before going live (Klarna, Adyen CSE), make sure this is done before the site is scheduled to go live. |
| | Verify that Geo-IP works as it should | Verify that you get the country you are browsing from. |
| | | Verify that the language, shipping and pricelist settings are correct. |
| | Verify that country selector does not empty out the other address fields | When changing country inside the Checkout, please check that the other fields are not being emptied out. This information should be unchanged when changing to another country. |
| | Payment failed-page | When cancelling a payment at the payment method, you will get back to a payment failed Page, this one should at least have a “Back to checkout”-link on it. |
| | Payment failed-page back URL | Verify that link back to checkout works. |
| | Verify changing country to another market (when the client is using multiple markets for different regions) | When changing country with a different market, some products might not be available in the new market. The customer should be notified that some items has changed in their selection. |
| | Verify that the shipping and pricelist settings are correct | Do all of the active pricelists have a shipping list connected to them? |
| | | Is there a country in multiple shipping lists for multiple currencies? A country should mostly only be present in one shipping list since you want to control what currency a country can buy from. |
| | Do all of the active pricelists have a shipping list connected to them? | Is there a country in multiple shipping lists for multiple currencies? A country should mostly only be present in one shipping list since you want to control what currency a country can buy from. |
| | Saving data in fields when posting | Is the address information inside the checkout still there when you go to a payment plugin and cancel that payment which redirects you back to the checkout? |
| | Payment widgets | Is the total the same in Klarna Checkout / Adyen Checkout as the summary from API? |
| | | Does total in Klarna Checkout / Adyen Checkout update accordingly when adding voucher, changing quantity of product, removing product, adding upsell product, changing shipping? |
| | Shipping widgets | Does total in Ingrid update accordingly when adding voucher, changing quantity of product, removing product, adding upsell product, changing shipping, does price / options change on country change as expected? |
| | Taxes | Is the tax value correct for different regions? |
| | | Are taxes applied correctly before and after checkout? |
| | Vouchers | Can voucher be added? |
| | | Can voucher be removed? |
| | Multiple vouchers | Does checkout support multiple vouchers? Can they be removed one by one? |
| | | Are vouchers applied in the right order? Multiple vouchers with the same priority set may give you unexpected results. |
| | | Do you have any vouchers that should not be combined with other vouchers? Do they have "no combine" setting properly applied? |
| | Google analytics and/or GTM + conversion | Make sure that conversions are registered in the analytics when orders are placed. |
| Product Page | Color select size memory | Make sure that if a size is selected and you change color, that the selected size is remembered, but only if that size exists in the new color, else select none. |
| | Don’t need to select size on one-size-products | If there’s only one size, remove the size selector completely, or make it selected per default. |
| | Different variant prices | If there is different variant prices, is the price changed when a different variant is selected? |
| | Sold out size | Is there any visual indication that a size is sold out? |
| | Selected size | Is there any visual indication of what size is currently selected? |
| | Selected variant/color | Is there any visual indication of what variant is currently selected? |
| | Adding of products | When you’ve added a product, are you able to select and add another size for the same product? |
| | | When you’ve added a product, are you able to select and add another color for the same product? |
| | Adding bundled products | If you use bundles, can a bundle be added to the basket? Are the items in the bundle listed correctly? |
| | Localization | Are Product descriptions and attributes translated to all appropriate languages? Are those translations returned correctly in the API? |

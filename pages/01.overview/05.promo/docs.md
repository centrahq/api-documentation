---
title: Cheaper is better: Vouchers, gift certificates and campaigns
altTitle: Promotions
excerpt: Learn about how Centra handles promotions: Vouchers, Gift Certificates and Campaigns.
taxonomy:
    category: docs
---

Centra allows store administrators to create many types of promotions, generate voucher codes, set up campaigns and cooperate with affiliates. Configuration of such promotions is separate for each Store in your Centra.

### Voucher

Vouchers allow to implement a number of different types of promotions - price discounts, free shipping, adding free products to the order, or "3 for the price of 2" kind of discount. Each Voucher is defined by its name, one Store and at least one Market it's enabled in, start and end dates for when it's valid, and maximum number of times the voucher can be used (which can be unlimited). Each voucher can be exclusive, meaning only one of them can be used at one time, or they can be configured to be combined with other vouchers.

There are three types of vouchers:  
1. Code vouchers - are activated when the user enters the appropriate promo code during checkout,
2. Auto vouchers - are activated when the user fulfills the voucher criteria, for example: free shipping for orders over 1000 SEK,
3. URL vouchers - are activated when the user navigates to the store using a pre-defined promo URL.

Every voucher has one or more actions (think of them as steps). Each action consists of one or more input criteria (like total order value, selection of specific product, selection of more than N products from category X, and so on) and results (like free shipping, percent discount, or setting fixed price of an order product). Each action can be applied to specific products in the order or to the entire order.

It is possible to add more actions, in which different logic will be applied. Following actions can be applied to an order as a whole, or only to products not affected by previous actions. This makes it possible to combine multiple promotions in one, like creating a voucher which sets the price of the cheapest product to 1 SEK and gives free shipping.

Multiple actions can be arranged in order they should be applied, and at least one of them needs to be selected as an "Entry point", in which voucher processing will begin.

More information on Vouchers can be found on our Support page: [Creating a voucher in B2C](https://support.centra.com/centra-sections/retail-b2c/promo/creating-a-voucher-in-b2c) or [Creating vouchers in bulk](https://support.centra.com/centra-sections/retail-b2c/promo/create-bulk-vouchers).

### Gift certificate

Gift certificates allow the user to purchase certain pre-defined store credit, pay with one of the configured payment options and then receive a PDF with a gift code. This code can be then used during checkout like a voucher.

Gift certificate definition in Centra consists of its name, the Store it's active in, and its type. It can be configured to either show or hide the gift value.

Gift certificates of type "Priceoff" allow to purchase store credit and specify its value in every currency of every Pricelist active in the Store, or, when appropriate configuration option is selected, only in the currency in which the certificate was purchased.

Gift certificates of type "Dynamic Priceoff" allow the end customer to specify the credit amount themselves.

[notice-box=info]
Because Gift Certificates are a "virtual" product, adding them to your selection will clear it of any other products. You cannot mix actual products and gift certs in the same order, and you should make it clear to your customers in your front end.
[/notice-box]

### Campaign

Campaigns allow the store admin to temporarily change the prices of selected products. Campaign is defined by its name, Store, Markets and Pricelists for which the Campaign should be active. In B2B Campaigns it's also required to select at least one Delivery Window. Then the user can select one or more products and set specific discounts for each of them, either by configuring a new, fixed price, or by specifying the percentage discount. Every product on the list has "Start" and "Stop" dates for when the discount is active.

The way Campaigns work is that they actually set a new base price of the Product. This means that any discount vouchers will apply to the Campaign price, not the Pricelist price. If this is not desired, you can instead configure your voucher to apply on the original price excluding campaign price. This is configurable in the voucher action results.

---
title: Tripletex
altTitle: Tripletex
excerpt: Use Tripletex with Centra.
taxonomy:
    category: docs
---

### Installation

To enable Tripletex module in Centra, you will need to create a user in Tripletex, or create an API-token for an existing user. The user needs to be allowed to create invoices and orders in Tripletex.

When you have created a user, you can go to the "API Access"-tab of the user and then click "New token":

![api-access.png](api-access.png)

Select Centra from the drop-down menu and give the token a name:

![create-token.png](create-token.png)

Now, copy the token you get and paste it in Centra under MODULES / Tripletex and CONFIG and select the "employee token". Click Save and then use the button called "Test connection" in the top right corner to verify your credentials:

![test-connection.png](test-connection.png)

If the information is correct, you have now connected Centra with Tripletex. All invoices ready to be sent to Tripletex will show up under "SYNC", and all sent invoices will be listed under "SENT". To sync back payments from Tripletex to Centra, you can use "Sync payments"-button in the top right corner. This will check all invoices against Tripletex and see if they have any registered payments for Centra to register.

All information about what was being sent or received and if there are any validation issues with the customer information will be listed in the start page of the Tripletex module, under "LOG".

### KID

To generate a proper [KID](https://tripletex.no/execute/docViewer?articleId=164&language=0&contextId=31544108) for the invoices, you need to insert the proper 4 digit "customer number" in the Tripletex CONFIG in Centra. The KID will be formatted like this:

```
16 characters in total:

9        = 1 digit
XXXX     = 4 digits, will contain the customer number
00       = 2 digits
XXXXXXXX = 8 digits, will contain the invoice number
X        = 1 digit, checksum for the whole KID
```

You get the KID from Tripletex when you have the proper connection set up with the bank.

### Taxes

To set up taxes, you need to route certain tax percentages from Centra to VAT-types in Tripletex. The default ones are:

```
25=3
0=6
```

This means 25% VAT will go into VAT-type 3 and 0% VAT will go into VAT-type 6. These are default codes in Tripletex, but you can modify these in Centra if you have other groups that you use.

### Additional settings

If you want Tripletex to send out emails whenever the invoices are synced to Tripletex, you can set "send invoice by email" in Centra to "yes". Since you are often syncing invoices after you have sent them out from Centra, this is default set to "no".

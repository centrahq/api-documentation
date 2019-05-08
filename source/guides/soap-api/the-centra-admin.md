# The Centra Admin

When working with the SOAP API you will also need to look at things in the Centra admin. This is a very brief guide to get you started.

Frist you need a username and password to log into the centra backend, and the link to where you log in. Ask someone from Centra to provide this for you. 

## The Centra Admin

After you login to Centra you will see the dashboard:

```eval_rst
.. image:: images/dashboard.png
   :width: 985
   :height: 747
   :scale: 75 %
```

The tabs at the top (Dashboard, Catalog, Sales...) is the main navigaion that will take you to different sections of Centra. The row at the bottom has the *System* and *Modules* menus have links to other sections that are less frequently used.

## Catalog Tab

Under the catalog tab, you will find:

- Products: The product catalog.
- Stock: The product catalog again, but a specialized view of the product stock.
- Charts: Sizetables are here. It is called "size charts" in the admin, but "sizetables" in the API.

## Retail And Wholesale Sections

The retail and wholesale sections have a similar set of tabs: Sales, Customers (retail) Accounts (wholesale), Promo and Setup.

- Sales tab: Orders and shipments are here.
- Customers tab: Only for retail, contains the retail customers.
- Accounts tab: Only for wholesale, contains the accounts and buyers.
- Setup tab:
  - Markets
  - Pricelists
  - Terms: Only for wholesale, the payment and shipping terms.

## The SOAP API Module

To go to the SOAP API "module", click on _Modules_ at the bottom of the screen, then _SOAP API_.

```eval_rst
.. image:: images/find-soap-api.png
   :width: 364
   :height: 123
   :scale: 100 %
```

The SOAP API modules has three tabs. A log with the XML requests and responses, the event queue, and the conversion table.

```eval_rst
.. image:: images/soap-api.png
   :width: 985
   :height: 451
   :scale: 75 %
```

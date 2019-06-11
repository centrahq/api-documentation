# Centra Concepts

## Store

Centra is built to handle multiple stores. The most common configuration is one retail store for the B2C webshop and one wholesale store for the Centra B2B showroom. Some of our clients have multiple retail stores where each store sells a specific brand.

Stores are created from Centra, and you need the store IDs on your side to be able to send data to Centra. 

## Markets

Each store has one or more markets. A market is a segmentation tool. Each customer in a store is connected to a single market, and will only see the products that are connected to that individual market. A product can be connected to many markets at the same time.

Markets can be created by your side or from Centra's side. Depending on what the integration should do, you might not need to work with markets at all.

## Pricelist

Each store has one or more pricelists. A pricelist is connected to a currency like EUR, and contains the prices of products. You can have many pricelists with the same currency. For example; two pricelists with EUR, one for Germany and one for France.

The pricelists for wholesale stores can also have a "recommended retail price" in addition to the price that wholesale customers would pay for a product.

Pricelists are created by your side.

## Retail Customers

Generally, retail customers get assigned to a market and pricelist based on which country they're visiting the webshop from. Sometimes our clients use special campaign markets where some retail customers get access to specific products or lower prices.

The customer data is created in Centra when the first order is placed. If the same customer (with the same email) has placed an order before, the order is connected to that customer.

Retail customers are created on the Centra side, and you get the customer data each time an order is placed for a customer.

## Wholesale Accounts

An account is the wholesale equivalent of the retail customer. But the wholesale store is not open for everyone. Before you are allowed to order from a Centra wholesale store, an account must be setup in Centra.

The account represents a company, and contains company information like shipping and billing address, VAT-number and so on. It also configures the market and pricelist for the account.

An account has one or more buyers. The buyers are people working for the account's company.

To access the Centra wholesale showroom, a buyer for an account logs in with their email address and password.

Accounts are almost always created by your side. Buyers for the accounts can be created by both sides, this should be decided depending on what the integration should do.

## Orders

Orders are created on the Centra side. Usually, after the order has been accepted on the Centra side the ownership is transfered to your side and you are responsible for updating the order. For example, telling Centra that the order has shipped.

## Products, Variants and Sizes

Centra has a fixed product structure consisting of products, variants and sizes. 

A product has one or more variants, and a variant has one or more sizes.

The "size" is the physical item you have in the warehouse. The product and variant are not physical items but groups of physical items.

Example: Turtleneck sweater

- Turtleneck sweater is the Centra product
- Its available in red and blue color, the Centra variants red and blue
- Its available in sizes S, M, L

The structure in Centra look like this:
 
```
    Turtleneck sweater product
        |
        |-> Red variant
        |    |-> S size
        |    |-> M size
        |    |-> L size
        |
        |-> Blue variant
             |-> S size
             |-> M size
             |-> L size
```

In the warehouse, its 6 different physical items:

- Turtleneck sweater, Red, S
- Turtleneck sweater, Red, M
- Turtleneck sweater, Red, L
- Turtleneck sweater, Blue, S
- Turtleneck sweater, Blue, M
- Turtleneck sweater, Blue, L

Products are always created and updated by your side.

A product is not displayed in a Centra store until you create a "display" for the product in that store. This is done in the Centra admin and not through the SOAP API.

---
title: Basic Centra concepts and definitions
taxonomy:
    category: docs
process:
	twig: true
---

Asterisk (*) means there are unresolved related comments to be addressed in [Google doc for developer.centra.com](https://docs.google.com/document/d/1HerK54L9ZsxuoTATE0sS3oIZpO0dc9V3I_2Knc-lXN0/)

### A

**Account**  
_B2B_  
Account is a company or individual buying Wholesale, with a profile stored in Centra. An Account can be represented by several Buyers. Information about the Account is stored where customer information is stored. Examples are: customer number, buyers, addresses. There are also attributes for segmentation such as market, price list and warehouse group. Accounts are only used in the Wholesale module of Centra. The corresponding concept in the Direct-to-Consumer module is Customer.

**Affiliate** *  
_B2C_  
Tool for linking orders to different sources, typically to track sales from social channels. An Affiliate can use it by inserting either a pixel or a code snippet with a specific URL into their own channels. Each call of the URL will create a cookie that identifies the end user and matches with the Affiliate. You have a possibility to setup Affiliate URL in the way that it will include additional attributes and change the amount of days that cookie will be valid.

**Agent**  
_B2B_  
Specific user role in Centra for agents. The Agent can add Accounts and place orders for Accounts. Agent users have access to both Centra and Centra Showroom. Agents can have a commission percentage which is used to calculate a Commission. 

**Attribute Catalog**  
_B2B/B2C_  
Configuration of Custom Attribute values. End-User Accessible.

**Attribute**  
_B2B/B2C_  
Specific data field attached to a Product (“general attributes”) or Variant (“variant attributes”). There are standard, predefined and custom attributes. Custom attributes are set up in the Configuration and custom attribute values are set up in the Attribute Catalog.

### B

**Back-order**  
_B2B/B2C_  
An order placed when there was no stock. Back-ordering is enabled/disabled for each Store separately and applies to all products in the store. When an Order is created with back-ordered items, Demand is created.  
See also: Preorder B2B/B2C

**Basket**  
_B2B/B2C_  
A basket is where products are held when selected for purchase. Naming convention of basket in Centra is Selection.

**Brand**  
_B2B/B2C_  
A brand is a general attribute on product level where you can store the product’s brand

**Buyer**  
_B2B_  
Individual connected to a specific Account, who can log in to Centra Showroom and place orders. For example a purchaser at a specific store.

**Bundle Product**  
_B2B/B2C_  
Bundle is a Product that was synthetically created by combining physical products within Centra. Important: stock updates on Bundle Product are triggered by updating stock of the corresponding physical Products.

### C

**Campaign**  
_B2B/B2C_  
are used to set up store-wide price reductions or to set a manual “New in store” flag. It’s important to note that the original price will not be overwritten. This can be done on specific markets and/or price lists. Unlike Vouchers, this logic is applied before checkout process.

**Campaign site**  
_B2C_  
A campaign site is a way to give selected Customers access to a campaign prior to its launch. This is achieved by assigning the Customer to a Market which they cannot access without going through the campaign site (i.e. V.I.P. Market).

**Cancel Date** *  
_B2B_  
Date after which orders are automatically cancelled unless confirmed. Set during the Wholesale checkout process. 

**Cart**  
See Selection.

**Category**  
Mechanism for structuring how Displays are shown on frontend sites and in Centra Showroom to facilitate navigation. Categories are arranged in a hierarchical tree-structure with up to 3 levels. One product can have multiple categories.
Also see: Folder. 

**Charts**  
see Measurement Chart, Size Chart

**Collection**  
Part of a product’s general attributes. In fashion, this might for example be a spring-summer collection like SS20. If products aren’t set by season and you were selling other appliances, this could e.g. be “Kitchen”.

**Configuration**  
Basic configuration settings for Centra are stored in config file that differs per client. Accessible for Centra front-end agency partners and Centra Support, not for end-users.

**CRUD**  
Create, Read, Update, Delete

**Customer, newsletter**  
_B2C_  
This section will give you a list of customers that selected to sign up for newsletters

**Customer, registered**  
_B2C_  
customer that decided to sing in (either during order process or through registration form).

### D

**Demand**  
_B2B/B2C_  
is used when having either “Allow backorders” or “Preorder” enabled, this will be the suggested amount to purchase from suppliers. 

**Delivery window**  
_B2B_  
(also known as DelWin) is used to manage when products should be expected to be delivered, all B2B orders in centra must belong to one or many Delivery Windows. Products are added to a delivery windows and when that delivery window is active, the products in that delivery window will be available for sale. Delivery window normally correspond with pars of “Order Type” logic in ERP systems. Products in a delivery window can have the stock availability based on “Stock”, “Link”, “Stock/Link”, or “Preorder”, depending on option the order will act differently in the way it allocates stock, links towards incoming supplier orders, or creates a demand. 

**Discount**  
_B2B/B2C_  
A discount is a setting to make a reduction off of the original value of a product.  (not sure how to describe this really, let me know what you would want here)

**Display**  
_B2B/B2C_  
In a display you choose how and where a product should be displayed. You set which market it should be displayed, in which categories and in which variant. You’ll also set the storefront product -name in the “display name”. A product without display won’t appear in API responses.

### E

**EAN**  
_B2B/B2C_  
European Article Number. A field on size level which should be unique. Can also be populated with a UPC.

**ERP**  
Enterprise Resource Planning (system).

### F

**Folder**  
Folders are used to categorize your products internally in Centra. You can also filter in certain views based on this.

**FTA (free to allocate)**  
Physical warehouse stock with allocated units removed

### G

**Gift certificate**  
_B2C_  
A gift certificate is a way to sell gift certs to your B2C customers. This will need its own separate checkout.

**Google Merchant**  

### H

**Handling cost**

**Harm code** *  
Harmonization code, also known as commodity code. Used for custom when exporting to certain countries.

### I

**Item** *  
ingen aning vad detta har för kontext 

### L

**Locale** *  
A parameter to define language

**Lookbook**  
_B2B_  
Lookbook is a feature (in Showroom), to generate a link to a specific delivery window, to be displayed without prices in order to present products to potential customers.

### M

**Market** *  
_B2B/B2C_  
Markets in Centra behave differently in B2B and B2C. For B2C, it’s a geographical market based on GeoIP. In B2B, it’s used more as customer groups.

**Marketplace**  
A place where you can sell your goods. Amazon is a marketplace.

**Measurement chart**  
Used to display the measurements of your products. Will appear in showroom.

**Merchant**  
Oklart

### O

**Omnichannel**  

**Order**

**Order sheet**  
An order sheet is the state of an order before it has been completed and checked out. It can be seen as an order suggestion. As long as the order sheet is not checked out, it will not become a sales order.

**Order date** *  
The date when the order is placed

### P

**Packaging**

**PIM**  
Product Information Management. See “Product Catalog”

**PO number**  
Purchase Order number. Usually given by customer to mark their sales order with

**Preorder**  
A preorder is used to take orders before goods are available.

**Price list**  
A list that contains prices for products to be sold. For B2B, you have Price A and B. Where A is RRP (Recommended Retail Price)

**Product**  
In Centra, Product is a top-level definition of an item for sale. Products are split up into variants (i.e. by colour, by style), and each variant is split up into sizes according to the selected size chart. Each product variant needs to belong to at least one display in order to be searchable and purchasable.

**Product Catalog**  
The product catalog contains all of your products Created in Centra. Whether or not they’re for B2C or B2B sales, or both. 

### R

**Refund**  
_B2C_  
A function to refund your customer in case of returns.

**Related products**  
Products can be related in different ways. This is used mainly for B2C stores to display things like “goes well with”. But it can also be used to display that a product is available in another material, as an example.

**Reorder**  
Finns detta i Centra? 

**Report**  
Used to create reports to export. Like sales figures.

**Retailer**  

**Return**  
förklar hur retur fungerar icentra

**Return date**  
Date of return

**Reuse value**  
Value left to re-use

**RRP**  
Recommended Retail Price

### S

**Sales Rep**  
The user responsible for a Wholesale B2B account

**Selection**  
_B2B/B2C_  
A selection is where products and quantity is stored together with customer data (see also: Basket). Typically in B2C we will call it Cart and in B2B an Ordersheet.

**Seller**

**Sent date**

**Serializable product**  
A function to use if products require s/n scanning

**Shipment**  A shipment is generated from a sales order. One order can have multiple shipments. It’s the outbound delivery.

**Shipment date**  
Date of shipment

**Shipping cost**  

**Size** *  
The size of the product

**Size chart**  
A chart that contains multiple sizes. Each variant for a product must have a size chart selected

**Size table**  
This might be the above one. 

**SKU**  
Stock Keeping Unit. In Centra the full SKU is separated in three different places. Main product SKU, variant SKU and Size SKU. 

**Static** *  
Statics are used for certain settings in Centra, like email copy for order and shipping confirmations. It can also be used for setting text for buttons in a storefront, if built that way.

**Stock**  

**Stock unit**

**Store**  
Centra can have multiple stores in the same instance. Normally, you have a B2C and a B2B store. But you can have more than one B2C store if needed.

**Supplier**  
A supplier in Centra is from where your products are purchased/manufactured. 

**Swatch**

### T

**Taxonomy**

**Terms**  
_B2B_  
Terms is a section where you setup your incoterms and payment terms to be used for your customers

### U

**Unit**

**Upsell**

### V

**Variant**  
Every product in Centra has at least one variant. A variant is typically a color or material of a product

**Voucher**  
_B2B/B2C_  
A voucher is used to give rebates, free shipping, free products etc to a customer. When a voucher is applied the selection will be updated to reflect changes made by the voucher. A voucher can be automatically applied based on certain rules, or a code can be entered

### W

**Warehouse**  
A warehouse in Centra is where stock is stored. There are no storage locations in Centra.

**Warehouse group**  
With the help of a warehouse group, you will set for which markets and stores specific warehouses is used for.

**WMS**  
Warehouse Management System

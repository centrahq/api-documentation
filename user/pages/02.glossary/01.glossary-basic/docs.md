---
title: Basic Centra concepts and definitions
altTitle: Basic concepts
taxonomy:
    category: docs
---

Asterisk (`*`) means there are unresolved related comments to be addressed in [Google doc for developer.centra.com](https://docs.google.com/document/d/1HerK54L9ZsxuoTATE0sS3oIZpO0dc9V3I_2Knc-lXN0/)

## **A**

**Account**  
_B2B_  
Account is a company or individual buying Wholesale with a profile stored in Centra. An Account can be represented by several Buyers. Information about the Account is stored where customer information is stored. Examples are: Customer Number, Buyers, Addresses. There are also attributes for segmentation such as Market, Price List and Warehouse Group. Accounts are only used in the Wholesale module of Centra. The corresponding concept in the Direct-to-Consumer module is Customer.

**Affiliate** *  
_B2C_  
Tool for linking orders to different sources, typically to track sales from social media channels. An Affiliate can use it by inserting a pixel or a code snippet with a specific URL into their own channels. Each call of the URL will create a cookie that identifies the end user and matches with the Affiliate. You have the option to setup the Affiliate URL to include additional attributes and change the amount of days that cookie will be valid.

**Agent**  
_B2B_  
Specific user role in Centra for agents. The Agent can add Accounts and place orders for Accounts. Agent users have access to both Centra and Centra Showroom. Agents can be configured with a commission percentage which is used to calculate their Commission. 

**Attribute**  
_B2B/B2C_  
Specific data field attached to a Product (General Attributes) or Variant (Variant Attributes). There are standard, predefined and custom attributes. Custom attributes definitions are set up in the Configuration and their values are set up in the Attribute Catalog

**Attribute Catalog**  
_B2B/B2C_  
This is where the static custom attributes defined in the client configuration are added to then be selectable on the products, variants, orders, customers or accounts. Attributes can be of type boolean, input, multi-line text, drop-down select, image, file or a readonly static. Please note that empty attribute values are not returned in API responses. Attribute catalog is shared by both B2B and B2C stores.

## **B**

**Back-order**  
_B2B/B2C_  
An order placed when there was no stock. Back-ordering is configured for each Store separately and applies to all products in the store. When an Order is created with back-ordered items, Demand is created.
See also: Preorder.

**Basket**  
_B2C_  
See Selection.

**Brand**  
_B2B/B2C_  
A Brand is a general attribute on product level where you can store the product’s brand. Each product can only belong to a single brand.

**Bundle Product**  
_B2B/B2C_  
A Bundle Product is a Product created by combining physical products within Centra. Once the Bundle Product is added to a selection, all items of that Bundle Product will be added automatically. Stock updates for Bundle Product are triggered by updating stock of the corresponding physical Products.

**Buyer**  
_B2B_  
Individual connected to a specific Account who can log in to Centra Showroom and place orders. For example a purchaser at a specific store.

## **C**

**Campaign**  
_B2B/B2C_  
Campaigns are used to set up store-wide price reductions or to set a manual “New in store” flag. It’s important to note that the original price will not be overwritten. Campaigns can be set-up on specific Markets and/or Price Lists. Unlike Vouchers, this logic is applied before checkout process.

**Campaign site**  
_B2C_  
A Campaign Site is a way to give selected Customers access to a campaign prior to its launch. This is achieved by assigning the Customer to a Market which they cannot access without going through the campaign site (like VIP Market).

**Cancel Date**  
_B2B_  
A note on an order if the Account don’t want the order after a certain date. The order is not automatically cancelled on the Cancel Date, it is a note for sales staff.

**Cart**  
_B2C_  
See Selection.

**Category**  
_B2B/B2C_    
Mechanism for structuring how Displays are shown on front-end sites and in Centra Showroom to ease navigation. Categories are arranged in a hierarchical tree-structure with up to 3 levels. One product can have multiple categories.
Also see: Folder. 

**Charts**  
_B2B/B2C_  
See Measurement Chart, Size Chart.

**Collection**  
_B2B/B2C_  
Part of a product’s General Attributes. In fashion, this could be a spring-summer Collection like SS20. If products aren’t set by season and you were selling other appliances, this could e.g. be “Kitchen”.

**Color Swatch**  
_B2B/B2C_  
Taken from the world of fashion, color swatches allow the customer to compare colors, gradients, textures or patterns in a simple manner. In Centra, color swatches can be defined as custom product or variant attributes, usually consisting of color description, hex value and/or small image to show the example texture or pattern.

**Configuration**  
_B2B/B2C_  
Basic configuration settings for Centra are stored in the config file. The config file differs per client and is only accessible for Centra’s front-end agency partners and Centra Support – not for end-users.

## **D**

**Demand** *  
_B2B/B2C_  
Demand is used with either “Allow backorders” or “Preorder” enabled, this will be the suggested amount to purchase from suppliers.

**Delivery window**  
_B2B_  
Delivery Window (also known as DelWin) is used to manage when products are expected to be delivered. Every B2B order in Centra must belong to one or many Delivery Windows. Products are available for sale once the Delivery Window they belong to has been activated. The Delivery Window normally corresponds with pars of “Order Type” logic in ERP systems. Products in a Delivery Window have available  stock based on “Stock”, “Link”, “Stock/Link”, or “Preorder”. Depending on selected option the order will act differently in the way it allocates stock, links towards incoming supplier orders, or creates a demand.

**Discount**  
_B2B/B2C_  
A Discount is a setting for making a reduction off the original price of a product. It can be applied to the price of a single product or the entire order. It can also be configured as a fixed or percentage discount value.

**Display**  
_B2B/B2C_  
In a display you choose how and where a product should be presented in the front end. You set which market, categories and variant it should be displayed in. You’ll also set the storefront product name in the “display name”. A product without display won’t appear in API responses.

## **E**

**EAN**  
_B2B/B2C_  
European Article Number. Like GTIN (Global Trade Item Number), it identifies a specific product, variant and size. Can be set as a field on size level which should be unique. Can also be populated with a UPC (Universal Product Code).

**ERP**  
Enterprise Resource Planning (system).

## **F**

**Folder**  
_B2B/B2C_  
Folders are used to categorize products internally in Centra. One product can belong to at most one folder. Folders are not exposed in the Front End.

## **G**

**General Attributes**  
_B2B/B2C_  
See Attributes.

**Gift certificate**  
_B2C_  
A gift certificate is a way to sell gift certs to your B2C customers. This will need its own separate checkout.

**Google Merchant Plugin**  
_B2B/B2C_  
Google Merchant is a service used for advertising your products in Google’s search results. You can use Centra’s plugin to feed information about your products to Google.

## **H**

**Handling cost** *  
_B2B/B2C_  
When creating an order, this is the cost of using a specific payment method. It’s configurable in the payment plugin. Handling Cost can also be added when creating a return. It will be added to the return value.

**Harm code** *  
Harmonization code, also known as commodity code. Used for customs when exporting to certain countries.

## **I**

**Item** *   
An API response for an order, for every element of the “items” table, item is presented as “X-Y”, where X is the product ID and Y is the variant ID.

## **L**

**Locale** *  
A parameter to define language

**Lookbook**  
_B2B_  
Lookbook is a feature in Showroom that allows you to generate a link to products offered in a specific delivery window and display them without prices in order to present products to potential customers.

## **M**

**Market** *  
_B2B/B2C_  
Markets allow you to segment your store into logical entities. They control which products are available on the website, what campaigns and vouchers are active and which shipping options will be available. In B2C, Market is usually selected based on the end customer geo-location, or it can be set when the customer visits the store via a campaign URL. In B2B, markets can be configured as separate customer groups.

**Measurement chart**  
_B2B/B2C_  
Used to display the measurements of your products. While Size Charts define product sizes (S, M, L, XL), measurement charts are used to define measurements, in specific units, for each size. For example, measuremement chart for trousers can consist of leg and waist size, defined in cm or inches, for each defined size. This data can be used when displaying products in Showroom.

## **N**

**Newsletter**  
_B2C_  
This section will list registered customers for which “Receive newsletter” field is set to “Yes”.

## **O**

**Order**  
_B2B/B2C_  
A document containing information about the customer or account (name, shipping address, etc.) and a list of ordered items. Selection becomes an order when you do a checkout

**Order sheet**  
_B2B_  
An order sheet is the state of an order before it has been completed and checked out. It can be seen as an order suggestion. The Order Sheet will not become a Sales Order until it has been checked out.

**Order date** *  
_B2B/B2C_  
The date when an order is placed. In B2C the order date is the date the customer receives the receipt. In B2B, the Order Date is when either the Seller or the Buyer confirm an order.

**Order status**  
_B2B/B2C_  

[Order flow in Centra](https://centra-api-documentation-demo.herokuapp.com/guides/orderflow)  
![OrderFlow](https://centra-api-documentation-demo.herokuapp.com/user/pages/01.guides/05.orderflow/order-flow.png?resize=400)  

* Incomplete (0)  
  This is a selection before it’s checked out. It contains the list of selected items, information about language and currency or discounts, plus a list of optional shipping methods.
* Pending (1)  
  This order has been checked out, with payment steps being completed. In addition to the incomplete order, it contains information on customer, shipping and payment.
* Confirmed (2)  
  This order has been manually confirmed in the Centra admin panel. Only confirmed orders can have a shipment created for them. This step can be skipped by enabling store option “Direct to Shipment”, in which case the checked out order will transfer to status Processing (3) with a shipment created.
* Processing (3)  
  This order has at least one shipment related to it, and at least one of those shipments is not completed. Ordered items can be split into multiple shipments depending on availability or other factors.
* Completed (4)  
  This order has completed payment capture and expedited all related shipments. Additional information on shipping details and tracking number can be added when completing each shipment.
* Archived (5)  
  This order has been archived and will not show up in search results in Centra. Depending on API plugin configuration, it may also be hidden in API responses.
* Cancelled (6)  
  This ordered has been cancelled at any stage before the payment was captured (once the payment has been successful, a refund should be made instead of cancelling the order). Cancelled orders have the option to be fully and irreversibly deleted from the database.
* Hold (flag)  
  This order is on hold by manual intervention in Centra backend. Its details can still be edited, but it cannot proceed with shipment or payment until resumed.
* Checkout Requested  

## **P**

**PIM**  
_B2B/B2C_  
Product Information Management. See “Product Catalog”.

**PO number**  
_B2B/B2C_  
Purchase Order number. Usually given by a customer to mark their sales order.

**Preorder**  
_B2B/B2C_  
Preorder function allows creating orders before goods are available.

**Price list**  
_B2B/B2C_  
A list that contains prices for available products. For each configured store, multiple pricelists can be defined, each using specific currency and default shipping method, and linked to one or more geo-locations. Only one pricelist can be selected as default for any country. For B2B, two prices - Price A and B - are defined for each product, where B is RRP (Recommended Retail Price).

**Product**  
_B2B/B2C_  
In Centra, Product is a top-level definition of an item for sale. Products are split up into variants (i.e. by colour, by style), and each variant is split up into sizes according to the selected size chart. Each Product Variant has to belong to at least one display in order to be searchable and purchasable.

**Product Catalog**  
_B2B/B2C_  
The product catalog contains all of your Products stored in Centra.

## **R**

**Registered customers**  
_B2C_  
This section will give you a list of all customers that have signed in, either during order process or through registration form. When creating orders, they will be linked to a registered customer by matching on their e-mail address.

**Refund**  
_B2C_  
A function to refund your customer in case of returns.

**Related products**  
_B2B/B2C_  
Products can be related in different ways. This is used mainly for B2C stores to display things like “goes well with”. But it can also be used i.e. to display that a product is available in another material.

**Report**  
Used to create reports to export. Like sales figures.

**Reuse value**  
_B2B/B2C_  
Value of a voucher left to reuse.

## **S**

**Sales Rep**  
The user responsible for a Wholesale B2B account.

**Selection**  
_B2B/B2C_  
A selection is where products are held when chosen for purchase. Once the selection is checked out, it becomes an Order. Typically in B2C we will call it Cart and in B2B an Order Sheet.

**Seller** *  

**Sent date**  
Timestamp for when a shipment was marked as “Shipped” and the shipment was completed.

**Serializable product**  
_B2B/B2C_  
A product is serializable if every item sold is unique, identified 1:1 by its serial number. For example, a red summer shirt size XL is not serializable, since it’s exactly the same as all other red summer XL shirts.

**Shipment**  
_B2B/B2C_  
A Shipment is generated from a sales order. One order can have multiple shipments. It’s the outbound delivery.

**Shipping cost**  
_B2B/B2C_  
The price of the freight of the order. It can be defined as a fixed price, or depend on the number and/or weight of items in order.

**Size** *  
The size of the product.

**Size chart**  
_B2B/B2C_  
A chart that contains multiple sizes. Each variant for a product must have a size chart selected

**SKU** *  
Stock Keeping Unit. In Centra the full SKU is built from three different values: main product SKU, variant SKU and size SKU.

**Static** *  
In Centra, statics are used to define some of the commonly used parts of the system. For example, e-mail statics can be used to define templates for order confirmations and cancellations. Other statics can define store terms and conditions, or items to be used in the Front End - a static button text or footer content. There are some pre-existing statics, and the customer has the option to add their own.

**Stock status**  
_B2B/B2C_  

* Physical  
  
* FTA  

* Physical warehouse stock with allocated units removed.  

* Allocated  

* Linked  

* Demand  

* Unshipped  

* Available now  

* Unlinked  

* Incoming  

* On delivery  

* Available  


**Store**  
_B2B/B2C_  
Centra can have multiple stores in the same instance. The normal setup is to have two stores - one for B2C and one for B2B. have a B2C and a B2B store. It is however possible to have more than one B2C store if needed.

**Supplier**  
_B2B/B2C_  
A Supplier in Centra is from where your products are purchased or manufactured.

## **T**

**Terms**  
_B2B_  
Terms is a section where you setup your incoterms and payment terms to be used for your customers. They are defined as store statics.

## **V**

**Variant**  
_B2B/B2C_  
Every product in Centra has at least one Variant. A variant is typically a color or material of a product.

**Voucher**  
_B2B/B2C_  
A voucher is used to give rebates, free shipping, free products etc. to a customer. When a voucher is applied, the selection will be updated to reflect changes made by the voucher. A voucher can be automatically applied based on certain rules, or a code can be entered.

## **W**

**Warehouse**  
_B2B/B2C_  
A warehouse in Centra is where stock is stored. Warehouse is defined by its name and priority. Each warehouse can belong to one or more warehouse groups. When stock is added, either by importing a CSV or via stock editor, it always needs to be added to one of the warehouses. There are no storage locations in Centra.

**Warehouse group**  
_B2B/B2C_  
Consists of one or more warehouses sorted by priority. One warehouse group can belong to multiple markets, but two groups cannot belong to the same market. With the help of a warehouse group, you will set for which markets and stores specific warehouses is used for. Each market has exactly one default warehouse group.

**WMS**  
Warehouse Management System.

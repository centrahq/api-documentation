---
title: Basic Centra concepts and definitions
altTitle: Centra A-Z
excerpt: Learn the basic glossary of terms used in Centra.
taxonomy:
    category: docs
---

## **A**

###  **Account**  
_B2B_  
Account is a company or individual buying Wholesale with a profile stored in Centra. An Account can be represented by several Buyers. Information about the Account is stored where customer information is stored. Examples are: Customer Number, Buyers, Addresses. There are also attributes for segmentation such as Market, Price List and Warehouse Group. Accounts are only used in the Wholesale module of Centra. The corresponding concept in the Direct-to-Consumer module is Customer.

### **Affiliate**  
_B2C_  
Tool for linking orders to different sources, typically to track sales from social media channels. An Affiliate can use it by inserting a pixel or a code snippet with a specific URL into their own channels. Each call of the URL will create a cookie that identifies the end user and matches with the Affiliate. You have the option to setup the Affiliate URL to include additional attributes and change the amount of days that cookie will be valid.

### **Agent**  
_B2B_  
Specific user role in Centra for agents. The Agent can add Accounts and place orders for Accounts. Agent users have access to both Centra and Centra Showroom. Agents can be configured with a commission percentage which is used to calculate their Commission. 

### **Allocated (stock)**
Allocated = Physical - Free To Allocate  
The number of said products that are allocated on orders or shipments which are not yet completed.

### **Attribute**  
_B2B/B2C_  
Specific data field attached to a Product (General Attributes) or Variant (Variant Attributes). There are standard, predefined and custom attributes. Custom attributes definitions are set up in the Configuration and their values are set up in the Attribute Catalog

### **Attribute Catalog**  
_B2B/B2C_  
This is where the static custom attributes defined in the client configuration are added to then be selectable on the products, variants, orders, customers or accounts. Attributes can be of type boolean, input, multi-line text, drop-down select, image, file or a readonly static. Please note that empty attribute values are not returned in API responses. Attribute catalog is shared by both B2B and B2C stores.

### **Archived** (order status 5)  
This order has been archived and will not show up in search results in Centra. Depending on API plugin configuration, it may also be hidden in API responses.

### **Available (stock)**
Available = Free To Allocate - Demand + Incoming  
The total of said product’s stock including incoming supplier orders.

### **Available now (stock)**
Available now = Free To Allocate - Demand  
The quantity available right now of said product.

## **B**

### **Back-order**  
_B2B/B2C_  
An order placed when there was no stock. Back-ordering is configured for each Store separately and applies to all products in the store. When an Order is created with back-ordered items, Demand is created.
See also: [Preorder](#preorder).

### **Basket**  
_B2C_  
See [Selection](#selection).

### **Brand**  
_B2B/B2C_  
A Brand is a general attribute on product level where you can store the product’s brand. Each product can only belong to a single brand.

### **Bundle Product**  
_B2B/B2C_  
A Bundle Product is a Product created by combining physical products within Centra. Once the Bundle Product is added to a selection, all items of that Bundle Product will be added automatically. Stock updates for Bundle Product are triggered by updating stock of the corresponding physical Products.

### **Buyer**  
_B2B_  
Individual connected to a specific Account who can log in to Centra Showroom and place orders. For example a purchaser at a specific Store.

## **C**

### **Campaign**  
_B2B/B2C_  
Campaigns are used to set up store-wide price reductions or to set a manual “New in store” flag. It’s important to note that the original price will not be overwritten. Campaigns can be set-up on specific Markets and/or Price Lists. Unlike Vouchers, this logic is applied before checkout process.

### **Campaign site**  
_B2C_  
A Campaign Site is a way to give selected Customers access to a campaign prior to its launch. This is achieved by assigning the Customer to a Market which they cannot access without going through the campaign site (like VIP Market).

### **Cancel Date**  
_B2B_  
A note on an order if the Account don’t want the order after a certain date. The order is not automatically cancelled on the Cancel Date, it is a note for sales staff.

### **Cancelled** (order status 6)  
This ordered has been cancelled at any stage before the payment was captured (once the payment has been successful, a refund should be made instead of cancelling the order). Cancelled orders have the option to be fully and irreversibly deleted from the database.

### **Cart**  
_B2C_  
See [Selection](#selection).

### **Category**  
_B2B/B2C_    
Mechanism for structuring how Displays are shown on front-end sites and in Centra Showroom to ease navigation. Categories are arranged in a hierarchical tree-structure with up to 3 levels. One product can have multiple categories.
Also see: [Folder](#folder). 

### **Charts**  
_B2B/B2C_  
See [Measurement Chart](#measurement-chart), [Size Chart](#size-chart).

### **Checkout Requested**  
A status of an Order Sheet in the Centra Showroom, if buyers are not allowed to confirm orders they have to request an Administrator or Sales person to confirm the order, before that’s done, it will be in the “Checkout Requested” mode. These Selections will only be visible in the Showroom or on the Dashboard under Incomplete Orders.

### **Collection**  
_B2B/B2C_  
Part of a product’s General Attributes. In fashion, this could be a spring-summer Collection like SS20. If products aren’t set by season and you were selling other appliances, this could e.g. be “Kitchen”. It’s mainly used as a filter option in both Centra and the Centra Showroom.

### **Color Swatch**  
_B2B/B2C_  
Taken from the world of fashion, color swatches allow the customer to compare colors, gradients, textures or patterns in a simple manner. In Centra, color swatches can be defined as custom product or variant attributes, usually consisting of color description, hex value and/or small image to show the example texture or pattern.

### **Completed** (order status 4)  
This order has completed payment capture and expedited all related shipments. Additional information on shipping details and tracking number can be added when completing each shipment.

### **Configuration**  
_B2B/B2C_  
Basic configuration settings for Centra are stored in the config file. The config file differs per client and is only accessible for Centra’s front-end agency partners and Centra Support – not for end-users.

### **Confirmed** (order status 2)  
This order has been manually confirmed in the Centra admin panel. Only confirmed orders can have a shipment created for them. This step can be skipped by enabling store option “Direct to Shipment”, in which case the checked out order will transfer to status Processing (3) with a shipment created and marked Good-To-Go.

## **D**

### **Demand**  
_B2B/B2C_  
Demand is used with either “Allow backorders” or “Preorder” enabled. Demand will show up in the Order View, Stock View, in the Supplier Module and in some reports. It tells you what you have not yet placed Purchase Order for, and what is the amount you have on open customer orders that are not Allocated.  
Demand in the Order overview will include what’s Linked towards Purchase Order, compared to the Stock View where Linked and Demand are separated.

### **Demand (stock)**  
The quantity of said product which is on order but not linked to a supplier order or allocated. All products in unshipped orders that are back ordered or on preorder.

### **Delivery window**  
_B2B_  
Delivery Window (also known as DelWin) is used to manage when products are expected to be delivered. Every B2B order in Centra must belong to one or many Delivery Windows. Products are available for sale once the Delivery Window they belong to has been activated. The Delivery Window normally corresponds with “Order Type” logic in ERP systems. Products in a Delivery Window have available  stock based on “Stock”, “Link”, “Stock/Link”, or “Preorder”. Depending on selected option the order will act differently in the way it Allocates Stock, Links towards incoming Supplier Orders, or creates a Demand.

### **Discount**  
_B2B/B2C_  
A Discount is a setting for making a reduction off the original price of a product. It can be applied to the price of a single product or the entire order. It can also be configured as a fixed or percentage discount value.

### **Display**  
_B2B/B2C_  
In a display you choose how and where a product should be presented in the front end. You set which market, categories and variant it should be displayed in. You’ll also set the storefront product name in the “display name”. A product without display won’t appear in API responses.

## **E**

### **EAN**  
_B2B/B2C_  
European Article Number, a type of GTIN (Global Trade Item Number). It identifies a specific product, variant and size. Can be set as a field on size level which should be unique. Can also be populated with a UPC (Universal Product Code).

## **F**

### **Folder**  
_B2B/B2C_  
Folders are used to categorize products internally in Centra and used for reporting. One product can belong to at most one folder. When synchronizing data in Centra to an ERP or BI system, it is recommended to maintain the same folder structure, to ensure consistency between reports generated by the different systems. Folders are not to be exposed in B2C sales channels and are not visible in Centra Showroom.

### **Free To Allocate (stock)**
FTA = Physical - Allocated  
This is the quantity of said product which is available to allocate on orders, or simply, this is the quantity available.

## **G**

### **General Attributes**  
_B2B/B2C_  
See [Attributes](#attribute).

### **Gift certificate**  
_B2C_  
A Gift Certificate is a way to sell Gift Certificates to your B2C customers. Gift certificates can not be added to the same Selection as Products, hence it will require it’s own checkout. A Gift Certificate will create a Voucher in Centra if there is a purchase made by a Consumer, the value of the voucher will be decided by the value of the Gift Certificate and that is how much the consumer will pay.

## **H**

### **Handling cost**  
_B2B/B2C_  
An administrative cost for handling an order. Handling cost in Centra is created automatically in two ways: As a fee for handling a return or as a fee for using specific payment method.

### **Harm code**  
Harmonization code, also known as commodity code. Used for customs when exporting to certain countries. There are different standards of Harm Codes, you may be required to use one standard when selling to the USA and one Standard when you sell within the EU and a third one if you sell to Norway. There is no validation of these codes in Centra. Standards for the EU can be found here: <https://trade.ec.europa.eu/tradehelp/eu-product-classification-system#Tariff_codes>.

### **Hold** (order status flag)  
This order is on hold by manual intervention in Centra backend or by Payment methods where fraud is suspected or if the order is waiting for a notification from the Payment Service Provider. Its details can still be edited, but it cannot proceed with shipment or payment until resumed.

## **I**

### **Incoming (stock)**  
The incoming quantity of said product. This field is only populated if you’re using the Supplier Module and have supplier orders with products which are not yet delivered. The supplier order also need to have a preferred warehouse for this to show up correctly.

### **Incomplete** (order status 0)  
This is a selection before it’s checked out. It contains the list of selected items, information about language and currency or discounts, plus a list of optional shipping methods.

### **Item**  
An API response for an order, for every element of the “items” table, item is presented as “X-Y”, where X is the product display ID and Y is the size ID. Items table presents name, EAN and stock for each size of a product.

## **L**

### **Linked (stock)**  
The quantity of said product which is on order and linked towards a supplier order.

### **Lookbook**  
_B2B_  
Lookbook is a feature in Showroom that allows you to generate a link to products offered in a specific delivery window and display them without prices in order to present products to potential customers.

## **M**

### **Market**  
_B2B/B2C_  
Markets allow you to segment your store into logical entities. They control which products are available on the website, what campaigns and vouchers are active and which shipping options will be available. In B2C, Market is usually selected based on the end customer geo-location, or it can be set when the customer visits the store via a campaign URL. In B2B, markets can be configured as separate customer groups.

### **Measurement chart**  
_B2B/B2C_  
Used to display the measurements of your products. While Size Charts define product sizes (S, M, L, XL), measurement charts are used to define measurements, in specific units, for each size. For example, measuremement chart for trousers can consist of leg and waist size, defined in cm or inches, for each defined size. This data can be used when displaying products in Showroom.

## **N**

### **Newsletter**  
_B2C_  
This section will list registered customers for which “Receive newsletter” field is set to “Yes”.

## **O**

### **On delivery (stock)**  
This field will be populated with data if said product is on a delivery created from a supplier order, which are not yet accepted.

### **Order**  
_B2B/B2C_  
A document containing information about the customer or account (name, shipping address, etc.) and a list of ordered items. Selection becomes an order when you do a checkout

### **Order sheet**  
_B2B_  
An order sheet is the state of an order before it has been completed and checked out. It can be seen as an order suggestion. The Order Sheet will not become a Sales Order until it has been checked out.

### **Order date**  
_B2B/B2C_  
The date when an order is placed. In B2C the order date is the date the customer receives the receipt. In B2B, the Order Date is when either the Seller or the Buyer confirm an order.

### **Order statuses**  
_B2B/B2C_  
See [Order flow in Centra](/guides/orderflow).  

## **P**

### **Pending** (order status 1)  
This order has been checked out, with payment steps being completed. In addition to the incomplete order, it contains information on customer, shipping and payment.

### **Physical (stock)**
Physical = Free To Allocate + Allocated  
This is the quantity that you have on the shelf in the warehouse. If there are any differences, Centra wouldn’t know about.

### **PIM**  
_B2B/B2C_  
Product Information Management. See [Product Catalog](#product-catalog).

### **PO number**  
_B2B/B2C_  
Purchase Order number, stored as a string on the Wholesale orders. Usually given by a customer to mark their sales order.

### **Preorder**  
_B2B/B2C_  
Preorder function allows creating orders before goods are available, meaning a Customer could place as many units as they like on an order. Preorder can be set on a product if you want to enable Preorders for Retail, in Wholesale Preorder on products is defined by the Delivery Window.

### **Price list**  
_B2B/B2C_  
A list that contains prices for available products. For each configured store, multiple Pricelists can be defined, each using specific currency and default shipping method, and linked to one or more geo-locations. You can define multiple Pricelists for every currency, e.g. EUR EU and EUR Asia. Only one pricelist can be selected as default for any country. For B2B, two prices - Price A and B - are defined for each product, where B is RRP (Recommended Retail Price).

### **Processing** (order status 3)  
This order has at least one shipment related to it, and at least one of those shipments is not completed. Ordered items can be split into multiple shipments depending on availability and other factors.

### **Product**  
_B2B/B2C_  
In Centra, Product is a top-level definition of an item for sale. Products are split up into variants (i.e. by colour, by style), and each variant is split up into sizes according to the selected size chart. Each Product Variant has to belong to at least one display in order to be searchable and purchasable. One product can be visible in both B2B and B2C depending on how the Displays have been set up. For more details, see [Product Model](/overview/products).

### **Product Catalog**  
_B2B/B2C_  
The product catalog contains all of your Products stored in Centra, used by both B2C and B2B stores.

### **PSP**  
_B2B/B2C_  
Payment Service Provider, like Klarna or Stripe. Each PSP provides support for multiple payment methods, like credit cards, Swish, Apple Pay, bank transfers or "Buy now, pay later" agreements.

## **R**

### **Registered customers**  
_B2C_  
This section will give you a list of all of your customers, either created when placing an order, signed through registration form or created directly via the API. When creating orders, they will be linked to a registered customer by matching on their e-mail address.

### **Registered user**  
_B2C_  
A Registered customer who made a consent when confirming an order to become registered.

### **Refund**  
_B2C_  
A function to refund money to your customer in case of returns. A refund can only be made based on a Return, and the value that will be suggested to Refund will be based on the products and additional costs added to the Return.

### **Related products**  
_B2B/B2C_  
Product displays can be related in different ways. This is used mainly for B2C stores to display things like “goes well with”. But it can also be used i.e. to display that a product is available in another material.

### **Report**  
_B2B/B2C_  
Used to create and export reports, like sales figures. Most reports can be configured to be exported in CSV or XLS format. You can also make it export to an e-mail address, in which case there will be a link sent to the e-mail of your choice where the file can be downloaded.

### **Reuse value**  
_B2B/B2C_  
Boolean attribute of a Voucher. Controls whether or not the remaining value of a partially used Voucher can be used on another order.

## **S**

### **Sales Rep**  
The user responsible for a Wholesale B2B account.

### **Selection**  
_B2B/B2C_  
A selection is where products are held when chosen for purchase. Once the selection is checked out, it becomes an Order. Typically in B2C we will call it Cart and in B2B an Order Sheet.

### **Sent date**  
Timestamp for when a shipment was marked as “Shipped” and the shipment was completed.

### **Serializable product**  
_B2B/B2C_  
Boolean attribute of a Product. A product is serializable if every item sold is unique, identified 1:1 by its serial number. For example, a red summer shirt size XL is not serializable, since it’s exactly the same as all other red summer XL shirts. Serial number can be appended to the shipment details when specific, serialized item is being added to shipment.

### **Shipment**  
_B2B/B2C_  
A Shipment is generated from a sales order. One order can have multiple shipments, which will be used by a warehouse to print packing lists and print delivery notes. When a shipment is completed there is an option to save tracking number so that the information can be sent to the consumer. Shipment is also the entity from where you can create and Invoice.

### **Shipping cost**  
_B2B/B2C_  
The price of the freight of the order. It can be defined as a fixed price, or depend on the number and/or weight of items in order.

### **Size chart**  
_B2B/B2C_  
A chart that contains multiple sizes. Each variant for a product must have a size chart selected

### **SKU**  
Stock Keeping Unit. In Centra the full SKU is built from three different values: main product SKU, variant SKU and size SKU.

### **Static**  
In Centra, statics are used to define some of the commonly used parts of the system. For example, e-mail statics can be used to define templates for order confirmations and cancellations. Other statics can define store terms and conditions, or items to be used in the Front End - a static button text or footer content. There are some pre-existing statics, and the customer has the option to add their own. Statics are defined by their name, type and the Store they’re configured for.

### **Store**  
_B2B/B2C_  
Centra can have multiple stores in the same instance. The usual setup is to have two stores - one for B2C and one for B2B. It is however possible to have more than one B2C store if needed. Each Store can have its own plugins configured. Each Store also has its own structure in terms of Brand, Categories, Pricelists and so forth. In a more general term a Store is a separate sales channel. However if you are to create two Wholesale stores they will share the same invoice number, hence you can not use stores for a multi company setup in B2B/Wholesale if you want to create Invoices.

### **Supplier**  
_B2B/B2C_  
A Supplier in Centra is from where your products are purchased or manufactured. It’s from a supplier you can create supplier orders and supplier orders can be shown in the Order API for integrations with either supplier or warehouses. It’s on the supplier you add your purchase price/cost price for your products.

### **Supplier Delivery**  
_B2B/B2C_  
From a supplier order you can create one or many deliveries. On a delivery you have the option to add additional cost, meaning you can get a correct landed cost for your products when they are added to your warehouse.

### **Supplier Order**  
_B2B/B2C_  
You can base a supplier order on the demand created from your preorders, additionally you can add over buy to you order, meaning you will have more to sell when you receive the goods from your supplier.

## **T**

### **Terms**  
_B2B_  
Terms is a section where you setup your incoterms and payment terms to be used for your customers. They are defined as store statics.

## **U**

### **Unlinked (stock)**  
The unlinked quantity of said product. This field is only used if you’re using the Supplier Module.

### **Unshipped (stock)**  
The quantity of said product which is allocated on order but not yet shipped.

## **V**

### **Variant**  
_B2B/B2C_  
Every product in Centra has at least one Variant. A variant is typically a color or material of a product. For more details, see [Product](#product).

### **Voucher**  
_B2B/B2C_  
A voucher is used to give rebates, free shipping, free products etc. to a customer. When a voucher is applied, the selection will be updated to reflect changes made by the voucher. A voucher can be automatically applied based on certain rules, or a code can be entered. For more details, see [Vouchers](/overview/promo#voucher).

## **W**

### **Warehouse**  
_B2B/B2C_  
A warehouse in Centra is where stock is stored. Warehouse is defined by its name and priority. Each warehouse can belong to one or more warehouse groups. When stock is added, either by importing a CSV or via stock editor, it always needs to be added to one of the warehouses.

### **Warehouse group**  
_B2B/B2C_  
Consists of one or more warehouses sorted by priority. One warehouse group can belong to multiple markets, but two groups cannot belong to the same market. With the help of a warehouse group, you will set for which markets and stores specific warehouses is used for. Each market has exactly one default warehouse group.

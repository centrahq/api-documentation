---
title: From basket to shipment: Order flow in Centra
altTitle: Order management
excerpt: Learn about the difference between Selections and Orders, basic Order flow in Centra, and all statuses an Order can have.
taxonomy:
    category: docs
---

## Creating and completing an order

### Selections

In Centra, a list of chosen products that are not yet an order are referred to as a Selection. Selections work differently for Direct-To-Consumer and Wholesale, but the overall concept is the same.

#### Direct-To-Consumer (B2C) Selections, also known as Carts

Centra stores both temporary Selections for users not logged in and Selections for logged in users. By default, selections for anonymous users are stored 30 days. When a user logs in, any temporary Selection is merged with any Selection stored in the user’s account.

#### Wholesale (B2B) Selections, also known as Order Sheets

Wholesale Selections are stored for each account and can be viewed and manipulated through the Showroom by any Centra user with the appropriate access rights. This may include Buyers, Agents, Sellers and Centra Administrators. In addition, Selections can be viewed and modified by anonymous users with a magic link generated from the Showroom.

#### Abandoned cart recovery 

Centra automatically detects Selections that are not checked out and generates Abandoned Cart events that are transferred to marketing applications for retargeting applications.

### Order flow

Here's the basic order flow as seen in Centra backend.

![OrderFlow](order-flow.png?lightbox=3333x4000&resize=1200)

### Order statuses

* **Incomplete** (0)  
  This is a selection before the checkout is completed. It contains the list of selected items, information about language and currency, discounts, plus a list of optional shipping methods.
* **Pending** (1)  
  This order has been checked out, with payment steps being completed. In addition to the incomplete order, it contains information on customer, selected shipping and payment. This step can be skipped by enabling the Store option "Autoconfirm Orders".
* **Confirmed** (2)  
  This order has been manually confirmed in the Centra admin panel, or confirmed automatically by appropriate Store setting. Only confirmed orders can have shipments created. This step can be skipped by enabling store option “Direct to Shipment”, in which case the checked out order will transfer to status Processing (3) with a shipment created and marked Good-To-Go.
* **Processing** (3)  
  This order has at least one related shipment, and at least one of those shipments is not completed. Ordered items can be split into multiple shipments depending on availability and other factors.
* **Completed** (4)  
  This order has completed payment capture and expedited all related shipments. Additional information on shipping details and tracking number can be added when completing each shipment.
* **Archived** (5)  
  This order has been archived and will not show up in search results in Centra. Depending on API plugin configuration, it may also be hidden in API responses.
* **Cancelled** (6)  
  This ordered has been cancelled at any stage before the payment was captured (once the payment capture has been successful, a refund should be made instead of cancelling the order). Cancelled orders have the option to be fully and irreversibly deleted from the database.
* **Hold** (flag)  
  This order is on hold by manual intervention in Centra backend, by Payment methods where fraud is suspected, or if the order is waiting for a notification from the Payment Service Provider. Its details can still be edited, but it cannot proceed with shipment or payment until resumed.

## Creating and completing a return

Here's the basic return flow as seen in Centra backend.

![ReturnFlow](return-flow.png?lightbox=3333x4000&resize=1200)

Returns in Centra are directly tied to order shipments. When browsing a shipment, you can select to return one, many or all items in that shipment.

After selecting items to return, you need to decide if you want to put them back into stock or remove them. This depends on your business logic and the state of the returned goods. If you choose to insert the items back into stock, you can either re-add it to the warehouse it was originally allocated from, or select to which warehouse to return the items into.

Once the return is created, it will have "Pending" status which in API will show as `"completed": false`. From this point the return can be completed without a refund, or completed with sending a refund request to a PSP (Payment Service Provider). Additionally, at any point (both before and after completing the return) you can create selection based on that return, which can be used to easily create an exchange order.

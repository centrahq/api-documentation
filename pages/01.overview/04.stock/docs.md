---
title: Somewhere to store it: Warehouses and stock
altTitle: Inventory management
excerpt: Learn about how stock works in Centra: Warehouses, Warehouses Groups and stock level definitions.
taxonomy:
    category: docs
---

As mentioned in the previous chapters, each Product has at least one Variant, and every Variant has at least one Size. In Centra, stock is defined on the Size level, which means we keep information about inventory for every Size of every Variant of every Product.

### Warehouses and Allocation Rules

A warehouse in Centra is where stock information about every product size is stored. Warehouse is defined by its name and priority. Each Warehouse can belong to one or more Allocation Rules. When stock is added, either by importing a CSV or via stock editor, it always needs to be added to one of the Warehouses. Warehouses in Centra don't hold any information about storage locations.

One Allocation Rule can belong to multiple Markets, but one Market can have only one Allocation Rule. This way Centra controls which Warehouses' stock will be displayed in each Market.

### Example stock levels and definitions

<div class="tableWrapper" markdown='1'>
Physical | FTA | Allocated | Linked | Demand | Unshipped | Available Now | Unlinked | Incoming | On Delivery | Available
---|---|---|---|---|---|---|---|---|---|---
38 | 18 | 20 | 2 | 1 | 4 | 17 | 8 | 10 | 0 | 27
</div>

* **Physical** = FTA + Allocated  
This is the quantity that you have on the shelf in the warehouse. If there are any differences, Centra wouldn’t know about it.
* **FTA** = Physical - Allocated - Warehouse Threshold/Product Variant offset  
Free to Allocate. This is the quantity of said product which is available to allocate on orders, or simply, this is the quantity available. 
Quantity might be protected from being sold by "Warehouse Threshold" or "Product variant offset" setting. 
If product offset is greater than 0, it overrides warehouse threshold settings.
* **Allocated** = Physical - FTA  
The number of said products that are allocated on orders or shipments which are not yet completed.
* **Linked**  
The quantity of said product which is on order and linked towards a supplier order.
* **Demand**  
The quantity of said product which is on order but not linked to a supplier order or allocated. All products in unshipped orders that are back ordered or on preorder.
* **Unshipped**  
The quantity of products on the order which are not yet shipped, including preorder or demand.
* **Available now** = FTA - Demand  
The quantity available right now of said product.
* **Unlinked**  
The unlinked quantity of said product. This field is only used if you’re using the Supplier Module.
* **Incoming**  
The incoming quantity of said product. This field is only populated if you’re using the Supplier Module and have supplier orders with products which are not yet delivered. The supplier order also need to have a preferred warehouse for this to show up correctly.
* **On delivery**  
This field will be populated with data if said product is on a delivery created from a supplier order, which are not yet accepted.
* **Available** = FTA - Demand + Incoming  
The total of said product’s stock including incoming supplier orders.

Available options to set threshold or offset are available in AMS:  
* Warehouse threshold setting: Setup -> Warehouses -> Add threshold  
* Product variant offset: Edit stock settings -> Offset

It's worth mentioning that these options do not apply to AMS full admin, that selection will not be blocked by the settings.

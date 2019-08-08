---
title: Showcase it: Products, variants, sizes and displays
altTitle: Product model
taxonomy:
    category: docs
---

Centra uses a predefined product model that is optimized to solve the complexities of fashion and lifestyle products. The structure cannot be changed by users, however users can switch some functionalities on and off and define their own attributes.

Two different concepts for modelling and storing items for sale are used in Centra: Displays and Products. This includes Variants and Sizes of Products.

![ProductModel](product-model.png?lightbox=3333x4000&resize=1200)

### Displays

A Display is, just like a display in a brick-and-mortar store, one or more related items for sale that is arranged and presented in a way that might trigger a purchase. An item for sale might be included in more than one Display. You might for example have a unisex item included both in a Display in the Women’s and Men’s department. When you query the API for what to show on a category page, you will get a set of Displays back, and when you query the API for what to show on a product page, you will get a single Display.

### Products, variants and sizes

A Product is stored in a hierarchical structure, in which the Product is broken down into Variants and Sizes. The Product represents a certain design. Variants are different versions of the same product, typically different colors. Sizes are the different sizes you can buy the style in. This product structure enables very efficient product information management.

Most information is stored on the Product level, where you find the Folder, Collection and all basic information such as Country of Origin, HS Code and Material Composition.

The Variant level focuses on media (images) and a few attributes, notably color. Campaigns can be set on the Variant level. Besides actual size, the Size level stores GTINs (UPC or EAN codes), weight and dimensions. Stock inventory is stored on the Size level, as the size represents the physical item that exists in a warehouse.

All products have at least one Variant and all Variants have at least one Size, even if it is a one-size product.

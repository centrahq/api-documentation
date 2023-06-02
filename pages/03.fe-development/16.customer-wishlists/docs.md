---
title: Customer wishlist
altTitle: Wishlist
taxonomy:
  category: docs
excerpt: Wishlists allows customers to save products to a list for later viewing or purchase
---

## Overview

The wishlist feature allows shoppers to add products to the list in one click, review those items at a later time and keep track of the prices and other product information. In this article we describe how to set it up.

The scope of the wishlist feature currently includes:

- Ability to have one wishlist per customer
- Ability to add products to a wishlist
- Ability to remove products from a wishlist

## Reasons customers love wishlists

- Saving items for later so that they are not lost or forgotten  
- Tracking items that are currently out of the shopper's price range but might be on sale in the future  
- Creating lists for special events such as a holiday or a birthday  

While these are important reasons for customers, the additional benefit of the wishlist is that it allows e-comm merchants to limit cart abandonment by encouraging customers to use the wishlist for item organization instead of using the cart. This is because a large part of shoppers use the cart with an intention to organize items for later purchasing, essentially as a wishlist, which is reflected in high cart abandonment rate. Customer wishlists feature allows users to add products to the list in one click, review those items at a later time, and track the prices and other information.

## What is required to enable Customer wishlists?

For now, the wishlist feature is only available in our Checkout API. It needs Frontend implementation to work. Here is how to implement it in your Frontend.

## Wishlist functionalities

### Which products can be added to the wishlist?

All products can be added to the wishlist, including the ones currently out of stock. The only exception is flexible bundles. Currently, the wishlist feature supports up to 10000 products in a single wishlist.

### One wishlist per shopper

Each shopper can have one wishlist connected to their account on your website. Your shopper must be logged in. Read here on [how to handle customer registration, login and password reset email flow](/fe-development/fe-elements#customer-registration-and-login).

### Allow customers to add products to their wishlist

You can allow customers to add products to the wishlist from any place in the purchasing journey: product listing page, product details page, basket, checkout etc. However, the place from which the end customer adds products to a wishlist is determined by your frontend implementation. At the moment, it is only possible to add products to a wishlist one item at a time.

### Allow customers to remove products from their wishlist

You can allow customers to remove products from the wishlist. Typically this is done from the customer account section on the wishlist level.

## Getting wishlist information through APIs

Currently, the functionality supports one wishlist per user. The default wishlist can be requested by identifier 0 in the request to get the customer wishlist:

`GET <api-url>/customer/wishlists/0`

It includes all the needed information to display wishlist data like:

- `id`  
- `isDefault`  
- `items`  

You can filter the items using the paginator query parameters:

`GET <api-url>/customer/wishlists/<wishlist-id>?page=<items-page>&limit=<items-limit>`

Parameters are:  
- `<wishlist-id>`: The ID of the wishlist, currently only one wishlist ID `0` is supported per customer  
- `<items-page>`: The page number of the results to return  
- `<items-limit>`: Limit the number of wishlist items returned  

#### Success

If the wishlist is found for the end user, the response will be:
```json
{
  "token": "...",
  "wishlist": {
    "wishlist": 0,
    "isDefault": true,
    "items": [
      {
        "wishlistItem": 1,
        "product": 1,
        "createdAt": "2023-05-05 10:39:52"
      }
    ]
  }
}
```

#### Success, empty wishlist

If the customer doesn't have a wishlist yet, the response will be:
```json
{
  "token": "...",
  "wishlist": {
    "wishlist": 0,
    "isDefault": true,
    "items": []
  }
}
```

#### Failure

If a non-existing wishlist identifier is provided, an error will be returned:
```json
{
  "token": "...",
  "errors": {
    "wishlist": "not found"
  }
}
```

### Adding the product to wishlist through the Checkout API

By default, each user has a wishlist, but it's not stored in the database until a product is added to the wishlist. To create the wishlist, use the following API endpoint:

`POST <api-url>/customer/wishlists/0/items/<item-id>`

Where `<item-id>` is [identifier of display item](/fe-development/fe-elements#why-do-i-see-different-product-ids-in-the-centra-backend-and-in-checkout-api).
  
### Validation errors

The endpoint has validation for several cases, including:

#### Display item not found

```json
{
  "token": "...",
  "errors": {
    "displayItem": "display item not found"
  }
}
```

#### Wishlist not found

```json
{
  "token": "...",
  "errors": {
    "wishlist": "Could not find a wishlist with id <id>"
  }
}
```

#### Duplicate item in wishlist

```json
{
  "token": "...",
  "errors": {
    "wishlist": "Cannot add display 1 to wishlist 1: duplicate item"
  }
}
```

#### Success

```json
{
  "token": "...",
  "wishlist": {
    "wishlist": 0,
    "isDefault": true,
    "items": [
      {
        "wishlistItem": 1,
        "product": 1,
        "createdAt": "2023-05-05 10:39:52"
      }
    ]
  }
}
```

### Removing the product from the wishlist

Use endpoint:

`DELETE <api-url>/customer/wishlists/0/items/<item-id>`

Where `<item-id>` is identifier of display item.

### Validation errors

The endpoint provides validation for several cases, including:

#### Display item not found

```json
{
  "token": "...",
  "errors": {
    "displayItem": "display item not found"
  }
}
```

#### Wishlist not found

```json
{
  "token": "...",
  "errors": {
    "wishlist": "Could not find a wishlist with id <id>"
  }
}
```

#### Current user is not owner of selected wishlist

```json
{
  "token": "...",
  "errors": {
    "user": "Current user is not owner of this wishlist"
  }
}
```

#### Success

```json
{
  "token": "...",
  "wishlist": {
    "wishlist": 0,
    "isDefault": true,
    "items": []
  }
}
```

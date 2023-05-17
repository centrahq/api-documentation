---
title: Customer wishlists
altTitle: Wishlists
taxonomy:
  category: docs
excerpt: Feature that allows customers to save products to a list for later viewing.
---

## Overview

Customer wishlists is a feature that enhances the shopping experience by allowing customers to
add desired products to the wishlist. Wishlists serve as a convenient way for customers to save
products they are interested in, making it easier for them to track and revisit those items at a later time.

The scope of the wishlist feature currently includes

* Ability to have one wishlist per customer
* Ability to add products to a wishlist
* Ability to remove products from a wishlist

## What is required to enable Customer wishlists?

Currently, Customer wishlists feature available in CheckoutAPI under the feature flag. Please contact our support to request enabling the feature.

## How does Customer wishlists work?

Customer wishlists feature allows users to add products to the list in one click,review those items at a later time and track the prices and other information.

### Which products can be added to wishlist?

All products are possible to add to the wishlist, including the out of the stock ones.
The lone exception is that flexible bundles are not possible to add to the wishlist.
Currently, wishlist supports 10000 products in a single wishlist.

### Getting wishlist information through APIs

Currently, functionality supports one wishlist per user.
Default wishlist can be requested by identifier 0 in the request to get customer wishlist send

`GET <api-url>/customer/wishlists/0` request.

It includes all the needed information to display wishlist data like:

* `id`
* `isDefault`
* `items`

You can filter the items using the paginator query parameters:

`GET <api-url>/customer/wishlists/<wishlist-id>?page=<items-page>&limit=<items-limit>`

Parameters:
<wishlist-id> - Id of wishlist, it can be sent as 0 to fetch the default wishlist.
<items-page> - Number of page of results to return.
<items-limit> - Limit the number of wishlist items returned.

#### Success

If wishlist found for the end user, then the response will be:

```json
{
  "token": "...",
  "wishlist": {
    "wishlist": 1,
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

By default, each user has a wishlist, but it's not stored in the database until a product is added to the wishlist. 
To create the wishlist, use the following API endpoint:

`POST <api-url>/customer/wishlists/0/items/<product-id>`

where <product-id> is identifier of display item.

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

#### Current user is not owner of selected wishlist

If we pass, not the 0 as <wishlist-id> and if we found a wishlist of different user

```json
{
  "token": "...",
  "errors": {
    "wishlist": "Invalid customer ID: 1, expected customer ID: 2"
  }
}
```

#### Success

```json
{
  "token": "...",
  "wishlist": {
    "wishlist": 1,
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

### Removing the product from the wishlist through the Checkout API

[notice-box=info]
Here we have to pass exact id of wishlist to remove the product from there
[/notice-box]

`DELETE <api-url>/customer/wishlists/1/items/<product-id>`

where <product-id> is identifier of display item.

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
    "wishlist": 1,
    "isDefault": true,
    "items": []
  }
}
```

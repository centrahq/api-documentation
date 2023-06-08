---
title: Klarna Payments
altTitle: Klarna Payments
excerpt: Learn how to use Klarna Payments plugin.
taxonomy:
category: docs
---

Klarna Payments is a PSP solution designed to incorporate Klarna's payment methods to existing checkout.
By integrating with Klarna Payments, merchants retain control over the checkout experience, while also offering customers the convenience of Klarna's payment options to finalize their purchases.

## Store plugin configuration 

![store_plugin.png](store_plugin.png)

### Required configuration

To ensure that Klarna Payments plugin is properly set up for testing fill in following configuration options:

- Status - set status to `Active`
- Plugin name - Name of the plugin
- Name in frontend - Name of the plugin returned by the API
- URI - Plugin identifier. Make sure that you're assigning a unique URI to the store plugin, especially if you're using multiple Klarna Payments plugins with plugin restrictions.
- Secret - Set up to your [MID](https://www.klarna.com/us/business/merchant-support/what-is-a-merchant-id/) configuration
- E-Store ID - Linked to your [MID](https://www.klarna.com/us/business/merchant-support/what-is-a-merchant-id/)
- Klarna endpoint - Should point towards proper region as per your [MID](https://www.klarna.com/us/business/merchant-support/what-is-a-merchant-id/) configuration

### Testing

For testing, set `Test mode` to `Yes`

![test_mode.png](test_mode.png)

### Available configuration options

- Default locale - Default locale sent to Klarna when payment session is initiated when Centra cannot match any locale on customer/basket level.
- Send product images to Klarna 
- Product image size
- Send product URLs to Klarna
- Frontend prefix for product URLs
- Send product sizes to Klarna

## Integration parties (APIs) SDK/Server side etc.

![integration_apis.png](integration_apis.png)

API references:
- [Klarna Payments API](https://docs.klarna.com/api/payments/)
- [Klarna Payments SDK](https://docs.klarna.com/klarna-payments/in-depth-knowledge/klarna-payments-sdk-reference/)
- [Centra Shop API](https://docs.centra.com/swagger-ui/?urls.primaryName=ShopAPI#/)
- [Centra Checkout API](https://docs.centra.com/swagger-ui/?urls.primaryName=CheckoutAPI)

## Authorisation flow

### Checkout init

![checkout_init.png](checkout_init.png)

1. `POST /payment` Shop API/Checkout API request
2. Centra creates session with Klarna and responds to Frontend with `client_token`
3. Frontend calls `SDK.init()` with `client_token` obtained from `POST /payment` response
4. Frontend calls `SDK.load()` and Klarna Payments widget is presented to the shopper in the proper container

### Updates in the checkout





## Best practices

### Locking the checkout to prevent updates during ongoing API calls


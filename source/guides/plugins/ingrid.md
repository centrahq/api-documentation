# Ingrid shipping plugin

### How do I add cart attributes to the Ingrid session?

When Ingrid is enabled as a plugin, calls to `PUT checkout-fields` (ShopAPI) and `PUT payment-fields` (CheckoutAPI) will listen to the value `ingridAttributes` inside the `additionalFields`. This field should contain an array of strings, like this:

```json
{
  "additionalFields": {
    "ingridAttributes": ["attribute1", "attribute2"]
  }
}
```

These attributes will then be set on the Ingrid cart as cart attributes.

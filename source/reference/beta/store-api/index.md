# Overview

```eval_rst
.. api-name:: Store API
   :version: 1
```

```eval_rst
.. note:: The Store API is not yet released. We will soon post updates about the introduction of the Store API.
```

## Existing APIs

You can find API reference for our existing APIs here:

```eval_rst
.. table::
   :widths: grid
   :class: api-table
   
   ======================== ===================== ==================================================== ============================================================================================= ================
    API                      Type                  Security                                             Description                                                                                   Status
   ======================== ===================== ==================================================== ============================================================================================= ================
   `Shop API`_               REST/JSON             Authentication mandatory                             Used for server-side implementation of an e-commerce website.                                 Stable release
   `Checkout API`_           REST/JSON             Directly callable from a JavaScript store frontend   Used for client-side implementation of an e-commerce website.                                 Stable release
   `Order API`_              REST/JSON             Authentication mandatory                             Used for backend implementations using a REST API to handle orders, customers and products.   Stable release
   `Subscription API`_       REST/JSON             Authentication mandatory                             Used for recurring order creation using subscription payment methods.                         Stable release
   ======================== ===================== ==================================================== ============================================================================================= ================

.. _Shop API: /reference/stable/shop-api/index
.. _Checkout API: /reference/stable/checkout-api/index
.. _Order API: /reference/stable/order-api/index
.. _Subscription API: /reference/stable/subscription-api/index
```

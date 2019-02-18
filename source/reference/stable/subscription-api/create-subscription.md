# Create subscription

```eval_rst
.. api-name:: Subscription API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/subscription/order

.. authentication::
   :api_key: true
```

Add a subscription with payment details, will not be completed/registered as a completed subscription until `subscription/payment` has been called.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``name`` ``sname``

       .. type:: string
          :required: true

     - First and last name of the customer

   * - ``email``

       .. type:: string
          :required: true

     - Customer's email

   * - ``address`` ``coaddress`` ``city`` ``state`` ``zipcode`` ``phoneNumber``

       .. type:: string
          :required: false

     - Address information for the customer.

   * - ``country``

       .. type:: string
          :required: true

     - The country of the customer. ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)

   * - ``package``

       .. type:: array
          :required: true

     - Array with Package IDs for each package you want in the subscription.

       For example: ``package[]=3232&package[]=4344``

   * - ``payment``

       .. type:: string
          :required: true

     - URI of payment plugin to be used. Needs to be set up before as a payment plugin for the store.

       .. note:: There are only a few payment plugins that supports subscription services. Please make sure the payment plugin you set up allows it.

   * - ``payment_url``

       .. type:: string
          :required: false

     - A url where the customer should be redirected to when payment is completed.

   * - ``pnr``

       .. type:: string
          :required: false

     - The social security number for the user, used for some payment plugins to invoice the customer.

   * - ``sendNewsletter``

       .. type:: boolean
          :required: false

     - If the user opted in to a newsletter subscription.

   * - ``startdate``

       .. type:: datetime
          :required: false

     - Default ``today``. The date when the subscription should start. The first order will be created first after this date.

   * - ``interval``

       .. type:: int
          :required: false

     - Default ``14``. The interval between each subscription. Depending on `intervaltype` it will be months or days.

   * - ``intervaltype``

       .. type:: enum
          :required: false

     - Default ``D``. The type of interval for the subscription.

       * ``M`` interval is in months.
       * ``D`` interval is in days.

   * - ``consent``

       .. type:: object
          :required: false

     - A list of consents the customer agreed to. The ``key`` of each item in the object is the key for the consent. If the consent key does not exists already, it will be added automatically.

       For example like this: ``consent[newsletter_consent][consent_name]=boop``

       .. list-table::
          :widths: auto

          * - ``consent_name``

              .. type:: string

            - The name of the consent.

          * - ``consent_text``

              .. type:: string

            - The description of the consent.

          * - ``consent_version``

              .. type:: string

            - The version of the consent.

          * - ``consent_language``

              .. type:: string

            - The language of the consent. No validation is made on this field for the formatting of the language code.

```

## Request examples

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/subscription/order HTTP/1.1
   Content-Type: application/x-www-form-urlencoded

   name=Kalle&sname=Anka&address=Paradisäppelvägen+9&
   coaddress=&city=Ankeborg&state=&zipcode=12345&
   country=SE&email=kalle.anka@example.com&package[]=1&package[]=3&
   payment=nets[&pnr=880101-7845]

```

Example Request with consents:

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/subscription/order HTTP/1.1
   Content-Type: application/x-www-form-urlencoded

   name=Kalle&sname=Anka&address=Paradisäppelvägen+9&coaddress=&
   city=Ankeborg&state=&zipcode=12345&country=SE&
   email=kalle.anka@example.com&package[]=1&package[]=3&
   payment=nets[&payment_url=https://...][&pnr=880101-7845]&
   consent[direct_marketing]=1&
   consent_name[direct_marketing]=Direct%20Marketing&
   consent_version[direct_marketing]=1.1&
   consent[newsletter]=1&consent_name[newsletter]=Newsletter&
   consent_version[newsletter]=v2&consent_language[newsletter]=sv_SE
```

## Response

`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - ``status``

       .. type:: string
          :required: true

     - ``ok`` if success, else ``no``.

   * - ``id``

       .. type:: int
          :required: true

     - The ID of the subscription that was created.

   * - ``payment``

       .. type:: object

     - A payment object with information on how finalize the payment.

       .. list-table::
          :widths: auto

          * - ``url``

              .. type:: string

            - A URL to redirect the user to. This could be to an external payment provider depending on the payment plugin.

          * - ``value``

              .. type:: string

            - The total value of the subscription.

          * - ``currency``

              .. type:: string

            - The currency that the subscription was registered with, ``SEK``, ``USD``, ``EUR``, etc.

   * - ``msg``

       .. type:: string
          :required: false

     - If ``status`` returns ``no``, this value should send back a message why it failed.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "id": 3,
     "payment": {
       "url": "https://...",
       "value": "123.50",
       "currency": "SEK"
     }
   }
```

## Error examples

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "Could not register customer",
     "error": true,
     "errors": [
       "email",
       "payment"
     ]
   }
```

Bad payment method:

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "Bad Payment Method",
     "error": true,
     "message": "Error message"
   }
```

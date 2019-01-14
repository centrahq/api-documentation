# Get customer

```eval_rst
.. api-name:: Order API
   :version: soon deprecated

.. endpoint::
   :method: GET
   :url: *base*/customers/*customerId*

.. authentication::
   :api_key: true
```

Return customer by specified Id.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``customerId``

       .. type:: int
          :required: true

     - The ``customerID`` from :ref:`List customers <order-api-list-customers>`.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/customers/4234 HTTP/1.1

```

```eval_rst
.. _order-api-get-customer-response:
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

   * - ``customer``

       .. type:: object
          :required: true

     - The customer object.

       .. list-table::
          :widths: auto

          * - ``customerId``

              .. type:: string

            - ID of the customer.

          * - ``email``

              .. type:: string

            - Email for the customer.

          * - ``address1`` ``address2`` ``zipCode`` ``city`` ``state``

              .. type:: string

            - The address of the customer

          * - ``country``

              .. type:: string

            - The country of the customer. ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).

          * - ``consents``

              .. type:: array

            - List of consents the customer has accepted. These consents are mostly created from external systems that can select their own data in these fields.

              .. list-table::
                 :widths: auto

                 * - ``key``

                     .. type:: string

                   - The key for this specific consent.

                 * - ``name``

                     .. type:: string

                   - Name of consent.

                 * - ``consented``

                     .. type:: boolean

                   - If the customer has consented to this or not.

                 * - ``text``

                     .. type:: string

                   - The description of this consent.

                 * - ``language``

                     .. type:: string

                   - The language for this consent. No restrictions on the format of the language code.

          * - ``created``

              .. type:: datetime

            - Date when the customer was created.

          * - ``newsletter``

              .. type:: boolean

            - If the customer has opt-ed in for newsletters.

          * - ``modified``

              .. type:: datetime

            - Date when the customer was modified.

          * - ``registered``

              .. type:: boolean

            - If the customer was registered, which means it is allowed to sign in.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
       "status": "ok",
       "customer": {
           "customerId": "4",
           "email": "jon.snow@example.com",
           "firstName": "Jon",
           "lastName": "Snow",
           "address1": "Time Square 55",
           "address2": "",
           "zipCode": "2456",
           "city": "Tampa",
           "state": "LA",
           "country": "US",
           "phoneNumber": "096456192",
           "newsletter": true,
           "gender": "",
           "registered": false,
           "consents": [
               {
                   "key": "test_key1",
                   "name": "Consent1",
                   "consented": true,
                   "text": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley ",
                   "language": "",
                   "version": "1",
                   "created": "2018-03-15 20:40:36",
                   "modified": "2018-03-15 20:40:36"
               },
               {
                   "key": "test_key2",
                   "name": "Consent2",
                   "consented": false,
                   "text": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley ",
                   "language": "EN",
                   "version": "",
                   "created": "2018-03-15 20:41:14",
                   "modified": "2018-03-15 20:41:14"
               }
           ],
           "created": "2018-03-15 20:42:59",
           "modified": "2018-03-15 20:42:59"
       }
   }

```

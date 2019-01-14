# Header 1

```eval_rst
.. api-name:: API-name
   :version: api-version

.. endpoint::
   :method: POST
   :url: /url

.. authentication::
   :api_key: true
   :organization_access_token: true
```

## Header 2

A Regular list:

* Item 1
* Item 2
  * Sub Item
  * Sub item 2
* Item 3

```eval_rst
.. note::
   This is a :doc:`notification</reference/formatting>`.
```

```eval_rst
.. warning::
   This is a :doc:`warning</reference/formatting>`. It needs rSt formatting of links.
```

```eval_rst
.. _header-reference:
```

### Header with a reference

[link to the reference](header-reference)

```eval_rst
Another link in rST to a :ref:`reference <header-reference>`.
```

### Header 3

Regular **bold** text with `code` inline and probably a [link to something](https://centra.com).

### Regular list table

```eval_rst
.. list-table::
   :widths: auto

   * - ``lines``

       .. type:: array
          :required: false
          :storetype: b2b

     - Regular table with a :doc:`link </reference/formatting>`. We need to use rSt formatting in these tables, but they're *really* nice!

   * - ``lines``

       .. type:: array
          :required: true
          :storetype: b2c

     - Regular table
```

### Deep list table

```eval_rst
.. list-table::
   :widths: auto

   * - ``lines``

       .. type:: array
          :required: true

     - Nested table

       Very nice.

       .. list-table::
          :widths: auto

          * - ``id``

              .. type:: string

            - One level down: ``abc123``. Here's a :doc:`link </reference/formatting>`.

          * - ``type``

              .. type:: object
                 :required: true
                 :storetype: b2c

            - Another one in the list. B2C only.

              .. list-table::
                 :widths: auto

                 * - ``id``

                     .. type:: string

                   - Another level down: ``abc123``. Here's a :doc:`link </reference/formatting>`.

                 * - ``id2`` ``id3`` ``id4``

                     .. type:: string

                   - Another level down: ``abc123``. Here's a :doc:`link </reference/formatting>`.


   * - ``lines2``

       .. type:: array
          :required: true

     - An array of objects containing the order line details you want to create a shipment for.  If you send an empty
       array, the entire order will be shipped. If the order is already partially shipped, any remaining lines will be
       shipped.
```

### Multi column table

```eval_rst
.. list-table::
   :header-rows: 1

   * -
     - API key
     - Organization access token
     - App access token (OAuth)

   * - **Access level**
     - Access to all actions on the payment processing APIs for a specific payment profile.
     - Access to the API actions you selected when creating the token.
     - Access to the API actions the app user gave your app explicit permission to.

   * - **Requirements**
     - Create a payment profile first via
       `Dashboard: Profiles overview <https://www.example.com>`_, or using the X.
     - None.
     - Create an application, then have a user authorize your app to access their account data. See
       X for more information.

   * - **Test mode**
     - API keys come in pairs. Use the Test API key for test mode.
     - Use the ``testmode`` parameter in your request.
     - Use the ``testmode`` parameter in your request.

   * - **Create via**
     - `Dashboard: API keys <https://www.example.com>`_
     - `Dashboard: Organization access tokens <https://example.com>`_
     - `OAuth authorization flow <https://example.com/3>`_
```

### Response
`200` `application/json`

### Regular code block

```
{"ok": "yes"}
```

### Syntax highlighted code block

```eval_rst
.. code-block:: php

  <?php

  echo "ok";
```

### Example

This one needs the header "Example" to work.

```eval_rst
.. code-block-selector::
   .. code-block:: bash
      :linenos:

      curl -X DELETE <base>/payments/abc \
         -H "Authorization: Bearer xyz"

   .. code-block:: php
      :linenos:

      <?php
      $centra = new \ApiClient();
      $centra->setApiKey("xyz");
      $canceled_payment = $centra->delete("abc");
```

### Example request

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-Type: application/json

   {
       "resource": "order",
       "id": "xyz"
   }
```

# Anonymize customer

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: PUT
   :url: *base*/anonymize-customer/*customerId*

.. authentication::
   :api_key: true
```

This endpoint will anonymize all personal data for a customer identifed by the customer id.

```eval_rst
.. warning:: This is irrevocable. Personal data will be permanently deleted. This may include financial data. Invoices due to legal requirements will NOT be anonymized.
```

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``customerId``

       .. type:: int
          :required: true

     - The ``customerID`` from :ref:`List customers <order-api-list-customers>`.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   PUT <base>/anonymize-customer/123 HTTP/1.1

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

   * - ``msg``

       .. type:: object
          :required: true

     - The response if the anonymization was successful or an error if ``status`` is ``no``.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "msg": "The personal data has been anonymized."
   }
```

## Error example

If the customer was not found:

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "The customer was not found."
   }
```

If the customer was already anonymized:

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "The personal data was already anonymized."
   }
```

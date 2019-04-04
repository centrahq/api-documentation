---
title: Authentication
taxonomy:
    category: docs
---

Here are the different authentication methods used today:

* **API key** A shared secret generated in the Plugin settings of the API.

You can use the `Authorization: Bearer X`-header with the token, this is the suggested method when posting JSON.

The overview section of each API Reference might also define other rules of how to authenticate.

## API key

The API key is created inside the setup of the API-plugin.

### Example request

```eval_rst
.. code-block:: bash
  :linenos:

  curl -H "Authorization: Bearer foo" <base>/orders
```

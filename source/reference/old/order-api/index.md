# API Reference

```eval_rst
.. api-name:: Order API
   :version: 1
```

The Order API is mostly used for pick & pack services to finalize already placed orders. It can create and fetch supplier orders. It supports inserting regular orders directly without working with an open cart, which means the order was settled outside of Centra.

## Authentication

The `<base>` mentioned in the API-reference is the location of the plugin URL when installing the Order API plugin. The `API-token` set up inside the plugin should be added as a `API-Authorization`-header in every call to the API, like this:

```http
GET <base>/orders HTTP/1.1
API-Authorization: xyz123
```

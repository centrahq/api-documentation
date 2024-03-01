---
title: Custom client configuration in Centra backend
altTitle: Custom client config
excerpt: Add custom settings and attributes based on customer's requirements
taxonomy:
    category: docs
---

## Custom client configuration

Important parts of client configuration have been moved to the Centra backend panel. Instead of writing to the `config.php` file, one can now edit relevant configuration sections with a JSON editor.

### How to access the new configs

Go to System => Configuration.

![](system-config.png)

If you can’t see it, it may be because:  
* It hasn’t been enabled on this instance yet. This option is in beta and is controlled by a feature flag at this moment, so you can ask to turn it on for a given instance. We will do it on demand until further notice.  
* You are not logged in as a full-access admin. 

### The new config update process

1. Make config changes in a QA instance.  
2. Test the changes in the QA instance.  
3. Notify us that the config should be copied to production.

Later, we will introduce some changes to the process, so it will become full self-service. You will be publishing a version of the configuration in QA and picking it up in production instances. Also, configs will be versioned and changes will be listed in the backend.

### Image sizes

There are some predefined image sizes, and you can add custom ones, just like before.

Old config:  
![](image-sizes-old.png)

New config:  
![](image-sizes-new.png)

### Custom relation types

[Learn how to configure custom display relations in our FE guide](/fe-development/fe-elements#custom-relation-types-for-product-displays).

Relation types have been moved from the `PRODUCT` section to a separate entry.

Old config:  
![](custom-relationtypes-old.png)

New config:  
![](custom-relationtypes-new.png)

### Custom attribute types

[Learn how to configure custom attributes](/overview/custom-attributes).

Every attribute type definition is editable separately. The configuration structure remains the same.

Old config:  
![](custom-attributes-old.png)

New config:  
![](custom-attributes-new.png)

You may notice that there is no `Edit` button on some attributes. These are not custom types, but belong to plugins. For example, if you have a Google Merchant or Facebook Feed plugin, you will see six attributes they define.

#### Modifying attributes

You can update and delete existing attribute definitions, and add new ones.

Attribute type names are restricted to letters, digits, underscore `_` and minus sign `-`. You cannot change the type name, but you can clone an existing attribute into a new one. Just click on the `Create attribute type` button and pick an existing attribute type to duplicate, then edit this copy.

![](modify-attributes.png)

#### Custom sort order (experimental: available for some customers only)

By default, we sort configurations alphabetically. If you want to change the order, you can edit `Sort order` field in the configuration definition. Configurations with sort order are treated with priority and displayed before Centra predefined attributes. For attributes coming from plugins or predefined by Centra, you are not able to change the sort order.

## Before we deploy

Remember, the config files are plain JSON, easy to read, modify and store for backup purposes. Try to make it a habit to always back up your current configuration before making significant changes. 

Centra staff will always help you out when you need to deploy the configuration to Production. Still, make sure to backup your existing config beforehand:

- Export configuration in Prod, save file as backup,  
- Export new, tested config from QA,  
- (Centra) Import the new config to Production  

## Broke something?

Just let us know, and we will restore all configs to the state defined in the client’s repository. Only remember that the synchronization is uni-directional. In short, we can still deploy the `config.php` configuration to AMS backend configuration on demand, but that will overwrite any changes not present in the config file. Migration from backend config to `config.php` is not possible.

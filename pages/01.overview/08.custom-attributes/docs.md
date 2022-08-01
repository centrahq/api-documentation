---
title: Add more details: Custom Attributes
altTitle: Custom Attributes
excerpt: See how products, variants or orders can be expanded by defining Custom Attributes.
taxonomy:
    category: docs
---

## Custom Attributes

Products, variants, orders and customers can all be expanded with additional information. Here's how you can do it.

The following structure is used in the `config.php` to define custom attributes on products, variants, accounts and orders. Attributes allow you to create arbitrary fields that will be available in the API and exports. There are different types of attributes.

The API-outputs defined below are using the Shop API, some differences might apply to other APIs, which will be defined in the corresponding API reference.

### Mapped attributes

The normal attribute on a product or variant is one which is mapped to an attribute object which can contain meta-data. There is a reason for this, for example: if you have a specific Color-attribute that contains the name, hex-code and image of the color. You do not want to upload these values every time, so an attribute is then created, which you then link to the products that should have the color. Think of mapped attributes as const values that you can later choose from.

The structure looks something like this:

```php
<?php
$usr_conf['ATTRIBUTE_TYPES'] = [
    'sh_swatch' => [
        'desc' => 'Showroom Color Swatch',
        'readonly' => true,
        'group' => 'variation',
        'elements' => [
            'color' => ['desc' => 'Image', 'type' => 'image', 'size' => '60x60'],
            'color_text' => ['desc' => 'Color', 'type' => 'textarea']
        ],
    ]
];
```

You can then create a new Showroom Color Swatch-attribute under `CATALOG / ATTRIBUTES`:

![](attribute-create.png)

When this attribute is saved, this attribute option will be listed under the `Showroom Color Swatch`-title in the variant-section of the product:

![](attribute-selectable.png)

In the API, the values will come out like this:

```json
{
    "countryOfOriginName": "",
    "sh_swatch": {
	    "color": {
	        "type": "image",
	        "url": "https://.../client/dynamic/attributes/image_9471.jpg",
	        "width": "60",
	        "height": "60",
	        "mimeType": "image/jpeg"
        },
        "color_text": "#8b0000"
    },
    "markets": {
        "...": "..."
    }
}
```

### Dynamic attributes

Dynamic attributes are in comparison to mapped attributes not linked to any pre existing attribute, but do have specific data for the specific products. This data needs to be set for each product instead of linking to an existing attribute. The difference between mapped and dynamic is that dynamic uses `"readonly": false` for the attribute.

[notice-box=info]
It used to be that if you had `"readonly": false` on the attribute, only the element with the `text` key would be visible in the API. This meant that if you needed multiple elements you needed multiple attributes as well. To keep with the previous behavior, this is still the case for single-element attributes. For dynamic attributes with multiple elements, every `element` will now be returned in the API as `[attribute-name]-[element-name]`.
[/notice-box]

```php
<?php
$usr_conf['ATTRIBUTE_TYPES'] = [
    'limited_edition' => [
        'desc' => 'Limited Edition',
        'group' => 'product',
        'readonly' => false,
        'elements' => [
            'bool' => ['desc' => 'Limited Edition', 'type' => 'boolean',
                'options' => [['0','No'],['1','Yes']]
            ],
        ],
    ],
    'promo' => [
        'desc' => 'Promotion',
        'group' => 'product',
        'readonly' => false,
        'elements' => [
            'sale' => ['desc' => 'Sale', 'type' => 'boolean',
                'options' => [['0','No'],['1','Yes']]],
            'preorder' => ['desc' => 'Pre-order', 'type' => 'boolean',
                'options' => [['0','No'],['1','Yes']]]
        ],
    ],
];
```

These will show up on the product directly with a `Yes / No`-option:

![](attributes-dynamic-with-multiple-elements2.png)

And in the API, it will show up like this:

```json
...
"limited_edition_bool": "1",
"promo_sale": "1",
"promo_preorder": "1",
...
```

[notice-box=info]
Please note that when the option you've selected is `0/false` the property will not show up in the API at all.
[/notice-box]

### Attribute groups

The `group` on the attribute inside the `config.php` specifies where the attribute should be placed. The following groups exist today:

| **Group** | **Description** |
| --- | --- |
| `product` | Listed under General Attributes on all Products. |
| `variation` | Listed under each Variant on all Products. |
| `order` | Listed on each Order. |
| `customer` | Listed under each Customer. |
| `account` | Listed under each Account (B2B). |
| `sizechart` | Listed under each size in a sizechart. |
| `product_media` | Not listed in UI. Exposed in Checkout & Shop API. Assignable through Integration API. |

### Attribute element types

Element-type is inside the `elements`-property for the attribute `config.php`:

```php
<?php
$usr_conf['ATTRIBUTE_TYPES'] = [
    'limited_edition' => [
        'desc' => 'This is the attribute',
        'group' => 'product',
        'elements' => [
            'text' => ['desc' => 'This is the element-type', 'type' => 'boolean',
                'options' => [['0','No'],['1','Yes']]
            ],
        ],
    ],
];
```

The following element types exist today. Not all of them are supported for the Dynamic attributes (which are shown inline on each product/variant), so the support for the different options are listed below:

| **Type** | **Look** | **Support** | **Options** |
| --- | --- | --- | --- |
| `input` | ![](attribute-input.png) | Mapped/Dynamic | One-line text field |
| `textarea` | ![](attribute-textarea.png) | Mapped/Dynamic | Multi-line text field |
| `readonly` | ![](attribute-readonly.png) | Dynamic | Allows a field without the ability to edit it. Used for showing IDs or things that should not be changed. |
| `boolean` | ![](attribute-boolean.png) | Dynamic | Options for the radio inputs (default is always 0): `'options' => [['0','No'],['1','Yes']]` |
| `select` | ![](attribute-select.png) | Mapped/Dynamic | Default selected is always first option, so keep it as `['0','Select']` |
| `image` | ![](attribute-image.png) | Mapped | Size of the image: `'size' => '600x400'`. Allowed image formats: JPG, JPEG, PNG, GIF, SVG |
| `file` | ![](attribute-file.png) | Mapped | No options available |

#### Attributes with multi-select value

Selectable mapped attributes can be configured so that multiple values can be selected at once. This is achieved by adding parameter `'multi' => true` to the attribute. For example, a multi-choice `Label` attribute can be configured like this:

```php
'label' => [
    'desc' => 'Label',
    'group' => 'variation',
    'readonly' => true,
    'multi' => true,
    'elements' => [
        'value' => [
            'desc' => 'Label description',
            'type' => 'text'
        ],
    ],
],
```

In Centra, the attribute will look like this:

![](attribute-multi.png)

Its values will be returned as an object in API response:

```json
"label": {
    "3": "Eco",
    "1": "Bio"
 },
```

### API-output

The API-output differs between Dynamic and Mapped attributes.

**Mapped attributes** will always have a parent element named as the attribute-key. This is how the elements look like from the mapped attributes:

```php
<?php
$usr_conf['ATTRIBUTE_TYPES'] = [
    'attribute_field' => [
        'desc' => 'This is the attribute',
        'group' => 'product',
        'readonly' => true,
        'elements' => [
            'text' => ['desc' => 'Text', 'type' => 'input'],
            'textarea' => ['desc' => 'Textarea', 'type' => 'textarea'],
            'boolean' => ['desc' => 'Boolean', 'type' => 'boolean',
                'options' => [['0','No'],['1','Yes']]
            ],
            'select' => ['desc' => 'Select', 'type' => 'select',
                'options' => [['0','Select'],['aa','AA'],['bb','BB']]
            ],
            'image' => ['desc' => 'Image', 'type' => 'image', 'size' => '600x400'],
            'file' => ['desc' => 'File', 'type' => 'file']
        ],
    ],
];
```

![](attribute-mapping-all.png)

This is how the response from the API looks like:

```json
{
    "attribute_field": {
	    "text": "Text",
	    "textarea": "Textarea",
	    "boolean": "1",
	    "select": "bb",
	    "image": {
	        "type": "image",
	        "url": "https://.../client/dynamic/attributes/image1_4265_png.jpg",
	        "width": "600",
	        "height": "400",
	        "mimeType": "image/jpeg"
	    },
	    "file": {
	        "type": "file",
	        "url": "https://.../client/dynamic/attributes/6/image1.png"
	    }
    }
}
```

**Dynamic attributes** however, will be listed inline on the product inside the API.

[notice-box=info]
Remember that only the element with the key `text` will be shown and only if the value is not `0/false`.
[/notice-box]

```php
<?php
$usr_conf['ATTRIBUTE_TYPES'] = [
    'attribute_name' => [
        'desc' => 'This is the attribute',
        'group' => 'product',
        'readonly' => false,
        'elements' => [
            'text' => ['desc' => 'Text', 'type' => 'input'],
        ],
    ],
];
```

![](attribute-text-dynamic.png)

This is how it looks like in the API:

```json
{
    "attribute_name": "This is the text"
}
```

Media object attributes. 

Configuration of an example dynamic attribute for product media of type `caption`:
```php
<?php
$usr_conf['ATTRIBUTE_TYPES'] = [
    'caption' => [
        'desc' => 'Image caption',
        'group' => 'product_media',
        'readonly' => false,
        'elements' => [
            'description' => [
                'desc' => 'Caption',
                'type' => 'input'
            ],
        ]
    ],
];
```


Response from the Checkout API:

```JSON
{
  "mediaObjects": [
    {
      "media": "1",
      "sources": {
        "standard": [
          {
            "url": "http://localhost/client/dynamic/images/1_9adfeff6f2-red.jpg"
          }
        ]
      },
      "attributes": {
        "caption_description": "Example caption"
      }
    }
  ]
}
```

Response from the Shop API:

```JSON
{
  "media": [
    {
      "type": "image",
      "sources": {
        "standard": {
          "url": "http://localhost/client/dynamic/images/1_9adfeff6f2-red.jpg",
          "width": 0,
          "height": 600,
          "mimeType": "image/jpeg"
        }
      },
      "attributes": {
        "caption_description": "Example caption"
      }
    }
  ]
}
```

The [dynamic attribute element types](#attribute-element-types) supported are all returning simple strings, so they look the same as per above.

## Examples

[notice-box=info]
We recommend using `snake_case` for all your custom attributes API names. Since Centra uses `camelCase`, and all the values are mixed up in the API responses, it's helpful to be able to immediately tell which attributes are custom, which also prevents the risk of accidentaly re-using already existing attribute name key.
[/notice-box]

#### Product care instructions

A multi-line dynamic text field for entering additional information about the Product. Can also be set up on the Variant level (`group => variation`).

```php
'pr_care_instructions' => [
    'desc' => 'Product Care Instructions',
    'group' => 'product',
    'readonly' => false,
    'elements' => [
        'text' => [
            'desc' => 'Product Care Instructions',
            'type' => 'textarea'
        ]
    ]
]
```

This displays like this:  
![](attribute-dynamic-multiline.png)

#### Product category video

File upload is easy to manage for a limited number of videos.

```php
'pr_cat_video' => [
    'desc' => 'Product Category Video',
    'group' => 'product',
    'readonly' => true,
    'elements' => [
        'file' => [
            'desc' => 'Category video',
            'type' => 'file'
        ]
    ]
]
```

After you add and upload the video files in Catalog -> Attributes, you will see the list of options in the Product page:  
![ProductCategoryVideo](example-product-category-video.png)

#### Product video

When the amount of videos is un-manageable, like one video per product, it might be better to use a dynamic input field to store video URL instead of a file

```php
'pr_video' => [
    'desc' => 'Product Video',
    'group' => 'product',
    'readonly' => false,
    'elements' => [
        'url' => [
            'desc' => 'Product Video URL',
            'type' => 'input'
        ]
    ]
]
```

This will look like this in the Product page:  
![ProductVideoURL](example-product-video-url.png)

#### Dangerous goods

Required for some products at customs. Might differ between product categories and shipping countries.

```php
'pr_dangerous' => [
    'desc' => 'Dangerous goods',
    'group' => 'product',
    'readonly' => false,
    'elements' => [
        'value' => [
            'desc' => 'Dangerous goods code',
            'type' => 'input'
        ]
    ]
]
```

It renders as a simple input field in the UI:  
![DangerousGoods](example-dangeours-goods.png)

#### Showroom swatch

Remember, Variant-level attribute use group `variation`, not `variant`.

```php
'sh_swatch' => [
    'desc' => 'Showroom Color Swatch',
    'group' => 'variation',
    'readonly' => true,
    'elements' => [
        'desc' => [
            'desc' => 'Color',
            'type' => 'input'
        ],
        'hex' => [
            'desc' => 'Hex',
            'type' => 'input'
        ],
        'image' => [
            'desc' => 'Image',
            'type' => 'image',
            'size' => '50x50'
        ]
    ]
]
```

Swatch definitions need to be configured in Catalog -> Attributes:  
![ShowroomSwatch2](example-showroom-2.png)

...and then selected on the Variant page:  
![ShowroomSwatch1](example-showroom-1.png)

#### Promotion yes/no

Booleans are normally dynamic, not pre-defined. Remember, default value(s) (index `0`) will _not_ be returned in the API.

```php
'var_promo' => [
    'desc' => 'Promotion',
    'group' => 'variation',
    'readonly' => false,
    'elements' => [
        'sale' => [
            'desc' => 'Sale',
            'type' => 'boolean',
            'options' => [['0','No'],['1','Yes']]
        ],
        'preorder' => [
            'desc' => 'Pre-order',
            'type' => 'boolean',
            'options' => [['0','No'],['1','Yes']]
        ]
    ]
]
```

![PromotionYesNo](example-promotion-yes-no.png)

#### Product gender

The difference between this and Static attribute is that the `select` options cannot be adjusted/expanded without a code change.

[notice-box=info]
Please notice, the keys are enums, not integers. Use `['0','Select']`, not `[0,'Select']`.
[/notice-box]

```php
'pr_gender' => [
    'desc' => 'Product gender',
    'group' => 'product',
    'readonly' => false,
    'elements' => [
        'value' => [
            'desc' => 'Product gender',
            'type' => 'select',
            'options' => [['0','Select'],['fem','Female'],['male','Male'],['unisex','Unisex']],
        ]
    ]
]
```

The select then looks like this in the UI:  
![ProductGender](example-product-gender.png)

#### Product material - multi-select

For attributes which are pre-defined, multiple values can be made selectable at once.

```php
'pr_material' => [
    'desc' => 'Product material(s)',
    'group' => 'product',
    'readonly' => true,
    'multi' => true,
    'elements' => [
        'name' => [
            'desc' => 'Material name',
            'type' => 'input'
        ],
        'description' => [
            'desc' => 'Material description',
            'type' => 'textarea'
        ]
    ]
]
```

Multi-select snippet looks like this in Centra:  
![ProductMaterialMulti](example-product-material-multi.png)

<!--
#### [Template]

Description

```php
'' => [
    'desc' => '',
    'group' => '',
    'readonly' => ,
    'elements' => [
        '' => [
            'desc' => '',
            'type' => ''
        ]
    ]
]
```

This displays like this:  
![](.png)
-->

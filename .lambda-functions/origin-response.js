'use strict';

exports.handler = (event, context, callback) => {

    const response = event.Records[0].cf.response;
    const request = event.Records[0].cf.request;
    const baseURI = 'https://docs-test.centra.systems'

    function redirectTo(path) {
        response.status = 302;
        response.statusDescription = 'Found';
        /* Drop the body, as it is not required for redirects */
        response.body = '';
        response.headers['location'] = [{ key: 'Location', value: baseURI + path }];
    }

    // Set new headers
    response.headers['x-content-type-options'] = [{ key: 'X-Content-Type-Options', value: 'nosniff' }];
    response.headers['x-frame-options'] = [{ key: 'X-Frame-Options', value: 'DENY' }];
    response.headers['x-xss-protection'] = [{ key: 'X-XSS-Protection', value: '1; mode=block' }];
    response.headers['referrer-policy'] = [{ key: 'Referrer-Policy', value: 'same-origin' }];

    delete response.headers["server"];

    let redirects = {
'/1.0/cms/overview':'/guides/cms/index',
'/1.0/cms/custom-attributes':'/guides/cms/custom-attributes',
'/1.0/checkout-api/overview':'/guides/checkout-api/index',
'/1.0/checkout-api/products-and-categories':'/reference/old/checkout-api/products-and-categories',
'/1.0/checkout-api/selections-and-orders':'/reference/old/checkout-api/selections-and-orders',
'/1.0/checkout-api/user-accounts':'/reference/old/checkout-api/user-accounts',
'/1.0/shop-api/checklist-for-launching':'/guides/shop-api/checklist-for-launching',
'/1.0/order-api/overview':'/reference/old/order-api/index',
'/1.0/shop-api/overview':'/guides/shop-api/index',
'/1.0/shop-api/changes-between-v0-and-v1':'/guides/shop-api/changes-between-v0-and-v1',
'/1.0/subscription-api/overview':'/reference/old/subscription-api/index',
'/1.0/integrations/quickpay':'/guides/plugins/quickpay',
};
    var test_url = request.uri.replace(/\/$/, '');
    // Configure the URL redirects
    if(redirects[test_url]) {
        redirectTo(redirects[test_url]);
    }

    // Return modified response
    callback(null, response);
};

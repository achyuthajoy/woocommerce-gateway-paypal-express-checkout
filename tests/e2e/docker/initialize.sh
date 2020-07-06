#!/bin/bash

echo "Updating permalink structure"
wp rewrite structure '/%postname%/'

echo "Initializing WooCommerce E2E"
wp plugin install woocommerce --activate
wp theme install storefront --activate
wp user create customer customer@woocommercecoree2etestsuite.com --user_pass=password --role=customer --path=/var/www/html

echo "Adding basic WooCommerce settings..."
wp option set woocommerce_store_address "60 29th Street"
wp option set woocommerce_store_address_2 "#343"
wp option set woocommerce_store_city "San Francisco"
wp option set woocommerce_default_country "US:CA"
wp option set woocommerce_store_postcode "94110"
wp option set woocommerce_currency "USD"
wp option set woocommerce_product_type "both"
wp option set woocommerce_allow_tracking "no"

echo "Importing WooCommerce shop pages..."
wp wc --user=admin tool run install_pages



echo "Installing and activating the WordPress Importer plugin..."
wp plugin install wordpress-importer --activate

echo "Importing some sample data..."
wp import wp-content/plugins/woocommerce/sample-data/sample_products.xml --authors=skip

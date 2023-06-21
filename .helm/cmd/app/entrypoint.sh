#!/bin/sh

set -e

cd /app

find ./ -type f ! -path "./node_modules/*" ! -path "./.output/server/node_modules/*" -exec sed -i "s/BUILDTEMPLATE-NUXT-ENV-API-URL/${NUXT_ENV_API_URL//\//\\/}/g" {} \;
find ./ -type f ! -path "./node_modules/*" ! -path "./.output/server/node_modules/*" -exec sed -i "s/BUILDTEMPLATE-SITE-FB-PIXEL/${SITE_FB_PIXEL//\//\\/}/g" {} \;
find ./ -type f ! -path "./node_modules/*" ! -path "./.output/server/node_modules/*" -exec sed -i "s/BUILDTEMPLATE-SITE-GTM/${SITE_GTM//\//\\/}/g" {} \;
find ./ -type f ! -path "./node_modules/*" ! -path "./.output/server/node_modules/*" -exec sed -i "s/BUILDTEMPLATE-NUXT-ENV-S3BACKET/${NUXT_ENV_S3BACKET//\//\\/}/g" {} \;

exec "$@"

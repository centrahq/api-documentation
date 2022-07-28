GRAV_VERSION="1.7.26"

# Read environment variables from env file
if [[ -f "$ENV_DIR/GITHUB_AUTH_TOKEN" && -f "$ENV_DIR/GRAV_THEMES_REPOSITORY" ]]; then
    GITHUB_AUTH_TOKEN=$(cat $ENV_DIR/GITHUB_AUTH_TOKEN)
    GRAV_THEMES_REPOSITORY=$(cat $ENV_DIR/GRAV_THEMES_REPOSITORY)
else
    echo 'Required variables not provided!'
    exit 1;
fi

# Install grav
mkdir html
curl -o grav.zip -SL https://getgrav.org/download/core/grav/${GRAV_VERSION} && \
    unzip grav.zip && \
    mv -T grav html && \
    rm grav.zip

cd html

# Replace default pages and config
rm -rf ./user/config
rm -rf ./user/pages
mv ../config ./user/config
mv ../pages ./user/pages

# Download and replace themes
rm -rf ./user/themes

mkdir temp && \
curl -H "Authorization: token $GITHUB_AUTH_TOKEN" -L $GRAV_THEMES_REPOSITORY | \
tar -xz --strip-components=1 -C temp && \
mv ./temp/themes ./user/themes && \
mv ./temp/shortcodes ./user/shortcodes && \
mv ./temp/webpack/webpack.config.js ./user/webpack.config.js && \
mv ./temp/webpack/package.json ./user/package.json && \
rm -rf temp

chmod a+rwx -R ./user

# Install plugins
bin/gpm install breadcrumbs
bin/gpm install external_links
bin/gpm install featherlight
bin/gpm install page-toc
bin/gpm install shortcode-core
bin/gpm install tntsearch
bin/gpm install svg-extension

# Create search index
bin/plugin tntsearch index
chmod a+rwx -R ./cache

# Build js and css
cd ./user

npm i
npm run build

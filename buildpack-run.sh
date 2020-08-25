GRAV_VERSION="1.6.26"

# Read auth token from env file
if [ -f "$ENV_DIR/GITHUB_AUTH_TOKEN" ]; then
    GITHUB_AUTH_TOKEN=$(cat $ENV_DIR/GITHUB_AUTH_TOKEN)
else
    echo 'Github auth token not provided!'
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

# Downlaod and replace themes
rm -rf ./user/themes

mkdir temp && \
curl -H "Authorization: token $GITHUB_AUTH_TOKEN" -L https://api.github.com/repos/centrahq/centra-grav-themes/tarball/master | \
tar -xz --strip-components=1 -C temp && \
mv ./temp/themes ./user/themes && \
mv ./temp/shortcodes ./user/shortcodes && \
rm -rf temp

chmod a+rwx -R ./user

# Install plugins
bin/gpm install breadcrumbs
bin/gpm install external_links
bin/gpm install featherlight
bin/gpm install highlight
bin/gpm install page-toc
bin/gpm install shortcode-core
bin/gpm install tntsearch

# Create search index
bin/plugin tntsearch index
chmod a+rwx -R ./cache

mkdir user/themes/centra/css -p
sass user/themes/centra/scss/style.scss:user/themes/centra/css/style.css --style compressed
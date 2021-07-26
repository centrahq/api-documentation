FROM nginx
# Based on https://github.com/gushmazuko/grav-nginx/blob/master/Dockerfile

# Install dependencies
RUN apt update && apt install -y --no-install-recommends \
    cron \
    git \
    nodejs \
    npm \
    php-fpm \
    php-cli \
    php-gd \
    php-curl \
    php-mbstring \
    php-xml \
    php-zip \
    php-apcu \
    unzip \
    vim \
    zip

# Configure PHP FPM
# https://learn.getgrav.org/17/webservers-hosting/vps/digitalocean#configure-php7-2-fpm
RUN sed -i "s/.*cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/7.*/fpm/php.ini

# Set user to www-data
RUN chown www-data:www-data /usr/share/nginx
RUN rm -rf /usr/share/nginx/html
USER www-data

# Define a specific version of Grav or use latest stable
ARG GRAV_VERSION="1.6.26"

# Install grav
WORKDIR /usr/share/nginx
#RUN curl -o grav-admin.zip -SL https://getgrav.org/download/core/grav-admin/${GRAV_VERSION} && \
#    unzip grav-admin.zip && \
#    mv -T /usr/share/nginx/grav-admin /usr/share/nginx/html && \
#    rm grav-admin.zip

RUN curl -o grav.zip -SL https://getgrav.org/download/core/grav/${GRAV_VERSION} && \
        unzip grav.zip && \
        mv -T grav html && \
        rm grav.zip

WORKDIR /usr/share/nginx/html
ARG GH_ACCESS_TOKEN
RUN mkdir temp && \
    curl -H "Authorization: token $GH_ACCESS_TOKEN" \
        -L https://api.github.com/repos/centrahq/centra-grav-themes/tarball/master \
    | tar -xz --strip-components=1 -C temp && \
    rm -rf ./user/themes && \
    mv ./temp/themes ./user/themes && \
    mv ./temp/shortcodes ./user/shortcodes && \
    rm -rf temp

RUN bin/gpm install breadcrumbs && \
    bin/gpm install external_links && \
    bin/gpm install featherlight && \
    bin/gpm install highlight && \
    bin/gpm install page-toc && \
    bin/gpm install shortcode-core && \
    bin/gpm install tntsearch

# TODO errors because it cannot find driver
#RUN bin/plugin tntsearch index && \
#    chmod a+rwx -R ./cache

# Create cron job for Grav maintenance scripts
# https://learn.getgrav.org/17/advanced/scheduler
RUN (crontab -l; echo "* * * * * cd /usr/share/nginx/html;/usr/bin/php bin/grav scheduler 1>> /dev/null 2>&1") | crontab -

# Return to root user
USER root

# Add nginx to www-data group
RUN usermod -aG www-data nginx

# Replace dafault config files by provided by Grav
# https://learn.getgrav.org/17/webservers-hosting/vps/digitalocean#configure-nginx-connection-pool
RUN rm /etc/php/7.3/fpm/pool.d/www.conf
RUN rm /etc/nginx/conf.d/default.conf
#COPY conf/php/grav.conf /etc/php/7.3/fpm/pool.d/
#COPY conf/nginx/grav.conf /etc/nginx/conf.d/

# Provide container inside image for data persistence
VOLUME ["/usr/share/nginx/html"]

ARG TZ
# TODO see if this path works fine
COPY package.* /usr/share/nginx/html/
RUN npm install && \
    mkdir user/themes/centra/css -p && \
    npx sass \
        user/themes/centra/scss/style.scss:user/themes/centra/css/style.css \
        --style compressed && \
    npx postcss \
        user/themes/centra/css/style.css \
        --use=autoprefixer \
        --map=false \
        --output=user/themes/centra/css/style.css

# Run startup script
#CMD ["/entrypoint.sh"]
CMD bash -c "service php7.3-fpm start && nginx -g 'daemon off;'"

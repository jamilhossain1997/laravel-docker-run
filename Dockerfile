From php:8.2-fpm 

# Install system dependencies
Run apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \ 
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install zip \
    && pecl install xdebug \

    #composer 
    COPY --from=composer:latest /usr/bin/composer /usr/bin/composer \

    #working directory
    WORKDIR /var/www/html

    #copy project files
    COPY . .

    # Permissions (classic Laravel pain fix 😤)
    RUN chown -R www-data:www-data /var/www/html/storage \
        && chown -R www-data:www-data /var/www/html/bootstrap/cache
    #install php dependencies
    RUN composer install
    #expose port 9000
    EXPOSE 9000
    #start php-fpm server
    CMD ["php-fpm"]
FROM php:7.2-apache-stretch

MAINTAINER Mark Labrecque

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    apt-utils re2c g++ \
    zlib1g zlib1g-dbg zlib1g-dev zlibc \
    wget zip unzip bash && \
    docker-php-ext-install mbstring pdo \
    pdo_mysql opcache zip



RUN wget https://getcomposer.org/installer && \
    php ./installer && \
    mv composer.phar /usr/local/bin/composer && \
    composer

RUN composer global require consolidation/cgr

RUN touch $HOME/.bashrc \
	&& echo "export PATH=$PATH:$HOME/.composer/vendor/bin" >> $HOME/.bashrc \
	&& cat $HOME/.bashrc \
	&& source $HOME/.bashrc \
	&& cgr drush/drush
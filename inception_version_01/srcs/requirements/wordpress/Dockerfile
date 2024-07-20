FROM debian:buster

RUN apt-get update && \
	apt-get -y install wget curl bash php php-cgi php-mysql php-fpm php-pdo php-gd php-cli php-mbstring tini

# wp-cli 다운로드 및 path 변경
# https://make.wordpress.org/cli/handbook/guides/installing/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# config 파일 복사
# https://myjeeva.com/php-fpm-configuration-101.html#pool-directives
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

# php-fpm7.3 실행시 필요한 디렉토리 생성
RUN mkdir /run/php

# wordpress 다운로드
COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/create_wordpress.sh"]

# nginx 실행에 필요한 디렉토리 설정
WORKDIR /var/www/html/

# expose 9000
# EXPOSE 9000

# php-fpm7.3 실행
CMD ["/usr/sbin/php-fpm7.3", "-F"]


FROM node:19-alpine3.16 as base

ENV NODE_ENV production

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN git clone --depth=1 --branch v5.1.23 https://github.com/Jermolene/TiddlyWiki5.git /usr/local/tiddlywiki
RUN git clone --depth=1 https://github.com/OokTech/TW5-Bob.git /usr/local/tiddlywiki/plugins/OokTech/Bob

WORKDIR /var/local/tiddlywiki
VOLUME /var/local/tiddlywiki

COPY entrypoint.sh /

RUN ["chmod", "+x", "/entrypoint.sh"]

CMD [ "/entrypoint.sh" ]

EXPOSE 8080

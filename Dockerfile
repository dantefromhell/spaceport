FROM node:20-alpine3.16 as base

ARG SPACEPORT_VERSION
ARG VCS_REF
ARG BUILD_DATE
LABEL name="Spaceport" version="${SPACEPORT_VERSION}-git-${VCS_REF}" variant="base" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="Spaceport" \
      org.label-schema.description="Collaborative, team-focused TiddlyWiki docker image" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-url="https://github.com/dantefromhell/spaceport" \
      org.label-schema.version="${SPACEPORT_VERSION}-git-${VCS_REF}" \
      org.label-schema.schema-version="1.0"

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

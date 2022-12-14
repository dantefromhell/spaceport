#!/bin/sh
set -e

# Create wiki
if [ ! -d /var/local/tiddlywiki/wikis ]
then
  mkdir /var/local/tiddlywiki/wikis
  cp -r /usr/local/tiddlywiki/plugins/OokTech/Bob/MultiUserWiki /var/local/tiddlywiki/wikis/BobWiki
  sed -i 's/127.0.0.1/0.0.0.0/' /var/local/tiddlywiki/wikis/BobWiki/settings/settings.json
fi

# Start the tiddlywiki server
node /usr/local/tiddlywiki/tiddlywiki.js wikis/BobWiki --wsserver

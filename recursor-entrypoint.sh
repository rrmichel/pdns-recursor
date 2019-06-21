#!/bin/sh

set -euo pipefail

# Create config file from template
envtpl < /recursor.conf.tpl > /etc/pdns/recursor.conf

# Fix config file ownership
chown recursor /etc/pdns/recursor.conf

exec "$@"

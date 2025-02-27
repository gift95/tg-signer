#!/bin/sh

set -x
if [ ! -f /opt/tg-signer/start.sh ]; then \
    echo "#!/bin/bash" > /opt/tg-signer/start.sh; \
    echo "echo 'start.sh not found, creating default one'" >> /opt/tg-signer/start.sh; \
    chmod +x /opt/tg-signer/start.sh; \
fi

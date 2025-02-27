# Build stage
FROM python:3.12-slim AS builder

RUN apt-get update && apt-get install -y gcc && \
    mkdir -p build && \
    pip wheel -w build tgcrypto

# Final image
FROM python:3.12-slim

# Copy built wheel from builder stage
COPY --from=builder /build/*.whl /tmp/

# Install required python packages
RUN pip install /tmp/*.whl && \
    pip install -U "tg-signer[tgcrypto]"

# Set working directory
WORKDIR /opt/tg-signer

# Copy the start.sh script into the container
COPY start.sh /opt/tg-signer/start.sh

# Make the start.sh script executable
RUN chmod +x /opt/tg-signer/start.sh

# Set the default command to run the script
CMD ["/opt/tg-signer/start.sh"]

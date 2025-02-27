# Build stage
FROM python:3.12-slim AS builder

# 设置 apt-get 镜像源为清华镜像
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stable main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stable main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y gcc && \
    mkdir -p build && \
    pip wheel -w build tgcrypto

# Final image
FROM python:3.12-slim

# 设置 apt-get 镜像源为清华镜像
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stable main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stable main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y bash

# 配置 pip 使用清华的 PyPI 镜像
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Copy built wheel from builder stage
COPY --from=builder /build/*.whl /tmp/

# 安装需要的 Python 包
RUN pip install /tmp/*.whl && \
    pip install -U "tg-signer[tgcrypto]"

# 将 start.sh 脚本复制到容器的指定目录
COPY start.sh /opt/tg-signer-config/start.sh

# 使 start.sh 脚本可执行
RUN chmod +x /opt/tg-signer-config/start.sh

# 复制 entrypoint.sh 脚本到容器中
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# 给 entrypoint.sh 脚本执行权限
RUN chmod +x /usr/local/bin/entrypoint.sh

# 设置默认的工作目录
WORKDIR /opt/tg-signer

# 设置容器的入口点
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# 默认命令（如果没有传入其他命令）
CMD ["bash"]

#!/bin/bash
# entrypoint.sh

# 检查 /opt/tg-signer/start.sh 文件是否存在
if [ ! -f /opt/tg-signer/start.sh ]; then
  echo "start.sh 文件不存在，正在创建默认的 start.sh 文件..."
  
  # 创建 start.sh 文件
    cp  /opt/tg-signer-config/start.sh  /opt/tg-signer/start.sh
  # 给 start.sh 文件执行权限
  chmod +x /opt/tg-signer/start.sh
fi

# 执行 start.sh 文件
echo "正在执行 start.sh 文件..."
exec /opt/tg-signer/start.sh "$@"

來自nginx:mainline-alpine-slim
維護者ifeng <https://t.me/HiaiFeng>
曝光80
用戶根

運行apk update && apk add --no-cache supervisor wget unzip curl

#定義UUID及偽裝路徑，請自行修改。
ENV UUID de04add9-5c68-8bab-950c-08cd5320df18
ENV VMESS_WSPATH /vmess
ENV VLESS_WSPATH /vless

複製supervisord.conf /etc/supervisor/conf.d/supervisord.conf
複製nginx.conf /etc/nginx/nginx.conf

運行mkdir /etc/v2ray /usr/local/v2ray
複製config.json /etc/v2ray/
複製entrypoint.sh /usr/local/v2ray/

#謝謝 fscarmen 大佬提供 Dockerfile 層優化方案
運行wget -q -O /tmp/v2ray-linux-64.zip https://github.com/v2fly/v2ray-core/releases/download/v4.45.0/v2ray-linux-64.zip && \
    unzip -d /usr/local/v2ray /tmp/v2ray-linux-64.zip v2ray && \
    wget -q -O /usr/local/v2ray/geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat && \
    wget -q -O /usr/local/v2ray/geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat && \
    chmod a+x /usr/local/v2ray/entrypoint.sh && \
    apk del wget 解壓縮 && \
    rm -rf /tmp/v2ray-linux-64.zip && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*
    
入口點[ "/usr/local/v2ray/entrypoint.sh" ]

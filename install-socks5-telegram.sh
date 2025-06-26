#!/bin/bash

echo "🔧 Cài đặt Dante SOCKS5 proxy trên Ubuntu (Telegram tối ưu, port 443)..."

# Phát hiện interface mạng chính
IFACE=$(ip -o -4 route show to default | awk '{print $5}')
echo "🌐 Interface mạng phát hiện: $IFACE"

# Cài đặt dante-server
sudo apt update && sudo apt install -y dante-server

# Cấu hình Dante
cat <<EOF | sudo tee /etc/danted.conf
logoutput: syslog
internal: $IFACE port = 443
external: $IFACE
method: username none
user.notprivileged: nobody

client pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    log: error
}

socks pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    log: connect disconnect error
}
EOF

# Bật dịch vụ
sudo systemctl restart danted
sudo systemctl enable danted

# Mở port 443 nếu có ufw
if command -v ufw &>/dev/null && sudo ufw status | grep -q "Status: active"; then
  echo "🧱 Mở cổng 443 trong ufw..."
  sudo ufw allow 443/tcp
fi

# Hiển thị IP Public
IP=$(curl -s ifconfig.me || hostname -I | awk '{print $1}')
echo "✅ SOCKS5 Proxy đã hoạt động!"

echo "👉 Cấu hình Telegram:"
echo "   - IP: $IP"
echo "   - Port: 443"
echo "   - Loại: SOCKS5 (no auth)"

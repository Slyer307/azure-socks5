# SOCKS5 Proxy cho Telegram trên Azure (Port 443)

Cài đặt proxy SOCKS5 (Dante) tối ưu cho Telegram, dùng được trên Azure VM Ubuntu.

## ✅ Tính năng

- Tự động phát hiện interface mạng
- Cài dante-server và cấu hình port 443
- Hoạt động tốt với Telegram tại Việt Nam
- Không cần username/password

## 🚀 Hướng dẫn sử dụng

### 1. SSH vào VPS Ubuntu (22.04+ hoặc 24.04)

```bash
ssh youruser@your-vps-ip
```

### 2. Tải & chạy script:

```bash
git clone https://github.com/slyer307/socks5-telegram-azure.git
cd socks5-telegram-azure
chmod +x install-socks5-telegram.sh
./install-socks5-telegram.sh
```

### 3. Cấu hình Telegram

- Type: SOCKS5
- IP: (được in ra sau khi chạy script)
- Port: 443
- No authentication

## 📌 Lưu ý

- Nếu dùng `ufw`, script sẽ tự mở port 443
- Không hỗ trợ username/password vì Telegram không hỗ trợ

## 🛡 Bảo mật nâng cao

- Bạn nên giới hạn IP hoặc firewall nếu dùng cho riêng cá nhân

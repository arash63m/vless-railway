# VLESS Server on Railway

## Deployment Steps:
1. Fork this repository
2. Go to Railway and create new project
3. Select "Deploy from GitHub repo"
4. Choose your forked repository
5. Add environment variables (optional):
   - `UUID`: Your custom UUID (auto-generated if empty)
   - `PORT`: Server port (default: 8080)
   - `DOMAIN`: Domain for TLS certificate (default: localhost)
6. Deploy!

## Client Configuration:
```json
{
  "v": "2",
  "ps": "Railway-VLESS",
  "add": "YOUR_RAILWAY_URL",
  "port": "443",
  "id": "YOUR_UUID",
  "aid": "0",
  "scy": "none",
  "net": "tcp",
  "type": "none",
  "host": "",
  "path": "",
  "tls": "tls",
  "sni": "",
  "alpn": "",
  "fp": ""
}

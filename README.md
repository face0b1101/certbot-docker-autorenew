# certbot-docker-autorenew

don't forget to combine the fullchain and privkey for HAProxy and the like:

```bash
cat fullchain.pem privkey.pem > example.com.pem
```
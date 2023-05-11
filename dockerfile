FROM certbot/dns-cloudflare

# RUN pip install certbot-dns-cloudflare cloudflare

ENTRYPOINT [ "sh","/scripts/certbot.sh" ]
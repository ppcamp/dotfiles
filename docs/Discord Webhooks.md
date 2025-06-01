

# Discord Webhooks

To create a webhook, go to your Discord server settings, navigate to the
"Integrations" section, and create a new webhook. You will receive a URL that
you can use to send messages to a specific channel.

```sh
❯ curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "Bitbucket Bot", "content": ":warning: Build failed on Bitbucket!"}' \
  "https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN"
```
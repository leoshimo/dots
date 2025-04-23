# gmailctl

Reference: https://github.com/mbrt/gmailctl
GCP: https://console.cloud.google.com/apis/dashboard?project=gmailctl-457400
Fowarding Settings: https://mail.google.com/mail/u/0/#settings/fwdandpop

## Workflow

```shell
# Setup
$ op read "op://Personal/jytenjmniazbvlz4plidwqqc3e/credentials.json" > /Users/leoshimo/.gmailctl/token.json

# Auth
$ gmailctl init

# Fetch existing filters
$ gmailctl download > ~/.gmailctl/config.jsonnet

# Check for syntax errors
$ gmailctl test

# Compare configuration against existing
$ gmailctl diff

# Apply
$ gmailctl apply
```

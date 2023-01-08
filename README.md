# DjStripe Test

This repository is for debugging an error with dj-stripe when using django-extensions commands.

# Steps to reproduce:

1. Clone this repository.
2. Add the *.env* file with the following contents:

```
DB_NAME=postgres
DB_USER=postgres
DB_PASSWORD=password
DB_HOST=postgres
DEBUG=True
STRIPE_LIVE_SECRET_KEY=<YOUR_LIVE_SECRET_KEY>
STRIPE_TEST_SECRET_KEY=<YOUR_TEST_SECRET_KEY>
DJSTRIPE_WEBHOOK_SECRET=<YOUR_DJSTRIPE_WEBHOOK_SECRET>

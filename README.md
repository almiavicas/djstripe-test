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
```

> Note: Details about how to get the `STRIPE_LIVE_SECRET_KEY`, `STRIPE_TEST_SECRET_KEY` and `DJSTRIPE_WEBHOOK_SECRET` are in the djstripe documentation: https://dj-stripe.dev/installation/

3. Build the docker image: `docker compose build`.
4. Run the migrate command: `docker compose run django python manage.py migrate`.
5. Start the server: `docker compose up -d`.
6. Head to the Django Admin section to add an Stripe Test API Key: *http://localhost:8000/admin/djstripe/apikey/*.
7. Run the sync command: `docker compose run django python manage.py djstripe_sync_models`.
8. Turn off the docker compose: `docker compose down -v --remove-orphans`.
9. Try to flush the database: `docker compose run django python manage.py reset_db --noinput`.

Here is the error you should obtain:

```
Traceback (most recent call last):
  File "/app/manage.py", line 22, in <module>
    main()
  File "/app/manage.py", line 18, in main
    execute_from_command_line(sys.argv)
  File "/usr/local/lib/python3.10/site-packages/django/core/management/__init__.py", line 446, in execute_from_command_line
    utility.execute()
  File "/usr/local/lib/python3.10/site-packages/django/core/management/__init__.py", line 440, in execute
    self.fetch_command(subcommand).run_from_argv(self.argv)
  File "/usr/local/lib/python3.10/site-packages/django/core/management/base.py", line 402, in run_from_argv
    self.execute(*args, **cmd_options)
  File "/usr/local/lib/python3.10/site-packages/django/core/management/base.py", line 448, in execute
    output = self.handle(*args, **options)
  File "/usr/local/lib/python3.10/site-packages/django_extensions/management/utils.py", line 62, in inner
    ret = func(self, *args, **kwargs)
  File "/usr/local/lib/python3.10/site-packages/django_extensions/management/commands/reset_db.py", line 175, in handle
    cursor.execute(drop_query)
psycopg2.errors.ObjectInUse: database "postgres" is being accessed by other users
DETAIL:  There is 1 other session using the database.
```
# Classy Letters

## Start Dev Environment

Create a `.env` file

```
GMAIL_ACCOUNT=XXX
GMAIL_PASSWORD=XXX
STRIPE_PRIVATE_API_KEY=XXX
STRIPE_PUBLIC_API_KEY=XXX
```

```
$ bundle install
$ foreman start
$ bundle exec autotest
```

## Deploying on Heroku

```
$ heroku config:add GMAIL_ACCOUNT=XXX
$ heroku config:add GMAIL_PASSWORD=XXX
$ heroku config:add STRIPE_PRIVATE_API_KEY=XXX
$ heroku config:add STRIPE_PUBLIC_API_KEY=XXX
```
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

## Features used in the project:
* General practice in building CRUD applications - migrations, associations, routing, seeding DB, etc.
* Nested comments (unlimited(?) depth), forms
* Service objects, form objects, queries
* Decorators, pagination
* Customizing devise action
* Preventing N+1 queries - with Bullet gem and with custom SQL queries for more complicated associations (e.g. deleting the User, his comments, articles, its comments, taggings and tags if there are no more articles assigned to it)
* RSpec - almost 100% of code according to Simplecov gem - exact value depends on the current stage of implementing new features (including controllers, models, queries, services, form objects, decorators) - with usage of mocks/stubs and factories
* Code refactoring (to follow the principle of 'DRY')
* Debugging, debugging, debugging

## How to start
1. Clone:
```bash
$ git clone https://github.com/RGu0000/Blog.git
```

2. Enter directory:
```bash
$ cd Blog
```

3. Instal gems:
```bash
$ bundle install
```

4. Create and seed database:
```bash
$ rails db:setup
```

5. Run rails server:
```bash
$ rails s
```

Enjoy!

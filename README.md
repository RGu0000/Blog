# BLOG
This app enables you to create the account and post articles and tag them. Users can comment on articles and rate them. Browsing tags and seeing associated articles is also possible.

---

### LATEST UPDATE: app's online under link:  https://rgublog.herokuapp.com/

---

## Technical features used in the project:
* General practice in building CRUD applications - migrations, associations, routing, seeding DB, strong params, mass updating, etc.
* Building few forms and using (and reusing) them in controller actions for both creating and editing
* Nested comments (unlimited(?) depth) with help of closure_tree gem
* Service objects, form objects, queries
* Decorators, pagination
* Customizing devise action
* Preventing N+1 queries - with Bullet gem as a reminder/helper to use eager loading and with custom SQL queries for more complicated associations (e.g. deleting the User, his comments, articles, its comments, taggings and tags if there are no more articles assigned to it with as few queries as possible)
* RSpec - almost 100% of code according to Simplecov gem is covered (including controllers, models, queries, services, form objects, decorators) - exact value of coverage depends on the current stage of implementation of new features. Mocks/stubs and factories were used as well while writing specs.
* Code refactoring (to follow the principle of 'DRY' and meet Rubocop's requirements)
* Debugging, debugging, debugging

## How to start the app:

#### Easy way:

https://rgublog.herokuapp.com/

#### Many steps way:

0. Have Ruby/Rails environment already set up
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

* Ruby version: 2.5.0
* Rails version: 5.1.5
* PostgreSQL version: 9.5.12

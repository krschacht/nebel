# Nebel

## Setting up a new dev environment

Clone the repository:

```
git clone git@github.com:krschacht/nebel.git
cd nebel
git remote add production git@heroku.com:nebelscience.git
```

Finally, do the usual:

```
gem install bundler
bundle install
```

Set up your database:

```
bundle exec rake db:create:all
bundle exec rake db:schema:load
bundle exec rake db:seed
```

Run the tests via the default rake task:

```
bundle exec rake
```

To deploy, do the usual:

```
git push production master
```

## Importing the Book

The book breaks things out into subjects, lessons, and parts. In the app, we map
those sections, respectively, to subjects, topics, and exercises. Later, we'll
introduce units that group topics and lessons that group exercises. This
renaming is done to allow us to maintain referential integrity between an
exercise and its supplementary material, i.e., visual aids, supplies, etc.

See the comments around `rake book:download_and_import` for instructions on how
to import the book text.

## Importing the Yahoo Group

The Yahoo Group exists here:

https://groups.yahoo.com/neo/groups/K5science/info

See the comments around `rake yahoo_group:import` for instructions on how to
import the messages from this group.

# BFSU

## Setting up a new dev environment

```
git clone git@heroku.com:nebelscience.git -o heroku
git remote add github ssh://git@github.com/avand/bfsu.git
git fetch github
git branch --track master github/master
```

This may be optional, but if you're using RVM and want to use the .ruby-version file then:
```
cd ..
cd nebelscience
```

Finally, do the usual:
```
gem install bundle
bundle install
```

To deploy, do the usual:
```
git push heroku master
```

```
rake db:migrate
rake db:seed
heroku run rake book:download_and_import["https://dl.dropboxusercontent.com/u/1062541/BFSU.zip"]
```

## Mapping

The book breaks things out into subjects, lessons, and parts. In the app, we map
those sections, respectively, to subjects, topics, and exercises. Later, we'll
introduce units that group topics and lessons that group exercises. This
renaming is done to allow us to maintain referential integrity between an
exercise and its supplementary material, i.e., visual aids, supplies, etc.

## Book Schema

* Overview
* Position in the Progress of Learning (optional)
* Time required
* Practices (optional)
* Required Background
* Materials
* Teachable Moments
* Methods and Procedures
* Questions/Discussion/Activities to Review, Reinforce, Expand, and Assess
  Learning
* To Parents an Others Providing Support
* Re: Framework's Principles and NGSS (optional)
* Books for Correlated Reading

# Recipes

[![Build Status](https://travis-ci.org/boblail/recipes.svg)](https://travis-ci.org/boblail/recipes)


### Prerequisites

 - Ruby 2.5.1
 - Postgres

If you're on a Mac, install Ruby with

    brew install rbenv
    rbenv init
    rbenv install 2.5.1

and install Postgres with the excellent [Postgres.app](https://postgresapp.com)



### Getting Started

    git clone https://github.com/boblail/recipes.git
    cd recipes
    bundle
    bundle exec rake db:setup

To run Origami

    bundle exec rails server


### Chrome Extension

This repo contains a Chrome Extension for adding recipes. It lives in `platforms/chrome`.

Public page: https://chromewebstore.google.com/detail/add-to-lailrecipes/hcgmkgaknppcjpohhfnmkipmninochga
Developer page: https://chrome.google.com/webstore/devconsole/ee7e7345-be02-4060-b1ee-0aff15b26b2f

You can publish it by running
```
yarn install
npm run publish:chrome
```



### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/boblail/recipes.

# Beer Search
**General information**
|![Heroku](https://pyheroku-badge.herokuapp.com/?app=beers-search&style=flat)  | [![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails) | ![example workflow](https://github.com/faraznaeem/beersearch/actions/workflows/rubyonrails.yml/badge.svg) |
|--|--|--|

- Beer search application based on [PunkAPI](https://punkapi.com/documentation/v2)
- Built with Ruby on Rails
- Tested with RSpec
- CD with Heroku
- CI with Github Actions
- [Deployed applicaton ](https://beers-search.herokuapp.com/)


## Run the application

To run the application locally the following must be installed:

- Postgresql
- Ruby 3.0.2
- Rails 7.0.3

In the terminal run
```bash
$ git clone git@github.com:faraznaeem/BeerSearch.git
```

```bash
$ bundle install
```

```bash
$ rails db:create db:migrate
```

```bash
$ rails server
```

Interact with the application on `localhost:3000` in the browser

To run tests:
```bash
$ bundle exec rspec
```

## **Development status:** ***In active development***

**Todo:**

 - [ ] Style: Add Tailwind CSS for styling
 - [ ] Refactor: Add Service Object for PunkAPI
 - [ ] Feature: Add AlpineJS for small user interactions and animations
 - [ ] Feature: Add beers, upload photos
 - [ ] Test: Add CodeCov
 - [ ] Test: Add Sentry

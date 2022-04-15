# Tea Tracker

![languages](https://img.shields.io/github/languages/top/JCNapier/sweater_weather?color=red)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov)
[![All Contributors](https://img.shields.io/badge/contributors-1-orange.svg?style=flat)](#contributors-)


## Description 

Tea Tracker is a small BE API creating three endpoints for creating, updating, and returning Customer Subscriptions and the Tea's on those subscriptions. In this application, customers have a _1 to Many_ relationship with subscriptins, and subscriptions have a _Many to Many_ relationship with Teas. There is full test suite for all end points have happy path, sad path, and edge case testing. 

## Versions
- Ruby 2.7.2
- Rails 5.2.6

## Gems
```ruby 
  #Global Scope Gems 
  gem 'jsonapi-serializer'
  
  #group :development, :test
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'simplecov'
  gem 'shoulda-matchers'
  
  #group :test
  gem 'rspec-rails'
  gem 'pry'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
```
- [JSONAPI_Serialzier Docs](https://github.com/jsonapi-serializer/jsonapi-serializer)
- [SimpleCov Docs](https://github.com/simplecov-ruby/simplecov)
- [Capybara Docs](https://github.com/teamcapybara/capybara)
- [ShouldMatchers Docs](https://github.com/thoughtbot/shoulda-matchers)
- [Factory Bot Rails Docs](https://github.com/thoughtbot/factory_bot_rails)
- [Faker Docs](https://github.com/faker-ruby/faker)

## Local Setup 

1. Fork & Clone the repo 
```shell
$ git@github.com:JCNapier/tea_tracker.git
```
2. Navigate to the directory 
```shell 
$ cd tea_tracker
```
3. Install gem packages:
```shell
$ bundle install
```
4. Update gem packages: 
```shell
$ bundle update
```
5. Run the migrations: 
```shell
$ rake db:{drop,create,migrate,seed}
```

## Test Suite 

1. After the initial setup you can simply run the following command. There will be 29 passing tests. 
``` shell 
$ bundle exec rspec
``` 

## End Points Created
- ``` GET /api/v1/customers/:customer_id/subscriptions```
- ``` PATCH /api/v1/customers/:customer_id/subscriptions/:id```
- ``` POST /api/v1/customers/:customer_id/subscriptions``` 
  *JSON Params Passed for Subscription Create* 
  ![Screen Shot 2022-04-14 at 8 05 06 PM](https://user-images.githubusercontent.com/81737385/163506288-8e605a30-e458-40ca-bfd1-c23684fc6722.png)
   
## Database Schema 
![Screen Shot 2022-04-14 at 8 06 22 PM](https://user-images.githubusercontent.com/81737385/163506390-3c5f5eae-91a0-4651-8849-f9148186d5d3.png)
![Screen Shot 2022-04-14 at 8 07 12 PM](https://user-images.githubusercontent.com/81737385/163506486-99a122ae-452d-489e-9476-b366d81f58b8.png)

## Project Contributors

<a href="https://github.com/JCNapier/tea_tracker/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=JCNapier/tea_tracker" />
</a>

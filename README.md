# Frosting

Let's simplify using presenters in Rails.

## Installation

Add `gem "frosting"` to your Gemfile and run `bundle install`.

## Introduction

You have a `Post` model. You're a good lil' rabbit, and it only contains methods concerned with its persistence.

So where do you put presentation-specific logic?

The view, right? Nah, man. You should probably use a presenter.

## Usage

Let's say we're in `PostsController#show` and you want to implement some sort of presentation logic. How about we're color coding based on the age of the post.

If you `present @post` from your controller (and its class is `Post`), frosting will look for `Presenters::Post` (defined in `/models/presenters/post.rb` presumably). Here's what that could look like:

```ruby
module Presenters
  class Post < Frosting::BasePresenter
    def color
      old? ? 'red' : 'green'
    end
  end
end
```

You defined `#old?` in your model because it's not a presentation concern. Good job.

`Frosting::BasePresenter` delegates to the resource you're presenting, and it also has access to the view context. It doesn't delegate anything by default, but you can delegate things like `link_to` and `content_tag` if it makes your life easier. You should probably make your own base presenter that inherits from frosting's base. It's your life, and you should do what you want to.

You can also call `present_collection @posts` should you be dealing with a collection of posts and want them all to be presented.

## Presenting Associations

As an additional trick, if you find yourself writing code like:

```ruby
def user
  present super(), context: @context
end
```

in order to have your presented `Post` return a presenter for the associated `User`, then you can save some typing with:

```ruby
presents_super :user
```

The `presents_super` method accepts options, so you can specify a presenter:

```ruby
presents_super :user, presenter: SomeCustomPresenter
```

You can also use `presents_super` for collections, by passing the `collection` option:

```ruby
presents_super :users, collection: true
```

## About Foraker Labs

![Foraker Logo](http://assets.foraker.com/attribution_logo.png)

Foraker Labs builds exciting web and mobile apps in Boulder, CO. Our work powers a wide variety of businesses with many different needs. We love open source software, and we're proud to contribute where we can. Interested to learn more? [Contact us today](https://www.foraker.com/contact-us).

This project is maintained by Foraker Labs. The names and logos of Foraker Labs are fully owned and copyright Foraker Design, LLC.

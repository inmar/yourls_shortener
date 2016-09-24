Yourls Shortener
================

Installation (for Rails)
------------------------

1. Add `gem 'yourls-shortener'` to your Gemfile and `bundle install`.
2. Put the yourls.yml file in your config directory.
3. Put the yourls.rb file in your config/initializers directory.

To Use
------

For a shortened URL:

```
Yourls::Shorten.url("https://urltoshorten.com")
```


To expand an already shortened URL:

```
Yourls::Expand.url("https://shortu.rl")
```

For a click count on a shortened URL:

```
Yourls::Clicks.url("https://shortu.rl")
```

Noizee
======

> A unified commandline timeline.

Use Noizee to keep tabs on what's going on in your world. Noizee aggregates events from around the internet and displays them in one place so you don't have to check dozens of apps and services to stay up to date so you can plan your next move. 

Features
--------

- Monitor an unlimited number of Twitter accounts!
- Watch an unlimited number of RSS feeds!
- Shiny 256 color terminal output!
- Simple YAML configuration!

![Action shot!](http://i.imgur.com/xhvRyY7.png)

*note that on first load (as in the screenshot above) the latest events will be displayed in the order they are discovered*

Getting Started
---------------

0. Create a YAML file called `.noizee` in your home directory
1. Add your credentials as shown in the **Configuration** section below
2. Run `bin/noizee`
3. Enjoy!

Configuration
-------------

In your configuration file you have a set of keys representing the services you want to use, each of those can be an array of multiple accounts which will be included in the aggregation. 

### Twitter

- key: `twitter`
- required settings: `consumer_key`, `consumer_secret`, `access_token`, and `access_token_secret`

### RSS

- key: `rss`
- required settings: `url`
- optional settings `alias`

### Facebook

**facebook support is experimental and not enabled by default**

- key: `facebook`
- required settings: `access_token`

Example `.noizee` configuration:

~~~
---
:twitter:
  - :consumer_key: "abc123"
    :consumer_secret: "abc123"
    :access_token: "abc123-abc123"
    :access_token_secret: "abc123"
  - :consumer_key: "abc123"
    :consumer_secret: "abc123"
    :access_token: "abc123-abc123"
    :access_token_secret: "abc123"
:rss:
  - :url: "http://feeds.sydv.net/latest-bash-quotes"
    :alias: "Bash.org"
~~~

Implemented
-----------

- Twitter integration
- RSS integration
- Multiple Twitter accounts
- Colorized output
- Facebook integration [experimental]

Planned
-------

- Filtering & Rules
- Highlighting
- Tag searching
- Google Plus integration
- XMPP integration
- Email integration
- Desktop notification support for highlights

`Copyright 2011-2015 Anthony M. Cook`

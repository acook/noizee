Noizee
======

> A unified commandline timeline.

Use Noizee to keep tabs on what's going on in your world. Noizee aggregates events from around the internet and displays them in one place so you don't have to check dozens of apps and services to stay up to date so you can plan your next move. 

Getting Started
---------------

0. Create a YAML file called `.noizee` in your home directory
1. Add your credentials as shown in the **Configuration** section below
2. Run `bin/noizee`
3. Enjoy!

Configuration
-------------

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

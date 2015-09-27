Noizee
======

> A unified commandline timeline.

Use Noizee to keep tabs on what's going on in your world. Noizee aggregates events from around the internet and displays them in one place so you don't have to check dozens of apps and services to stay up to date so you can plan your next move. 

Getting Started
---------------

0. Create a YAML file called `.noizee` in your home directory
1. Add your credentials as hash keys
2. Run `bin/noizee`

Configuration
-------------

Example `.noizee` configuration:

~~~
---
# twitter
:consumer_key: "abc123"
:consumer_secret: "abc123"
:access_token: "abc123-abc123"
:access_token_secret: "abc123"
~~~

Implemented
-----------

- Twitter support
- Colorized output

Planned
-------

- Filtering
- Highlighting
- Tag searching
- Facebook support
- RSS support
- Google Plus support
- XMPP support
- Email support
- Desktop notification support for highlights

`Copyright 2011-2015 Anthony M. Cook`

# Diaspora::Cluster::Creator

[![Build Status](https://secure.travis-ci.org/jeremyf/diaspora-cluster-creator.png)](http://travis-ci.org/jeremyf/diaspora-cluster-creator)

Thus far, this is an over-engineered solution that does very little.

I'm using it as a means of pushing out my understanding of cucumber and
fast unit tests.

## Installation

You will need to install [Graphviz](http://graphviz.org)

Add this line to your application's Gemfile:

    gem 'diaspora-cluster-creator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install diaspora-cluster-creator

## Usage

Once installed you can ask diaspora-cluster for help

	$ diaspora-cluster -h

Or request the defaults

	$ diaspora-cluster

Or you can specify names

	$ diaspora-cluster names="Sparta [T2 E1 R3], Athens [T-2], Corinth [R3 T2 E1], Ephesus, Rhodes [T4]"

Or perhaps you prefer a PNG

	$ diaspora-cluster filename=output.png names="Sparta [T2 E1 R3], Athens [T-2], Corinth [R3 T2 E1], Ephesus, Rhodes [T4]"
	
Take a look at /features/command_line.feature for better definitions.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![Build Status](https://travis-ci.org/mdubbs/corepathing.svg?branch=master)](https://travis-ci.org/mdubbs/corepathing) [![Code Climate](https://codeclimate.com/github/mdubbs/corepathing/badges/gpa.svg)](https://codeclimate.com/github/mdubbs/corepathing) [![Test Coverage](https://codeclimate.com/github/mdubbs/corepathing/badges/coverage.svg)](https://codeclimate.com/github/mdubbs/corepathing/coverage)

# Corepathing

Produces student education paths from provided domain ordering and student test scores CSV files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'corepathing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install corepathing

## Usage

Setup the pathing object with your CSV files
```ruby
# setup
pathing = Corepathing::Pathing.new("spec/data/stu.csv", "spec/data/ord.csv")

# the parameter is the limit for number of steps to return for each student
pathing.path_students(5)

# will return an array of strings, each string representing the student's path
[#<Corepathing::Student:0x007fe8ab8d0568 @name="Albin Stanton", @max_domain_levels={"RF"=>"2", "RL"=>"3", "RI"=>"K", "L"=>"3"}, @path=[{"K"=>"RI"}, {"1"=>"RI"}, {"2"=>"RF"}, {"2"=>"RI"}, {"3"=>"RF"}]>, #<Corepathing::Student:0x007fe8ab8ca550 @name="Erik Purdy", @max_domain_levels={"RF"=>"3", "RL"=>"1", "RI"=>"1", "L"=>"1"}, @path=[{"1"=>"RL"}, {"1"=>"RI"}, {"2"=>"RI"}, {"2"=>"RL"}, {"2"=>"L"}]>]

#if you just want to calculate one student, given their row you can do
student_obj = pathing.get_path(student_row)
#<Corepathing::Student:0x007fc92b4f3e30 @name="Albin Stanton", @max_domain_levels={"RF"=>"2", "RL"=>"3", "RI"=>"K", "L"=>"3"}, @path=[{"K"=>"RI"}, {"1"=>"RI"}, {"2"=>"RF"}, {"2"=>"RI"}, {"3"=>"RF"}]>

#to get the string representation of the student's education path
student_obj.to_s
# will return "Albin Stanton,K.RI,1.RI,2.RF,2.RI,3.RF"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mdubbs/corepathing. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


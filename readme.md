# Gfrom (From Google Form)

Render unathenticated Google Form in your website. Useful for collecting data from your users without a database. Just create a google form from your google account

## Installation

Add this line to your application's Gemfile:

    gem 'gfrom'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gfrom

## Usage

```ruby
GOOGLE_FORM_URL = "https://docs.google.com/a/myorganization.com/spreadsheet/embeddedform?formkey=dGlXS0ZNWVVGYWZqMVhXUENvOXQtSnc6MQ&hl=en"
@myform = Gfrom.new(GOOGLE_FORM_URL)
# fields are stored in array of hashes
# @fields=[
#   {:element=>"input", :type=>"text", :name=>"entry.0.single", :value=>"", :class=>"ss-q-short", :id=>"entry_0", :label=>"Name", :required=>true},
#   {:element=>"input", :type=>"text", :name=>"entry.2.single", :value=>"", :class=>"ss-q-short", :id=>"entry_2", :label=>"Email", :required=>true},
#   {:element=>"textarea", :name=>"entry.1.single", :rows=>"8", :cols=>"75", :class=>"ss-q-long", :id=>"entry_1", :label=>"Message"},
#   {:element=>"input", :type=>"hidden", :name=>"pageNumber", :value=>"0"}, {:element=>"input", :type=>"hidden", :name=>"backupCache", :value=>""}
# ]
puts @myform.fields
# submit the form data to Google will return a hash
result = @myform.submit(params)
# { :success => true, :message => "Thanks" }
# or false otherwise, and an error message, which would probably unsatisfied required fields
```

# TODO

* Support for Authenticated forms (requires login to organization/google apps)
* Radio buttons and checkboxes (not sure if this will work on current version - 0.1.0)
* Supply an RDOC
* Tests

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

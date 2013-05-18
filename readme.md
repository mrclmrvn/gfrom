# Gfrom (From Google Form)

Wrap Google Form in your website. Useful for collecting data from your users without a database, and if you hate country restrictions of the form services out there. Plus you can style it your on way.

Just create a form from your google account and copy the published URL. If you are using Google Apps, please read [form options](http://support.google.com/drive/bin/answer.py?hl=en&answer=160166), make sure `require sign-in` is unchecked.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gfrom'
```

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
#   {:element=>"input", :type=>"text", :name=>"entry.479273699", :value=>"", :class=>"ss-q-short", :id=>"entry_479273699", :label=>"First name\n\n*", :dir=>"auto", :"aria-required"=>"true"},
#   {:element=>"input", :type=>"text", :name=>"entry.372120214", :value=>"", :class=>"ss-q-short", :id=>"entry_372120214", :label=>"Last name\n\n*", :dir=>"auto", :"aria-required"=>"true"},
#   {:element=>"input", :type=>"text", :name=>"entry.1874514893", :value=>"", :class=>"ss-q-short", :id=>"entry_1874514893", :label=>"Middle name", :dir=>"auto"},
#   {:element=>"input", :type=>"radio", :label=>"Male", :name=>"entry.1593861918", :value=>"Male", :id=>"group_1593861918_1", :class=>"ss-q-radio", :"aria-label"=>"Male"},
#   {:element=>"input", :type=>"radio", :label=>"Female", :name=>"entry.1593861918", :value=>"Female", :id=>"group_1593861918_2", :class=>"ss-q-radio", :"aria-label"=>"Female"},
#   {:element=>"input", :type=>"checkbox", :label=>"Ruby", :name=>"entry.299194237[]", :value=>"Ruby", :id=>"group_299194237_1", :class=>"ss-q-checkbox"},
#   {:element=>"input", :type=>"checkbox", :label=>"PHP", :name=>"entry.299194237[]", :value=>"PHP", :id=>"group_299194237_2", :class=>"ss-q-checkbox"},
#   {:element=>"input", :type=>"checkbox", :label=>"Django", :name=>"entry.299194237[]", :value=>"Django", :id=>"group_299194237_3", :class=>"ss-q-checkbox"},
#   {:element=>"input", :type=>"checkbox", :label=>"Python", :name=>"entry.299194237[]", :value=>"Python", :id=>"group_299194237_4", :class=>"ss-q-checkbox"},
#   {:element=>"input", :type=>"hidden", :name=>"draftResponse", :value=>"[] "},
#   {:element=>"input", :type=>"hidden", :name=>"pageHistory", :value=>"0"}
# ]
puts @myform.fields
# submit the form data to Google will return a hash
result = @myform.submit(params)
# { :success => true, :message => "Thanks" }
# or false otherwise, and an error message, which would probably unsatisfied required fields
```

## TODO

* Retain form values on unsuccesful submit
* Fields with error after submit
* Label for grouped form tags - checkbox and radio
* Support for getting select form tag (use radio button for now)
* Support for Authenticated forms (requires login to organization/google apps)
* Supply an RDOC
* Tests

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

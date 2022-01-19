# Settings Library

Declare settings attributes in classes that use configuration data, and push configuration data to those settings while respecting encapsulation.

Use either a JSON file or a hash as the settings data source.

Some lower-level capabilities allow interaction with the settings data directly, as well as overriding and reseting the data, which is useful in testing scenarios, as well as hierarchical overrides of data in hierarchical namespaces.

## Usage

```ruby
settings = Settings.build ...

settings.set(example)

example.some_setting == "some value"
# => true
example.some_other_setting == "some other value"
# => true
```

In the above code, `example` is an instance of a class with attributes declared as `setting`:

```ruby
class Example
  setting :some_setting
  setting :some_other_setting
end
```

The settings object is built with a pathname to a JSON file, or a hash of raw data. In either case, values are assigned to the object's settings attributes based on whether there's a key in the data that matches the name of a setting attribute.

An example of JSON data for the example above would be:

```javascript
{
  "some_setting": "some value",
  "some_other_setting": "some other value"
}

```

## Building a Settings Object

A settings object is built by passing it either:

1. A filename (current working directory is assumed)
2. A directory path ("settings.json" is assumed as the filename)
3. A pathname to a JSON file (either relative or absolute)
4. A hash containing the data
5. Ruby's ENV object, providing access to operating system environment variables
6. Nothing ("settings.json" in the current working directory is assumed)

### From a File Path

A frequent use case will be instantiating `Settings` with a file path:

```ruby
settings = Settings.build('settings/example.json')
```

Where the data in `settings/example.json` would be:

```javascript
{
  "some_setting": "some value",
  "some_other_setting": "some other value"
}
```

### From a Hash

The same can be achieved using a hash of the data:

```ruby
data = {
  some_setting: "some value",
  some_other_setting: "some other value"
}

settings = Settings.build(data)
```

### From the ENV Object

Additionally, a `Settings` instance can be creating from Ruby's `ENV` object:

```ruby
settings = Settings.build(ENV)
```

When using ENV as a source, the settings names are converted to lower case. They're no longer upper case as they would be typically when using the `ENV` object directly.

## Specifying the Data Source in a Subclass

A subclass of a `Settings` class can provide either the pathname or the hash of data by implementing the `data_source` class method.

```ruby
class SomeSettings < Settings
  def self.data_source
    'settings/example.json'
  end
end

settings = SomeSettings.build
```

There's no need to pass a data source to the build method if a subclass has implemented the `data_source` method. However, if a data source is provided as an argument to the build method when building the subclass, the argument to the build method will have precedence over the subclass's `data_source` method:

```ruby
settings = SomeSettings.build('settings/other_example.json')
```

## Setting Individual Setting Attributes

While it's common to set an object, causing all of its setting attributes with corresponding data to be set, individual setting attributes can be set explicitly as well.

Use the optional keyword argument `attribute` to specify the specific attribute to set:

```ruby
settings.set(example, attribute: :some_setting)

example.some_setting == "some value"
# => true
```

### Errors Raised When Setting Individual Setting Attributes Explicitly

If the receiver has no `some_setting` attribute that is declared as a `setting`, an error will be raised:

```ruby
class Example
  setting :some_other_setting
end
```
```ruby
settings.set example, attribute: :some_setting
# => RuntimeError: Can't set "some_attr". It isn't assignable to Example.
```

The same would be true if the attribute was declared, but as a plain old `attr_accessor`:

```ruby
class Example
  attr_accessor :some_attr
  setting :some_other_setting
end
```
```ruby
settings.set(example, attribute: :some_attr)
# => RuntimeError: Can't set "some_attr". It isn't a setting of Example.
```

An error is raised because the implementer knows precisely the attribute to set. Since this level of control is being exerted, it's assumed that any deviation is a mistake and thus deserves an error.

## Setting Plain Old Attributes (Strictness)

While it's not recommended to inject into an interface that is not under direct control (ie: one developed by an external party in an external codebase), it can be useful or even necessary.

### Attributes Are Ignored By Default

By default, plain old attributes (ie: `attr_accessor`) are ignored:

```ruby
class Example
  setting :some_setting
  attr_accessor :some_attr
end
```
```javascript
{
  "some_setting": "some value",
  "some_attr": "some attr value"
}
```
```ruby
settings = Settings.build
example = Example.new
settings.set(example)

example.some_setting == "some value"
# => true
example.some_attr == "some attr value"
# => false (some_attr remains unset, and is nil)
```

### Turning Off Strictness to Include Plain Old Attributes

In order for an attribute to be a candidate to by assigned to from the settings data, it should be declared as a `setting`.

However, it's possible to override this behavior with the optional keyword argument `strict`.

Turning strictness off using the `strict` argument will also set attributes that are not declared as `settings`:

```ruby
settings.set(example, strict: false)

example.some_setting == "some value"
# => true
example.some_attr == "some attr value"
# => true (some_attr is set)
```

### Strictness and Setting Individual Setting Attributes Explicitly

Strictness can also be turned off when setting individual attributes explicitly:

```ruby
settings.set(example, attribute: :some_attr, strict: false)

example.some_attr == "some attr value"
# => true
```

An error will be raised if settinga plain old attribute explicitly and the attribute isn't assignable:

```ruby
class Example
  setting :some_other_setting
end
```
```ruby
settings.set(example, attribute: :some_attr)
# => RuntimeError: Can't set "some_attr". It isn't assignable to Example.
```

## Namespaced Data (Nested JSON)

The source data isn't required to be a flat key/value list. The data may be namespaced:

```javascript
{
  "some_namespace": {
    "some_setting": "some value",
    "some_other_setting": "some other value"
  }
}
```

To set the data, the namespace where the data resides is specified:

```ruby
settings.set(example, "some_namespace")

example.some_setting == "some value"
# => true
example.some_other_setting == "some other value"
# => true
```

The same can be done with specific attributes as well:

```ruby
settings.set(example, "some_namespace", attribute: :some_setting)

example.some_setting == "some value"
# => true
example.some_other_setting == nil
# => true
```

And of course, with plain old attributes by turning off stictness

```javascript
{
  "some_namespace": {
    "some_attr": "some attr value"
  }
}
```

```ruby
settings.set(example, "some_namespace", attribute: :some_attr, strict: false)

example.some_attr == "some attr value"
# => true
```

### Deep Namespaces

Namespaces can be arbitrarily deep, as well:

```javascript
{
  "some_namespace": {
    "some_deeper_namespace": {
      "and_so_on": {
        "some_setting": "some value"
        "some_other_setting": "some other value"
      }
    }
  }
```

To set the data, the namespaces where the data resides is are specified:

```ruby
settings.set example, "some_namespace", "some_deeper_namespace", "and_so_on"

example.some_setting == "some value"
# => true
example.some_other_setting == "some other value"
# => true
```

#### Also for Setting Specific Attributes

Deep namespaces can also be specified when setting individual attributes:

```ruby
settings.set example, "some_namespace", "some_deeper_namespace", "and_so_on", attribute: :some_setting

example.some_setting == "some value"
# => true
example.some_other_setting == nil
# => true
```

And for setting plain old attributes as well:

```ruby
settings.set(example, "some_namespace", "some_deeper_namespace", "and_so_on", )attribute: :some_attr, strict: false

example.some_attr == "some attr value"
# => true
```

## Retrieving Settings Data

Settings data can be retrieved from a settings object by the name of the data's key:

```ruby
val = settings.get(:some_setting)

val == "some value"
# => true
```

Namespaced data can also be retrieved by specifying the path to the setting:

```ruby
val = settings.get(:some_namespace, :some_deeper_namespace, :and_so_on, :some_setting)

val == "some value"
# => true
```

## License

The `settings` library is released under the [MIT License](https://github.com/eventide-project/settings/blob/master/MIT-License.txt).

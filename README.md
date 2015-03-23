# Settings Library

Get settings from a JSON file or a hash. Declare settings attributes in classes that use configuration data, and push configuration data to those settings while respecting encapsulation.

Some lower-level capabilities allow interaction with the settings data directly, as well as overriding and reseting the data, which is useful in testing scenarios, as well as hierarchical overrides in more specialized namespaces.

## Synopsis

```ruby
settings = Settings.build ...

settings.set example

example.some_setting == "some value"
# => true
example.some_other_setting == "some other value"
# => true
```

In the above code, `example` is an instance of a class with _setting_ attributes:

```ruby
class Example
  setting :some_setting
  setting :some_other_setting
end
```

The settings object is built with a pathname to a JSON file, or a hash with raw data. In either case, values are assigned to the object's settings attributes based on whether there's a key in the data that matches the name of a setting attribute.

In the above code, the JSON data would be:

```javascript
{
  "some_setting": "some value",
  "some_other_setting": "some other value"
}

```

## Building a Settings Object

A settings object is built by passing it either:

1. A hash containing the data
2. A filename (current working directory is assumed)
3. A directory path ("settings.json" is assumed as the filename)
4. A fully-qualified pathname to a JSON file (either relative or absolute)
5. Nothing ("settings.json" in the current working directory is assumed)

A frequent use case will be instantiating `Settings` with a directory path:

```ruby
settings = Settings.build './settings/example.json'
```

Where the data in `./settings/example.json` would be:

```javascript
{
  "some_setting": "some value",
  "some_other_setting": "some other value"
}

```

The same can be achieved using a hash of the data:

```ruby
data = {
  some_setting: "some value",
  some_other_setting: "some other value"
}

settings = Settings.build './settings/example.json'
```

## Setting Individual Setting Attributes

While it's common to set an object, causing all of its setting attributes with corresponding data to be set, individual setting attributes can be set explicitly as well.

Use the optional keyword argument `attribute` to specify the specific attribute to set:

```ruby
settings.set example, attribute: :some_setting

example.some_setting == "some value"
# => true
```

### Errors Raised When Setting Individual Setting Attributes Explicitly

If there is no `some_setting` attribute that is declared using the `setting` macro, an error will be raised.

An error is raised in this case because it's assumed that the implementer knows precisely that there is a setting attribute on the receiver with the specified name.

## Strictness

_Strictness_ controls whether errors are raised refers to the behavior of errors

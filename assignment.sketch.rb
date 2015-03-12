class SomeObj
  attr :foo
  attr :bar
end

some_obj = SomeObj.new

settings = Settings.build 'some-path'

setting.configure some_obj

{
  "foo" => "foo value",
  "bar" => "bar value"
}

puts some_obj.foo # => "foo value"
puts some_obj.bar # => "bar value"

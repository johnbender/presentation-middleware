def foo
  bar(baz(bak("fing")))
end

Builder.new {
  use Bak
  use Baz
  use Bar
}.call("fing")

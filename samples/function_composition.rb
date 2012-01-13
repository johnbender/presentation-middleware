def foo
  bar(baz(bak("fing")))
end

stack = Builder.new do
  use Bak
  use Baz
  use Bar
end

stack.call("fing")

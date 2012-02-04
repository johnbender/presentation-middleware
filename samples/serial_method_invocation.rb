def foo
  bar(1)
  baz(2)
  bak("fing")
end

Builder.new do
  use Bar, 1
  use Baz, 2
  use Bak, "fing"
end

@stack ||= Builder.new do
  use Bar
  use Baz
  use Bak
end

stack.call(1, 2, "fing")

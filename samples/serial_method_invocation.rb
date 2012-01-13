def foo
  bar(1)
  baz(1, 2)
  bak("fing")
end

stack = Builder.new do
  use Bar
  use Baz
  use Bak
end

stack.call( 1, 1, 2, "fing")


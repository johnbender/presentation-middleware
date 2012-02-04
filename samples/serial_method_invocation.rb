def foo
  bar(1)
  baz(1, 2)
  bak("fing")
end

Builder.new do
  use Bar, 1
  use Baz, 1, 2
  use Bak, "fing"
end

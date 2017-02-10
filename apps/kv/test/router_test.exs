defmodule RouterTest do
  use ExUnit.Case, async: true

  @tag :distributed
  test "route request across nodes" do
    assert KV.Router.router("hello", Kernel, :node, []) == :"foo@anderson-pc"

    assert KV.Router.router("world", Kernel, :node, []) == :"bar@anderson-pc"
  end

  test "raises unknown entries" do
    assert_raise(RuntimeError, ~r/could not find entry/, fn ->
      KV.Router.router(<<0>>, Kernel, :node, []) end)
  end
end

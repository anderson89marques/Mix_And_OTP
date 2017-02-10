defmodule KV.Router do

  @doc """
  Dispatch the given `mod`, `fun`, `args` request
  to the appropriate node based on the bucket.
  """
  def router(bucket, mod, fun, args) do
    # Get the first byte on the binary
    first = :binary.first(bucket)

    # Try to find a entry in the table() or raise
    entry =
      Enum.find(table(), fn({enum, _node}) ->
        first in enum
      end) || no_entry_error(bucket)

    if elem(entry, 1) == node() do
      apply(mod, fun, args)
    else
      {KV.RouterTasks, elem(entry, 1)}
      |> Task.Supervisor.async(KV.Router, :router, [bucket, mod, fun, args])
      |> Task.await()
    end
  end

  defp no_entry_error(bucket) do
    raise "could not find entry for #{inspect bucket} in table #{inspect table()}"
  end

  @doc """
  The routing table
  """
  defp table do
    [{?a..?m, :"foo@anderson-pc"},
    {?n..?z, :"bar@anderson-pc"}]
  end
end

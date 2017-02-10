excludes =
  if Node.alive?, do: [], else: [distributed: true]
ExUnit.start(exclude: excludes)

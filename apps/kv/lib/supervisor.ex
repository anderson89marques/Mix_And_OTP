defmodule KV.Supervisor do
  use Supervisor
  @moduledoc false

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(KV.Registry, [KV.Registry]), # KV.Registry.start_link(KV.Registry)
      supervisor(BucketSupervisor, []),
      supervisor(Task.Supervisor,[[name: KV.RouterTasks]])
    ]

    supervise(children, strategy: :rest_for_one)
  end
end

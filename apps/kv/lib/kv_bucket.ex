defmodule KV.Bucket do

  @doc """
  Inicia um novo agente
  """
  def start_link() do
    Agent.start_link(fn  -> %{} end)
  end

  @doc """
  Busca um valor do 'bucket' através de uma chave
  """
  def get(bucket, key) do
    Agent.get(bucket, fn mapa -> Map.get(mapa, key) end)
  end

  @doc """
  Coloca o valor (value) de uma chave (key) no 'bucket'
  """
  def put(bucket, key, value) do
    Agent.update(bucket, fn mapa -> Map.put(mapa, key, value)  end)
  end

  @doc """
  Apaga 'key' de 'bucket'
  """
  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end
end
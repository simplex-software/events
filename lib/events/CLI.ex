defmodule Events.CLI do
  def main(["server"]) do
    IO.puts("Running in server mode")
    {:ok, _} = Application.ensure_all_started(:events)
    receive do _ -> :ok end
  end

  def main(["client"]) do
    IO.puts("Welcome!")
  end

  def main(_args) do
    IO.puts("Unknown mode. Use 'client' or 'server'")
  end
  
end

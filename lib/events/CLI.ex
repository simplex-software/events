defmodule Events.CLI do
  @node Application.get_env(:events, :node)

  def main(["server", server_address]) do
    start("server", server_address)
    IO.puts("Running in server mode")
    {:ok, _} = Application.ensure_all_started(:events)
    :net_kernel.monitor_nodes(true)

    monitor()
  end

  def main(["client", server_address, client_address]) do
    start("client", client_address)
    atom_address = String.to_atom("server@#{server_address}")
    @node.connect(atom_address)
    connected?(@node.ping(atom_address), atom_address)
  end

  def main(_args) do
    IO.puts("Unknown mode. Use 'client' or 'server'")
  end

  defp start(name, address) do
    System.cmd("epmd", ["-daemon"])
    @node.start :"#{name}@#{address}"
  end

  defp connected?(:pong, server_address) do
    IO.puts("Welcome!, connected to #{server_address}")
    receive do _ -> :ok end
  end

  defp connected?(:pang, server_address) do
    IO.puts("Oops! something went wrong while trying to connect to #{server_address}")
  end

  defp monitor() do
      receive do
        :stop -> :ok
        {:nodeup, name} ->
          IO.puts("node #{name} connected")
          monitor()
        {:nodedown, name} ->
          IO.puts("node #{name} disconnected")
          monitor()
      end
  end
end

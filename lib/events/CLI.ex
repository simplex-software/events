defmodule Events.CLI2 do
  @node Application.get_env(:events, :node)

  def main(["server", server_address]) do
      start("server", server_address)
      {:ok, _} = Application.ensure_all_started(:events)
      :net_kernel.monitor_nodes(true)
      monitor()
  end

  def main(["client", client_address]) do
     start("client", client_address)
     client = Socket.UDP.open!(broadcast: true)
     :ok = Socket.Datagram.send!(client, "configurable-password", {"255.255.255.255", 9090})
     {server_address, _} = Socket.Datagram.recv!(client, [timeout: 5000])
     atom_address = String.to_atom(server_address)
     @node.connect(atom_address)
  end

  def main(_args) do
    IO.puts("Unknown mode. Use 'client' or 'server'")
  end

  defp start(name, address) do
    System.cmd("epmd", ["-daemon"])
    @node.start :"#{name}@#{address}"
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

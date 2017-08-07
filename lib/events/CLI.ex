defmodule Events.CLI do
  use Bitwise
  @node Application.get_env(:events, :node)

  def main(["server", server_address]) do
    IO.puts "Running in server mode"
    start("server", server_address)
    {:ok, _} = Application.ensure_all_started(:events)
    :net_kernel.monitor_nodes(true)
    monitor()
  end

  def main(["client"]) do
    client = Socket.UDP.open!(broadcast: true)
    :ok = Socket.Datagram.send!(client, "configurable-password", {"255.255.255.255", 9090})
    {server_address, {server_ip, _port}} = Socket.Datagram.recv!(client, [timeout: 5000])
    {client_address, _, _} = reconize_ip(server_ip)
    client_address = Enum.join(Tuple.to_list(client_address), ".")
    start("client", client_address)
    atom_address = String.to_atom(server_address)
    @node.connect(atom_address)
    IO.puts "Welcome!, connected to #{atom_address}\n"
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

  defp reconize_ip(server_address) do
    {:ok, local_ips} = :inet.getif()
    Enum.find(local_ips, fn {addr, _broadaddr, netmask} ->
      zip = Enum.zip([Tuple.to_list(addr), Tuple.to_list(server_address), Tuple.to_list(netmask)])
      Enum.all?(zip, fn {x, y, z} ->
        Bitwise.band(x, z) == Bitwise.band(y, z)
      end)
    end)
  end
end

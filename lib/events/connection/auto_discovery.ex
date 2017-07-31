defmodule Events.Connection.AutoDiscovery do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(%{}) do
    listen()
    {:ok, Socket.UDP.open!(9090)}
  end

  defp listen() do
    GenServer.cast(self(), {:listen})
  end

  ## Callbacks
  def handle_cast({:listen}, socket) do
      listen(socket)
      {:noreply, socket}
  end

  defp listen(socket) do
    {"configurable-password", sender} = Socket.Datagram.recv!(socket)
    Socket.Datagram.send(socket, Atom.to_string(node()), sender)
    listen()
  end

  ## Pre-restart
  def terminate(_reason, socket) do
    Socket.close(socket)
  end
end

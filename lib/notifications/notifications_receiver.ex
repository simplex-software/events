defmodule Events.Notifications.NotificationReceiver do
  use GenServer

    def start_link do
      GenServer.start_link(__MODULE__, %{})
    end

    def init(state) do
      {:ok, state}
    end

    #Callbacks
    def handle_info({:notification, content}, state) do
      IO.puts content
      {:noreply, state}
    end
end

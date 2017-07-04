defmodule Events.Notifications.NotificationService do
  use GenServer

    def start_link do
      GenServer.start_link(__MODULE__, %{}, name: {:global, __MODULE__})
    end

    def init(state) do
      {:ok, state}
    end

    def add_to_topic(pid, topic) do
      GenServer.cast({:global, __MODULE__}, {:add_to_topic, {pid, topic}})
    end

    def delete_from_topic(pid, topic) do
      GenServer.cast({:global, __MODULE__}, {:remove_from_topic, {pid, topic}})
    end

    def notify(topic, message) do
      GenServer.cast({:global, __MODULE__}, {:notify, {topic, message}})
    end

    ##Callbacks

    def handle_cast({:add_to_topic, {pid,  topic}}, state) do
      state = add_to_key(state, topic, pid)
      {:noreply, state}
    end

    def handle_cast({:remove_from_topic, {pid,  topic}}, state) do
      list = Map.get(state, topic)
      list = List.delete(list, pid)
      state = Map.put(state, topic, list)
      {:noreply, state}
    end

    def handle_cast({:notify, {topic, message}}, state) do
      Enum.each(Map.get(state, topic), fn (x) -> send x, {:notification, message} end)
      {:noreply, state}
    end

    def handle_call({:list}, _from, state) do
      {:reply, state, state}
    end

    ##private functions
    defp add_to_key(map, key, value) do
      map = add_key_to_map(map, key)
      list = Map.get(map, key)
      if Enum.member?(list, value) do
        map
      else
        list = [value | list]
        Map.put(map, key, list)
      end
    end

    defp add_key_to_map(map, key) do
      Map.put_new(map, key, [])
    end
end

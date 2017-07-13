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
      Process.monitor(pid)
      state = add_to_key(state, topic, pid)
      {:noreply, state}
    end

    def handle_cast({:remove_from_topic, {pid,  topic}}, state) do
      list = Map.get(state, topic)
      list = List.delete(list, pid)
      state = update_key(state, topic, list)
      {:noreply, state}
    end

    def handle_cast({:notify, {topic, message}}, state) do
      pids = Map.get(state, topic)
      if pids != nil do
        Enum.each(pids, fn (x) -> send x, {:notification, message} end)
      end
      {:noreply, state}
    end

    def handle_info({:DOWN, _reference, :process, pid, _reason}, state) do
      Enum.each(Map.keys(state), fn(x) -> delete_from_topic(pid, x) end)
      {:noreply, state}
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

    defp update_key(map, key, []) do
      Map.drop(map, [key])
    end

    defp update_key(map, key, list) do
      Map.put(map, key, list)
    end

end

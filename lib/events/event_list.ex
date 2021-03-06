defmodule Events.EventList do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{id: 0, events: []})
  end

  def init(pid) do
    {:ok, pid}
  end

  def add_event(pid, title, description, date, duration, owner) do
     GenServer.cast(pid, {:add_event, [title, description, date, duration, owner]})
  end

  def list_events(pid) do
     GenServer.call(pid, :list_events)
  end

  def remove_event(pid, event_id) do
     GenServer.cast(pid, {:remove_event, event_id})
  end

  # Callbacks

  def handle_call(:list_events, _from, events_list ) do
     {:reply, events_list[:events], events_list}
  end

  def handle_cast({:remove_event, event_id}, events_list) do
    event = Enum.find(events_list[:events], fn(target_event) -> elem(target_event, 0) == event_id end)
    if event != nil do
      {_, event_pid} = event
      Events.EventSupervisor.terminate_child(event_pid)
      new_events_list = %{ events_list | events: List.delete(events_list[:events], event)}
      {:noreply, new_events_list}
    else
      {:noreply, events_list}
    end
  end

  def handle_cast({:add_event, event}, events_list) do
    new_event = [(events_list[:id] + 1) | event]
    {:ok, pid} = Events.EventSupervisor.start_child(new_event)
    new_events_list = %{ events_list | events: [{(events_list[:id] + 1), pid} | events_list[:events]],
    id: (events_list[:id] + 1)}
    {:noreply, new_events_list}
  end

end

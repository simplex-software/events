defmodule Events.Event do
  use GenServer

  defstruct id: nil  , title: nil, description: nil, date: nil, duration: nil, owner: nil, participants: []

  def start_link(id, title, description, date, duration, owner) do
    GenServer.start_link(__MODULE__, %Events.Event{id: id,
    title: title,
    description: description,
    date: date,
    duration: duration,
    owner: owner
    })
  end

  def init(pid) do
    {:ok, pid}
  end

  def get_event(pid) do
     GenServer.call(pid, :get_event)
  end

  def add_participant(pid, participant) do
      GenServer.cast(pid, {:add_participant, participant})
  end

  def remove_participant(pid,participant) do
    GenServer.cast(pid, {:remove_participant, participant})
  end

  def update_title(pid, new_title) do
    GenServer.cast(pid, {:title, new_title})
  end

  def update_description(pid, new_description) do
    GenServer.cast(pid, {:description, new_description})
  end

  def update_date(pid, new_date) do
    GenServer.cast(pid, {:date, new_date})
  end

  def update_duration(pid, new_duration) do
    GenServer.cast(pid, {:duration, new_duration})
  end

  #CALLBACKS

  def handle_call(:get_event, _from, event) do
    {:reply, event, event}
  end

  def handle_cast({:add_participant, participant}, event) do
      if Enum.member?(event.participants, participant) do
        {:noreply, event}
      else
        newevent = %{ event | participants: event.participants ++ [participant]}
        {:noreply, newevent}
      end
  end

  def handle_cast({:remove_participant, participant}, event) do
     if Enum.member?(event.participants, participant) do
      newevent = %{ event | participants: List.delete(event.participants, participant)}
      {:noreply, newevent}
    else
      {:noreply, event}
    end
  end

  def handle_cast({:title, new_title}, event) do
    newevent = %{ event | title: new_title}
    {:noreply, newevent}
  end

  def handle_cast({:description, new_description}, event) do
    newevent = %{ event | description: new_description }
    {:noreply, newevent}
  end

  def handle_cast({:date, new_date}, event) do
    newevent = %{ event | date: new_date}
    {:noreply, newevent}
  end

  def handle_cast({:duration, new_duration}, event) do
    newevent = %{ event | duration: new_duration}
    {:noreply, newevent}
  end

end

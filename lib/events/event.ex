defmodule Events.Event do
  use GenServer

  defstruct title: nil, description: nil, date: nil, duration: nil, owner: nil, participants: []

  def start_link(title, description, date, duration, owner) do
    GenServer.start_link(__MODULE__, %Events.Event{title: title,
    description: description,
    date: date,
    duration: duration,
    owner: owner
    })
  end

  def init(state) do
    {:ok, state}
  end

  def get_event(state) do
     GenServer.call(state, :get_event)
  end

  def add_participant(state, participant) do
      GenServer.cast(state, {:add_participant, participant})
  end

  def remove_participant(state,participant) do
    GenServer.cast(state, {:remove_participant, participant})
  end

  def modify_title(state, new_title) do
    GenServer.cast(state, {:title, new_title})
  end

  def modify_description(state, new_description) do
    GenServer.cast(state, {:description, new_description})
  end

  def modify_date(state, new_date) do
    GenServer.cast(state, {:date, new_date})
  end

  def modify_duration(state, new_duration) do
    GenServer.cast(state, {:duration, new_duration})
  end

  #CALLBACKS

  def handle_call(:get_event, _from, event) do
    {:reply, event, event}
  end

  def handle_cast({:add_participant, participant}, event) do
     Enum.member?(event.participants, participant)
     newevent = %{ event | participants: event.participants ++ [participant]}
     {:noreply, newevent}
  end

  def handle_cast({:remove_participant, participant}, event) do
     Enum.member?(event.participants, participant)
     newevent = %{ event | participants: List.delete(event.participants, participant)}
     {:noreply, newevent}
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

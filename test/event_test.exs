defmodule EventTest do
  use ExUnit.Case
  doctest Events.Event

  test "add new particpant to event" do
    event = Events.Event.start_link("Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    Events.Event.add_participant(pid, ["guido"])
    aux_event = Events.Event.get_event(pid)
    assert length(aux_event.participants) == 1
  end

  test "remove existing particpant to event" do
    event = Events.Event.start_link("Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    Events.Event.add_participant(pid, ["guido"])
    Events.Event.remove_participant(pid, ["guido"])
    aux_event = Events.Event.get_event(pid)
    assert length(aux_event.participants) == 0
  end

  test "add existing particpant to event" do
    event = Events.Event.start_link("Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    Events.Event.add_participant(pid, ["guido"])
    Events.Event.add_participant(pid, ["guido"])
    aux_event = Events.Event.get_event(pid)
    assert length(aux_event.participants) == 1
  end

  test "remove nonexisting particpant to event" do
    event = Events.Event.start_link("Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    Events.Event.remove_participant(pid, ["guido"])
    aux_event = Events.Event.get_event(pid)
    assert length(aux_event.participants) == 0
  end

  test "modify title" do
    event = Events.Event.start_link("Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    new_title = "New title"
    Events.Event.modify_title(pid, new_title)
    aux_event = Events.Event.get_event(pid)
    assert aux_event.title == new_title
  end

  test "modify description" do
    event = Events.Event.start_link("Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    new_description = "New description"
    Events.Event.modify_description(pid, new_description)
    aux_event = Events.Event.get_event(pid)
    assert aux_event.description == new_description
  end

  test "modify date" do
    event = Events.Event.start_link("Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    new_date =  ~N[2017-07-01 23:22:07]
    Events.Event.modify_date(pid, new_date)
    aux_event = Events.Event.get_event(pid)
    assert aux_event.date == new_date
  end

  test "modify duration" do
    event = Events.Event.start_link("Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    new_duration = 120
    Events.Event.modify_duration(pid, new_duration)
    aux_event = Events.Event.get_event(pid)
    assert aux_event.duration == new_duration
  end

end

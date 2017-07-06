defmodule EventTest do
  use ExUnit.Case
  doctest Events.Event

  test "add new particpant to event" do
    event = Events.Event.start_link(1, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    Events.Event.add_participant(pid, ["guido"])
    aux_event = Events.Event.get_event(pid)
    assert length(aux_event.participants) == 1
  end

  test "remove existing particpant to event" do
    event = Events.Event.start_link(2, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    Events.Event.add_participant(pid, ["guido"])
    Events.Event.remove_participant(pid, ["guido"])
    aux_event = Events.Event.get_event(pid)
    assert length(aux_event.participants) == 0
  end

  test "add existing particpant to event" do
    event = Events.Event.start_link(3, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    Events.Event.add_participant(pid, ["guido"])
    Events.Event.add_participant(pid, ["guido"])
    aux_event = Events.Event.get_event(pid)
    assert length(aux_event.participants) == 1
  end

  test "remove nonexisting particpant to event" do
    event = Events.Event.start_link(4, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    Events.Event.remove_participant(pid, ["guido"])
    aux_event = Events.Event.get_event(pid)
    assert length(aux_event.participants) == 0
  end

  test "update title" do
    event = Events.Event.start_link(5, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    new_title = "New title"
    Events.Event.update_title(pid, new_title)
    aux_event = Events.Event.get_event(pid)
    assert aux_event.title == new_title
  end

  test "update description" do
    event = Events.Event.start_link(6, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    new_description = "New description"
    Events.Event.update_description(pid, new_description)
    aux_event = Events.Event.get_event(pid)
    assert aux_event.description == new_description
  end

  test "update date" do
    event = Events.Event.start_link(7, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    new_date =  ~N[2017-07-01 23:22:07]
    Events.Event.update_date(pid, new_date)
    aux_event = Events.Event.get_event(pid)
    assert aux_event.date == new_date
  end

  test "update duration" do
    event = Events.Event.start_link(8, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    {_, pid} = event
    new_duration = 120
    Events.Event.update_duration(pid, new_duration)
    aux_event = Events.Event.get_event(pid)
    assert aux_event.duration == new_duration
  end

end

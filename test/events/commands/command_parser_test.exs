defmodule Events.Commands.CommandParserTest do
  use ExUnit.Case
  doctest Events.Commands.CommandParser
  alias Events.Commands.CommandParser
  alias Events.Commands.CreateCommand
  alias Events.Commands.DeleteCommand
  alias Events.Commands.UpdateCommand
  alias Events.Commands.SubscribeCommand
  alias Events.Commands.UnsubscribeCommand
  import ExUnit.CaptureIO

  test "parse arguments in create command returns CreateCommand" do
    create_command = CommandParser.parse_arguments("create --name=Dinner party --description=Invitation to Juani's dinner party  --date=~N[2017-06-30 20:00:00] --duration=240 --owner=juani@someemail.com --participants=email@email.com,email2@email.com")
    %CreateCommand{name: name,
                    description: description,
                    date: date,
                    duration: duration,
                    owner: owner,
                    participants: participants} = create_command
    assert name == "Dinner party"
    assert description == "Invitation to Juani's dinner party"
    assert date == "~N[2017-06-30 20:00:00]"
    assert duration == "240"
    assert owner == "juani@someemail.com"
    assert participants == "email@email.com,email2@email.com"
  end

  test "parse arguments in delete command returns DeleteCommand" do
    delete_commmand = CommandParser.parse_arguments("delete --event=123098")
    %DeleteCommand{event_id: event_id} = delete_commmand

    assert event_id == "123098"
  end

  test "parse arguments in modify command returns UpdateCommand" do
    update_command = CommandParser.parse_arguments("update  --event=123098 --name=Birthday party --description=Invitation to Juani's birthday party --date=~N[2017-06-30 20:00:00] --duration=240 --owner=juani@someemail.com --participants=ramiro@someemail.com,valentin@someemail.com")
    %UpdateCommand{event_id: event_id,
                    name: name,
                    description: description,
                    date: date,
                    duration: duration,
                    owner: owner,
                    participants: participants} = update_command
    assert event_id == "123098"
    assert name == "Birthday party"
    assert description == "Invitation to Juani's birthday party"
    assert date == "~N[2017-06-30 20:00:00]"
    assert duration == "240"
    assert owner == "juani@someemail.com"
    assert participants == "ramiro@someemail.com,valentin@someemail.com"
  end

  test "parse arguments in subscribe returns SubscribeCommand" do
    subscribe_command = CommandParser.parse_arguments("subscribe --event=123098  --email=ramiro@someemail.com")
    %SubscribeCommand{event_id: event_id, email: email} = subscribe_command

    assert event_id == "123098"
    assert email == "ramiro@someemail.com"
  end

  test "parse arguments in unsubscribe returns UnsubscribeCommand" do
    unsubscribe_command = CommandParser.parse_arguments("unsubscribe --event=123098 --email=ramiro@someemail.com")
    %UnsubscribeCommand{event_id: event_id, email: email} = unsubscribe_command

    assert event_id == "123098"
    assert email == "ramiro@someemail.com"
  end

  test "when parse arguments receives an unvalid command then prints usage info" do
    assert capture_io(fn ->
      CommandParser.parse_arguments("unvalid command") end) == "Usage: \n
      create --name=<name> --description=<description> --date=<date> \n
      --duration=<minutes> --owner=<email> --participants=<email1,email2>\n
      delete --event=<event_id>\n
      update --event=<event_id> [--name=<name>] [--description=<description>]\n
       [--date=<date>] [--duration=<minutes>] [--owner=<email>]\n
        [--participants=<email1,email2]>\n
      subscribe --event=<event_id> --email=<email>\n
      unsubscribe --event=<event_id> --email=<email>\n"
  end
end

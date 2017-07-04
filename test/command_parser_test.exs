defmodule CommandParserTest do
  use ExUnit.Case
  doctest CommandParser

  test "parse arguments in create command returns CreateCommand" do
    create_command = CommandParser.parse_arguments(["create", "Dinner party",
    "--description", "Invitation to Juani's dinner party",
    "--date", ~N[2017-06-30 20:00:00],
    "--duration", 240,
    "--owner", "juani@someemail.com",
    "--participants", ["ramiro@someemail.com","valentin@someemail.com"]])
    %CreateCommand{name: name,
                    description: description,
                    date: date,
                    duration: duration,
                    owner: owner,
                    participants: participants} = create_command
    assert name == "Dinner party"
    assert description == "Invitation to Juani's dinner party"
    assert date == ~N[2017-06-30 20:00:00]
    assert duration == 240
    assert owner == "juani@someemail.com"
    assert participants == ["ramiro@someemail.com", "valentin@someemail.com"]
  end

  test "parse arguments in delete command returns DeleteCommand" do
    delete_commmand = CommandParser.parse_arguments(["delete", 123098])
    %DeleteCommand{event_id: event_id} = delete_commmand

    assert event_id == 123098
  end

  test "parse arguments in modify command returns ModifyCommand" do
    modify_command = CommandParser.parse_arguments(["modify", 123098,
    "--name", "Birthday party",
    "--description", "Invitation to Juani's birthday party",
    "--date", ~N[2017-06-30 20:00:00],
    "--duration", 240,
    "--owner", "juani@someemail.com",
    "--participants", ["ramiro@someemail.com","valentin@someemail.com"]])
    %ModifyCommand{event_id: event_id,
                    name: name,
                    description: description,
                    date: date,
                    duration: duration,
                    owner: owner,
                    participants: participants} = modify_command
    assert event_id == 123098
    assert name == "Birthday party"
    assert description == "Invitation to Juani's birthday party"
    assert date == ~N[2017-06-30 20:00:00]
    assert duration == 240
    assert owner == "juani@someemail.com"
    assert participants == ["ramiro@someemail.com", "valentin@someemail.com"]
  end

  test "parse arguments in subscribe returns SubscribeCommand" do
    subscribe_command = CommandParser.parse_arguments(["subscribe", 123098, "--email", "ramiro@someemail.com"])
    %SubscribeCommand{event_id: event_id, email: email} = subscribe_command

    assert event_id == 123098
    assert email == "ramiro@someemail.com"
  end

  test "parse arguments in unsubscribe returns UnsubscribeCommand" do
    unsubscribe_command = CommandParser.parse_arguments(["unsubscribe", 123098, "--email", "ramiro@someemail.com"])
    %UnsubscribeCommand{event_id: event_id, email: email} = unsubscribe_command

    assert event_id == 123098
    assert email == "ramiro@someemail.com"
  end
end

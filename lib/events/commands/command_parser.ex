defmodule Events.Commands.CommandParser do
  alias Events.Commands.CreateCommand
  alias Events.Commands.DeleteCommand
  alias Events.Commands.ModifyCommand
  alias Events.Commands.SubscribeCommand
  alias Events.Commands.UnsubscribeCommand

  @moduledoc """
  Documentation for CommandParser.
  """

  @doc """

  ## Examples

  """

  def parse_arguments(args) do
    parsed_arguments = OptionParser.parse(args)
    case parsed_arguments do

      {[description: description,
        date: date,
        duration: duration,
        owner: owner,
        participants: participants],
        ["create", name],
        _} -> %CreateCommand{name: name,
                              description: description,
                              date: date,
                              duration: duration,
                              owner: owner,
                              participants: participants}

      {_, ["delete", event_id], _} -> %DeleteCommand{event_id: event_id}

      {[name: name,
        description: description,
        date: date,
        duration: duration,
        owner: owner,
        participants: participants],
        ["modify", event_id],
        _} -> %ModifyCommand{event_id: event_id,
                              name: name,
                              description: description,
                              date: date,
                              duration: duration,
                              owner: owner,
                              participants: participants}

      {[email: email],
        ["subscribe", event_id],
        _} -> %SubscribeCommand{event_id: event_id, email: email}

      {[email: email],
        ["unsubscribe", event_id],
        _} -> %UnsubscribeCommand{event_id: event_id, email: email}

    end
  end
end

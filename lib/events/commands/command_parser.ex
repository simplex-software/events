defmodule Events.Commands.CommandParser do
  alias Events.Commands.CreateCommand
  alias Events.Commands.DeleteCommand
  alias Events.Commands.UpdateCommand
  alias Events.Commands.SubscribeCommand
  alias Events.Commands.UnsubscribeCommand

  @moduledoc """
  Documentation for CommandParser.
  """

  @doc """

  ## Examples

  """

  def parse_arguments(args) do
    parsed_arguments = "operation=" <> args
                        |> String.split(~r/\s+--/)
                        |> Enum.map(fn x-> String.split(x, "=") end)
                        |> Enum.map(fn x-> List.to_tuple(x) end)
                        |> Map.new

    case parsed_arguments["operation"] do

      "create" -> %CreateCommand{name: parsed_arguments["name"],
                              description: parsed_arguments["description"],
                              date: parsed_arguments["date"],
                              duration: parsed_arguments["duration"],
                              owner: parsed_arguments["owner"],
                              participants: parsed_arguments["participants"]}

      "delete" -> %DeleteCommand{event_id: parsed_arguments["event"]}

      "update" -> %UpdateCommand{event_id: parsed_arguments["event"],
                              name: parsed_arguments["name"],
                              description: parsed_arguments["description"],
                              date: parsed_arguments["date"],
                              duration: parsed_arguments["duration"],
                              owner: parsed_arguments["owner"],
                              participants: parsed_arguments["participants"]}

      "subscribe" -> %SubscribeCommand{event_id: parsed_arguments["event"],
                                      email: parsed_arguments["email"]}

      "unsubscribe" -> %UnsubscribeCommand{event_id: parsed_arguments["event"],
                                          email: parsed_arguments["email"]}

      _ -> IO.puts("Usage: \n
      create --name=<name> --description=<description> --date=<date> \n
      --duration=<minutes> --owner=<email> --participants=<email1,email2>\n
      delete --event=<event_id>\n
      update --event=<event_id> [--name=<name>] [--description=<description>]\n
       [--date=<date>] [--duration=<minutes>] [--owner=<email>]\n
        [--participants=<email1,email2]>\n
      subscribe --event=<event_id> --email=<email>\n
      unsubscribe --event=<event_id> --email=<email>")

    end
  end
end

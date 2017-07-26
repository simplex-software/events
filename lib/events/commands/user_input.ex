defmodule Events.Commands.UserInput do
  alias Events.Commands.CommandParser
  use GenServer

  def start_link() do
    GenServer.start(__MODULE__, :ok)
  end

  def init(:ok) do
    GenServer.cast(self(), :read_input)
    {:ok, {}}
  end

# CALLBACKS

  def handle_cast(:read_input, _state) do
    IO.gets(">") |> CommandParser.parse_arguments()
    GenServer.cast(self(), :read_input)
    {:noreply, {}}
  end

end

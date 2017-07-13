defmodule Events.CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run in server mode" do
    send(self(), :stop)
    assert capture_io(fn ->
      Events.CLI.main(["server"])
    end) == "Running in server mode\n"
  end

  test "run in client mode" do
    assert capture_io(fn ->
      Events.CLI.main(["client"])
    end) == "Welcome!\n"
  end

  test "run with unknown mode" do
    assert capture_io(fn ->
      Events.CLI.main(["other"])
    end) == "Unknown mode. Use 'client' or 'server'\n"
  end
end

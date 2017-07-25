defmodule Events.CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run in server mode" do
    send(self(), :stop)
    assert capture_io(fn ->
      Events.CLI.main(["server", "fakeServerAddress"])
    end) == "Running in server mode\n"
  end

  test "run in server mode notifies when a new node connects" do
    send(self(), {:nodeup, "client@127.0.0.1"})
    send(self(), :stop)
    assert capture_io(fn ->
      Events.CLI.main(["server", "fakeServerAddress"])
    end) == "Running in server mode\nnode client@127.0.0.1 connected\n"
  end

  test "run in server mode notifies when a node disconnects" do
    send(self(), {:nodedown, "client@127.0.0.1"})
    send(self(), :stop)
    assert capture_io(fn ->
      Events.CLI.main(["server", "fakeServerAddress"])
    end) == "Running in server mode\nnode client@127.0.0.1 disconnected\n"
  end

  test "run in client mode with valid server address" do
    send(self(), :stop)
    assert capture_io(fn ->
      Events.CLI.main(["client", "validServerAddress", "fakeClientAddress"])
    end) == "Welcome!, connected to server@validServerAddress\n"
  end

  test "run with unknown mode" do
    assert capture_io(fn ->
      Events.CLI.main(["other"])
    end) == "Unknown mode. Use 'client' or 'server'\n"
  end
end

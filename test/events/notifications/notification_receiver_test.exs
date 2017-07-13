defmodule Events.Notifications.NotificationReceiverTest do
  use ExUnit.Case, async: true
  doctest Events.Notifications.NotificationReceiver
  alias Events.Notifications.NotificationReceiver
  import ExUnit.CaptureIO

  setup do
    {:ok, serverPid} = NotificationReceiver.start_link
    {:ok, serverPid: serverPid}
  end

  test "Handle info with notification prints notification" do
    assert capture_io(fn ->
      NotificationReceiver.handle_info({:notification, "This is a notification"}, %{})
    end) == "This is a notification\n"
  end
end

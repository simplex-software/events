defmodule Events.Notifications.NotificationServiceTest do
  use ExUnit.Case, async: true
  doctest Events.Notifications.NotificationService
  alias Events.Notifications.NotificationService

  setup do
    {:ok, serverPid} = NotificationService.start_link
    {:ok, serverPid: serverPid}
  end

  test "Add to topic adds to topic" do
    :ok = NotificationService.add_to_topic(self(), :test)
    :ok = NotificationService.notify(:test, "hola")
    assert_receive({:notification, "hola"})
  end

  test "Delete from topic deletes from topic" do
    selfPid = self()
    :ok = NotificationService.add_to_topic(selfPid, :test)
    :ok = NotificationService.notify(:test, "hola")
    assert_receive({:notification, "hola"})
    :ok = NotificationService.delete_from_topic(selfPid, :test)
    :ok = NotificationService.notify(:test, "hola")
    refute_receive({:notification, "hola"})
  end

  test "Notify notifies all pids in a topic" do
    :ok = NotificationService.add_to_topic(self(), :test)
    :ok = NotificationService.notify(:test, "hola")
    assert_receive({:notification, "hola"})
  end

end

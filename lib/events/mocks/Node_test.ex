defmodule Events.Mocks.NodeTest do

  def connect(_address) do
    :ok
  end

  def ping(:"server@validServerAddress") do
    :pong
  end

  def ping(:"server@127.0.0.1") do
    :pong
  end

  def ping(:"server@invalidServerAddress") do
    :pang
  end

  def start(_address) do
    :ok
  end
end

defmodule Phd2CommunicatorTest do
  use ExUnit.Case
  doctest Phd2ctrl.Phd2Communicator

  import Phd2ctrl.Phd2Communicator, only: [send_command: 1]

  test "responds with {:error, :invalid_command} when given invalid command" do
    assert send_command("badcommand") == {:error, :invalid_command}
  end
end

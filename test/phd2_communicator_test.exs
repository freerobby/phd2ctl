defmodule Phd2CommunicatorTest do
  use ExUnit.Case, async: false
  doctest Phd2ctrl.Phd2Communicator

  import Phd2ctrl.Phd2Communicator, only: [send_command: 1]

  test "responds with {:error, :invalid_command} when given invalid command" do
    assert send_command("badcommand") == {:error, :invalid_command}
  end

  test "passes command to execute_command when it is valid" do
#    with_mock Phd2ctrl.Phd2Communicator, [execute_command: fn(command) -> :ok end] do
#      assert send_command("pause") == {:ok}
#    end
  end
end

defmodule Phd2ctrl.Phd2Communicator do

  @host "localhost"
  @port 4300

  @phd2_messages %{
    pause: 1,
    resume: 2,
    move1: 3,
    move2: 4,
    move3: 5,
#    image: 6, # Not yet implemented in PHD2
#    guide: 7, # Not yet implemented in PHD2
#    camconnect: 8, # Not yet implemented in PHD2
#    camdisconnect: 9, # Not yet implemented in PHD2
    reqdist: 10,
    reqframe: 11,
    move4: 12,
    move5: 13,
    autofindstar: 14,
    setlockposition: 15,
    flipracal: 16,
    getstatus: 17,
    stop: 18,
    loop: 19,
    startguiding: 20,
    loopframecount: 21,
    clearcal: 22,
    flip_sim_camera: 23,
    deselect: 24
  }

  def send_command(command) do
    if String.to_atom(command) in Map.keys(@phd2_messages) do
      execute_command(command)
    else
      {:error, :invalid_command}
    end
  end

  def execute_command(command) do
    command_value = @phd2_messages[String.to_atom(command)]

    sock = Socket.TCP.connect! @host, @port, packet: :raw

    Socket.Stream.send! sock, <<command_value>>

    <<response>> = Socket.Stream.recv! sock, 1

    {:ok, response}
  end
end

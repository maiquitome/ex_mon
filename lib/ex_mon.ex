defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Charizard"

  def create_player(name, move_average, move_random, move_heal) do
    Player.build(name, move_random, move_average, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:claw_slash, :fire_spin, :heal)
    |> Game.start(player)

    Status.print_round_message(Game.info)
  end

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info)
  end
end

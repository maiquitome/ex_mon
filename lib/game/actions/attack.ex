defmodule ExMon.Game.Actions.Attack do
  @move_average_power 18..25
  @move_random_power 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)
  end

  defp calculate_power(:move_average), do: Enum.random(@move_average_power)
  defp calculate_power(:move_random), do: Enum.random(@move_random_power)
end

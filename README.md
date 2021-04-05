<div align="center">
  <h1>ExMon: A Pokemon-style game</h1>
  <img src=".github/Pikachu_Hello.gif">
  <h2>
  This project is part of the Udemy course: Elixir e Phoenix do zero! Crie sua primeira API Phoenix.
  </h2>
  <br>
</div>

## 🎮 Game explanation
* Turn based game where we will have a human against the computer;
* At the start of the game, the human will be able to choose his character's name, as well as the name of his 3 moves.
* Human and computer start with 100 life points;
* Each round, each can do one of 3 moves:
  - Average attack causing between (18-25) damage;
  - Random attack causing between (10-35) damage;
  - Healing power, healing between (18-25) of life.
* At each movement, the screen should display what happened and the situation of each player;
* If you or the computer have 0 life left, the game ends:
  - If someone loses, when displaying the result, it should not be displayed that any player was left with negative life.

## 🖥️ Final result

<div align="center">
  <h1> 👨‍💻 Creating the project from scratch 👨‍💻 </h1>
</div>

## 📚 Recommended study topics for this project
* Maps
  - https://hexdocs.pm/elixir/Map.html
* Structs
  - https://elixir-lang.org/getting-started/structs.html
* Agent
  - https://hexdocs.pm/elixir/Agent.html
  - https://elixircasts.io/intro-to-agents 👈 *very big*

## 🆕 Creating the project
* In the directory where we want to generate our project, we must run the command:
  - mix new ex_mon
* Enter the directory created with the command
  - cd ex_mon
* Open the project in visual studio code with the command:
  - code .

## ✔️ Checklist for creating the player
### 1. Creating the player structure
* [  ] In the lib folder, create a file called __player.ex__
* [  ] Create the __ExMon.Player__ module
* [  ] Create the player struct
  * The player must have:
    - :name
    - :moves
      - average_attack, random_attack, healing_power
    - :life_points
* [  ] Put the __list of keys__ in a __module attribute "as constant" @required_keys__
* [  ] Make __all keys__ mandatory 👉 @enforce_keys
* [  ] Put the constant value 100 from the life_points key into a __module attribute @max_life__
* [  ] Create the player using the __def build()__
```bash
iex> ExMon.Player.build("Pikachu", :tail_whip, :heal, :thunderbolt)
%ExMon.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```
### 2. Creating the player in the main module
* [  ] Create the __def create_player__ in the __main ExMon module__
  - [  ] It must have the following parameters in this order:
    - name, random_attack, average_attack, healing_power
  - [  ] It should use the __ExMon.Player.build__
  - [  ] It can use an __alias__ for the __Player Module__
```bash
iex> ExMon.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMon.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```
## ✔️ Checklist for storing the game state
### 1. Game Agent
* We need to know:
  - Whose turn is it?
  - Has the game started?
  - Is the game going on?
  - Is the game over?
  - Who are the players?
  - What is the status of each player?
* A map in memory will store our state and each round we will update this map:
    ```elixir
    %{
      computer: computer,
      human: human,
      turn: :human, # or :computer
      status: :started # or :continue, :game_over
    }
    ```
* Where is this map?
  - [  ] In the lib folder, create a file called __game.ex__
  - [  ] Create the __ExMon.Game__ module
* In this file, we will use the __Agent__
  - The __Agent module__ provides a basic server implementation that allows state to be retrieved and updated via a simple API.
  - To do this, we will use the functions below:
    ```elixir
      start(computer_pokemon, human_pokemon) # Indicates the Agent with the initial values

      info() # returns game information

      update() # updates the game status
    ```

### 2. Starting the game
* In the __def start__ (game.ex):
  - [  ] create the variable __initial_value__ with this map inside
  - [  ] To store this value in the Agent we need to use __Agent.start_link__

* [  ] Create the __def start_game__ in the __main ExMon module__
  - [  ] With the our __human pokemon__ as parameter
  - [  ] Create the computer_pokemon using __def create_player__
    - name: "Charizard"
    - random_attack: :fire_spin
    - average_attack: :claw_slash,
    - healing_power: :heal,
  - [  ] Call the __ExMon.Game.start(computer_pokemon, human_pokemon)__ inside of __start_game__.
  - [  ] alias ExMon.{Game, Player}
  - [  ] Put "Charizard" in a constant @computer_pokemon_name
  - [  ] Use Pipe Operator
```bash
iex> human_pokemon = ExMon.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMon.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
iex> ExMon.start_game(human_pokemon)
{:ok, #PID<0.257.0>}
```

### 3. Printing game status
* In the __def info__ (game.ex):
  - [  ] use __Agent.get__
```bash
iex> recompile
Compiling 1 file (.ex)
:ok
iex> ExMon.Game.info
%{
  computer: %ExMon.Player{
    life_points: 100,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMon.Player{
    life_points: 100,
    moves: %{
      average_attack: :tail_whip,
      healing_power: :heal,
      random_attack: :thunderbolt
    },
    name: "Pikachu"
  },
  status: :started,
  turn: :human
}
```
* In the lib folder, create a file and folder __game/status.ex__
  - [  ] Create the module __ExMon.Game.Status__
  - [  ] Create the __def print_round_message__
    - [  ] IO.puts("\n===== The game is started! =====\n")
    - [  ] IO.inspect( __ExMon.Game.info()__ )
    - [  ] IO.puts("----------------------------")
      - [  ] It can use __alias ExMon.Game__
  - [  ] In the __def start_game__ (ex_mon.ex) call __ExMon.Game.Status.print_round_message__
    - [  ] It can use __alias ExMon.Game.Status__

```bash
iex> human_pokemon = ExMon.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMon.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
iex> ExMon.start_game(human_pokemon)

===== The game is started! =====

%{
  computer: %ExMon.Player{
    life_points: 100,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMon.Player{
    life_points: 100,
    moves: %{
      average_attack: :tail_whip,
      healing_power: :heal,
      random_attack: :thunderbolt
    },
    name: "Pikachu"
  },
  status: :started,
  turn: :human
}
--------------------------------------
:ok
```

## ✔️ Checklist for player moves
### 1. Return human pokemon data
* [  ] Create __def player__ (game.ex)
  - [  ] Using __Map.get__
    - https://hexdocs.pm/elixir/Map.html
  ```bash
  iex> ExMon.Game.player(:human)
  %ExMon.Player{
    life_points: 100,
    moves: %{
      average_attack: :tail_whip,
      healing_power: :heal,
      random_attack: :thunderbolt
    },
    name: "Pikachu"
  }
  ```
### 2. Check whether a move exists or not
* [  ] In the game folder, create a file called __actions.ex__
  - [  ] Create __ExMon.Game.Actions__ module
  - [  ] Create __defp find_move(moves, move)__
    - [  ] Using __Enum.find_value()__
      - https://hexdocs.pm/elixir/Enum.html
    - [  ] Return {:error, move} if the move does not exist
    - [  ] Return {:ok, key} if the move exists
  - [  ] Create __def does_move_exist(move)__
    - [  ] Use ExMon.Game.player
    - [  ] Use Map.get(:moves)
    - [  ] Use find_move(moves, move)
* In the __ex_mon.ex__
  - [  ] Create the __def make_move(move)__
    - [  ] Use __ExMon.Game.Actions.does_move_exist(move)__
```bash
iex> ExMon.make_move(:punch)
{:error, :punch}
iex> ExMon.make_move(:thunderbolt)
{:ok, :random_attack}
```

### 3. Printing error or success message when making the move.
* In the __status.ex__ file
  - [  ] create print_wrong_move_message(move)
    - [  ] IO.puts("\n===== Invalid move: #{move}. =====\n")
* In the __ex_mon.ex__ file
  - [  ] create __defp do_move({:error, move})__
    - [  ] Status.print_wrong_move_message(move)
  - [  ] create __defp do_move({:ok, :healing_power})__
    - [  ] Prints "performs healing"
  - [  ] create __defp do_move({:ok, move})__
    - [  ] Prints "performs attack"
  - [  ] In the __make_move(move)__
    - [  ] Add do_move()
    - [  ] Pipe Operator
```bash
iex> ExMon.make_move(:heal)
"performs healing"
iex> ExMon.make_move(:thunderbolt)
"performs attack"
iex> ExMon.make_move(:punch)

===== Invalid move: punch. =====

:ok
```
### 4. Printing a random number when attacking
* [  ] In the game folder, create __actions/attack.ex__
  - [  ] defmodule ExMon.Game.Actions.Attack
  - [  ] Create @average_attack_power 18..25
  - [  ] Create @random_attack_power 10..35
  - [  ] Create calculate_power(:average_attack)
    - [  ] Use Enum.random(@average_attack_power)
  - [  ] Create calculate_power(:random_attack)
    - [  ] Use Enum.random(@random_attack_power)
  - [  ] Create __def attack_oponent(oponnent, move)__
    - [  ] damage = calculate_power(move)

* [  ] In the __game.ex__ file
  - [  ] Create a function to pick up the turn of the game

* [  ] In the __actions.ex__ file
  - [  ] alias ExMon.Game.Actions.Attack
  - [  ] Create the __def attack(move)__
  - [  ] Check which player's turn it is
    - [  ] :human -> Attack.attack_opponent(:computer, move)
    - [  ] :computer -> Attack.attack_opponent(:human, move)


* In the __ex_mon.ex__ file
  - In the __defp do_move({:ok, move})__
    - [  ] Change "performs attack" to Actions.attack(move)

```bash
iex> ExMon.make_move(:thunderbolt)
14
iex> ExMon.make_move(:thunderbolt)
32
iex> ExMon.make_move(:thunderbolt)
31
```
### 5. Causing damage to the opponent
* In the __actions/attack.ex__ file
  - [  ] create __def calculate_total_life(life, damage)__
    - [  ] life - damage < 0 === 0
    - [  ] life - damage
  - [  ] Create __def update_opponent_life(opponent)__
    - [  ] - Take the opponent's data
    - [  ] - Update Life with Map.put
      - https://hexdocs.pm/elixir/Map.html
  -In the __def attack_opponent(opponent, move)__
    - [  ] Take the opponent's life
    - [  ] __def Use calculate_total_life(life, damage)__
    - [  ] Use __update_opponent_life(life, opponent)__
```bash
iex> ExMon.make_move(:thunderbolt)
%ExMon.Player{
  life_points: 85, # ELIXIR IS IMMUTABLE
  moves: %{
    average_attack: :claw_slash,
    healing_power: :heal,
    random_attack: :fire_spin
  },
  name: "Charizard"
}
iex> ExMon.make_move(:thunderbolt)
%ExMon.Player{
  life_points: 86, # ELIXIR IS IMMUTABLE
  moves: %{
    average_attack: :claw_slash,
    healing_power: :heal,
    random_attack: :fire_spin
  },
  name: "Charizard"
}
```
### 6. Updating the game state: Elixir is immutable, so we always need to reassign the values
* [  ] In the __game.ex__ file
  - [  ] Create the __def update(state)__
    - [  ] Agent.update(__MODULE __, fn _ -> state end)

* In the __game/actions/attack.ex__
  - [  ] Create __def update_game(player, opponent)__
    - [  ] Get game information
    - [  ] Map.put(opponent, player)
    - [  ] Game.update()

  - [  ] Create __def update_opponent_life(life, opponent)__
    - [  ] fetch player
    - [  ] update life
    - [  ] update_game(opponent)
```bash
iex> ExMon.make_move(:thunderbolt)
:ok
iex> ExMon.Game.info()
%{
  computer: %ExMon.Player{
    life: 82,
    moves: %{
      move_average: :claw_slash,
      move_heal: :heal,
      move_random: :fire_spin
    },
    name: "Charizard"
  },
  player: %ExMon.Player{
    life: 100,
    moves: %{
      move_average: :thunderbolt,
      move_heal: :heal,
      move_random: :tail_whip
    },
    name: "Pikachu"
  },
  status: :started,
  turn: :player
}
iex> ExMon.make_move(:thunderbolt)
:ok
iex> ExMon.Game.info()
%{
  computer: %ExMon.Player{
    life: 60,
    moves: %{
      move_average: :claw_slash,
      move_heal: :heal,
      move_random: :fire_spin
    },
    name: "Charizard"
  },
  player: %ExMon.Player{
    life: 100,
    moves: %{
      move_average: :thunderbolt,
      move_heal: :heal,
      move_random: :tail_whip
    },
    name: "Pikachu"
  },
  status: :started,
  turn: :player
}
```
### 7. Printing the Attack Message
* In the __status.ex__ file
  - [  ] Create __def print_move_message(:computer, :attack, damage)__
    - [  ] IO.puts("\n===== The Player attacked the computer causing #{damage} damage. =====\n")

* In the same __game/actions/attack.ex__
  - [  ] In the __def update_opponent_life(life, opponent)__
    - [  ] Put the damage parameter

  - [  ] In the __def update_game(player, opponent)__
    - [  ] Put the damage parameter
    - [  ] Put the Status.print_move_message(opponent, :attack, damage)
    - [  ] alias ExMon.Game.Status
```bash
iex> ExMon.make_move(:thunderbolt)

===== The Player attacked the computer causing 24 damage. =====

:ok
```

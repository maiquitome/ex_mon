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


# 👨‍💻 Creating the project from scratch

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
    - Name
    - Moves
      - Average attack, Random attack, Healing power
    - 100 life points
* [  ] Make __all keys__ mandatory 👉 @enforce_keys
* [  ] Put the __list of keys__ in a __Module Attribute "as constant" @...__
* [  ] Put the constant value 100 from the life key into a module attribute
* [  ] Create the player using the __build__ function
```bash
iex> player = ExMon.Player.build("Pikachu", :tail_whip, :thunderbolt, :heal)
%ExMon.Player{
  life: 100,
  moves: %{
    move_average: :thunderbolt,
    move_heal: :heal,
    move_random: :tail_whip
  },
  name: "Pikachu"
}
```
### 2. Creating the player in the main module
* [  ] Create the __create_player__ function in the __main ExMon module__
  - [  ] It must have the following parameters:
    - name, move_random, move_average, move_heal
  - [  ] It should use the __build function__ from __Player module__
  - [  ] It should use an __alias__ for the __Player module__
```bash
iex> player = ExMon.create_player("Pikachu", :tail_whip, :thunderbolt, :heal)
%ExMon.Player{
  life: 100,
  moves: %{
    move_average: :tail_whip,
    move_heal: :heal,
    move_random: :thunderbolt
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
      player: player,
      turn: :player, # or :computer
      status: :started # or :continue, :game_over
    }
    ```
* Where is this map?
  - [  ] In the lib folder, create a file called __game.ex__
* In this file, we will use the __Agent__
  - The __Agent module__ provides a basic server implementation that allows state to be retrieved and updated via a simple API.
  - To do this, we will use the functions below:
    ```elixir
      start(computer, player) # Indicates the Agent with the initial values

      info() # returns game information

      update() # updates the game status
    ```

### 2. Starting the game
* In the __start function__ (game.ex):
  - [  ] create the variable __initial_value__ with this map inside
  - [  ] Use __Agent.start_link__

* [  ] Create the __start_game__ function in the __main ExMon module__
  - [  ] With the our __human player__ as parameter
  - [  ] Create the computer pokemon
    - name: "Charizard"
    - move_average: :claw_slash,
    - move_heal: :heal,
    - move_random: :fire_spin
  - [  ] Using __create_player__ function
  - [  ] Call the __start function__ of the __Game module__ with the two players as parameters (computer and human) inside of __start_game__.

### 3. Printing game status
* In the __info function__ (game.ex):
  - [  ] use __Agent.get__
* In the lib folder, create a file and folder __game/status.ex__
  - [  ] Create the module __ExMon.Game.Status__
  - [  ] Create the __print_round_message__ function
    - [  ] IO.puts ("The game is started")
    - [  ] IO.inspect( __Game.info()__ )
      - [  ] Using __alias ExMon.Game__
  - [  ] In the __start_game__ (ex_mon.ex) call __Status.print_round_message__ (using __Status alias__)

## ✔️ Checklist for player moves
* [  ] Create __def player__ (game.ex)
  - [  ] Using __Map.get__
  ```bash
  iex> ExMon.Game.player
  %ExMon.Player{
    life: 100,
    moves: %{
      move_average: :tail_whip,
      move_heal: :heal,
      move_random: :thunderbolt
    },
    name: "Pikachu"
  }
  ```

* [  ] In the game folder, create a file called __actions.ex__
  - [  ] Create __ExMon.Game.Actions__ module
  - [  ] Create __defp find_move(moves, move)__
    - [  ] Using __Enum.find_value()__
  - [  ] Create __fetch_move(move)__ function
    - [  ]
* [  ] Create the __make_move function__ (ex_mon.ex)
  - [  ] Use __Actions.fetch_move(move)__

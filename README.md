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

### 1. Creating my pokemon
```bash
iex(1)> my_pokemon = ExMonCopy.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMonCopy.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```
### 2. Starting the game
```bash
iex(2)> ExMonCopy.start_game(my_pokemon)

===== The game is started! =====

%{
  computer: %ExMonCopy.Player{
    life_points: 100,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMonCopy.Player{
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

----------------------------------

:ok
```
### 3. I attacked the computer but the computer recoverd life points
```bash
iex(3)> ExMonCopy.make_move(:thunderbolt)

===== You attacked the computer causing 31 damage. =====


===== It's the computer's turn to play =====

%{
  computer: %ExMonCopy.Player{
    life_points: 69,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMonCopy.Player{
    life_points: 100,
    moves: %{
      average_attack: :tail_whip,
      healing_power: :heal,
      random_attack: :thunderbolt
    },
    name: "Pikachu"
  },
  status: :continue,
  turn: :computer
}

------------------------------------------


===== The computer recovered itself to 90 life points. =====


========= It's your turn to play! =========

%{
  computer: %ExMonCopy.Player{
    life_points: 90,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMonCopy.Player{
    life_points: 100,
    moves: %{
      average_attack: :tail_whip,
      healing_power: :heal,
      random_attack: :thunderbolt
    },
    name: "Pikachu"
  },
  status: :continue,
  turn: :human
}

--------------------------------------------

:ok
```
### 4. After many attacks, the game is over!
```bash
iex(8)> ExMonCopy.make_move(:thunderbolt)

===== You attacked the computer causing 2 damage. =====

%{
  computer: %ExMonCopy.Player{
    life_points: 0,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMonCopy.Player{
    life_points: 19,
    moves: %{
      average_attack: :tail_whip,
      healing_power: :heal,
      random_attack: :thunderbolt
    },
    name: "Pikachu"
  },
  status: :game_over,
  turn: :human
}

    ============================================
    ============= The game is over! ============
    ============================================
    ================ YOU WIN :) ================
    ============================================

:ok
```

Made with ♥ by Maiqui Tomé 😀
<br>

*Reach out to me* 👇

[![Codepen](https://img.shields.io/badge/Codepen-000000?style=flat-square&logo=codepen&logoColor=white "Codepen")](https://codepen.io/maiquitome)
[![Youtube](https://img.shields.io/badge/YouTube-FF0000?style=flat-square&logo=youtube&logoColor=white "Youtube")](https://www.youtube.com/channel/UCoXn0XyxLsKpIE5px0UNuEw)
[![Medium](https://img.shields.io/badge/Medium-black?&style=flat-square&logo=medium&logoColor=white "Medium")](https://medium.com/@maiquitome)
[![Linkedin](https://img.shields.io/badge/LinkedIn-0A66C2.svg?&style=flat-square&logo=linkedin&logoColor=white "Linkedin")](https://www.linkedin.com/in/maiquitome)
[![Instagram](https://img.shields.io/badge/Instagram-D8226B.svg?&style=flat-square&logo=instagram&logoColor=white "Instagram")](https://www.instagram.com/maiquitome)
[![Facebook](https://img.shields.io/badge/Facebook-0674E7.svg?&style=flat-square&logo=facebook&logoColor=white "Facebook")](https://www.facebook.com/maiquitome)
[![Twitter](https://img.shields.io/badge/Twitter-1DA1F2?&style=flat-square&logo=twitter&logoColor=white "Twitter")](https://twitter.com/MaiquiTome)

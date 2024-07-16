# Hangman Game

This is a command-line implementation of the classic Hangman game in Ruby. The game randomly selects a word from a dictionary file, and the player tries to guess the word letter by letter before running out of attempts. This is a part of The Odin Project.

## Features

- Randomly selects words between 5 and 12 characters long from a dictionary file
- Displays the current state of the guessed word and incorrect guesses
- Case-insensitive letter input
- Option to save and load games
- Simple and intuitive command-line interface

## Requirements

- Ruby (developed and tested with Ruby 2.7+)
- `google-10000-english-no-swears.txt` dictionary file in the same directory as the script

## How to Play

1. Clone this repository or download the `game.rb` file.
2. Make sure you have the `google-10000-english-no-swears.txt` file in the same directory.
3. Run the game using Ruby:

```
ruby game.rb
```

4. Choose to start a new game or load a saved game.
5. Guess letters one at a time or type 'save' to save your progress.
6. Try to guess the word before running out of attempts!

## Saving and Loading Games

- During your turn, type 'save' instead of a letter to save your current game.
- When starting the game, choose the "Load Game" option to resume a previously saved game.

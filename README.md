# Hangman
A REST in Peace Rails Classic

## Setup
```
bundle install
rake db:create
rake db:create RAILS_ENV=test
rake db:migrate
rails s
```

## Specs
Run the test suite with the `rspec` command. Code coverage is 98.7% and can be found under `./coverage/index.html` after you have run the `rspec` command.

## Playing a game
on the command line with `curl`

Let's start a new game:
```
curl -X POST http://localhost:3000/games -d ''
```

Let's list all games:
```
curl -X GET http://localhost:3000/games
```

Show the status of the first game:
```
curl -X GET http://localhost:3000/games/1
```

Let's play a game:
```
curl -X POST http://localhost:3000/games/1 -d 'char=h'
curl -X POST http://localhost:3000/games/1 -d 'char=i'
curl -X POST http://localhost:3000/games/1 -d 'char=r'
curl -X POST http://localhost:3000/games/1 -d 'char=e'
```

Did we find the word yet?
```
curl -X GET http://localhost:3000/games/1
```

Nope, let's continue:
```
curl -X POST http://localhost:3000/games/1 -d 'char=m'
curl -X POST http://localhost:3000/games/1 -d 'char=e'
```

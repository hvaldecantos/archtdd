# Architecture and TDD

Uncovering architecture breakers through the process of Test Driven Development

## Set the environment

1. Install RVM (Ruby Version Manager) https://rvm.io/rvm/install
2. Go to the root directory and follow RVM instructions if needed
3. Install blunder gem: ```gem install blunder```
4. Run ```$ bundle install```to install dependecies

## Run the cli

### Help

```
$ ruby cli_runner.rb --help
```

### Commands

```
$ ruby cli_runner.rb --login "{name: 'name', pass: '1234'}"
$ ruby cli_runner.rb --new-user "{name: 'Fred', password: '1234', role: 'admin'}"
$ ruby cli_runner.rb --list-users "{name: 'Fred', token: 'token'}"
```

## Run tests

```
$ rake test
```
## Run tests coverage

```
$ rake coverage
```

# Architecture and TDD

Uncovering architecture breakers through the process of Test Driven Development

## Run the cli

### Help

```
ruby cli_runner.rb --help
```

### Commands

```
ruby cli_runner.rb --login "{name: 'name', pass: '1234'}"
ruby cli_runner.rb --new-user "{name: 'Fred', password: '1234', role: 'admin'}"
ruby cli_runner.rb --list-users "{name: 'Fred', token: 'token'}"
```

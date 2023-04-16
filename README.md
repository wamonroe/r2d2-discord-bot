# R2D2 Discord Bot

A simple discord bot I put together for a family server. It is a fairly basic
bot intended primarily to be run only on for a single server. Settings are
generally stored in environmental variables with a lot of assumptions on usage.

## Features

- Welcome message when a user joins the server.
- Random most interesting man (or woman) in the world quotes for select people.
- A basic ping command to make sure R2D2 is online and working correctly.

## Installation

1. Fork this repository.
2. Create a new Heroku application and connect it to that repository.
3. Create Config Vars
   1. `R2D2_CLIENT_ID`=client id of your discord app
   2. `R2D2_TOKEN`=bot token of your discord app's bot
   3. `R2D2_MOST_INTERESTING`=comma seperated list of interesting people
   4. `R2D2_PUBLIC_CHANNELS`=comma seperated list of public channel ids
4. Start a worker process (requires the Heroku CLI installed)

```bash
heroku login
heroku scale worker=1 --app <app name here>
```

## Configuration

### R2D2_CLIENT_ID

This is is the OAuth2 CLIENT ID of a Discord Application. If you don't already
have one, you need to create on in the [developer
portal](https://discord.com/developers/applications).

### R2D2_TOKEN

This is the TOKEN of the bot created for your application. After creating an
application in the developer portal, you will need to create a Bot user for that
application.

### R2D2_MOST_INTERESTING

Defines a comma seperated list of names the bot generates most interresting
facts about. You can optionally append a `:m` or `:f` to the name to transform
the pronounces to male/female pronouns.

For example:

```bash
R2D2_MOST_INTERESTING=chuck:m,sally:f
```

With the above example, R2D2 would create two commands `!chuck` and `!sally`,
with the sally command returning female pronouns.

### R2D2_PUBLIC_CHANNELS

The public channel IDs that R2D2 will not respond to commands on.

## Commands

`!chuck`
Sends a random fact Chuck Norris fact.

`!dadjoke`
Sends a random dad joke.

`!<name>`
Sends a random fact interesting fact about the named person. You must specify
the names to monitor using the [R2D2_MOST_INTERESTING](#r2d2_most_interesting)
environmental variable.

`!ping`
Check up on R2D2.

## Running Locally

To run the bot locally, create a `.env` file and place in the various
[Configuration](#configuration) values. You can use the `.env.example` file
as a template.

Install the dependencies:

```shell
bundle install
```

And start the bot:

```shell
bundle exec ruby bot.rb
```

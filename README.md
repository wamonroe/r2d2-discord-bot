# R2D2 Discord Bot

A simple discord bot I put together for a family server. It is a fairly basic bot intended primarily
to be run only on for a single server. Settings are generally stored in environmental variables with
a lot of assumptions on usage.

## Features

* Welcome message when a user joins the server.
* Random most interesting man (or woman) in the world quotes for select people.
* A basic ping command to make sure R2D2 is online and working correctly.

## Installation

1. Fork this repository.
2. Create a new Heroku application and connect it to that repository.
3. Create Config Vars
    1. R2D2_CLIENT_ID=_client id of your discord app_
    2. R2D2_TOKEN=_bot token of your discord app's bot_
    3. R2D2_MOST_INTERESTING=_comma seperated list of interesting people_
    4. R2D2_PUBLIC_CHANNELS=_comma seperated list of public channel ids_
4. Start a worker process (requires the Heroku CLI installed)

```bash
heroku login
heroku scale worker=1 --app <app name here>
```

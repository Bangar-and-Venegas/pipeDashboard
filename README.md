# README

pipeDashbard gets data from pipedrive API and displays in a dashboard.

## Setup

Add "PIPE_KEY" to your environment variables. It should contain your Pipedrive API Key

## Data loading

After running migrations, to populate data run:

```
rake p2d:populate
```

This loads:
* All users
* All won deals
* All done activities

It's also possible to load just users, deals or activities with:

```
rake p2d:users
rake p2d:deals
rake p2d:activities
```

WARNING! When loading activities, you only get those from users already in the DB.

## Ruby version

Ruby version used: 2.0.0

## Test suite

pipeDashboard uses RSpec. For running the tests, run:

```
rspec spec
```

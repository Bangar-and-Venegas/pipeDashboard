# README

pipeDashbaord gets data from pipedrive API and displays them in a dashboard.

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

## Information displayed

pipeDashboard displays the information for these time ranges:
* Since one month ago.
* Since three months ago.
* Since one year ago.

The dashboard uses colors to identify the different users. The color legend is displayed on the bottom right corner of the screen.

The following information is displayed on the dashboard:

**Number of calls made** - Number of activities that:
* are done,
* have some information in the *note* field, and
* whose *type* is "call".

**Average calls** - Number of calls made (see above) divided by the number of days considered.

**Call conversion** - Number of calls made (see above) belonging to a won deal, divided by the number of won deals.

**Activities** - Number of activities that:
* are done, and
* have some information in the *note* field.

**Deals won** - Number of won deals.

**Revenue** - Value of the won deals.

**Average budget** - Revenue (see above) divided by deals won (see above)

## Test suite

pipeDashboard uses RSpec. For running the tests, run:

```
rspec spec
```

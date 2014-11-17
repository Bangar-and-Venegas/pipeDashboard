# README

pipeDashbaord collects data from pipedrive API and displays it in the dashboard.

## Setup

Add "PIPE_KEY" to your environment variables. It should contain your Pipedrive API Key.

## Data loading

After running database migrations, run the following to populate data:

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

WARNING! When loading activities, you only get those from users already in the database.

## Information displayed

pipeDashboard displays the information for the following time ranges:
* Since one month.
* Since three months.
* Since one year.

The dashboard uses colours to identify each user. The colour legend is displayed at the bottom right corner of the screen.

The following information is displayed on the dashboard:

**Number of calls made** - Number of activities that:
* are done,
* have some information in the *note* field, and
* where the *type* is "call".

**Average calls** - Number of calls made (see above) divided by the number of days considered.

**Call conversion** - Number of calls made (see above) belonging to a won deal, divided by the number of won deals.

**Activities** - Number of activities that:
* are done, and
* have some information in the *note* field.

**Deals won** - Number of won deals.

**Revenue** - Value of the won deals.

**Average budget** - Revenue (see above) divided by deals won (see above)

## Frameworks and libraries used

On the frontend side, pipeDashboard uses Bootstrap and Morris.js. Check the Gemfile to see other frameworks and libraries used.  

## Test suite

pipeDashboard uses RSpec. For running the tests, run:

```
rspec spec
```

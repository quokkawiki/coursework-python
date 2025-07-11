# Python coursework

## Goal

I'm gonna be for real, I'm not 100% sure I understood the goal of this coursework but I hope I'm getting it right. I think I should replicate the results seen in `inventory_full_analysis_20250530.xlsx` which you sent us before.

## Project Structure

-   [`db`](./db/)&nbsp;&mdash;&nbsp;Files needed for database setup
    -   [`food_inventory.csv`](./db/food_inventory.csv)&nbsp;&mdash;&nbsp;Inventory data, taken from the Excel file you gave us
    -   [`migration.sql`](./db/migration.sql)&nbsp;&mdash;&nbsp;Database setup script
-   [`analysis.ipynb`](./analysis.ipynb)&nbsp;&mdash;&nbsp;Analysis notebook
-   [`environment.yml`](./environment.yml)&nbsp;&mdash;&nbsp;Conda environment configuration
-   [`.env.example`](./.env.example)&nbsp;&mdash;&nbsp;Environment variables template

## Setup instructions

I wanted this environment to be as replicable as possible, so I am giving you instructions on how to replicate it.

### Database

For this database, we will be using PostgreSQL because it is what I am familiar with. I used Postgres version 17.5 on Docker for replicability. You can run it locally using Docker with this command, changing the password:

```
$ docker run -d --name coursework-db -e POSTGRES_PASSWORD=[Change this] -p 5432:5432 -v ./db:/mnt/db postgres:17.5
```

Now our database is initialized. We can now run the migration:

```
$ docker exec -i coursework-db psql -h localhost -U postgres -a -f /mnt/db/migration.sql
```

This runs [the database setup script](./db/migration.sql), which:

1. Creates a database called `coursework`
2. Adds a table called `food_inventory`
3. Copies the content of [`food_inventory.csv`](./db/food_inventory.csv) into the table
4. Creates a user `coursework` with permissions to `SELECT` the table

If you want, you can also change this password in the script and in the `.env` file.

### Python

This Python environment is running in [Anaconda](<https://en.wikipedia.org/wiki/Anaconda_(Python_distribution)>) _([download instructions](/docs/getting-started/anaconda/install#macos-linux-installation))_ for replicability.

To create the Python environment, simply run

```
$ conda env create -f environment.yml
```

Now copy `.env.example` into `.env`, and make modifications if needed. It has a connection string with the host, post, user, password and database name.

When you run [the notebook](./analysis.ipynb), you will be prompted to select a kernel. You will need to select the one that says `coursework`, as this is the Anaconda environment that we've just created.

## Confession

I did use [Claude Sonnet 4](https://claude.ai) to assist me with some more technical parts of this coursework, but for the most part it's actually me.

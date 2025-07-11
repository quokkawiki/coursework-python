# Python coursework

## Goal

I'm gonna be for real, I'm not 100% sure I understood the goal of this coursework but I hope I'm getting it right. I think I should replicate the results seen in `inventory_full_analysis_20250530.xlsx` which you sent us before.

## Project Structure

-   [`analysis.ipynb`](./analysis.ipynb)&nbsp;&mdash;&nbsp;Analysis notebook
-   [`environment.yml`](./environment.yml)&nbsp;&mdash;&nbsp;Conda environment configuration
-   [`.env.example`](./.env.example)&nbsp;&mdash;&nbsp;Environment variables template
-   📂 [`db`](./db/)&nbsp;&mdash;&nbsp;Files needed for database setup
    -   [`food_inventory.csv`](./db/food_inventory.csv)&nbsp;&mdash;&nbsp;Inventory data taken from the Excel file you gave us
    -   📂 [`migrations`](./db/migration/)
        -   [`migration.sql`](./db/migration.sql)&nbsp;&mdash;&nbsp;Database setup script

## Setup instructions

I wanted this environment to be as replicable as possible, so I am giving you instructions on how to replicate it.

### Environment variables

Copy [`.env.example`](./.env.example) into `.env`, and make modifications if needed.

The environment variabes used are:

-   `DB_SUPERUSER_PASSWORD`&nbsp;&mdash;&nbsp;Password for the database superuser
-   `DB_NAME`&nbsp;&mdash;&nbsp;Name of the database that will store the data
-   `DB_HOST`&nbsp;&mdash;&nbsp;Hostname of the database server
-   `DB_PORT`&nbsp;&mdash;&nbsp;Port where the database will be accessible
-   `DB_USER`&nbsp;&mdash;&nbsp;User that will be created for the project
-   `DB_PASSWORD`&nbsp;&mdash;&nbsp;Password for the user (`DB_USER`)

### Database

For this database, we will be using PostgreSQL because it is what I am familiar with. I used Postgres version 17.5 on Docker Compose for replicability. You can run it with this command:

```
$ docker compose up -d
```

The migration is automatically run, and our database is ready.

This runs [the database setup script](./db/migration/migration.sql), which:

1. Adds a table called `food_inventory`
2. Copies the content of [`food_inventory.csv`](./db/food_inventory.csv) into the table
3. Creates a user with permissions to `SELECT` the table

If you want, you can also change this password in the script and in the `.env` file.

### Python

This Python environment is running in [Anaconda](<https://en.wikipedia.org/wiki/Anaconda_(Python_distribution)>) _([download instructions](/docs/getting-started/anaconda/install#macos-linux-installation))_ for replicability.

To create the Python environment, simply run

```
$ conda env create -f environment.yml
```

When you run [the notebook](./analysis.ipynb), you will be prompted to select a kernel. You will need to select the one that says `coursework`, as this is the Anaconda environment that we've just created.

## Confession

I did use [Claude Sonnet 4](https://claude.ai) to assist me with some more technical parts of this coursework, but for the most part it's actually me.

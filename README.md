# Python coursework

> **Note**: Yes, I know you told us to use Google Colab, but:
>
> 1. I prefer running things locally if possible
> 2. I don't think you can run a DB in Colab
> 3. I don't want to waste my Google Drive space on this

## Goal

I'm gonna be for real, I'm not 100% sure I understood the goal of this coursework but I hope I'm getting it right. I think I should replicate the results seen in the inventory analysis notebook which you sent us before.

## Project Structure

-   [`analysis.ipynb`](./analysis.ipynb)&nbsp;&mdash;&nbsp;Analysis notebook
-   [`environment.yml`](./environment.yml)&nbsp;&mdash;&nbsp;Conda environment configuration
-   [`database.sqlite`](./database.sqlite)&nbsp;&mdash;&nbsp;The database we'll be using

## Database

Initially, I did this with a PostgreSQL database and I included a Docker Compose with a migration script and environment variables, but then I realized that's really fucking stupid and overkill for this project, so I switched to SQLite3 instead.

You can see how I did the setup in the commit history (up to commit `9b7937b`) if you want.

I also created a view `food_inventory_with_relative_expiry`, which adds a column `days_until_expiry` that takes the difference between the latest expiry date and the row's expiry date:

```sql
CREATE VIEW food_inventory_with_relative_expiry AS
SELECT *,
    JULIANDAY((SELECT MAX(expiry_date) FROM food_inventory)) - JULIANDAY(expiry_date) AS days_until_expiry
FROM food_inventory;
```

## Setup instructions

I wanted this environment to be as replicable as possible, so the Python environment is running in [Anaconda](<https://en.wikipedia.org/wiki/Anaconda_(Python_distribution)>) _([download instructions](https://www.anaconda.com/docs/getting-started/anaconda/install))_ for replicability.

To create the Python environment, simply run:

```
$ conda env create -f environment.yml
```

When you run [the notebook](./analysis.ipynb), you will be prompted to select a kernel. You will need to select the one that says `coursework`, as this is the Anaconda environment that we've just created.

## Confession

I did use [Claude Sonnet 4](https://claude.ai) to assist me with some more technical parts of this coursework, but for the most part it's actually me. You can see the Git commit history and see that it's mostly my own actual idiocy *(AI)*.

# Flask Website Example

An example webpage running in Python with Flask for HTTP processing/handling.

# Setup

- [pyenv Installer](https://github.com/pyenv/pyenv-installer)

System ("Environment") setup:

```bash
pyenv install 3.8.2;
pyenv virtualenv 3.8.2 py38;  # `py38` is a custom name, choose your own...
pip install --upgrade pip;
pip install --upgrade poetry;
```

Setup for this repository after cloning locally as `leafyrabbet/webdev_examples_flask`:

```bash
cd </PATH/TO>/leafyrabbet/webdev_examples_flask/;
pyenv activate py38;  # From above, or choose your own...
poetry install;
```

The above will use the Python `poetry` app/utility to read the `poetry.lock` file included in this repository and install the Python packages into the current Python environment.

## Separating Virtual Environments

As the comments note, you can create your own `pyenv virtualenv` named however you like, and then use the `poetry` tool to install the dependencies into that environment. If you don't want to "pollute" your own Python 3.8.x environment, you can create a local virtual environment in this repo, but that will create like a gigabyte of new files.

If you want a separate environment where you don't need to reinstall `poetry`, but will install all the dependencies, there, separately, you can instead do the following:

```bash
cd </PATH/TO>/leafyrabbet/webdev_examples_flask/;
pyenv virtualenv 3.8.2 py38alt;  # New custom name for environment.
pyenv activate py38alt;          # Switch to the new environment.
poetry install;
```

# Run

There are multiple ways to run this `flask` application, so the following subsections break-up the different approaches into their use-case or intentions.

Using Nginx is the typical preference for a professional / open-web deployment, but may be considered "excessive" if you're just trying to test some minor modifications to the example Python code. Similarly, `uWSGI` sits somewhere between the local _vs._ deployment approaches, since it allows for deeper configuration and multiple-access.

## Local Server Test

With the following command, a local server will be started, bound to the address and port that are provided in the `app.run(...)` method call.

```bash
python ./flask_app.py
```

This is a useful way to develop locally and do the simplest test-run of the `flask` application.


## Run uWSGI Locally

The `uWSGI` utility can setup an intermediary server that supports multiple-access instead of the single-access approach if you were to just use `flask` directly.

To test this, you can use the following command:

```bash
uwsgi --socket 0.0.0.0:80 --protocol=https -w flask_app:app
```

The above will bind to the `0.0.0.0` address on port `80`. If you have any conflicts, you can change these values.

Since the `flask_app.py` module has this line that configures the app alias: `app = Flask(__name__)`, we give the `[MODULE_NAME]:[FLASK_ALIAS]` to the `-w` option of the `uwsgi` utility.

These are, of course, configurable, but need to coordinate Python import/path access from wherever you're running the `uwsgi` utility. In this case, the `flask_app.py` module is at the top-level directory of this repository, so we have the following just simply as:

- `MODULE_NAME`: `flask_app`
- `FLASK_ALIAS`: `app`

## Run behind Nginx on macOS


## Run behind Nginx on Linux

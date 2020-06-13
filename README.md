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

Running `uwsgi` locally requires that the `uwsgi` package has been installed in the current Python environment. As mentioned up above, you'll want to first use `pyenv activate [VIRTUALENV_ALIAS]` with your custom `[VIRTUALENV_ALIAS]` (_e.g._, `py38`) before doing any of the following.

This is likely the preferred testing approach to make sure that everything is working in the code and in the environment, before moving on to the Nginx Deployment approaches.

### Commandline Approach

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

### Helper-Script Approach

For convenience, we can also install the files to an `opt` directory and test `uWSGI` locally with the macOS helper scripts, by doing the following (assuming you've `cd`-ed into this top-level repo directory):

```bash
cd ./macos;
./install.sh;
./run_ex_uwsgi.sh;
```

### Stopping Server

After you've tested the `uWSGI` utility's server, or if you notice an error you need to fix, you can stop the app with `CTRL+C` (`[^C]`) to send the `SIGTERM` signal. This will only work as long as `uwsgi` is in the foreground. If you added `&` to any of the commands to move it to the background, then you'll need to use `pgrep` or `ps` to figure out and kill the process, or use `fg` to move it to the foreground before you can send `SIGTERM`.

## Run behind Nginx on macOS


## Run behind Nginx on Linux

On a Linux system you'll need an accessible Python installation and an accessible Nginx installation. This tutorial/example also shows how to rely on `systemd` through the `systemctl` utility to manage the `uswgi` and `nginx` apps.




## References

These are the reference links that we used to build this example project and where we found troubleshooting information for the nuances of `systemd`, `launchd`, `uwsgi`, and accessing `pyenv`.

### Overall Project

- https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uswgi-and-nginx-on-ubuntu-18-04
- https://github.com/tiangolo/uwsgi-nginx-flask-docker

### uWSGI

- https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html
- https://stackoverflow.com/questions/21669354/rebuild-uwsgi-with-pcre-support
- https://stackoverflow.com/questions/20176959/uwsgi-no-request-plugin-is-loaded-you-will-not-be-able-to-manage-requests

### Scripting

- https://stackoverflow.com/questions/9366816/sed-fails-with-unknown-option-to-s-error
- https://unix.stackexchange.com/questions/379572/escaping-both-forward-slash-and-back-slash-with-sed
- https://stackoverflow.com/questions/3327013/how-to-determine-the-current-shell-im-working-on

### macOS launchd/launchctl

- https://stackoverflow.com/questions/34215527/what-does-launchd-status-78-mean-why-my-user-agent-not-running
- https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html
- https://alvinalexander.com/mac-os-x/mac-osx-startup-crontab-launchd-jobs/
- https://alvinalexander.com/mac-os-x/launchd-examples-launchd-plist-file-examples-mac/

### Linux systemd/systemctl



#!/bin/sh

# @file
# @brief Exemplar Run Script for uWSGI Local Server Flask-App
# 
# This is an example script for `bash` in macOS to show how to run the `uwsgi`
# utility locally to act as a testing webserver to verify the Flask-App as
# written in the Python code.
# 
# The assumption here is that you have `pyenv` installed and have created a
# named `virtualenv` with `pyenv` that correspends to a Python 3.8.x version.
# 
# The paths here need to correlate with the `macos/install.sh` script, or you
# could edit `FILE_INSTALL_DIR` variable to point to the top-level directory
# for this repository, if you don't want to run the `install.sh` script.
# 
# Note that this test the `uwsgi` server directly, this does not actually rely
# on the `plist` file for `launchd`. At this time, that `plist` file is only
# a demo that logs a string to a logfile, so there's no conflict. But it's
# possible that if that "LaunchAgent" is running, it could conflict with the
# attempt to run this script since they would both use the same INI file and
# thus try to bind to the same port(s).
# 
# @copyright (c) 2020, TenonGarden Productions
# @author tommy vegetables <leafyrabbet@gmail.com>

PYTHON_VIRTUALENV_NAME=py38                # Put your custom virtualenv name here, for pyenv.
FILE_INSTALL_DIR=/usr/local/opt/flasktest  # Put the install directory used in `install.sh` here.
INI_FILE_NAME=flask_app.ini                # Put the name of the INI file for `uwsgi` here.

# RUN uWSGI SERVER (STANDALONE) LOCALLY
pyenv activate ${PYTHON_VIRTUALENV_NAME}
uwsgi --ini ${FILE_INSTALL_DIR}/${INI_FILE_NAME}

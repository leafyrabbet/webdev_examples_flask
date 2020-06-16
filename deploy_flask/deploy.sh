#!/bin/sh
# @file
# @brief Deployment Script for running Flask app locally
#
# The hosting address and bound port are established in the `__main__`
# namespace conditional statement in `flask_app.py`, as shown here:
#
# ```python
# app.run(
#    host="0.0.0.0",
#    port="80",
# )
# ```
#
# This is not meant as a production-ready deployment, and really
# should only be used for design, testing, and verification. But
# this approach is the simplest and easiest to deploy, with the
# fewest configuration requirements, so it is quite useful.
#
# @author tommy vegetables <leafyrabbet@gmail.com>
# @copyright 2020, TenonGarden Productions

cd ../src;
python ./flask_app.py;

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phrase_client,
  base_url: "https://api.phrase.com/v2/",
  token: System.get_env("TOKEN")

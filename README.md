# Uno-fficial phrase.com Elixir Client

**TODO: Support all other endpoints, add more tests, PRs welcome**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `phrase_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phrase_client, "~> 0.1.0"}
  ]
end
```


At the moment this library is simply a minimal wrapper around the Phrase.com APIs and does only 2 things: 

- List all projects
- Get one project
- Get the translations for a language in a project


You will have to generate a token and find the id of both the project and the language in your Phrase.com dashboard. When you found them add them to your
config like the following:

```
config :phrase_client,
  base_url: "https://api.phrase.com/v2/",
  token: System.get_env("PHRASE_TOKEN") || raise "export PHRASE_TOKEN first!"
```

How to download a translation?

```
project_id = ""
locale_id = ""
{:ok, locale} = PhraseClient.download_locale(project_id, locale_id, %{file_format: :json})
```

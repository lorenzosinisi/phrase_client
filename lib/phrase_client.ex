defmodule PhraseClient do
  @moduledoc """
  The HTTP layer of the Phrase client, this module interacts
  with the endpoints of the service offered by Phrase.com and
  returns the HTTP response
  """

  use Tesla

  plug(Tesla.Middleware.BaseUrl, Application.fetch_env!(:phrase_client, :base_url))

  plug(Tesla.Middleware.Headers, [
    {"authorization", "token #{Application.fetch_env!(:phrase_client, :token)}"}
  ])

  plug(Tesla.Middleware.JSON)

  @doc "List all projects the current user has access to. https://developers.phrase.com/api/#get-/projects"
  def projects do
    case get("/projects") do
      {:ok, %{status: 200, body: body}} -> {:ok, body}
      otherwise -> {:error, otherwise}
    end
  end

  @doc "List the project the user has access to. https://developers.phrase.com/api/#get-/projects"
  def get_project(id) when is_binary(id) do
    case get("/projects/#{id}") do
      {:ok, %{status: 200, body: body}} -> {:ok, body}
      otherwise -> {:error, otherwise}
    end
  end

  @doc "Download a locale in a specific file format. https://developers.phrase.com/api/#get-/projects/{project_id}/locales/{id}/download"
  def download_locale(project_id, locale_id, params \\ %{file_format: :json})
      when is_binary(project_id) and is_binary(locale_id) do
    query = URI.encode_query(params)

    case get("/projects/#{project_id}/locales/#{locale_id}/download?#{query}") do
      {:ok, %{status: 200, body: body}} -> {:ok, body}
      otherwise -> {:error, otherwise}
    end
  end
end

defmodule PhraseClientTest do
  use ExUnit.Case
  doctest PhraseClient
  import Mock

  @projects [
    %{
      "account" => %{
        "company" => nil,
        "company_logo_url" => nil,
        "created_at" => "2021-08-27T10:07:07Z",
        "id" => "ff7faf5e752f6eae9d51a8c857630bd6",
        "name" => "Example Example",
        "slug" => "lorenzo-example-0423943b-e60e-4b69-bde2-1c0d930dc403",
        "updated_at" => "2021-08-30T16:15:49Z"
      },
      "created_at" => "2021-08-27T10:07:08Z",
      "id" => "263584a34a351571a1e41bb62434e0ff",
      "main_format" => "node_json",
      "name" => "ExampleApp",
      "project_image_url" => nil,
      "slug" => "my-demo-application",
      "space" => nil,
      "updated_at" => "2021-08-30T16:15:49Z"
    }
  ]

  test "projects/0 gets all projects" do
    with_mocks([
      {Tesla, [], [execute: fn _, _, _ -> {:ok, %{status: 200, body: @projects}} end]}
    ]) do
      assert PhraseClient.projects() == {:ok, @projects}
    end
  end

  test "get_project/1 gets a project" do
    with_mocks([
      {Tesla, [], [execute: fn _, _, _ -> {:ok, %{status: 200, body: List.first(@projects)}} end]}
    ]) do
      assert PhraseClient.get_project("something") == {:ok, List.first(@projects)}
    end
  end

  test "get_project/1 fails" do
    with_mocks([
      {Tesla, [], [execute: fn _, _, _ -> {:ok, %{status: 500, body: List.first(@projects)}} end]}
    ]) do
      assert PhraseClient.get_project("something") ==
               {:error, {:ok, %{status: 500, body: List.first(@projects)}}}
    end
  end

  test "download_locale/3 gets a specific locale" do
    with_mocks([
      {Tesla, [], [execute: fn _, _, _ -> {:ok, %{status: 200, body: List.first(@projects)}} end]}
    ]) do
      assert PhraseClient.download_locale("project_id", "locale_id", %{extra: :extra}) ==
               {:ok, List.first(@projects)}
    end
  end

  test "download_locale/3 gets a specific locale and fails" do
    with_mocks([
      {Tesla, [], [execute: fn _, _, _ -> {:ok, %{status: 401, body: List.first(@projects)}} end]}
    ]) do
      assert PhraseClient.download_locale("project_id", "locale_id", %{extra: :extra}) ==
               {:error, {:ok, %{status: 401, body: List.first(@projects)}}}
    end
  end
end

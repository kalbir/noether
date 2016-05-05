defmodule Noether.PageControllerTest do
  use Noether.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Noether!"
  end

  test "GET /apps/ with correct username/password returns PASSED" do
    assert Noether.PageController.get_your_apps.message == "PASSED: GET /apps/ gets a 200"
    assert String.contains?(Noether.PageController.get_your_apps.response, "test")
  end
  
  test "GET /apps/ with correct username/password returns the correct body" do
    assert Noether.PageController.get_your_apps.response == "test"
    assert String.contains?(Noether.PageController.get_your_apps.response, "test")
  end

  test "Using CLI to `drie show apps` returns some apps" do
    assert Noether.PageController.cli_shows_some_apps.message == "PASSED: cli shows some apps"
  end
  
  test "Use CLI to add an app" do
    assert Noether.PageController.cli_add_an_app.message == "PASSED: cli has added app 'kalbir-test'"
  end
end

defmodule Noether.PageController do
  use Noether.Web, :controller

  def index(conn, _params) do 
    render conn, "index.html", result: get_your_apps
  end

  def get_your_apps do

    auth = [hackney: [basic_auth: {System.get_env("DRIE_ID"), System.get_env("DRIE_PASSWORD")}]]

    case HTTPoison.get("http://api.drie.co/apps/", %{}, auth) do
    
    {:ok, %HTTPoison.Response{status_code: 200, body: response}} ->
    result = %{:response => response, :result => "success", :message => "PASSED: GET /apps/ gets a 200"} 
    
    {:ok, %HTTPoison.Response{status_code: _, body: response}} ->
    result = %{:response => response, :result => "danger", :message => "FAILED: GET /apps/ gets a 200"} 
    end

  end

  def cli_shows_some_apps do
    
    case System.cmd "drie", ["apps", "show"] do

    { _, 0} -> result = %{:result => "success", :message => "PASSED: cli shows some apps"}

    {_, 1} -> result = %{:result => "danger", :message => "FAILED: cli shows some apps"}
    end
  end
  
  def cli_add_an_app do
    
    case System.cmd "drie", ["app", "add", "kalbir-test"] do

    { _, 0} -> result = %{:result => "success", :message => "PASSED: cli has added app 'kalbir-test'"}

    {_, 1} -> result = %{:result => "danger", :message => "FAILED: cli has added app 'kalbir-test'"}
    end
  end

end

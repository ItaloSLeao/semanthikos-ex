defmodule TestFetch do
  def run do
    user = EventManager.Repo.get!(EventManager.Schemas.User, 9)
    token = EventManager.Core.generate_user_session_token(user)
    
    # We can just build a conn and pass it to the LiveView endpoint directly
    conn = Phoenix.ConnTest.build_conn()
    conn = Plug.Test.init_test_session(conn, %{user_token: token})
    
    html = EventManagerWeb.Endpoint.call(conn, [])
    # wait, we can't easily simulate the router this way.
  end
end

import Phoenix.ConnTest
import Phoenix.LiveViewTest
@endpoint EventManagerWeb.Endpoint

# We cannot easily test without a valid session, so let's just observe if there are compilation errors.

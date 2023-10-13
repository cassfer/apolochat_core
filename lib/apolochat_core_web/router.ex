defmodule ApolochatCoreWeb.Router do
  use ApolochatCoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApolochatCoreWeb do
    pipe_through :api
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", ApolochatCoreWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end


  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:apolochat_core, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ApolochatCoreWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

defmodule ApolochatCoreWeb.DefaultController do
	use ApolochatCoreWeb, :controller

	def index(conn, _params) do
		text conn, "ApoloChatCore is alive!!!"
	end

end
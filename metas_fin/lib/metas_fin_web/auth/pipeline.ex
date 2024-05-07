defmodule MetasFinWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :metas_fin,
    error_handler: MetaFinWeb.Auth.AuthError,
    module: MetasFin.Profile.Guardian

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end

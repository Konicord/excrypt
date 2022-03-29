defmodule Excrypt.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do

    # fetch the bot token from the application
    bot_token = Application.get_env(:excrypt, :bot_token)

    children = [
      ExGram,
      {Excrypt.Bot, [method: :polling, token: bot_token]}
      #                                       ^ you could also replace this with "the bot token ..."
    ]

    opts = [strategy: :one_for_one, name: Excrypt.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# Excrypt
A simple example how to create a telegram bot with pure elixir & http requests.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `excrypt` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:excrypt, "~> 0.1.0"}
  ]
end
```

## Get started
- Create an account [here at Telegram](https://web.telegram.org/k/)
- DM BotFather and run `/newbot`
  Follow the instructions ...

- Copy the bot token, rename `.env-example` to `.env` and paste the bot token into it.

## APi
There are the following commands:

```elixir
# fetching the api
iex> {:ok, response} = Tesla.get("https://api.coingecko.com/api/v3/coin")

# decode the results
iex> Jason.decode!(response.body)

# only displaying the first value of the body
iex> Jason.decode!(response.body) |> List.first

# displaying token ids
iex> token["id"]

# mapping the results
iex> token = Jason.decode!(response.body) |> Enum.map(fn result -> result["id"] end)

# take the 10 results
iex> token = Jason.decode!(response.body) |> Enum.map(fn result -> result["id"] end) |> Enum.take(10)
```
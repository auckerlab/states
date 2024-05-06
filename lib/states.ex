defmodule States do
  use Application

  def start(_type, videos) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(States.Server, [videos])
      {States.Server, [videos], id: States.Server}
    ]

    opts = [strategy: :one_for_one, name: States.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

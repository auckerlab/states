defmodule StateMachine do
  defmacro __using__(_) do
    quote do
      import StateMachine
      # initialize temporary data
      @states []
      @before_compile StateMachine
    end
  end

  # defmacro state(name, events), do: IO.puts("Declaring state #{name}")
  defmacro state(name, events) do
    quote do
      @states [{unquote(name), unquote(events)} | @states]
    end
  end

  # defmacro __before_compile__(env), do: nil
  defmacro __before_compile__(env) do
    states = Module.get_attribute(env.module, :states)

    events =
      states
      |> Keyword.values()
      |> List.flatten()
      |> Keyword.keys()
      |> Enum.uniq()

    quote do
      def state_machine do
        unquote(states)
      end

      unquote(event_callbacks(events))
    end
  end

  def event_callback(name) do
    callback = name

    quote do
      def unquote(name)(context) do
        StateMachine.Behavior.fire(state_machine, context, unquote(callback))
      end
    end
  end

  def event_callbacks(names) do
    Enum.map(names, &event_callback/1)
  end
end

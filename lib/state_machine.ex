defmodule StateMachine do
  defmacro __using__(_) do
    quote do
      import StateMachine
      # initialize temporary data
    end
  end

  defmacro state(name, events), do: IO.puts("Declaring state #{name}")
  defmacro __before_compile__(env), do: nil
end

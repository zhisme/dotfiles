if defined?(Pry)
  Pry::Commands.command /^$/, "repeat last command" do
    _pry_.run_command Pry.history.to_a.last
  end

  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'c', 'continue'
end

Pry.config.editor = "vim"
Pry.config.editor = proc { |file, line| "vim +#{line} #{file}" }

if defined?(LazyNames)
  Pry.config.hooks.add_hook(:when_started, :lazy_names) do
    LazyNames.load_definitions!
  end
end

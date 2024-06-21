require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/gems/'
  add_filter '/log/'
  add_filter '/spec/' # se usi spec per i test
  add_filter '/test/' # se usi test/unit per i test
  add_filter '/vendor/'
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter
])
# Run me with:
#
# $ watchr specs.watchr
 
# --------------------------------------------------
# Helpers
# --------------------------------------------------
def run_all_tests
  # see Rakefile for the definition of the test:all task
  system( "rake -s spec VERBOSE=true" )
end
 
# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch( '^.*\.rb' ) { run_all_tests }
 
# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end
 
# Ctrl-C
Signal.trap('INT') { abort("\n") }

# Run
run_all_tests
 

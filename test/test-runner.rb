require 'test/unit/ui/console/testrunner'
require_relative './util-test.rb'
require_relative './dfa-test.rb'

Test::Unit::UI::Console::TestRunner.run(UTIL_TEST)
Test::Unit::UI::Console::TestRunner.run(DFA_TEST)

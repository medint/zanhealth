require 'open3'
require 'test/unit'

class Migration < Test::Unit::TestCase
   def test_migration
      stdin, stdout, stderr, wait_thread = Open3.popen3('export RAILS_ENV=test && rake db:drop && rake db:create && rake db:migrate')
      assert_equal(0, wait_thread.value) 
   end
end

require 'rubygems'
require 'bundler'
require 'yaml'

Bundler.require :default, :development

require 'massive_record/spec/support/simple_database_cleaner'




SPEC_DIR = File.dirname(__FILE__) unless defined? SPEC_DIR
CONFIG = YAML.load_file(File.join(SPEC_DIR, 'config.yml')) unless defined? MR_CONFIG

Rspec.configure do |c|
  #c.fail_fast = true 
  Sunspot.config.solr.url = "http://#{CONFIG['solr']['hostname']}:#{CONFIG['solr']['port']}/solr"

  c.before(:all) do
    unless @connection
      @connection_configuration = {:host => CONFIG['hbase']['host'], :port => CONFIG['hbase']['port']}
      MassiveRecord::ORM::Base.connection_configuration = @connection_configuration
      @connection = MassiveRecord::Wrapper::Connection.new(@connection_configuration)
      @connection.open
    end
  end
end

Dir["#{SPEC_DIR}/models/*.rb"].each { |f| require f }
Dir["#{SPEC_DIR}/support/**/*.rb"].each { |f| require f }

module SunspotMassiveRecord
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'sunspot_rails.init' do
        Sunspot.session = Sunspot::Rails.build_session
      end

      rake_tasks do
        load 'sunspot_massive_record/rails/tasks.rb'
      end
    end
  end
end

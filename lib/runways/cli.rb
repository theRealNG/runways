# frozen_string_literal: true

module Runways
  class CLI < Thor
    desc 'new name', 'provide name for the framework'
    def new(app_name)
      puts "building framework #{app_name}"

      AppStructure.start([app_name])
    end
  end
end

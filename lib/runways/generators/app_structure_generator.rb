require 'thor'

class AppStructure < Thor::Group
  include Thor::Actions

  argument :name

  def self.source_root
    File.dirname(__FILE__)
  end

  def create_basic_app_structure
    root_directory = name.to_s
    app_directory = root_directory + "/app"
    models_directory = app_directory + "/models"
    lib_directory = root_directory + "/lib"

    create_following_dirs([
      root_directory, app_directory, 
      models_directory, lib_directory,
    ])
  end

  def generate_proto_file
    # generate from template
    template("templates/proto.tt", "#{name}/proto/#{name}.proto")
  end

  def generate_application_record
    template(
      "templates/application_record.tt",
      "#{name}/app/models/application_record.rb"
    )
  end

  def generate_models
    template(
      "templates/models.tt",
      "#{name}/app/models.rb"
    )
  end

  private
  def create_following_dirs(dir_paths)
    dir_paths.each do |dir_path|
      empty_directory(dir_path)
    end
  end
end

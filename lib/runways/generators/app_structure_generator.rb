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
    controller_directory = app_directory + "/controllers"
    db_directory = root_directory + "/db"
    migration_directory = db_directory + "/migrate"
    lib_directory = root_directory + "/lib"
    lib_protos_directory = lib_directory + "/protos"
    tasks_directory = lib_directory + "/tasks"
    config_directory = root_directory + "/config"

    create_following_dirs([
      root_directory, app_directory, config_directory,
      lib_directory, lib_protos_directory, tasks_directory,
      models_directory, controller_directory,
      db_directory, migration_directory,
    ])
  end

  def generate_proto_file
    # generate from template
    template("templates/proto.tt", "#{name}/proto/#{name}.proto")
  end

  def generate_gemfile
    template("templates/gemfile.tt", "#{name}/Gemfile")
  end

  def generate_db_rake_file
    template("templates/db_rake.tt", "#{name}/lib/tasks/db.rake")
  end

  def generate_rake_file
    template("templates/rakefile.tt", "#{name}/Rakefile")
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

  def generate_service_file
    template(
      "templates/service.tt",
      "#{name}/lib/#{name.underscore}_service.rb"
    )
  end

  def generate_server_file
    template(
      "templates/server.tt",
      "#{name}/#{name.underscore}_server.rb"
    )
  end

  def generate_db_config_file
    template("templates/db_config.tt", "#{name}/config/db_config.rb")
  end

  def generate_protofub_file
    template("templates/protobuf_rake.tt", "#{name}/lib/tasks/generate_protobuf_files.rake")
  end

  private
  def create_following_dirs(dir_paths)
    dir_paths.each do |dir_path|
      empty_directory(dir_path)
    end
  end
end

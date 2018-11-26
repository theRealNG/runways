# frozen_string_literal: true

require 'thor'

class AppStructure < Thor::Group
  include Thor::Actions

  argument :name

  def self.source_root
    File.dirname(__FILE__)
  end

  def root_directory
    app_name = name.to_s
    empty_directory(app_name)
    path = app_name

    app_directory(path)
    db_directory(path)
    lib_directory(path)
    proto_directory(path)
    config_directory(path)
    test_directory(path)

    generate_gemfile(path)
    generate_rake_file(path)
    generate_server_file(path)

    run_protoc_cmd(path)
    run_bundle_install(path)
  end

  private

  def app_directory(path)
    path += '/app'
    empty_directory(path)

    models_directory(path)
  end

  def models_directory(path)
    path += '/models'
    empty_directory(path)

    generate_application_record(path)
  end

  def generate_application_record(path)
    path += '/'
    template_name = 'application_record'
    generate_template(
      path: path, template_name: template_name, extenstion: 'rb'
    )
  end

  def db_directory(path)
    path += '/db'
    empty_directory(path)

    migration_directory(path)
  end

  def migration_directory(path)
    path += '/migrate'
    empty_directory(path)
  end

  def lib_directory(path)
    path += '/lib'
    empty_directory(path)

    protos_directory(path)
    tasks_directory(path)

    generate_service_file(path)
  end

  def protos_directory(path)
    path += '/protos'
    empty_directory(path)
  end

  def tasks_directory(path)
    path += '/tasks'
    empty_directory(path)

    generate_db_rake_file(path)
    generate_protofub_rake_file(path)
  end

  def generate_db_rake_file(path)
    path += '/'
    generate_template(
      path: path, extenstion: 'rake', template_name: 'db'
    )
  end

  def generate_protofub_rake_file(path)
    path += '/'
    generate_template(
      path: path, extenstion: 'rake', template_name: 'generate_protobuf_files'
    )
  end

  def generate_service_file(path)
    path += '/'
    file_name = "#{name.underscore}_service"

    generate_template(
      path: path, file_name: file_name,
      extenstion: 'rb', template_name: 'service'
    )
  end

  def proto_directory(path)
    path += '/proto'
    empty_directory(path)

    generate_proto_file(path)
  end

  def generate_proto_file(path)
    path += '/'
    generate_template(
      path: path, extenstion: 'proto', template_name: 'proto', file_name: name
    )
  end

  def config_directory(path)
    path += '/config'
    empty_directory(path)

    generate_db_config_file(path)
    generate_application_config_file(path)
  end

  def generate_db_config_file(path)
    path += '/'
    generate_template(
      path: path, extenstion: 'rb', template_name: 'db_config'
    )
  end

  def generate_application_config_file(path)
    path += '/'
    generate_template(
      path: path, extenstion: 'rb', template_name: 'application'
    )
  end

  def test_directory(path)
    path += '/test'
    empty_directory(path)

    generate_test_client_file(path)
  end

  def generate_test_client_file(path)
    path += '/'
    generate_template(
      path: path, extenstion: 'rb', template_name: 'test_client'
    )
  end

  def generate_gemfile(path)
    path += '/'
    generate_template(
      path: path, template_name: 'Gemfile'
    )
  end

  def generate_rake_file(path)
    path += '/'
    generate_template(
      path: path, template_name: 'Rakefile'
    )
  end

  def generate_server_file(path)
    path += '/'
    generate_template(
      path: path, template_name: 'server',
      file_name: name + '_server', extenstion: 'rb'
    )
  end

  def run_protoc_cmd(path)
    inside(path) do
      run 'grpc_tools_ruby_protoc'\
        '-I proto --ruby_out=lib/protos'\
        '--grpc_out=lib/protos'\
        "proto/#{name.underscore}.proto"
    end
  end

  def run_bundle_install(path)
    inside(path) do
      run 'bundle install'
    end
  end

  def templates_directory
    'templates'
  end

  def generate_template(path:, template_name:, extenstion: '', file_name: nil)
    template(
      path.sub(name, templates_directory) + template_name + '.tt',
      path + (file_name || template_name) +
        (extenstion.present? ? '.' + extenstion : extenstion)
    )
  end
end

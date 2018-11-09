require 'thor'

class ProtoGenerator < Thor::Group
  include Thor::Actions

  argument :name

  def generate_proto_file
    template("templates/template.proto.tt", "#{name}/proto/#{name}.proto")
  end
end

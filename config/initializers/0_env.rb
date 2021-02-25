if Feature.use_ssm?
  client = Aws::SSM::Client.new
  result = client.get_parameters_by_path(path: ENV["SSM_PARAMETERS_PATH"])
  result.parameters.each do |parameter|
    env_name = parameter.name.split("/").last
    env_value = parameter.value
    ENV[env_name] = env_value
  end
end

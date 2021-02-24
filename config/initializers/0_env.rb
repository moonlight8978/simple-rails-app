if Feature.use_ssm?
  client = Aws::SSM::Client.new
  parameters = client.get_parameters_by_path(path: ENV["SSM_PARAMETERS_PATH"], max_results: 1)
  parameters.each do |parameter|
    env_name = parameter.name.split("/").last
    env_value = parameter.value
    ENV[env_name] = env_value
  end
end

if Feature.use_redis?
  Rails.application.config.session_store :redis_store,
    servers: ["redis://#{ENV["REDIS_URL"]}/session"],
    expire_after: 90.minutes,
    key: "_cfn_complete_session",
    threadsafe: true,
    secure: false
end

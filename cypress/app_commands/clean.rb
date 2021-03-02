if defined?(DatabaseCleaner)
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  FileUtils.rm_rf(Dir[Rails.root.join("tmp", "test_mails")])
else
  logger.warn "add database_cleaner or update cypress/app_commands/clean.rb"
end

Rails.logger.info "APPCLEANED" # used by log_fail.rb

if Feature.use_dev_fake_mailer?
  LetterOpenerWeb.configure do |config|
    # To overrider the location for message storage.
    # Default value is `tmp/letter_opener`
    if Feature.system_test_mode?
      config.letters_location = Rails.root.join('tmp', 'test_mails')
    else
      config.letters_location = Rails.root.join('tmp', 'mails')
    end
  end
end

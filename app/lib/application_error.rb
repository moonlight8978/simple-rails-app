class ApplicationError < StandardError
  def self.status(status)
    define_method :status do
      status
    end
  end

  status 500
end

module Errors::Auth
  class Base < ApplicationError; end

  class Unauthenticated < Base
    status 401
  end

  class Unauthorized < Base
    status 403
  end
end

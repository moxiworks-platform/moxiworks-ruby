module MoxiworksPlatform
  module Exception
    # general error for moxi_works_platform all other errors are children of
    class PlatformError < StandardError; end

    # an expected argument is not defined, or the argument is in an unexpected form
    class ArgumentError < PlatformError; end

  end
end

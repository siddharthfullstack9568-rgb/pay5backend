module Otp
  class OtpRouter
    def initialize
      @provider = SmsDealNowProvider.new
    end

    def send_otp(mobile)
      @provider.send_otp(mobile)
    end

    def verify_otp(mobile, otp)
      @provider.verify_otp(mobile, otp)
    end
  end
end

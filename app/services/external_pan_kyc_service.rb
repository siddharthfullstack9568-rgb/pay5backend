class ExternalKycService
  # Aadhaar OTP Generation
  def self.generate_otp(aadhaar_number)
    if aadhaar_number =~ /\A[0-9]{12}\z/
      {
        success: true,
        error: nil,
        data: { transaction_id: SecureRandom.uuid }
      }
    else
      {
        success: false,
        error: "Invalid Aadhaar Number"
      }
    end
  end

  # Aadhaar OTP Verification
  def self.verify_otp(aadhaar_number, aadhaar_otp)
    if aadhaar_otp == "123456"
      data = {
        name: "Rahul Sharma",
        dob: "1990-05-10",
        gender: "M",
        address: "123, MG Road, Delhi",
        aadhaar_last4: aadhaar_number[-4..]
      }
      { success: true, error: nil, data: data }
    else
      { success: false, error: "Invalid OTP" }
    end
  end

  # PAN OTP Generation
  def self.send_pan_otp(pan_number)
    if pan_number =~ /\A[A-Z]{5}[0-9]{4}[A-Z]{1}\z/   # simple PAN regex
      otp = rand(100000..999999).to_s
      {
        success: true,
        error: nil,
        otp: otp,
        data: { transaction_id: SecureRandom.uuid }
      }
    else
      {
        success: false,
        error: "Invalid PAN Number"
      }
    end
  end

  # PAN OTP Verification
  def self.verify_pan_otp(pan_number, pan_otp, expected_otp)
    if pan_otp == expected_otp
      data = {
        pan_number: pan_number,
        pan_holder: "Rahul Sharma",
        pan_status: "active"
      }
      { success: true, error: nil, data: data }
    else
      { success: false, error: "Invalid PAN OTP" }
    end
  end
end

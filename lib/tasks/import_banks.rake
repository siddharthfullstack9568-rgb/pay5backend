namespace :banks do
  task import: :environment do
    require "csv"

    file_path = "/home/siddharth/Downloads/eko_banks.csv"

    CSV.foreach(file_path, headers: true) do |row|
      data = row.to_h.transform_keys { |k| k.to_s.strip }
                      .transform_values { |v| v.to_s.strip }

      EkoBank.find_or_create_by!(
        bank_code: data["BANK CODE"]
      ) do |bank|
        bank.bank_id = data["BankID"]
        bank.name        = data["BANK_NAME"]
        bank.ifsc_prefix = data["BANK CODE"]
        bank.status      = data["IMPS_Status"] == "Enabled"
      end
    end

    puts "✅ Banks imported with clean data"
  end
end

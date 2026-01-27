namespace :banks do
  task import: :environment do
    require "csv"

    file_path = "/home/siddharth/Downloads/Bank List.csv"

    CSV.foreach(file_path, headers: true) do |row|
      data = row.to_h.transform_keys { |k| k.to_s.strip }
                    .transform_values { |v| v.to_s.strip }

      EkoBank.find_or_create_by!(
        bank_code: data["Bank Code"]
      ) do |bank|
        bank.bank_id     = data["Bank ID"]
        bank.name        = data["Bank Name"]
        bank.bank_code   = data["Bank Code"]
        bank.ifsc_prefix = data["Static IFSC"].presence
        bank.status      = data["IMPS Status"] == "Enabled"
      end
    end

    puts "✅ Banks imported successfully"
  end
end

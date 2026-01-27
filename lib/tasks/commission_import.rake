namespace :commission do
  desc "Import commissions from CSV"
  task import: :environment do
    require 'csv'

    file_path = "/home/siddharth/Downloads/Commission_list - Sheet1.csv"

    unless File.exist?(file_path)
      puts "❌ CSV file not found"
      exit
    end

    CSV.foreach(file_path, headers: true) do |row|
      operator_id = row['Operator Id']
      p "========operator_id========="
      p operator_id

      service_product = Category.find_by(
        title: row['Category']
      )
      p "====================service_product"
      p service_product

      unless service_product
        puts "❌ ServiceProduct not found for category: #{row['Category']}"
        next
      end

      service_product_item = ServiceProductItem.find_or_create_by!(
        operator_id: operator_id,
        category_id: service_product.id,
        name: row['Operator Name']
      )

      commission_type = row['Commission Type'].to_s.downcase.strip

      below_raw = row['B2B Commission BELOW 5K']
                    .to_s.gsub(/[₹\s]/, '').to_f

      above_raw = row['B2B Commission ABOVE 5K']
                    .to_s.gsub(/[₹\s]/, '').to_f

      # ✅ CORE FIX
      if commission_type == 'percentage'
        below_value = (below_raw * 100).to_i
        above_value = (above_raw * 100).to_i
      else
        # fixed / zero
        below_value = below_raw
        above_value = above_raw
      end

      commission_rate = "#{below_value}-#{above_value}"

      Commission.find_or_initialize_by(
        service_product_item_id: service_product_item.id,
        from_role: 'superadmin',
        to_role: 'admin',
        scheme_id: 2
      ).update!(
        commission_type: commission_type,
        commission_rate: commission_rate,
        value: 100,
      )

      puts "✅ Imported | Operator #{operator_id} | #{commission_type} | #{commission_rate}"
    end

    puts "🎉 All commissions imported successfully"
  end
end

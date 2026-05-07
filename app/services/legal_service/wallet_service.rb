module LegalService
    class WalletService
  
      def self.fetch_wallets
        BaseClient.get('/api/v1/admin/wallets')
      end
  
      def self.create_wallet(params)
        BaseClient.post('/api/v1/admin/wallets', body: params)
      end
  
      def self.balance
        BaseClient.get('/api/v1/admin/wallets/balance')
      end
  
      def self.payment(params)
        BaseClient.post('/api/v1/admin/payments', body: params)
      end

      def self.dashboard
        BaseClient.get('/api/v1/admin/dashboards')
      end

      def self.notice(params)
        BaseClient.post('/api/v1/admin/notices', body: params)
      end

      def self.service
        BaseClient.get('/api/v1/superadmin/surpass_services')
      end

      def self.service_category(params)
        BaseClient.post("/api/v1/admin/surepass/surpass_category", body: params)
      end
  
    end
  end
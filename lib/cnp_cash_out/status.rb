require 'savon'

module CnpCashOut
  class Status

    PERMITTED_PARAMS = %i(merchant_id reference_nr merchant_keyword wsdl endpoint)
    REQUIRED_PARAMS  = %i(merchant_id reference_nr merchant_keyword wsdl endpoint)
    RESPONSE_PARAMS  = %i(transaction_status transaction_currency_code amount
                          additional_information auth_code merchant_local_date_time
                          card_issuer_country masked_card_number user_ip_address
                          success error_description fee sender_name)

    attr_reader *(PERMITTED_PARAMS + RESPONSE_PARAMS)

    def initialize(params = {})
      CnpCashOut.config
                 .to_h
                 .merge(params)
                 .select { |p| PERMITTED_PARAMS.include?(p) }
                 .each { |p| instance_variable_set("@#{p[0]}", p[1])}
      if missing_params.any?
        raise StandardError, "#{missing_params} is required, but not set"
      else
        request!
      end
    end

    def missing_params
      REQUIRED_PARAMS - REQUIRED_PARAMS.map { |p| p.to_sym if send(p) }
    end

    def hash_to_send
      PERMITTED_PARAMS.map { |p| [p, send(p)] }.to_h
    end

    def request!
      client = Savon.client(wsdl: wsdl, soap_version: 2, endpoint: endpoint, log: true)
      request = client.call(:get_cash_out_transaction_status, message: hash_to_send )
      response(request.body[:get_cash_out_transaction_status_response][:return])
    end

    def response(args = {})
      args.each { |p| instance_variable_set("@#{p[0]}", p[1]) if respond_to?(p[0])}
    end
  end
end

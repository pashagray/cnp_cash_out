module CnpCashOut
  class StartTransaction

        PERMITTED_PARAMS = %i(merchant_id merchant_keyword customer_reference tran_amount
                              currency_code language_code description user_id card_id
                              additional_information_list return_u_r_l
                              user_login merchant_local_date_time receiver_name sender_name wsdl endpoint)
        REQUIRED_PARAMS  = %i(merchant_id merchant_keyword tran_amount currency_code language_code
                              return_u_r_l merchant_local_date_time user_id card_id
                              user_login receiver_name sender_name wsdl endpoint)
        FUNDING_PARAMS   = %i(user_id card_id user_login)
        RESPONSE_PARAMS  = %i(success redirect_url rsp_code error_description customer_reference)

        attr_reader *(PERMITTED_PARAMS + RESPONSE_PARAMS)

        def initialize(params = {})
          CnpCashOut.config
                     .to_h
                     .merge(params)
                     .select { |p| PERMITTED_PARAMS.include?(p) }
                     .each { |p| instance_variable_set("@#{p[0]}", p[1])}
          if missing_params.any?
            raise StandardError, "#{missing_params.sort} is required, but not set"
          else
            request!
          end
        end

        def missing_params
          REQUIRED_PARAMS - REQUIRED_PARAMS.map { |p| p.to_sym if send(p) }
        end

        def additional_information_list
          [
            { key: 'USER_ID',             value: user_id },
            { key: 'CARD_ID',             value: card_id },
            { key: 'USER_LOGIN',          value: user_login },
          ]
        end

        def hash_to_send
          PERMITTED_PARAMS.reject { |k, v| FUNDING_PARAMS.include?(k) }.map { |p| [p, send(p)] }.to_h
        end

        def request!
          client = Savon.client(wsdl: wsdl, soap_version: 2, endpoint: endpoint, log: true)
          request = client.call(:start_cash_out_transaction, message: { transaction: hash_to_send })
          response(request.body[:start_cash_out_transaction_response][:return])
        end

        def response(args = {})
          args.each { |p| instance_variable_set("@#{p[0]}", p[1]) if respond_to?(p[0])}
        end
  end
end

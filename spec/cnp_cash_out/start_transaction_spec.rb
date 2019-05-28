require 'spec_helper'
require_relative '../../lib/cnp_cash_out/start_transaction'

describe CnpCashOut::StartTransaction do
  describe '#new' do
    before do
      CnpCashOut.configure(
        merchant_id: '000000000000097',
        language_code: 'en',
        currency_code: 398,
        wsdl: 'spec/CNPMerchantWebService.wsdl',
        endpoint: 'https://test.processing.kz:443/CNPMerchantWebServices/services/CNPMerchantWebService.CNPMerchantWebServiceHttpSoap11Endpoint/'
      )
    end

      context 'when not all required params are presented' do
        it 'raises error' do
          expect do
            described_class.new
          end.to raise_error(StandardError).with_message('[:card_id, :card_number, :merchant_keyword, :merchant_local_date_time, :receiver_account, :receiver_name, :return_u_r_l, :sender_name, :tran_amount, :user_id, :user_login] is required, but not set')
        end

        context 'when all required params are presented' do
          it 'returns url for card data entry' do
            # stub_start_card_registration_request
            expect(described_class.new(return_u_r_l: ':3000', merchant_keyword: '111', tran_amount: 100000, merchant_local_date_time: '01.02.2012 12:34:58', user_id: 3671, card_id: 2343, user_login: 'tpepost@gmail.com', receiver_name: 'AIBEK IZHANOV', sender_name: 'MoneyBox', card_number: '4263 4339 9252 8668', receiver_account: '4263 4339 9252 8668').success).to eq(true)
          end
        end
    end
  end
end

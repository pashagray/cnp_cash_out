require 'spec_helper'

describe CnpCashOut::CashOutToRegisteredCardStart do

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
        end.to raise_error(StandardError).with_message('[:card_id, :merchant_keyword, :merchant_local_date_time, :receiver_card_id, :receiver_user_id, :return_u_r_l, :sender_name, :tran_amount, :user_id, :user_login] is required, but not set')
      end
    end

    context 'when all required params are presented' do
      it 'returns url for registration new card' do
        # stub_start_card_registration_request
        expect(described_class.new(return_u_r_l: ':3000', merchant_keyword: '111', tran_amount: 100000, merchant_local_date_time: '01.02.2012 12:34:58', user_id: 3372, card_id: 2246, receiver_user_id: 21901, receiver_card_id: 11588, user_login: 'tpepost@gmail.com', receiver_user_login: 'vinci@gmail.com', sender_name: 'Ivan Ivanov').success).to eq(true)
      end
    end
  end
end

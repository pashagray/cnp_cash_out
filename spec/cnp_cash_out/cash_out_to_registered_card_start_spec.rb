require 'spec_helper'

describe CnpCashOut::CashOutToRegisteredCardStart do

  describe '#new' do

    before do

      CnpCashOut.configure(
        merchant_id: '777000000000018',
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
        end.to raise_error(StandardError).with_message('[:merchant_keyword, :tran_amount, :return_u_r_l, :merchant_local_date_time, :user_id, :card_id, :receiver_user_id, :user_login, :receiver_card_id, :sender_name] is required, but not set')
      end
    end

    context 'when all required params are presented' do
      it 'returns url for registration new card' do
        # stub_start_card_registration_request
        expect(described_class.new(return_u_r_l: ':3000', merchant_keyword: '111', tran_amount: 100000, merchant_local_date_time: '01.02.2012 12:34:58', user_id: 3671, card_id: 2343, receiver_user_id: 3671, receiver_card_id: 2343, user_login: 'tpepost@gmail.com', receiver_user_login: 'tpepost@gmail.com', sender_name: 'Ivan Ivanov').success).to eq(true)
      end
    end
  end
end

require 'spec_helper'

describe CnpCashOut::Complete do

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
        end.to raise_error(StandardError).with_message('[:reference_nr, :transaction_success, :merchant_keyword] is required, but not set')
      end
    end

    context 'when all required params are presented' do
      it 'returns transaction result' do
        expect(described_class.new(reference_nr: 1, merchant_keyword: 111, transaction_success: true).transaction_success).to eq(true)
      end
    end
  end
end

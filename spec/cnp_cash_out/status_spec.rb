require 'spec_helper'

describe CnpCashOut::Status do

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
        end.to raise_error(StandardError).with_message('[:merchant_keyword, :reference_nr] is required, but not set')
      end
    end

    context 'when all required params are presented' do
      it 'returns url for registration new card' do
        expect(described_class.new(reference_nr: 156413354845, merchant_keyword: 111).transaction_status).to eq('NO_SUCH_TRANSACTION')
      end
    end
  end
end

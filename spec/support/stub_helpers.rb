module StubHelpers

  ENDPOINT = 'http://test.processing.kz:443/CNPMerchantWebServices/services/CNPMerchantWebService.CNPMerchantWebServiceHttpSoap11Endpoint/'

  def stub_cash_out_to_registered_card_start_request
    stub_request(:post, ENDPOINT).to_return(status: 200, body: File.new('spec/fixtures/start_card_registration_response.xml'))
  end
end

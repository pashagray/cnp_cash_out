require 'spec_helper'

describe CnpCashOut do

  it 'sets and returns configuration properly' do
    CnpCashOut.configure(merchant_id: 1000)
    expect(CnpCashOut.config.merchant_id).to eq(1000)
  end
end

require 'ostruct'

module CnpCashOut

  class << self
    attr_reader :config
  end

  def self.configure(params = {})
    @config = OpenStruct.new(params)
  end
end

class CurrencyRates
  attr_accessor :base_currency, :target_currency

  def self.latest
    OpenStruct.new(HTTParty.get(ENV["CURRENCY_EXCHANGE_BASE_URL"] + '/latest'))
  end

  def self.history(date)
    OpenStruct.new(HTTParty.get(ENV["CURRENCY_EXCHANGE_BASE_URL"] + "/#{date.to_s}"))
  rescue URI::InvalidURIError
    { error: "Bad URI", reason: "Invalid date object passed" }
  end

  def initialize(base_currency, target_currency = nil)
    @base_currency = base_currency
    @target_currency = target_currency
  end

  def get
    return OpenStruct.new(HTTParty.get(ENV["CURRENCY_EXCHANGE_BASE_URL"] + "/latest?base=#{base_currency}")) if target_currency.blank?
    result = OpenStruct.new(HTTParty.get(ENV["CURRENCY_EXCHANGE_BASE_URL"] + "/latest?base=#{base_currency}")).rates["#{target_currency}"]
    OpenStruct.new({ base: base_currency, rates: { "#{target_currency}": result } }.with_indifferent_access)
  end
end

class CurrencyRates
  attr_accessor :base_currency, :target_currency

  def self.latest
    OpenStruct.new(HTTParty.get('https://api.exchangeratesapi.io/latest'))
  end

  def self.history(date)
    OpenStruct.new(HTTParty.get("https://api.exchangeratesapi.io/#{date.to_s}"))
  rescue URI::InvalidURIError
    { error: "Bad URI", reason: "Invalid date object passed" }
  end

  def initialize(base_currency, target_currency = nil)
    @base_currency = base_currency
    @target_currency = target_currency
  end

  def get
    return OpenStruct.new(HTTParty.get("https://api.exchangeratesapi.io/latest?base=#{base_currency}")) if target_currency.blank?
    OpenStruct.new(HTTParty.get("https://api.exchangeratesapi.io/latest?symbols=#{base_currency},#{target_currency}"))
  end
end

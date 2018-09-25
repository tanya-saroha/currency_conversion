class CurrencyConvertor
  def initialize(currency_name)
    @currency = currency_name
    @conversion = OpenStruct.new(HTTParty.get('https://api.exchangeratesapi.io/latest?base=' + "#{@currency}"))
  end

  def rates
    OpenStruct.new(@conversion.rates)
  end
end

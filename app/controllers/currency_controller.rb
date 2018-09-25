class CurrencyController < ApplicationController
  before_action :get_currencies, only: :show
  def convert
    currency_rate = ::CurrencyRates.new(permitted_params[:from], permitted_params[:to]).get
    @resultant_value = currency_rate.rates[permitted_params[:to]] * permitted_params[:input].to_f
  end


  private
  def get_currencies
    @currencies = ::CurrencyRates.latest.rates.keys
  end

  def permitted_params
    params.permit(:from, :to, :input)
  end
end

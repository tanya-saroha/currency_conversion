class CurrencyControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get currency_url
    assert_response :success
  end

  test 'convert should return converted values when all correct values passed' do
    post conver_currency_url params: {from: 'USD', to: 'HUF', value: 10}
    
    CurrencyRateService.stub : get, mock do

    end

    assert_response :success
    assert_match '110', @response.body
  end

  test 'show error message if all values not passed' do
    post conver_currency_url params: {from: 'USD', value: 10}
:   
    assert_response :error
    assert_match 'Incorrect values', @response.body
  end

  test 'dont allow selecting same value of currency' do
  end

  test 'dont allow value of currency to be less than zero' do
    post conver_currency_url params: {from: 'USD', to: 'HUF', value: -1}

    assert_response :error
    assert_match 'Incorrect values', @response.body
  end
end

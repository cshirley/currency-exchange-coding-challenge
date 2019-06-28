# frozen_string_literal: true

# These are just suggested definitions to get you started.  Please feel
# free to make any changes at all as you see fit.

# http://test-unit.github.io/
require 'test/unit'
require 'currency_exchange'
require 'date'

class CurrencyExchangeTest < Test::Unit::TestCase
  def setup; end

  def test_non_base_currency_exchange_is_correct
    correct_rate = 1.2870493690602498
    assert_equal correct_rate,
                 CurrencyExchange.rate(Date.new(2018, 11, 22), 'GBP', 'USD')
  end

  def test_base_currency_exchange_is_correct
    correct_rate = 0.007763975155279502
    assert_equal correct_rate,
                 CurrencyExchange.rate(Date.new(2018, 11, 22), 'JPY', 'EUR')
  end

  def test_non_currency_exchange_raises_error
    assert_raise CurrencyExchange::RateNotFound do
      CurrencyExchange.rate(Date.new(2018, 11, 22), 'FOOBAR', 'EUR')
    end
  end

  def test_no_currency_exchange_for_date_raises_error
    assert_raise CurrencyExchange::RateNotFound do
      CurrencyExchange.rate(Date.new(1969, 1, 1), 'GBP', 'EUR')
    end
  end
end

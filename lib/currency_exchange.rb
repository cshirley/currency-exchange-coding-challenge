# frozen_string_literal: true

require_relative 'strategies/euro_based_rates'

module CurrencyExchange
  RateNotFound = Class.new(StandardError)

  RATE_STRATEGIES = [Strategies::EuroBasedRates].freeze

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency)
    RATE_STRATEGIES.find do |adapter|
      return adapter.call(
        date: date, from_currency: from_currency, to_currency: to_currency
      )
    end
  end
end

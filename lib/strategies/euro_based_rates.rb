# frozen_string_literal: true

require_relative '../services/json_file_service'
require 'date'

module CurrencyExchange
  module Strategies
    # Class EuroBasedRates
    #
    # calculates the exchange rate between from_currency and to_currency
    # on the date supplied using EUR rates as the base
    class EuroBasedRates
      BASE_EXCHANGE_CURRENCY = 'EUR'

      # Calculates exchange rate for a currency pair on a particular date
      #
      # @raise CurrencyExchange::RateNotFound if no rate can be found
      #        or calculated for the date/currencies provided
      #
      # @param [Date] date - date of the exchange rate
      # @param [String] from_currency - source currency to convert from
      # @param [String] to_currency - destination currency to convert too
      #
      # @return [Float] Exchange rate
      def self.call(date:, from_currency:, to_currency:)
        new(
          date: date, from_currency: from_currency, to_currency: to_currency
        ).call
      end

      # Calculates exchange rate for a currency pair on a particular date
      #
      # @raise CurrencyExchange::RateNotFound if no rate can be found
      #        or calculated for the date/currencies provided
      #
      # @return [Float] Exchange rate
      def call
        validate!

        to_rate / from_rate
      end

      private

      def initialize(date:, from_currency:, to_currency:)
        @date_str = date&.strftime('%Y-%m-%d')
        @from_currency = from_currency&.to_s&.upcase
        @to_currency = to_currency&.to_s&.upcase
      end

      attr_reader :date_str, :from_currency, :to_currency

      def validate!
        return true if find_currency(from_currency) && find_currency(to_currency)

        raise RateNotFound, "for #{from_currency}/#{to_currency} on #{date_str}"
      end

      def from_rate
        find_currency(from_currency)
      end

      def to_rate
        find_currency(to_currency)
      end

      def find_currency(currency)
        return 1.0 if currency == BASE_EXCHANGE_CURRENCY

        rates&.fetch(currency, nil)&.to_f
      end

      def rates
        @rates ||= service.find_for_date(date: date_str)
      end

      def service
        @service ||= Services::JsonFileService.new(
          file_path: File.expand_path('./data/eurofxref-hist-90d.json')
        )
      end
    end
  end
end

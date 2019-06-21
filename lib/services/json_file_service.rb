# frozen_string_literal: true

require 'json'

module CurrencyExchange
  module Services
    # class JsonFileService
    #
    # parses JSON exchange data from file
    class JsonFileService
      def initialize(file_path:)
        @file_path = file_path
      end

      # @param [String] date: format of YYYY-MM-DD
      # @return [Hash] key: currency, value: code
      def find_for_date(date:)
        data_source[date]
      end

      private

      attr_reader :file_path

      def data_source
        @data_source ||= JSON.parse(File.read(file_path))
      end
    end
  end
end

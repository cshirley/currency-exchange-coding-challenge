# frozen_string_literal: true

require 'test/unit'
require 'currency_exchange'
require 'date'

class JsonFileServiceTest < Test::Unit::TestCase
  def setup; end

  def described_class
    CurrencyExchange::Services::JsonFileService
  end

  def subject
    described_class.new(file_path: './test/fixtures/service_data.json')
  end

  def test_file_does_not_exist_test
    assert_raise Errno::ENOENT do
      described_class
        .new(file_path: 'does_not_exist.json')
        .find_for_date(date: '2000-02-02')
    end
  end

  def test_file_exists_with_matching_date_test
    assert_equal nil, subject.find_for_date(date: '2001-01-01')
  end

  def test_file_exists_with_no_matching_date_test
    expected_result = {
      'USD' => 1.1379,
      'GBP' => 0.90228
    }

    assert_equal expected_result, subject.find_for_date(date: '2018-12-11')
  end
end

require 'spec_helper'
require_relative '../stock_picker'

RSpec.describe 'Ruby exercises' do
  describe 'Counts best days to buy and sell in stock market' do
    it 'works when highest day is first day' do
      expect(stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])).to eq([1, 4])
    end

    it 'works when lowest day is last day' do
      expect(stock_picker([7, 3, 6, 9, 15, 8, 6, 17, 1])).to eq([1, 7])
    end

    it 'works when highest day is first day and lowest day is last day' do
      expect(stock_picker([17, 3, 6, 9, 15, 8, 6, 10, 1])).to eq([1, 4])
    end

    it 'works when highest day is repeated' do
      expect(stock_picker([6, 17, 3, 15, 8, 21, 10, 21])).to eq([2, 5])
    end

    it 'works when lowest day is repeated' do
      expect(stock_picker([3, 17, 3, 15, 8, 21, 10, 11])).to eq([0, 5])
    end

    it 'works when lowest day is first day and highest is last day' do
      expect(stock_picker([1, 3, 11, 9, 15, 8, 6, 10, 17])).to eq([0, 8])
    end

    it 'works when lowest day is first and next consecutive day and highest day is one day before last and last day' do
      expect(stock_picker([17, 17, 3, 11, 9, 15, 8, 6, 10, 1, 1])).to eq([2, 5])
    end
  end
end

require 'spec_helper'
require_relative '../bubble_sort.rb'

RSpec.describe 'Algorithms:' do
  describe 'Bubble sort' do
    it 'works with positive integers' do
      expect(bubble_sort([3, 2, 1])).to eq([1, 2, 3])
    end

    it 'works with negative integers' do
      expect(bubble_sort([-1, -2, -3])).to eq([-3, -2, -1])
    end

    it 'works with both negative and positive integers' do
      expect(bubble_sort([1, 2, -5, 10, 0, -100, 100])).to eq([-100, -5, 0, 1, 2, 10, 100])
    end
  end
end

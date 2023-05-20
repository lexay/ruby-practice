require 'spec_helper'
require_relative '../caesar_cipher'

RSpec.describe "Caesar's cipher" do
  describe 'shift string characters' do
    it 'works with small shift number' do
      expect(caesar_cipher('Hello World!', 5)).to eq('Mjqqt Btwqi!')
    end

    it 'works with large shift number' do
      expect(caesar_cipher('Hello World!', (26 * 50) + 5)).to eq('Mjqqt Btwqi!')
    end

    it 'works with negative shift number' do
      expect(caesar_cipher('Hello World!', -3)).to eq('Ebiil Tloia!')
    end

    it 'works with no number' do
      expect(caesar_cipher('Hello World!')).to eq('Hello World!')
    end
  end
end

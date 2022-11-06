require 'spec_helper'
require_relative '../substrings'

RSpec.describe 'Count substrings' do
  describe 'select valid substrings that word includes' do
    it 'works with one word' do
      expect(substrings('below', ['below', 'down', 'go', 'going', 'horn', 'how', 'howdy', 'it', 'i', 'low', 'own', 'part', 'partner', 'sit'])).to eq({ 'below' => 1, 'low' => 1 })
    end

    it 'works with long strings' do
      expect(substrings("Howdy partner, sit down! How's it going?", ['below', 'down', 'go', 'going', 'horn', 'how', 'howdy', 'it', 'i', 'low', 'own', 'part', 'partner', 'sit'])).to eq({'down' => 1, 'go' => 1, 'going' => 1, 'how' => 2, 'howdy' => 1, 'it' => 2, 'i' => 3, 'own' => 1, 'part' => 1, 'partner' => 1, 'sit' => 1 })
    end
  end
end

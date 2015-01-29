require 'spec_helper'

describe 'Yourls' do
  let(:short_url) { 'http://examp.le/123a' }
  let(:long_url)  { 'http://giantbatfarts.com' }

  describe '.count' do
    subject { Yourls::Clicks.url(short_url) }

    it 'returns a count' do
      expect(subject).to be_a(Fixnum)
    end
  end
end


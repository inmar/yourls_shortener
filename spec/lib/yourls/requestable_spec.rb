require 'spec_helper'

module EmptyModule
  include Yourls::Requestable
  extend self

  def url(url)
    @url = url
    already_shortened?
  end
end

describe Yourls::Requestable do

  let(:module) { EmptyModule }

  describe '#already_shortened?' do
    subject { EmptyModule.already_shortened? }
    context 'when given a normal url' do
      let(:url) { 'http://giantbatfarts.com' }

      it 'returns false' do
        expect(EmptyModule.url(url)).to eq(false)
      end
    end

    context 'when given a shortened url' do
      let(:url) { 'http://examp.le/123a' }

      it 'returns true' do
        expect(EmptyModule.url(url)).to eq(true)
      end
    end
  end

  describe '#domain' do
    subject { EmptyModule.domain }
    let(:domain) { 'examp.le' }

    before do
      #module.instance_variable_set(:YOURLS_CONFIG)
    end
    context 'when the domain is set in the YAML' do
      it 'returns the custom domain' do
        puts YOURLS_CONFIG
        expect(subject).to eq(domain)
      end
    end

    context 'when the domain is not set' do
      it 'returns the host domain'
    end
  end
end

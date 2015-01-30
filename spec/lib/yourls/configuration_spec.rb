require 'spec_helper'

describe Yourls::Configuration do
  let(:config) { Yourls::Configuration }

  let(:config_hash) do
    {
      api_key: api_key,
      api_endpoint: api_endpoint
    }.merge(additional_fields)
  end
  let(:additional_fields) { {} }

  let(:api_key)      { '313378483' }
  let(:api_endpoint) { 'http://examp.le/yourls-api.php' }

  before { config.const_set('YOURLS_CONFIG', config_hash) }
  after  { config.send(:remove_const, 'YOURLS_CONFIG') }

  describe '.to_params' do
    subject { config.to_params }

    let(:expected_params) do
      {
        signature: api_key,
        api_endpoint: api_endpoint
      }
    end
    it 'converts the YAML to the expected parameters' do
      expect(subject).to eq(expected_params)
    end
  end

  describe '.translate' do
    subject { config.translate(key) }

    context 'when the key is not in the dictionary' do
      let(:key) { :timeout }

      it 'returns the original key' do
        expect(subject).to eq(key)
      end
    end

    context 'when the key is in the dictionary' do
      let(:key)            { :api_key }
      let(:translated_key) { :signature }

      it 'returns the translated key' do
        expect(subject).to eq(translated_key)
      end
    end
  end
  describe '.domain' do
    context 'when no specific domain is set' do
      let(:domain) { 'examp.le' }

      it 'parses the endpoint for the domain' do
        expect(config.domain).to eq(domain)
      end
    end

    context 'when a domain is set in the YAML' do
      let(:additional_fields) { { domain: domain } }
      let(:domain)            { "sho.rt" }

      it 'uses the domain field' do
        expect(config.domain).to eq(domain)
      end
    end

    describe '.open_timeout' do
      let(:additional_fields) { { open_timeout: open_timeout } }
      let(:open_timeout)      { 20 }

      it 'uses the open timeout field' do
        expect(config.open_timeout).to eq(open_timeout)
      end
    end

    describe '.timeout' do
      let(:additional_fields) { { timeout: timeout } }
      let(:timeout)            { 20 }

      it 'uses the timeout field' do
        expect(config.timeout).to eq(timeout)
      end
    end
  end
end

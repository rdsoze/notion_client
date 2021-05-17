require 'spec_helper'

RSpec.describe Notion::Client do
  let(:token) { 'some-token' }
  let(:client) { Notion::Client.new(token) }


  it "should use the correct base uri" do
    expect(client.connection.url_prefix). to eq(URI("https://api.notion.com/v1/"))
  end

  describe "get request" do
    let(:success_request_path) { '/success' }
    let(:stubbed_success_response_body) { load_fixture('200_response.json') }
    let(:stubbed_success_response) { |env| [200, {} , stubbed_success_response_body.to_json] }

    let(:fail_auth_request_url) { '/fail-auth' }
    let(:stubbed_fail_auth_response) { |env| [401, {}, {"object":"error","status": 401,"code":"unauthorized","message":"API token is invalid."}.to_json] }    

    let(:test_connection) {
      Faraday.new do |builder|
        builder.adapter :test do |stubs|
          stubs.get(success_request_path) { stubbed_success_response }
          stubs.put(fail_auth_request_url) { stubbed_fail_auth_response }
        end
      end
    }

    before do
      allow(client).to receive(:connection).and_return(test_connection)
    end

    subject { client.send(:get, success_request_path) }

    it "returns results for valid requests" do
      expect(subject).to eq(stubbed_success_response_body)
    end
  end
end
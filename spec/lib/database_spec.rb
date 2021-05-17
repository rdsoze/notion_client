require 'spec_helper'

RSpec.describe Notion::Database do
  let(:token) { 'some-token' }
  let(:client) { Notion::Client.new(token) }

  let(:database_id) { '1' }
  let(:get_database_path) { "databases/#{database_id}" }
  let(:get_database_response_fixture) { load_fixture('database/get_database_response.json') }

  let(:get_databases_path) { "databases" }
  let(:get_databases_response_fixture) { load_fixture('database/get_databases_response.json') }

  let(:test_connection) {
    Faraday.new do |builder|
      builder.adapter :test do |stubs|
        stubs.get(get_database_path) { [200, {}, get_database_response_fixture.to_json] }
        stubs.get(get_databases_path) { [200, {}, get_databases_response_fixture.to_json] }
      end
    end
  }

  before do
    allow(client).to receive(:connection).and_return(test_connection)
  end

  it "should get_database" do
    expect(client.get_database(database_id)).to eq(get_database_response_fixture)
  end

  it "should get_databases" do
    expect(client.get_databases).to eq(get_databases_response_fixture)
  end

  it "should query_database" do
    # expect(client.query_database(query)).to eq(query_response_fixture)
  end



end
# frozen_string_literal: true

describe ApacheGitboxUrlParser do

  describe "#parse" do
    it 'parses apache svn urls' do
      [
        %w[https://gitbox.apache.org/repos/asf?p=camel-quarkus.git;a=summary camel-quarkus],
        %w[https://gitbox.apache.org/repos/asf/metamodel.git metamodel]
      ].each do |row|
        url, full_name = row
        result = described_class.parse(url)
        expect(result).to eq(full_name)
      end
    end

    it "doesn't parse the Apache repos URL" do
      url = "scm:svn:https://svn.apache.org/repos/asf/stanbol/tags/apache-stanbol-1.0.0/release-1.0.0-branch/stanbol.apache.org"
      expect(described_class.parse(url)).to be_nil
    end
  end

  describe "#parse_to_full_url" do
    it 'parses apache svn urls' do
      [
        %w[https://gitbox.apache.org/repos/asf?p=camel-quarkus.git;a=summary https://gitbox.apache.org/repos/asf/camel-quarkus],
        %w[https://gitbox.apache.org/repos/asf/metamodel.git https://gitbox.apache.org/repos/asf/metamodel]
      ].each do |row|
        url, full_name = row
        result = described_class.parse_to_full_url(url)
        expect(result).to eq(full_name)
      end
    end
  end
end
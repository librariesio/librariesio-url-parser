# frozen_string_literal: true

describe ApacheGitWipUrlParser do

  describe "#parse" do
    it 'parses apache svn urls' do
      [
        %w[https://git-wip-us.apache.org/repos/asf?p=nifi.git nifi],
        %w[https://git-wip-us.apache.org/repos/asf?p=flume.git;a=tree;h=refs/heads/trunk;hb=trunk flume]
      ].each do |row|
        url, full_name = row
        result = described_class.parse(url)
        expect(result).to eq(full_name)
      end
    end
  end

  describe "#parse_to_full_url" do
    it 'parses apache svn urls' do
      [
        %w[https://git-wip-us.apache.org/repos/asf?p=nifi.git https://git-wip-us.apache.org/repos/asf/nifi],
        %w[https://git-wip-us.apache.org/repos/asf?p=flume.git;a=tree;h=refs/heads/trunk;hb=trunk https://git-wip-us.apache.org/repos/asf/flume]
      ].each do |row|
        url, full_name = row
        result = described_class.parse_to_full_url(url)
        expect(result).to eq(full_name)
      end
    end
  end
end
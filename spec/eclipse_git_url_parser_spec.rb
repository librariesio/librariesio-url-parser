# frozen_string_literal: true

describe EclipseGitUrlParser do

  describe "#parse" do
    it 'parses eclipse git urls' do
      [
        %w[https://git.eclipse.org/c/dltk/org.eclipse.dltk.releng.git dltk/org.eclipse.dltk.releng.git],
        %w[http://git.eclipse.org/c/jetty/org.eclipse.jetty.orbit.git/tree/jetty-orbit jetty/org.eclipse.jetty.orbit.git]
      ].each do |row|
        url, full_name = row
        result = described_class.parse(url)
        expect(result).to eq(full_name)
      end
    end
  end

  describe "#parse_to_full_url" do
    it 'parses eclipse git urls' do
      [
        %w[https://git.eclipse.org/c/dltk/org.eclipse.dltk.releng.git https://git.eclipse.org/c/dltk/org.eclipse.dltk.releng.git],
        %w[http://git.eclipse.org/c/jetty/org.eclipse.jetty.orbit.git/tree/jetty-orbit https://git.eclipse.org/c/jetty/org.eclipse.jetty.orbit.git]
      ].each do |row|
        url, full_name = row
        result = described_class.parse_to_full_url(url)
        expect(result).to eq(full_name)
      end
    end
  end
end
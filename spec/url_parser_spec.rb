# frozen_string_literal: true

describe URLParser do
  class MinimalURLParser < URLParser
    def domain
      "example"
    end

    def tlds
      ["com"]
    end

    def remove_domain
      url.sub!(/(example\.com)+?(:|\/)?/i, '')
    end
  end

  it "cleans urls" do
    # the specific URLParser subclasses test a bunch more examples, but if you're working on a bug
    # that's generic to the base class, feel free to add stuff here.
    examples = [
      ["https://example.com/foo/bar", ["foo", "bar"]],
      ["[?] Project git repository (git://example.com/a.stadnik/dev-assets.git)", nil]
    ]
    results = examples.map(&:first).map do |url|
      parser = MinimalURLParser.new(url)
      parser.send(:clean_url!)
      parser.send(:url)
    end

    expected_results = examples.map { |ex| ex[1] }

    expect(results).to eq(expected_results)
  end
end

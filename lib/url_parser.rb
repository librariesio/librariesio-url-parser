# frozen_string_literal: true

class URLParser
  CASE_SENSITIVE = false

  def self.parse(url)
    new(url).parse
  end

  def initialize(url)
    @url = url.to_s.dup
  end

  def parse
    return nil unless parseable?

    if url = extractable_early?
      url
    else
      clean_url
      format_url
    end
  end

  def self.parse_to_full_url(url)
    new(url).parse_to_full_url
  end

  def self.parse_to_full_user_url(url)
    new(url).parse_to_full_user_url
  end

  def self.try_all(url)
    # run through all the subclasses and try their parse method
    # exit the reduce at the first non nil value and return that
    all_parsers.reduce(nil) do |_, n|
      r = n.parse_to_full_url(url)
      break r if r
    end
  end

  def parse_to_full_url
    path = parse
    return nil if path.nil? || path.empty?

    [full_domain, path].join('/')
  end

  def parse_to_full_user_url
    return nil unless parseable?

    path = clean_url
    return nil unless path.length == 1

    [full_domain, path].join('/')
  end

  def self.case_sensitive?
    self::CASE_SENSITIVE
  end

  # This computation is memoized because it is expensive. This prevents use cases which require using
  # .try_all in a tight loop. However, if this class is required directly (without requiring any subparsers),
  # this method will memoize an empty array. It is recommended to simply require librariesio-url-parser.rb directly.
  # This is the default behavior when installing this gem.
  def self.all_parsers
    @all_parsers ||=
      begin
        all_parsers = []
        ObjectSpace.each_object(singleton_class) do |k|
          next if k.singleton_class?

          all_parsers.unshift k unless k == self
        end
        all_parsers
      end
  end

  private

  attr_accessor :url

  def clean_url
    remove_whitespace
    remove_brackets
    remove_anchors
    remove_querystring
    remove_auth_user
    remove_equals_sign
    remove_scheme

    unless includes_domain?
      self.url = nil
      return nil
    end

    remove_subdomain
    remove_domain
    remove_git_scheme
    remove_extra_segments
    remove_git_extension
  end

  def format_url
    return nil if url.nil?
    return nil unless url.length == 2

    url.join('/')
  end

  def parseable?
    !url.nil? && url.include?(domain)
  end

  def tlds
    raise NotImplementedError
  end

  def domain
    raise NotImplementedError
  end

  def domain_regex
    "#{domain}\.(#{tlds.join('|')})"
  end

  def website_url?
    url.match(/www\.#{domain_regex}/i)
  end

  def includes_domain?
    url.match(/#{domain_regex}/i)
  end

  def extractable_early?
    return false if website_url?

    match = url.match(/([\w\.@\:\-_~]+)\.#{domain_regex}\/([\w\.@\:\-\_\~]+)/i)
    if match && match.length == 4
      return "#{match[1]}/#{match[3]}"
    end

    nil
  end

  def remove_anchors
    url.gsub!(/(#\S*)$/i, '')
  end

  def remove_auth_user
    self.url = url.split('@')[-1]
  end

  def remove_domain
    raise NotImplementedError
  end

  def remove_brackets
    url.gsub!(/>|<|\(|\)|\[|\]/, '')
  end

  def remove_equals_sign
    self.url = url.split('=')[-1]
  end

  def remove_extra_segments
    self.url = url.split('/').reject{ |s| s.strip.empty? }[0..1]
  end

  def remove_git_extension
    Array(url).last&.gsub!(/(\.git|\/)$/i, '')
  end

  def remove_git_scheme
    url.gsub!(/git\/\//i, '')
  end

  def remove_querystring
    url.gsub!(/(\?\S*)$/i, '')
  end

  def remove_scheme
    url.gsub!(/(((git\+https|git|ssh|hg|svn|scm|http|https)+?:)(\/\/)?)/i, '')
  end

  def remove_subdomain
    url.gsub!(/(www|ssh|raw|git|wiki|svn)+?\./i, '')
  end

  def remove_whitespace
    url.gsub!(/\s/, '')
  end
end

# frozen_string_literal: true
class ApacheGitboxUrlParser < URLParser
  private

  def full_domain
    'https://gitbox.apache.org/repos/asf'
  end

  def tlds
    %w(org)
  end

  def domain
    'gitbox.apache'
  end

  def remove_querystring
    url
  end

  def remove_equals_sign
    # we need to preserve the p=<some_name> query parameter
    splits = url.split('=')
    p_index = splits.index{|s| s.end_with?("?p") || s.end_with?("&p")}
    if p_index
      new_url = splits[0..p_index+1].join("=") if p_index
      # remove separator characters present at the end of this string
      # before the next parameter in the query parameter list
      # ";"
      new_url.gsub!(/[;,&].*/, '')

      self.url = new_url
    end
  end

  def domain_regex
    # match only the viewvc endpoint at the domain
    "#{domain.split("/").first}\.(#{tlds.join('|')})\/repos"
  end

  def remove_domain
    # find the matches for any github domain characters in the url string
    # and replace only the first match incase we find a repo with something like github.com as the name
    url.sub!(/(gitbox\.apache\.org\/(repos\/asf))+?(:|\/)?/i, '')
  end

  def remove_extra_segments
    if url.is_a?(String) && url.start_with?("?p=")
      self.url = url.split("=").last
    end
  end

  def format_url
    url.is_a?(String) ? url : nil
  end
end

# frozen_string_literal: true
class ApacheGitboxUrlParser < URLParser
  CASE_SENSITIVE = true

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
    # it is common for the name to be passed in as a query parameter so we need to keep them in
    # the url string for now and process them in later steps to pull the name out of the parameter
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
    # match only the repos/asf endpoint at the domain
    "#{domain.split("/").first}\.(#{tlds.join('|')})\/repos/asf"
  end

  def remove_domain
    url.sub!(/(gitbox\.apache\.org\/(repos\/asf))+?(:|\/)?/i, '')
  end

  def remove_extra_segments
    # by the time the URL gets here it should have been mostly pared down to the correct name
    # however if the name was passed as a query parameter the ?p= is still at the front of the name
    if url.is_a?(String) && url.start_with?("?p=")
      self.url = url.split("=").last
    end
  end

  def format_url
    # ignore something if it comes in at as an Array at this point
    url.is_a?(String) ? url : nil
  end
end

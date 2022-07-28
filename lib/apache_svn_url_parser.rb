# frozen_string_literal: true
class ApacheSvnUrlParser < URLParser
  SUBDIR_NAMES = %w[trunk tags branches].freeze
  private

  def full_domain
    'https://svn.apache.org/viewvc'
  end

  def tlds
    %w(org)
  end

  def domain
    'svn.apache'
  end

  def domain_regex
    # match only the viewvc endpoint at the domain
    "#{domain}\.(#{tlds.join('|')})\/(viewvc|viewcvs\.cgi|repos\/asf)"
  end

  def remove_domain
    # find the matches for any github domain characters in the url string
    # and replace only the first match incase we find a repo with something like github.com as the name
    url.sub!(/(apache\.org\/(viewvc|repos\/asf|viewcvs\.cgi))+?(:|\/)?/i, '')
  end

  def extractable_early?
    false
  end

  def remove_extra_segments
    # split the url by / and remove any empty sections
    self.url = url.split('/').reject{ |s| s.strip.empty? }

    # check to see if any repository subdirectories are included in the segments
    # this parser is parsing SVN projects, so any common folders used for branching should trip this
    # truncate the array of segments to stop once we hit a top level sub directory typically seen in SVN repos
    # and return everything up to that point
    #
    # for example apache.org/viewvnc/myproject/subproject/tags/my-1.0.0-release should stop at myproject/subproject
    # since the tags are just part of that repository
    subdir_index = url.index{ |s| SUBDIR_NAMES.include?(s) }

    # it looks like the maven/pom directory on the Apache SVN server has a bunch of repositories stored under tags
    # in this special case, grab the directory name under the subdirectory
    # it looks like this is most likely to be the first directory under tags/
    in_maven_pom_dir = url[0..1].join("/").downcase == "maven/pom"

    if in_maven_pom_dir
      self.url = url[0..subdir_index+1] if subdir_index
    else
      self.url = url[0..subdir_index-1] if subdir_index
    end
  end

  def format_url
    # if this is an Array then the url has gone through all the clean up steps
    #
    # if this is just a string then the url was not cleaned up and I have no idea how to format it
    return nil unless url.is_a?(Array) && url.length.positive?

    url.join("/")
  end
end

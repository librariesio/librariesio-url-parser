# frozen_string_literal: true
class AndroidGooglesourceUrlParser < URLParser
  private

  def full_domain
    'https://android.googlesource.com'
  end

  def tlds
    %w(com)
  end

  def domain
    'android.googlesource'
  end

  def remove_domain
    url.sub!(/(android\.googlesource\.com)+?(:|\/)?/i, '')
  end

  def remove_extra_segments
    self.url = url.split('/').reject{ |s| s.strip.empty? }
  end

  def format_url
    # if this is an Array then the url has gone through all the clean up steps
    #
    # if this is just a string then the url was not cleaned up and I have no idea how to format it
    return nil unless url.is_a?(Array) && url.length.positive?

    # the links that code into specific branches of the repository start with + in the path
    # for example https://android.googlesource.com/device/amlogic/yukawa/ is the top level repository
    # but looking at the master branch is the url
    # https://android.googlesource.com/device/amlogic/yukawa/+/refs/heads/master
    # and the same applies for tags
    # https://android.googlesource.com/device/amlogic/yukawa/+/refs/tags/android-12.1.0_r16

    self.url = url.split('+', 1).first

    url.join("/")
  end
end

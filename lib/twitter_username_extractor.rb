require 'twitter_username_extractor/version'

module TwitterUsernameExtractor
  class Error < StandardError; end

  def self.extract(t)
    return if t.to_s.empty?
    return Regexp.last_match(1) if t.match(/^\@(\w+)$/)
    return Regexp.last_match(1) if t.match(/^(\w+)$/)
    return Regexp.last_match(1) if t.match(%r{(?:www.)?twitter.com/@?(\w+)$}i)

    # Odd special cases
    return Regexp.last_match(1) if t.match(%r{twitter.com/search\?q=%23(\w+)}i)
    return Regexp.last_match(1) if t.match(%r{twitter.com/#!/https://twitter.com/(\w+)}i)
    return Regexp.last_match(1) if t.match(%r{(?:www.)?twitter.com/#!/(\w+)[/\?]?}i)
    return Regexp.last_match(1) if t.match(%r{(?:www.)?twitter.com/@?(\w+)[\/]?}i)
    fail Error, "Unknown twitter handle: #{t}"
  end
end

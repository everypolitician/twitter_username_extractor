require 'test_helper'

class TwitterUsernameExtractorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TwitterUsernameExtractor::VERSION
  end

  def extract(string)
    TwitterUsernameExtractor.extract(string)
  end

  def test_returns_untouched_if_plain_username
    assert_equal 'username', extract('username')
  end

  def test_extracting_from_mention
    assert_equal 'username', extract('@username')
  end

  def test_extracting_from_url
    assert_equal 'username', extract('https://twitter.com/username')
    assert_equal 'username', extract('http://twitter.com/username')
    assert_equal 'username', extract('https://twitter.com/@username')
    assert_equal 'username', extract('http://twitter.com/@username')
    assert_equal 'username', extract('https://www.twitter.com/username')
    assert_equal 'username', extract('http://www.twitter.com/username')
    assert_equal 'username', extract('https://www.twitter.com/@username')
    assert_equal 'username', extract('http://www.twitter.com/@username')
    assert_equal 'username', extract('twitter.com/username')
    assert_equal 'username', extract('twitter.com/username')
    assert_equal 'username', extract('twitter.com/@username')
    assert_equal 'username', extract('twitter.com/@username')
    assert_equal 'username', extract('www.twitter.com/username')
    assert_equal 'username', extract('www.twitter.com/username')
    assert_equal 'username', extract('www.twitter.com/@username')
    assert_equal 'username', extract('www.twitter.com/@username')
  end

  def test_extracting_from_search
    assert_equal 'username', extract('twitter.com/search?q=%23username')
  end

  def test_odd_urls
    assert_equal 'username', extract('https://twitter.com/#!/https://twitter.com/username')
    assert_equal 'username', extract('https://twitter.com/@username/')
  end

  def test_raises_error_for_unknown_username
    assert_raises TwitterUsernameExtractor::Error do
      extract('http://example.com/twitter/username')
    end
  end
end

require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @req = req
    @cookies = {}
    unless @req.cookies['_rails_lite_app'].nil?
      @cookies = JSON.parse(@req.cookies['_rails_lite_app'])
    end
  end

  def [](key)
    @cookies[key]
  end

  def []=(key, val)
    @cookies[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie('_rails_lite_app', @cookies.to_json)
  end
end

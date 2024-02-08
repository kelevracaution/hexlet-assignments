require 'uri'
require 'forwardable'

class Url

  include Comparable

  def <=>(other)
    query_params <=> other.query_params &&
      host <=> other.host &&
      scheme <=> other.scheme &&
      port <=> other.port
  end



  def initialize(str)
    @url = URI(str)
  end

  extend Forwardable
  def_delegators :@url, :host, :scheme, :port

  def query_params
    hash = {}
    @url.to_s
        .partition('?').last
        .split('&').each do |el|
      key, value = el.split('=')
      hash[key.to_sym] = value
    end
    hash
  end

  def query_param(key, value = nil)
    query_params.key?(key) ? query_params[key] : value
  end

end


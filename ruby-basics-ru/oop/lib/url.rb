require 'uri'
require 'forwardable'

class Url

  include Comparable
  attr :url
  def <=>(other)
    self.query_params <=> other.query_params
  end

  attr_reader :url

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

  def query_param(key,value = nil)
    self.query_params.key?(key.to_s) ? self.query_params[key.to_s] : value
  end

end
yandex_url = Url.new 'http://yandex.ru?key=value&key2=value2'


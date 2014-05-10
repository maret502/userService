require 'rubygems'
require 'typhoeus'
require 'json'

class User
  class << self; attr_accessor :base_uri end

  def self.find_by_name(name)
    response = Typhoeus::Request.get(
        "#{base_uri}/api/v1/users/#{name}")
    if response.code == 200
      JSON.parse(response.body)
    elseif response.code == 404
        nil
    else
      raise response.body
    end
  end
end

def self.create(attributes)
  response = Typhoeus::Request.post(
      "#{base_uri}/api/v1/users",
      :body => attributes.to_json)
  if response.code == 200
    JSON.parse(response.body)
  else
    raise response.body
  end
end

def self.update(name, attributes)
  response = Typhoeus::Request.put(
     "#{base_uri}/api/v1/users/#{name}",
     :body => attributes.to_json)
    if response.code == 200
      JSON.parse(response.body)
    else
      raise response.body
    end
end
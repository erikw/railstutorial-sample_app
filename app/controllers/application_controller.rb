class ApplicationController < ActionController::Base
  def hello
    render html: "Hello, worldz!"
  end
end

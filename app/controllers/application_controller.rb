class ApplicationController < ActionController::Base
  puts "allow_browser active!" unless Rails.env.test?
  allow_browser versions: :modern unless Rails.env.test?
end

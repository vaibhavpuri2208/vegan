# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'veganApp'
  app.frameworks = ['CoreLocation', 'MapKit']  
 
  app.pods do
    dependency 'JSONKit'

  end
end

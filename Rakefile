# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
require 'rubygems'
require 'open-uri'
#require 'motion-cocoapods'

 Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'veganApp'
  app.frameworks = ['CoreLocation', 'MapKit','QuartzCore']  
  app.info_plist['UIAppFonts'] = ['Roboto-Medium.ttf', 'RobotoCondensed-Bold.ttf']
  #app.sdk_version = "6.0"

  app.pods do
    dependency 'JSONKit'

  end
end

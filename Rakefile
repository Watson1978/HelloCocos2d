# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'HelloCocos2d'
  app.interface_orientations = [:landscape_left, :landscape_right]
  app.vendor_project('vendor/cocos2d-iphone', :static,
      :products => %w{libs/libcocos2d.a},
      :headers_dir => 'Headers'
      )
  app.frameworks += %w{QuartzCore OpenGLES OpenAL AudioToolbox AVFoundation UIKit Foundation CoreGraphics GameKit}
  app.libs = %w{/usr/lib/libz.dylib /usr/lib/libsqlite3.dylib}

  app.info_plist['UIRequiredDeviceCapabilities'] = {
    'accelerometer' => true,
    'opengles-2'    => true,
  }

end

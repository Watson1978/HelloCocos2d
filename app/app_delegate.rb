class MyNavigationController < UINavigationController
  # The available orientations should be defined in the Info.plist file.
  # And in iOS 6+ only, you can override it in the Root View controller in the "supportedInterfaceOrientations" method.
  # Only valid for iOS 6+. NOT VALID for iOS 4 / 5.
  def supportedInterfaceOrientations
    # iPhone only
    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone
      return UIInterfaceOrientationMaskLandscape
    end

    # iPad only
    return UIInterfaceOrientationMaskLandscape
  end

  # Supported orientations. Customize it for your own needs
  # Only valid on iOS 4 / 5. NOT VALID for iOS 6.
  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    # iPhone only
    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone
      return UIInterfaceOrientationIsLandscape(interfaceOrientation)
    end

    # iPad only
    #  iPhone only
    return UIInterfaceOrientationIsLandscape(interfaceOrientation)
  end

  # This is needed for iOS4 and iOS5 in order to ensure
  # that the 1st scene has the correct dimensions
  # This is not needed on iOS6 and could be added to the application:didFinish...
  def directorDidReshapeProjection(director)
    if director.runningScene == nil
      # Add the first scene to the stack. The director will draw it immediately into the framebuffer. (Animation is started automatically when the view is displayed.)
      # and add the scene to the stack. The director will run it when it automatically when the view is displayed.
      director.runWithScene(IntroLayer.scene)
    end
  end

end

class AppDelegate
  attr_accessor :window, :navController, :director

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # Create the main window
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
    glView = CCGLView.viewWithFrame(@window.bounds,
                                    pixelFormat: KEAGLColorFormatRGB565,
                                    depthFormat: 0,
                                    preserveBackbuffer: false,
                                    sharegroup: nil,
                                    multiSampling: false,
                                    numberOfSamples: 0)

    @director = CCDirector.sharedDirector

    # Display FSP and SPF
    @director.wantsFullScreenLayout = true

    # Display FSP and SPF
    @director.setDisplayStats(true)

    # set FPS at 60
    @director.setAnimationInterval(1.0 / 60)

    # attach the openglView to the director
    @director.setView(glView)

    # 2D projection
    @director.setProjection(KCCDirectorProjection2D)

    # Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
    if ! @director.enableRetinaDisplay(true)
      NSLog("Retina Display Not supported")
    end

    # Default texture format for PNG/BMP/TIFF/JPEG/GIF images
    # It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
    # You can change this setting at any time.
    CCTexture2D.setDefaultAlphaPixelFormat(KCCTexture2DPixelFormat_RGBA8888)

    # If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
    # On iPad HD  : "-ipadhd", "-ipad",  "-hd"
    # On iPad     : "-ipad", "-hd"
    # On iPhone HD: "-hd"
    sharedFileUtils = CCFileUtils.sharedFileUtils
    sharedFileUtils.setEnableFallbackSuffixes(false)       # Default: NO. No fallback suffixes are going to be used
    sharedFileUtils.setiPhoneRetinaDisplaySuffix("-hd")    # Default on iPhone RetinaDisplay is "-hd"
    sharedFileUtils.setiPadSuffix("-ipad")                 # Default on iPad is "ipad"
    sharedFileUtils.setiPadRetinaDisplaySuffix("-ipadhd")  # Default on iPad RetinaDisplay is "-ipadhd"

    # Assume that PVR images have premultiplied alpha
    CCTexture2D.PVRImagesHavePremultipliedAlpha(true)

    # Create a Navigation Controller with the Director
    @navController = MyNavigationController.alloc.initWithRootViewController(@director)
    @navController.navigationBarHidden = true

    # for rotation and other messages
    @director.setDelegate(@navController)

    # set the Navigation Controller as the root view controller
    @window.setRootViewController(@navController)

    # make main window visible
    @window.makeKeyAndVisible

    true
  end

  # getting a call, pause the game
  def applicationWillResignActive(application)
    if @navController.visibleViewController == @director
      @director.pause
    end
  end

  # call got rejected
  def applicationDidBecomeActive(application)
    CCDirector.sharedDirector.setNextDeltaTimeZero(true)
    if @navController.visibleViewController == @director
      @director.resume
    end
  end

  def applicationDidEnterBackground(application)
    if @navController.visibleViewController == @director
      @director.stopAnimation
    end
  end


  def applicationWillEnterForeground(application)
    if @navController.visibleViewController == @director
      @director.startAnimation
    end
  end

  # application will be killed
  def applicationWillTerminate(application)
    # CC_DIRECTOR_END()
  end

  # purge memory
  def applicationDidReceiveMemoryWarning(application)
    CCDirector.sharedDirector.purgeCachedData
  end

  # next delta time will be zero
  def applicationSignificantTimeChange(application)
    CCDirector.sharedDirector.setNextDeltaTimeZero(true)
  end

end

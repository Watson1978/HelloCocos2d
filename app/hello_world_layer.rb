class HelloWorldLayer < CCLayer
  # Helper class method that creates a Scene with the HelloWorldLayer as the only child.
  def self.scene
    # 'scene' is an autorelease object.
    scene = CCScene.node

    # 'layer' is an autorelease object.
    layer = HelloWorldLayer.node

    # add layer as a child to scene
    scene.addChild(layer)

    # return the scene
    return scene
  end

  # on "init" you need to initialize your instance
  def init
    # always call "super" init
    # Apple recommends to re-assign "self" with the "super's" return value
    super

    # create and initialize a Label
    label = CCLabelTTF.labelWithString("Hello World", fontName: "Marker Felt", fontSize: 64)

    # ask director for the window size
    size = CCDirector.sharedDirector.winSize

    # position the label on the center of the screen
    label.position = RM_ccp( size.width / 2, size.height / 2)

    # add the label as a child to this Layer
    self.addChild(label)

    #
    # Leaderboards and Achievements
    #

    # Default font size will be 28 points.
    CCMenuItemFont.setFontSize(28)

    # to avoid a retain-cycle with the menuitem and blocks
    @copy_self = self
    # Achievement Menu Item using blocks
    @itemAchievement = CCMenuItemFont.itemWithString("Achievements", block: lambda { |sender|
      achivementViewController = GKAchievementViewController.alloc.init
      achivementViewController.achievementDelegate = @copy_self
      app = UIApplication.sharedApplication.delegate
      app.navController.presentModalViewController(achivementViewController, animated: true)
      # achivementViewController.release
    })

    # Leaderboard Menu Item using blocks
    @itemLeaderboard = CCMenuItemFont.itemWithString("Leaderboard", block: lambda { |sender|
      leaderboardViewController = GKLeaderboardViewController.alloc.init
      leaderboardViewController.leaderboardDelegate = @copy_self
      app = UIApplication.sharedApplication.delegate
      app.navController.presentModalViewController(leaderboardViewController, animated: true)
      # leaderboardViewController.release
    })

    menu = CCMenu.menuWithItems(@itemAchievement, @itemLeaderboard, nil)

    menu.alignItemsHorizontallyWithPadding(20)
    menu.setPosition(RM_ccp(size.width / 2, size.height / 2 - 50))

    # Add the menu to the layer
    self.addChild(menu)


    return self
  end

  def achievementViewControllerDidFinish(viewController)
    app = UIApplication.sharedApplication.delegate
    app.navController.dismissModalViewControllerAnimated(true)
  end

  def leaderboardViewControllerDidFinish(viewController)
    app = UIApplication.sharedApplication.delegate
    app.navController.dismissModalViewControllerAnimated(true)
  end

end

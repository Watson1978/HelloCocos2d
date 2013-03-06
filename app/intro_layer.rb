class IntroLayer < CCLayer
  # Helper class method that creates a Scene with the HelloWorldLayer as the only child.
  def self.scene
    # 'scene' is an autorelease object.
    scene = CCScene.node

    # 'layer' is an autorelease object.
    layer = IntroLayer.node

    # add layer as a child to scene
    scene.addChild(layer)

    # return the scene
    return scene
  end

  def init
    super

    # ask director for the window size
    size = CCDirector.sharedDirector.winSize

    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
      background = CCSprite.spriteWithFile("Default.png")
      background.rotation = 90
    else
      background = CCSprite.spriteWithFile("Default-Landscape~ipad.png")
    end
    background.position = RM_ccp(size.width / 2, size.height / 2)

    # add the label as a child to this Layer
    self.addChild(background)

    return self
  end

  def onEnter
    super

    CCDirector.sharedDirector.replaceScene(CCTransitionFade.transitionWithDuration(1.0, scene: HelloWorldLayer.scene))
  end

end

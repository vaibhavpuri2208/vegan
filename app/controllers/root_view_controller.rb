class RootViewController < UIViewController
  def viewDidLoad
    super

    startScreen
    performSelector("addNewView", withObject:nil ,afterDelay:1)
    mainScreen
  end


  def startScreen
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    if BW::Device.retina?
      self.view.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/bg-intro-2x.png"))
    else
      self.view.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/bg-intro.png"))
    end
  end

  def mainScreen
   
  self.view.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/bg-main-menu.png"))
  #  self.view.backgroundColor = UIColor.whiteColor
    addLabelsToMainScreen    

  end


  def addLabelsToMainScreen


    #logo = UILabel.alloc.initWithFrame(CGRectMake(10,50,300,100))
    #logo.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/logo.png")); 
    #elf.view.addSubview logo

   

    xPosition = 40
    yPosition = 180
    xImageSize = 90
    yImageSize = 55

    button = UIButton.buttonWithType(UIButtonTypeSystem)
    button.frame = CGRectMake(xPosition,yPosition,xImageSize,yImageSize)
    theimage=loadImageWithState('cafe')
    button.setBackgroundImage(UIImage.imageNamed(theimage),forState:UIControlStateNormal)
    button.addTarget(self, action:'loadCafes', forControlEvents:UIControlEventTouchUpInside)
    button.setUserInteractionEnabled true
    self.view.addSubview button


    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.frame = CGRectMake(xPosition*2+xImageSize*1.25,yPosition,xImageSize,yImageSize)
    theimage=loadImageWithState('restaurant')
    button.setBackgroundImage(UIImage.imageNamed(theimage),forState:UIControlStateNormal)
    button.addTarget(self, action:'loadRestaurants', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview button


    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(xPosition,yPosition*1.4+yImageSize*1.2,xImageSize,yImageSize)
    theimage=loadImageWithState('grocery')
    button.setBackgroundImage(UIImage.imageNamed(theimage),forState:UIControlStateNormal)
    button.addTarget(self, action:'loadGroceries', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview button

    
  end

    
  def loadImageWithState imageName 
    imageNameNormal = "interface_elements/main_menu-icon-" + imageName +".png"
    imageNameRetina = "interface_elements/main_menu-icon-" + imageName + "-2x.png"
    if BW::Device.retina?
      theimage = imageNameRetina
    else
      theimage = imageNameNormal
    end
    theimage
  end




  def addNewView
    UIView.transitionWithView(@containerView,  duration:0.2,options: UIViewAnimationOptionTransitionFlipFromLeft |UIViewAnimationOptionAllowUserInteraction,animations: 
      lambda do ||
        mainScreen         
      end,
      completion:
      lambda do |notification|
        # @containerView.addSubview @launchView
         # @containerView.bringSubviewToFront @launchView
        #@button1.setUserInteractionEnabled(true)
        
      end


     )    
  end

=begin
  def get_json

    BubbleWrap::HTTP.get("http://localhost:3000/hackathons.json") do |response|
      if response.ok?
        @data = BubbleWrap::JSON.parse response.body.to_str    
      end
    end
  
  end
=end



  def title textValue, textSize, textX,textY, textColor

    labelX = textX
    labelY = textY
  
    myFont = UIFont.fontWithName("HelveticaNeue-Bold", size:textSize)
    
    startLabel = UILabel.alloc.initWithFrame(CGRectMake(labelX,labelY,UIScreen.mainScreen.bounds.size.width,textSize+10))
    startLabel.textAlignment = UITextAlignmentCenter
    startLabel.backgroundColor = UIColor.clearColor
    startLabel.text = textValue
    startLabel.font = myFont 
    startLabel.textColor = textColor
    startLabel
  end


  def loadCafes
    UIApplication.sharedApplication.delegate.appTabBarController 0
  end
  
  def loadRestaurants
    UIApplication.sharedApplication.delegate.appTabBarController 1
  end

  def loadGroceries
      UIApplication.sharedApplication.delegate.appTabBarController 2
  end
  

end



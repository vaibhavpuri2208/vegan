class RootViewController < UIViewController
  def viewDidLoad
    super

    
    @containerView = UIView.alloc.init
    self.view.addSubview @containerView

    startScreen
    mainScreen    

    get_json
    #addNewView
    @containerView.addSubview @startView

    performSelector("addNewView", withObject:nil ,afterDelay:1)

  end



  def loadCafes
    App.alert("Loading Cafes")
  end
  
  def loadRestaurants
        App.alert("Loading Restaurants")
  
  end

  def startScreen
    @startView = UIView.alloc.initWithFrame( UIScreen.mainScreen.bounds )
    @startView.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/bg-intro-pq.jpg"))
    
  end

  def mainScreen
    @launchView = UIView.alloc.initWithFrame( UIScreen.mainScreen.bounds )
    @launchView.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/bg-orange.jpg"))
  
    addLabelsToMainScreen    

  end


  def addLabelsToMainScreen

    xPosition = 50
    yPosition = 100
    xImageSize = 80
    yImageSize = 120
    
    logo = UILabel.alloc.initWithFrame(CGRectMake(10,50,300,100))
    logo.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/logo.png")); 
    @launchView.addSubview logo

    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(xPosition,yPosition,xImageSize,yImageSize)
    button.setBackgroundImage (UIImage.imageNamed("interface_elements/bt-cafes.png"),forState:UIControlStateNormal)
    button.addTarget(self, action:'loadCafes', forControlEvents:UIControlEventTouchUpInside)

    @launchView.addSubview button




    @button1 = UIButton.buttonWithType(UIButtonTypeCustom)
    @button1.frame = CGRectMake(xPosition*2+xImageSize*1.2,yPosition,xImageSize,yImageSize)
    @button1.setBackgroundImage (UIImage.imageNamed("interface_elements/bt-restaurants.png"),forState:UIControlStateNormal)
    @button1.addTarget(self, action:'loadRestaurants', forControlEvents:UIControlEventTouchUpInside)

    @launchView.addSubview @button1

    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(xPosition,yPosition*1.2+yImageSize*1.2,xImageSize,yImageSize)
  #bug in the naming of the method
  #  theimage = UIImage.imageNamed("interface_elements/bt-groceries.png",forState:UIControlStateNormal)
 #   theimage.userInteractionEnabled = true
   # button.setBackgroundImage(theimage)
    button.addTarget(self, action:'loadGroceries', forControlEvents:UIControlEventTouchUpInside)
    @launchView.addSubview button


    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(xPosition*2+xImageSize*1.2,yPosition*1.2+yImageSize*1.2,xImageSize,yImageSize)
    button.setBackgroundImage (UIImage.imageNamed("interface_elements/bt-recipes.png"),forState:UIControlStateNormal)
    button.addTarget(self, action:'loadRecipes', forControlEvents:UIControlEventTouchUpInside)

    @launchView.addSubview button
    
  end

  def addNewView
    UIView.transitionWithView(@containerView,  duration:10.0,options: UIViewAnimationOptionCurveEaseOut |UIViewAnimationOptionAllowUserInteraction,animations: 
      lambda do ||
          @startView.removeFromSuperview
          @containerView.addSubview @launchView
          @containerView.bringSubviewToFront @launchView

      end,
     completion:
      lambda do |notification|

        
      end


     )    
  end


  def get_json

    BubbleWrap::HTTP.get("http://localhost:3000/hackathons.json") do |response|
      if response.ok?
        @data = BubbleWrap::JSON.parse response.body.to_str    
      end
    end
  
  end



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




  def loadGroceries
  
  end
  
  def loadRecipes
  
  end  
end



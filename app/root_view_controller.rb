class RootViewController < UIViewController
  def viewDidLoad
    super

    startScreen
    performSelector("addNewView", withObject:nil ,afterDelay:1)

  end



  def loadCafes
    App.alert("Loading Cafes")
  end
  
  def loadRestaurants
    App.alert("Loading Restaurants")
  
  end

  def startScreen
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.view.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/bg-intro-pq.jpg"))
  end

  def mainScreen
   
  self.view.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/bg-orange.jpg"))
  addLabelsToMainScreen    

  end


  def addLabelsToMainScreen

    
    #logo = UILabel.alloc.initWithFrame(CGRectMake(10,50,300,100))
    #logo.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("interface_elements/logo.png")); 
    #elf.view.addSubview logo

   

    xPosition = 50
    yPosition = 100
    xImageSize = 80
    yImageSize = 120

    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.frame = CGRectMake(xPosition,yPosition,xImageSize,yImageSize)
    button.setBackgroundImage (UIImage.imageNamed("interface_elements/bt-cafes.png"),forState:UIControlStateNormal)
    button.addTarget(self, action:'loadCafes', forControlEvents:UIControlEventTouchUpInside)
    button.setUserInteractionEnabled true
    self.view.addSubview button


    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.frame = CGRectMake(xPosition*2+xImageSize*1.2,yPosition,xImageSize,yImageSize)
    button.setBackgroundImage (UIImage.imageNamed("interface_elements/bt-restaurants.png"),forState:UIControlStateNormal)
    button.addTarget(self, action:'loadRestaurants', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview button


    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(xPosition,yPosition*1.2+yImageSize*1.2,xImageSize,yImageSize)
    theimage = UIImage.imageNamed("interface_elements/bt-groceries.png")
    button.setBackgroundImage(theimage,forState:UIControlStateNormal)
    button.addTarget(self, action:'loadGroceries', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview button


    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(xPosition*2+xImageSize*1.2,yPosition*1.2+yImageSize*1.2,xImageSize,yImageSize)
    button.setBackgroundImage (UIImage.imageNamed("interface_elements/bt-recipes.png"),forState:UIControlStateNormal)
    button.addTarget(self, action:'loadRecipes', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview button

    
  end

  def addNewView
    UIView.transitionWithView(@containerView,  duration:0.2,options: UIViewAnimationOptionTransitionFlipFromLeft |UIViewAnimationOptionAllowUserInteraction,animations: 
      lambda do ||
        mainScreen         
      end,
      completion:
      lambda do |notification|
         #@containerView.addSubview @launchView
          #@containerView.bringSubviewToFront @launchView
        #@button1.setUserInteractionEnabled(true)
        
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



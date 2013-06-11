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


  def startScreen
    @startView = UIView.alloc.initWithFrame( UIScreen.mainScreen.bounds )
    @startView.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("loadingscreen.jpg"))
    
  end

  def mainScreen
    @launchView = UIView.alloc.initWithFrame( UIScreen.mainScreen.bounds )
    @launchView.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("bg-intro-pq.jpg"))
  

    xPosition = 60
    yPosition = 100
    xImageSize = 80
    yImageSize = 120
    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(xPosition,yPosition,xImageSize,yImageSize)
    button.setBackgroundImage (UIImage.imageNamed("interface_elements/bt-cafes.png"),forState:UIControlStateNormal)
    @launchView.addSubview button


    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(xPosition*2+xImageSize*1.2,yPosition,xImageSize,yImageSize)
    button.setBackgroundImage (UIImage.imageNamed("interface_elements/bt-restaurants.png"),forState:UIControlStateNormal)
    @launchView.addSubview button



  end


  def addNewView
    UIView.transitionWithView(@containerView,  duration:10.0,options: UIViewAnimationOptionCurveEaseOut ,animations: 
      lambda do ||
          @startView.removeFromSuperview
          @containerView.addSubview @launchView

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


end



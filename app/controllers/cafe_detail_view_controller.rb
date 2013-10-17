
class CafeDetailViewController < UIViewController

  attr_accessor :name, :description, :address, :phone

  class << self

    attr_accessor :Y_INCREMENT, :X_INCREMENT, :X_LEFT_POSITION, :Y_FIRST_POSITION, :LABEL_HEIGHT, :MAP_HEIGHT, :GAP_CLOSER, :ICON_WIDTH, :ICON_HEIGHT, :TEXT_OFFSET

  end
  

  def setGrid
    if BW::Device.retina?
      self.class.Y_INCREMENT = 36
    else
      self.class.Y_INCREMENT = 30
    end  
      self.class.X_INCREMENT = 40
      self.class.X_LEFT_POSITION = 25
      self.class.Y_FIRST_POSITION =0
      self.class.LABEL_HEIGHT = 50
      self.class.MAP_HEIGHT = 75
      self.class.GAP_CLOSER = 20
      self.class.ICON_WIDTH = 16
      self.class.ICON_HEIGHT = 16
      self.class.TEXT_OFFSET = 10
  end

  def buildView
    setGrid
    self.view.backgroundColor = UIColor.whiteColor
    
    myScrollView = UIScrollView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    myScrollView.contentSize =  CGSizeMake(328,758)
    self.view.addSubview myScrollView 
    
    yCordinate = self.class.Y_FIRST_POSITION  
    backgroundView = drawBackground yCordinate,self.class.LABEL_HEIGHT, true
    myScrollView.addSubview backgroundView
    textField = drawText self.class.X_LEFT_POSITION,yCordinate, :name,self.class.LABEL_HEIGHT, "RobotoCondensed-Bold", 20.0
    myScrollView.addSubview textField




    #Address Row
    yCordinate = yCordinate + self.class.LABEL_HEIGHT
    xCordinate =  self.class.X_LEFT_POSITION+ self.class.ICON_WIDTH+self.class.TEXT_OFFSET

    iconView = UIImageView.alloc.initWithImage( UIImage.imageNamed('interface_elements/icon-location-2x.png') )
    iconView.frame =  CGRectMake(self.class.X_LEFT_POSITION-self.class.ICON_WIDTH/4, yCordinate+(self.class.LABEL_HEIGHT-self.class.ICON_HEIGHT)/2, self.class.ICON_WIDTH, self.class.ICON_HEIGHT)
    myScrollView.addSubview iconView
    

    backgroundView = drawBackground yCordinate, self.class.LABEL_HEIGHT,false 
    myScrollView.addSubview backgroundView
    
    textField = drawText xCordinate, yCordinate, :address,self.class.LABEL_HEIGHT, "RobotoCondensed-Bold", 16.0
    myScrollView.addSubview textField


    #Description Row
    yCordinate = yCordinate + self.class.LABEL_HEIGHT
    backgroundView = drawBackground yCordinate, self.class.LABEL_HEIGHT,false
    myScrollView.addSubview backgroundView
    
    iconView = UIImageView.alloc.initWithImage( UIImage.imageNamed('interface_elements/icon-description-2x.png') )
    iconView.frame =  CGRectMake(self.class.X_LEFT_POSITION-self.class.ICON_WIDTH/4, yCordinate+(self.class.LABEL_HEIGHT-self.class.ICON_HEIGHT)/2, self.class.ICON_WIDTH, self.class.ICON_HEIGHT)
    myScrollView.addSubview iconView


    textField = drawText xCordinate, yCordinate, "Description", self.class.LABEL_HEIGHT,"RobotoCondensed-Bold", 16.0
    myScrollView.addSubview textField

    yCordinate = yCordinate + self.class.LABEL_HEIGHT# - self.class.GAP_CLOSER
    backgroundView = drawBackground yCordinate,self.class.LABEL_HEIGHT*1, false
    myScrollView.addSubview backgroundView
    textField = drawText xCordinate, yCordinate-self.class.GAP_CLOSER, :description,self.class.LABEL_HEIGHT*1, "Roboto-Medium", 12.0
    textField.lineBreakMode = NSLineBreakByWordWrapping
    textField.numberOfLines = 0
    textField.sizeToFit
    myScrollView.addSubview textField
    #yCordinate += self.class.LABEL_HEIGHT 


    
    #Timings Row
    yCordinate = yCordinate + self.class.LABEL_HEIGHT
    xCordinate =  self.class.X_LEFT_POSITION+ self.class.ICON_WIDTH+self.class.TEXT_OFFSET
    incrementy = 20
    incrementx = 100
    iconView = UIImageView.alloc.initWithImage( UIImage.imageNamed('interface_elements/icon-time-2x.png') )
    iconView.frame =  CGRectMake(self.class.X_LEFT_POSITION-self.class.ICON_WIDTH/4, yCordinate+(self.class.LABEL_HEIGHT-self.class.ICON_HEIGHT)/2, self.class.ICON_WIDTH, self.class.ICON_HEIGHT)
    myScrollView.addSubview iconView

    backgroundView = drawBackground yCordinate,self.class.LABEL_HEIGHT+incrementy, true
    myScrollView.addSubview backgroundView


    textField1 = drawText xCordinate ,yCordinate, "Mon-Fr", self.class.LABEL_HEIGHT,"RobotoCondensed-Bold", 16.0
    textField2 = drawText xCordinate +incrementx ,yCordinate, "Sat", self.class.LABEL_HEIGHT,"RobotoCondensed-Bold", 16.0
    textField3 = drawText xCordinate +incrementx*2,yCordinate, "Sun", self.class.LABEL_HEIGHT,"RobotoCondensed-Bold", 16.0

    myScrollView.addSubview textField1 
    myScrollView.addSubview textField2
    myScrollView.addSubview textField3


    textField1 = drawText xCordinate ,yCordinate +incrementy, "1000 - 2400", self.class.LABEL_HEIGHT,"Roboto-Medium", 12.0
    textField2 = drawText xCordinate +incrementx ,yCordinate+incrementy, "1400 - 2400", self.class.LABEL_HEIGHT,"Roboto-Medium", 12.0
    textField3 = drawText xCordinate +incrementx*2,yCordinate+incrementy, "Closed", self.class.LABEL_HEIGHT,"Roboto-Medium", 12.0

    myScrollView.addSubview textField1 
    myScrollView.addSubview textField2
    myScrollView.addSubview textField3




    #Phone Row
    yCordinate = yCordinate + self.class.LABEL_HEIGHT + incrementy
    increment = 0
    xCordinate =  self.class.X_LEFT_POSITION+ self.class.ICON_WIDTH+self.class.TEXT_OFFSET

    iconView = UIImageView.alloc.initWithImage( UIImage.imageNamed('interface_elements/icon-phone-2x.png') )
    iconView.frame =  CGRectMake(self.class.X_LEFT_POSITION-self.class.ICON_WIDTH/4, yCordinate+(self.class.LABEL_HEIGHT-self.class.ICON_HEIGHT)/2, self.class.ICON_WIDTH, self.class.ICON_HEIGHT)
    myScrollView.addSubview iconView

    backgroundView = drawBackground yCordinate,self.class.LABEL_HEIGHT, false
    myScrollView.addSubview backgroundView

    textField = drawText xCordinate ,yCordinate, :phone, self.class.LABEL_HEIGHT,"RobotoCondensed-Bold", 16.0
    myScrollView.addSubview textField

    
    #Pictures Scroll Bar Row
    yCordinate = yCordinate + self.class.LABEL_HEIGHT 
    increment = 0
    xCordinate =  self.class.X_LEFT_POSITION+ self.class.ICON_WIDTH+self.class.TEXT_OFFSET

    iconView = UIImageView.alloc.initWithImage( UIImage.imageNamed('interface_elements/icon-no_picture-2x.png') )
    iconView.frame =  CGRectMake(self.class.X_LEFT_POSITION-self.class.ICON_WIDTH/4, yCordinate+(self.class.LABEL_HEIGHT-self.class.ICON_HEIGHT)/2, self.class.ICON_WIDTH, self.class.ICON_HEIGHT)
    myScrollView.addSubview iconView

    backgroundView = drawBackground yCordinate,self.class.LABEL_HEIGHT*2, true
    myScrollView.addSubview backgroundView

    textField = drawText xCordinate ,yCordinate, "Pictures", self.class.LABEL_HEIGHT,"RobotoCondensed-Bold", 16.0
    myScrollView.addSubview textField


    yCordinate = yCordinate#+ self.class.LABEL_HEIGHT
    pictureSubView = setupPicScroll xCordinate, yCordinate
    myScrollView.addSubview pictureSubView
   # pictureSubView.release



=begin
    yCordinate = yCordinate + self.class.LABEL_HEIGHT

    @map_view_for_location = self.initMap yCordinate
    self.regionForMap
    myScrollView.addSubview @map_view_for_location
=end



  end

  def setupPicScroll xCordinate, yCordinate
    picScroll = UIScrollView.alloc.initWithFrame(CGRectMake(0,self.class.LABEL_HEIGHT,UIScreen.mainScreen.bounds.size.width, self.class.LABEL_HEIGHT ))  
    picScroll.delegate = self

    picScroll.backgroundColor = UIColor.clearColor

    #picScroll.setCanCancelContentTouches = false
    picScroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    picScroll.clipsToBounds = false
    picScroll.scrollEnabled = true
    picScroll.pagingEnabled = true
    picScroll.contentSize =  CGSizeMake(90,self.class.LABEL_HEIGHT)


    firstImage = UIImageView.alloc.initWithImage( UIImage.imageNamed('interface_elements/cafe1.jpg') )

    firstImage.frame =  CGRectMake(xCordinate,yCordinate,30, self.class.LABEL_HEIGHT )


    secondImage = UIImageView.alloc.initWithImage( UIImage.imageNamed('interface_elements/cafe1.jpg') )
    secondImage.frame =  CGRectMake(xCordinate+40,yCordinate,30, self.class.LABEL_HEIGHT )

    thirdImage = UIImageView.alloc.initWithImage( UIImage.imageNamed('interface_elements/cafe1.jpg') )
    thirdImage.frame =  CGRectMake(xCordinate+80,yCordinate,30, self.class.LABEL_HEIGHT )


    picScroll.addSubview firstImage
    picScroll.addSubview secondImage
    picScroll.addSubview thirdImage
    picScroll
  end



  def drawText xPosition, yPosition, attribute_name, labelHeight, fontName, fontSize
    dataLabelField = UILabel.alloc.initWithFrame(CGRectMake(xPosition,yPosition+10, UIScreen.mainScreen.bounds.size.width-xPosition, labelHeight/2))
    dataLabelField.backgroundColor = UIColor.clearColor
    dataLabelField.textColor = UIColor.colorWithRed(94.0/255.0, green:89.0/255.0, blue:69.0/255.0, alpha:1.0)
    dataLabelField.font = UIFont.fontWithName(fontName, size:fontSize)
    dataLabelField.adjustsFontSizeToFitWidth = true
    if attribute_name.class == Symbol
      dataLabelField.text = self.send(attribute_name)
    else
      dataLabelField.text = attribute_name
    end
    dataLabelField

  end

  def drawBackground yPosition,labelHeight, borderBOOL
    surroundingLayer = UILabel.alloc.initWithFrame(CGRectMake(-1,yPosition*1.0, UIScreen.mainScreen.bounds.size.width+10, labelHeight))
    surroundingLayer.backgroundColor = UIColor.colorWithRed(242.0/255.0, green:236.0/255.0, blue:209.0/255.0, alpha:0.5)
    surroundingLayer.backgroundColor = UIColor.clearColor #over-riding the brownish color
    if borderBOOL
      surroundingLayer.layer.borderColor = UIColor.colorWithRed(160.0/255.0, green:152.0/255.0, blue:120.0/255.0, alpha:0.5).CGColor
      #surroundingLayer.frame =CGRectMake(-1,yPosition*1.0, UIScreen.mainScreen.bounds.size.width+10, labelHeight)
    else
      surroundingLayer.layer.borderColor = UIColor.clearColor.CGColor
    end

    surroundingLayer.layer.borderWidth =1.0
    surroundingLayer

  end

  def setMyFont fontName, fontSize



  end


  def initMap yCordinate
     map_view = MKMapView.alloc.initWithFrame([[0,yCordinate], [UIScreen.mainScreen.bounds.size.width, yCordinate +self.class.MAP_HEIGHT]])
     map_view.mapType = MKMapTypeStandard
     map_view.backgroundColor = UIColor.colorWithRed(244.0/255.0, green:214.0/255.0, blue:188.0/255.0, alpha:1.0)
     map_view 
  end


  def regionForMap
    completion_block =  lambda do |placemark, error|
      if !error
        latitude = placemark[0].location.coordinate.latitude
        longitude= placemark[0].location.coordinate.longitude
        coordinates = CLLocationCoordinate2DMake(latitude,longitude)
        setAnnotation coordinates
        #region = MKCoordinateRegionMake(coordinates, MKCoordinateSpanMake(0.1, 0.1))
        distance = NSNumber.numberWithDouble(1000)
        region = MKCoordinateRegionMakeWithDistance(coordinates, distance, distance)
        @map_view_for_location.setRegion region
      end
    end

    CLGeocoder.alloc.init.geocodeAddressString(self.address, completionHandler: completion_block)
    
  end

  def setAnnotation coordinates
    annotation = createAnnotation(coordinates, self.name, self.address)
    @map_view_for_location.addAnnotation(annotation)
  end      

  def createAnnotation(coordinate, title, address)
    AnnotationObject.alloc.initWithCoordinate(coordinate,title:title,andSubTitle:address)
  end


end


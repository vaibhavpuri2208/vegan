
class CafeDetailViewController < UIViewController

  attr_accessor :name, :description, :address, :phone

  class << self

    attr_accessor :Y_INCREMENT, :X_INCREMENT, :X_LEFT_POSITION, :Y_FIRST_POSITION, :LABEL_HEIGHT, :MAP_HEIGHT

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
      self.class.MAP_HEIGHT = 100
  end

  def buildView
    setGrid
    self.view.backgroundColor = UIColor.whiteColor


    yCordinate = self.class.Y_FIRST_POSITION  
    backgroundView = drawBackground yCordinate, true
    self.view.addSubview backgroundView
    textField = drawText self.class.X_LEFT_POSITION,yCordinate, :name, "AvenirNext-Bold", 16.0
    self.view.addSubview textField


    yCordinate = yCordinate + self.class.LABEL_HEIGHT
    backgroundView = drawBackground yCordinate, false 
    self.view.addSubview backgroundView
    textField = drawText self.class.X_LEFT_POSITION, yCordinate, :address, "Avenir-Book", 16.0
    self.view.addSubview textField


    yCordinate = yCordinate + self.class.LABEL_HEIGHT

    @map_view_for_location = self.initMap yCordinate
    self.regionForMap
    self.view.addSubview @map_view_for_location


    yCordinate = yCordinate*2 + self.class.MAP_HEIGHT 
    backgroundView = drawBackground yCordinate, false
    self.view.addSubview backgroundView
    textField = drawText self.class.X_LEFT_POSITION,yCordinate, :phone, "Avenir-Book", 16.0
    self.view.addSubview textField


  end


  def drawText xPosition, yPosition, attribute_name, fontName, fontSize
    dataLabelField = UILabel.alloc.initWithFrame(CGRectMake(xPosition,yPosition+10, UIScreen.mainScreen.bounds.size.width-xPosition, self.class.LABEL_HEIGHT/2))
    dataLabelField.backgroundColor = UIColor.clearColor
    dataLabelField.textColor = UIColor.colorWithRed(119.0/255.0, green:93.0/255.0, blue:70.0/255.0, alpha:1.0)
    dataLabelField.font = UIFont.fontWithName(fontName, size:fontSize)
    dataLabelField.adjustsFontSizeToFitWidth = true
    dataLabelField.text = self.send(attribute_name)
    dataLabelField

  end

  def drawBackground yPosition, borderBOOL
    surroundingLayer = UILabel.alloc.initWithFrame(CGRectMake(-1,yPosition*1.0, UIScreen.mainScreen.bounds.size.width+2, self.class.LABEL_HEIGHT))
    surroundingLayer.backgroundColor = UIColor.colorWithRed(255.0/255.0, green:246.0/255.0, blue:235.0/255.0, alpha:0.5)
    if borderBOOL
      surroundingLayer.layer.borderColor = UIColor.brownColor.CGColor
    else
      surroundingLayer.layer.borderColor = UIColor.clearColor.CGColor
    end

    surroundingLayer.layer.borderWidth =1.0
    surroundingLayer

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


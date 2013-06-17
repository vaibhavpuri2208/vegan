class CafeDetailViewController < UIViewController

  attr_accessor :name, :description, :address, :phone

  class << self

    attr_accessor :Y_INCREMENT, :X_INCREMENT, :X_LEFT_POSITION, :Y_FIRST_POSITION

  end
  

  def setGrid
    if BW::Device.retina?
      self.class.Y_INCREMENT = 36
    else
      self.class.Y_INCREMENT = 30
    end  
      self.class.X_INCREMENT = 40
      self.class.X_LEFT_POSITION = 25
      self.class.Y_FIRST_POSITION =10
  end

  def buildView
    setGrid
    self.view.backgroundColor = UIColor.whiteColor
  
    textField = drawText self.class.X_LEFT_POSITION, self.class.Y_FIRST_POSITION, :name
    self.view.addSubview textField
  
    textField = drawText self.class.X_LEFT_POSITION, self.class.Y_FIRST_POSITION + self.class.Y_INCREMENT, :address
    self.view.addSubview textField

    @map_view_for_location = self.initMap
    self.regionForMap
    self.view.addSubview @map_view_for_location

    textField = drawText self.class.X_LEFT_POSITION, self.class.Y_FIRST_POSITION+self.class.Y_INCREMENT*10, :phone
    self.view.addSubview textField


  end


  def drawLabel xPosition, yPosition, label_name 
    labelField = UILabel.alloc.initWithFrame(CGRectMake(xPosition,yPosition,200,50))
    labelField.backgroundColor = UIColor.clearColor
    labelField.text = label_name
    labelField.textColor = UIColor.blackColor
    labelField
  end


  def drawText xPosition, yPosition, attribute_name
    dataLabelField = UILabel.alloc.initWithFrame(CGRectMake(xPosition,yPosition, UIScreen.mainScreen.bounds.size.width, 30))
    dataLabelField.backgroundColor = UIColor.clearColor
    dataLabelField.textColor = UIColor.blackColor
    dataLabelField.font = UIFont.systemFontOfSize(17)
    dataLabelField.text = self.send(attribute_name)
    dataLabelField
  end


  def initMap 
     map_view = MKMapView.alloc.initWithFrame([[self.class.X_LEFT_POSITION,self.class.Y_FIRST_POSITION+self.class.Y_INCREMENT*3], [self.class.X_LEFT_POSITION+self.class.X_INCREMENT*6, self.class.Y_FIRST_POSITION+self.class.Y_INCREMENT*6]])
     map_view.mapType = MKMapTypeStandard
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


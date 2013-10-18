#require 'open-uri'

class CafeTableViewController < UITableViewController
  CELL_REUSE_ID = "SomeCafeId"

  def initWithStyle(style)
    super
    self.title = "Vegan Cafés"
    #startLocationTracking
    readJSONtrial
    self
  end

  def viewDidLoad
    setupTabItem #Setup of Tab Icon and view
     
  end



  def setupTabItem
    theimage = loadImage("cafe") 
    tab_bar_item = UITabBarItem.alloc.initWithTitle(nil,image:UIImage.imageNamed(theimage),tag:1)
    self.tabBarItem = tab_bar_item    
   # getCoordinates "Barcelona" 
    #puts @locationCordinates
  end

 

  def calculateDistance(startposition,endposition) 
    startposition.distanceFromLocation endposition
  end

  def getCoordinates address
    puts address
  #  address ="Berlin"
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false"
    url = URI::encode url
    request = setupGETRequest url
    queque = NSOperationQueue.alloc.init
    error_pointer = Pointer.new(:object)
    @locationCordinates = Hash.new
    NSURLConnection.sendAsynchronousRequest(request,queue: queque, completionHandler: lambda do |response, data, error|
      json_data = NSJSONSerialization.JSONObjectWithData(data, options: NSDataReadingUncached, error: error_pointer)
      @locationCordinates[:lat]= json_data[:results][0][:geometry][:location][:lat]
      @locationCordinates[:lng]= json_data[:results][0][:geometry][:location][:lng]
      @deviceRecentLocation =  UIApplication.sharedApplication.delegate.instance_variable_get(:@deviceRecentLocation)
      endPosition = CLLocation.alloc.initWithLatitude( @locationCordinates[:lat], longitude:@locationCordinates[:lng])
      @distance = calculateDistance(@deviceRecentLocation,endPosition)

    end)
       @distance 
   end

  def setupGETRequest url
    url = NSURL.URLWithString url
    request = NSMutableURLRequest.requestWithURL(url)
    request.setTimeoutInterval 30
    request.setHTTPMethod("GET")
    request.setCachePolicy NSURLRequestUseProtocolCachePolicy
    request
  end


  def readJSONtrial
    request = self.setupGETRequest 'http://localhost:3000/places.json'
    queque = NSOperationQueue.alloc.init
    @cafe = NSMutableArray.new
    NSURLConnection.sendAsynchronousRequest(request,queue: queque,
                                            completionHandler: lambda do |response, data, error|                                              error_pointer = Pointer.new(:object)

                                              json_data = NSJSONSerialization.JSONObjectWithData(data, options: NSDataReadingUncached, error: error_pointer)
                                             # @cafe= block.call(json_data)
                                              
                                              json_data.each do |place|
                                                if place[:category_id] == 1
                                                  address = NSMutableString.new
                                                  address = place[:address]
                                                  if address
                                                    address = address.gsub(/\s/, '+')
                                                   #getCoordinates address

                                                  end

                                                  temp_place = place.mutableCopy
                                                  #temp_place[:distance] = distance
                                                  #puts distance
                                                  @cafe<< temp_place
                                                  #@cafe.last[:distance] = distance
                                                end
                                              end
                                              self.tableView.performSelectorOnMainThread(:reloadData, withObject:nil, waitUntilDone:false)

                                            end

    )



  end

  def loadImage imageName 
    imageNameNormal = "interface_elements/menu_bar-icon-" + imageName +".png"
    imageNameRetina = "interface_elements/menu_bar-icon-" + imageName + "-2x.png"
    if BW::Device.retina?
     theimage = imageNameRetina
    else
      theimage = imageNameNormal
    end
    theimage
  end


  def tableView(tableView, numberOfRowsInSection:section)
    @cafe.length
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_REUSE_ID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: CELL_REUSE_ID)
    cafe = @cafe[ indexPath.row ]
    cell.textLabel.text = cafe[:name]
    cell.detailTextLabel.text = cafe[:description]
    accView= UIView.alloc.initWithFrame CGRectMake(20, 0, 60, 44)
    accLabel =UILabel.alloc.initWithFrame CGRectMake(0,0,60,35)
    #format the address to include the + sign
    distance_to_display = getCoordinates(cafe[:address].to_s) 
    accLabel.text = distance_to_display.to_s
    puts distance_to_display.to_s
    accView.addSubview accLabel
    cell.accessoryView = accView
    theImage = UIImage.imageNamed('interface_elements/cafe1.jpg')
    cell.imageView.image = theImage;

    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    p "row #{indexPath.row} selected"
    cafe_selected = @cafe[indexPath.row]

    @cafe_detail_controller = self.initWithData cafe_selected
    self.navigationController.pushViewController(@cafe_detail_controller, animated:true)

  end

=begin  
  def tableView(tableView, viewForHeaderInSection:section)

    #   header_view = UIImageView.alloc.initWithImage(UIImage.imageNamed("interface_elements/bg-orange.jpg"))
    #   header_view.frame = [[0,0], [320, 44]]
    #   header_view.setUserInteractionEnabled(true)
    #   header_view
  end

  def tableView(tableView, heightForHeaderInSection:section)
   # 64.0
  end
=end
   def initWithData data
    cafe_detail_controller = CafeDetailViewController.alloc.init
    cafe_detail_controller.name = data[:name]
    cafe_detail_controller.description = data[:description]
    cafe_detail_controller.address = data[:address]
    cafe_detail_controller.phone = data[:phone]
    cafe_detail_controller.buildView 
    cafe_detail_controller  
  end

end


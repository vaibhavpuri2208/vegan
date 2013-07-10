class CafeTableViewController < UITableViewController
  CELL_REUSE_ID = "SomeCafeId"

  def initWithStyle(style)
    super
    self.title = "Vegan Cafés & Bars"
    self
  end

  def viewDidLoad
    setupTabItem
    puts @cafe
  end

  def setupTabItem
    theimage = loadImage("cafe")
    tab_bar_item = UITabBarItem.alloc.initWithTitle(nil,image:UIImage.imageNamed(theimage),tag:1)
    self.tabBarItem = tab_bar_item
    #UIApplication.sharedApplication.delegate.readJSONtrial
    url =NSURL.URLWithString 'http://localhost:3000/places.json'
    request =    NSMutableURLRequest.requestWithURL(url)
    request.setTimeoutInterval 30
    request.setHTTPMethod("GET")
    request.setCachePolicy NSURLRequestUseProtocolCachePolicy

    queque = NSOperationQueue.alloc.init
    @data =NSData.new
    @cafe = Array.new

    NSURLConnection.sendAsynchronousRequest(request,queue: queque,
                                            completionHandler: lambda do |response, data, error|


                                              error_pointer = Pointer.new(:object)
                                              @json_data = NSJSONSerialization.JSONObjectWithData(data, options: NSDataReadingUncached, error: error_pointer)
                                              puts "JSON Class is" +@json_data.class.to_s

                                              @data = @json_data

                                              @data.each do |place|
                                                if place[:category_id] == 1
                                                  @cafe << place
                                                end

                                              end

                                            #self.tableView.reloadData
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
    puts "the Cafe name is" + cafe[:name].to_s
    cell.detailTextLabel.text = cafe[:description]
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


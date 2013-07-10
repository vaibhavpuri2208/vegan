class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = RootViewController.alloc.init
    @window.makeKeyAndVisible
    true
  end


  def appTabBarController tabIndex
    cafe_navigation_controller = UINavigationController.alloc.initWithRootViewController(CafeTableViewController.alloc.initWithStyle(UITableViewStylePlain))
    restaurant_table_view_controller = RestaurantTableViewController.alloc.init
    grocery_table_view_controller = GroceryTableViewController.alloc.init
    tab_bar_controller = UITabBarController.alloc.init
    tab_bar_controller.viewControllers = [cafe_navigation_controller, restaurant_table_view_controller,grocery_table_view_controller
    ]
    tab_bar_controller.selectedIndex = tabIndex 
    @window.rootViewController = tab_bar_controller
  end


  def readJSONtrial
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


                                            end
    )

  end


  def readJSON


    error_pointer = Pointer.new(:object)    



    #data_file = NSBundle.bundleWithURL(NSURL.URLWithString url)
    # For us to load the file, we need to pass a pointer. So if something goes wrong we can print
    # the error

    
    #Get the path of our JSON File inside the bundle
    data_file  = NSBundle.mainBundle.pathForResource('data', ofType:'json')

    # Lets load the file into a NSData
    data = NSData.alloc.initWithContentsOfFile(data_file,options:NSDataReadingUncached,error:error_pointer)

    unless data

     if error_pointer[0].code == NSFileReadNoSuchFileError

      $stderr.puts "Error: Missing File Error"

      else

      $stderr.puts "Error: #{error_pointer[0].description}"

      end
      return nil
    end


  # Serialize the NSData into something we can work with, in this case a Hash
  
    json_data = NSJSONSerialization.JSONObjectWithData(data, options: NSDataReadingUncached, error: error_pointer)

    unless json_data

      $stderr.puts "Error: #{error_pointer[0].description}"

      return nil
    end
    
    json_data

  end


end

    
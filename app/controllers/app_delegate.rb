class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
   

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = RootViewController.alloc.init
    @window.makeKeyAndVisible


    true
  end



    def appTabBarController tabIndex

    tab_bar_controller = UITabBarController.alloc.init
    tab_bar_controller.viewControllers = [ CafeTableViewController.alloc.init, RestaurantTableViewController.alloc.init,
      GroceryTableViewController.alloc.init]
     #tab_bar_controller.tabBar.backgroundImage = UIImage.imageNamed "interface_elements/bg-orange.jpg"
     tab_bar_controller.selectedIndex = tabIndex 

     @window.rootViewController = tab_bar_controller
  end


end

    
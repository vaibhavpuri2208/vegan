class RestaurantTableViewController < UITableViewController


  def initWithStyle(style)
    super
    self.title = "Vegan Restaurants"
    self
  end

  def setupTabItem
    tab_bar_item = UITabBarItem.alloc.initWithTitle("Restaurants", image: nil , tag:2)
    tab_bar_item.setFinishedSelectedImage(UIImage.imageNamed("interface_elements/bt-restaurants.png"), withFinishedUnselectedImage:UIImage.imageNamed("interface_elements/bt-restaurants-hover.png"))
    self.tabBarItem = tab_bar_item
  end

end


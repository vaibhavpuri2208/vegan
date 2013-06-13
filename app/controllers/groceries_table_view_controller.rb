class GroceryTableViewController < UITableViewController

  def initWithStyle(style)
    super
    self.title = "Grocery Stores"
    self
  end


  def setupTabItem
    tab_bar_item = UITabBarItem.alloc.initWithTitle("Grocery stores", image: nil , tag:3)
    self.tabBarItem = tab_bar_item
  end

end
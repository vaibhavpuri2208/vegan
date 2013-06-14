class CafeTableViewController < UITableViewController
  CELL_REUSE_ID = "SomeCafeId"

  def initWithStyle(style)
    super
    self.title = "Vegan Cafés & Bars"
    setupTabItem
    self
  end

  def setupTabItem
    tab_bar_item = UITabBarItem.alloc.initWithTitle("cafés",image: loadImage "cafes" , tag:1)
    self.tabBarItem = tab_bar_item
    @data_all = UIApplication.sharedApplication.delegate.readJSON
    @cafe = @data_all["cafe"]
  end




  def tableView(tableView, numberOfRowsInSection:section)
    @cafe.length
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_REUSE_ID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: CELL_REUSE_ID)
    cafe = @cafe[ indexPath.row ]
    cell.textLabel.text = cafe[:name]
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


  def tableView(tableView, viewForHeaderInSection:section)

    header_view = UIImageView.alloc.initWithImage(UIImage.imageNamed("interface_elements/bg-orange.jpg"))
    header_view.frame = [[0,0], [320, 44]]
    header_view.setUserInteractionEnabled(true)
    header_view
  end

  def tableView(tableView, heightForHeaderInSection:section)
    64.0
  end

   def initWithData data
    cafe_detail_controller = CafeDetailViewController.alloc.init
    cafe_detail_controller.name = data[:name]
    cafe_detail_controller.description = data[:description]
    cafe_detail_controller.address = data[:address]
    cafe_detail_controller.buildView 
    cafe_detail_controller  
  end

end


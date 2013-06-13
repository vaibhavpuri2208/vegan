class CafeTableViewController < UITableViewController
  CELL_REUSE_ID = "SomeCafeId"

  def initWithStyle(style)
    super
    self.title = "Vegan Cafés & Bars"
    setupTabItem
    self
  end

  def setupTabItem
    tab_bar_item = UITabBarItem.alloc.initWithTitle("cafés",image: UIImage.imageNamed('interface_elements/bt-cafes.png') , tag:1)
    self.tabBarItem = tab_bar_item
    @data_all = readJSON
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
    cell
  end


  #Reading the JSON items from the main file.

  def readJSON

   # Get the path of our JSON File inside the bundle
  data_file  = NSBundle.mainBundle.pathForResource('data', ofType:'json')

  # For us to load the file, we need to pass a pointer. So if something goes wrong we can print
  # the error
  error_pointer = Pointer.new(:object)

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


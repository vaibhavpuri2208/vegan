class CafeDetailViewController < UIViewController


  def initWithData data
  @cafe_details = data
  cafe_detail_controller = CafeDetailViewController.alloc.init
  #cafe_detail_controller.build_view 
  cafe_detail_controller  
  end
  

  def buildView
    #leackage in instance variable.
    textField = UITextField.alloc.initWithFrame(CGRectMake(20,20, 170, 30))
    textField.borderStyle = UITextBorderStyleRoundedRect
    textField.font = UIFont.systemFontOfSize(15)
    textField.text = "Playing with the text" #@cafe_details[:name]
    self.view.addSubview textField

  end


end


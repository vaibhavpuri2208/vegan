class ViewHelpMethods

    def loadImage imageName 
    imageNameNormal = "interface_elements/main_menu-icon-" + imageName +".png"
    imageNameRetina = "interface_elements/main_menu-icon-" + imageName + "-2x.png"
    if Device.retina?
      theimage = UIImage.imageNamed(imageNameRetina)
    else
      theimage = UIImage.imageNamed(imageNameNormal)
    end
  
    UIImage.imageNamed(theimage)
  end
  
end


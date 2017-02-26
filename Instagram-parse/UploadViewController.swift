//
//  UploadViewController.swift
//  Instagram-parse
//
//  Created by Derrick Wong on 2/25/17.
//  Copyright © 2017 Derrick Wong. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //outlets
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var captionField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the image to nil when the vc loads
        self.previewImage = nil
        
        //set the text field to be empty when view loads
        self.captionField.text = ""

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //allows user to select an image for upload
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.previewImage.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    //when user presses cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //when the user clicks on 'Library' button
    @IBAction func onUploadButton(_ sender: Any) {
        //user will be prompted to choose a photo
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    //sets the caption to write to Parse server
    func setCaption(){
        let caption = captionField.text
    }
    
    
    //resize the image
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }


}

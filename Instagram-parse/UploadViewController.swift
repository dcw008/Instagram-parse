//
//  UploadViewController.swift
//  Instagram-parse
//
//  Created by Derrick Wong on 2/25/17.
//  Copyright © 2017 Derrick Wong. All rights reserved.
//

import UIKit
import Parse

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //outlets
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var captionField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.previewImage.image = image
        } else{
            print("Something went wrong")
        }

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
    
    //when capture button is clicked
    @IBAction func onCaptureButton(_ sender: Any) {
        //user will be prompted to choose a photo
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        //only use camera if available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            vc.sourceType = .camera
        } else {
            //otherwise, use the photo library
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
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
    
    //when the user is done, upload the image to Parse server.
    @IBAction func onDoneButton(_ sender: Any) {
        if(self.previewImage != nil && self.captionField.text != ""){
            let post = PFObject(className:"Post")
            let resizedImage = self.resize(image: self.previewImage.image!, newSize: CGSize(width: 343, height: 236))
            
            let imageData = UIImageJPEGRepresentation(resizedImage, 0)
            
            //create a parse file to store
            post["image"] = PFFile(name: "uploaded_image.jpg", data: imageData!)
            
            //post["image"] = imageData
            post["caption"] = self.captionField.text
            post["user"] = PFUser.current()
            post.saveInBackground {
                (success: Bool, error: Error?) -> Void in
                if (success) {
                    print("Post was saved")
                } else {
                    // There was a problem, check error.description
                    print(error!.localizedDescription)
                }
            }
        }
    }
    

}

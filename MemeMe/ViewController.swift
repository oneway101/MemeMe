//
//  ViewController.swift
//  MemeMe
//
//  Created by Ha Na Gill on 10/31/16.
//  Copyright © 2016 Ha Na Gill. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : NSNumber(value: 2.00)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        topText.delegate = self
        bottomText.delegate = self
        topText.placeholder = "TOP"
        bottomText.placeholder = "BOTTOM"
        topText.textAlignment = .center
        bottomText.textAlignment = .center
        topText.backgroundColor = UIColor.clear
        bottomText.backgroundColor = UIColor.clear
        //when textColor is set, it does not show the black stroke
        //topText.textColor = UIColor.white
        bottomText.borderStyle = .none
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
    }
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagePickerView.image = image
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func pickImageFromAlbum(sender: AnyObject){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func pickImageFromCamera(sender:AnyObject){
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    
    // Hide the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 

}

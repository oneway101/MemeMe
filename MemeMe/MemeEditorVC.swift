//
//  ViewController.swift
//  MemeMe
//
//  Created by Ha Na Gill on 10/31/16.
//  Copyright © 2016 Ha Na Gill. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var topNavbar: UINavigationBar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelMemeButton: UIBarButtonItem!
    
    var selectedImage: UIImage!
    var newMemeWidth: CGFloat!
    var newMemeHeight: CGFloat!
    
    let imagePicker = UIImagePickerController()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : NSNumber(value: -3.00)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetting()
        configureTextField(textField: topText)
        configureTextField(textField: bottomText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        // Subscribe to keyboard notifications to allow the view to raise when necessary
        subscribeToKeyboardNotifications()
    
    }
    // Unsubscribe
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    func configureTextField(textField: UITextField){
        textField.delegate = self
        textField.returnKeyType = .done
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = .none
    }
    
    func defaultSetting(){
        imagePicker.delegate = self
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        //self.view.backgroundColor = UIColor.black
        shareButton.isEnabled = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagePickerView.image = image
            selectedImage = image
            shareButton.isEnabled = true
            self.dismiss(animated: true, completion: nil)
        }
        
        //calculate selected meme image dimensions
        newMemeWidth = self.view.frame.width
        newMemeHeight = (imagePickerView.image!.size.height/imagePickerView.image!.size.width)*self.view.frame.width
        print("deviceWidth: \(self.view.frame.width)")
        print("deviceHeight: \(self.view.frame.height)")
        print("newWidth: \(newMemeWidth)")
        print("newHeight: \(newMemeHeight)")
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
        textField.text = ""
    }
    
    // Hide the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomText.isFirstResponder{
        self.view.frame.origin.y = -(getKeyboardHeight(notification))
        }
        else{
            self.view.frame.origin.y = 0
        }
    }
    
    func keyboardWillHide(_ notification:Notification){
        if bottomText.isFirstResponder{
            self.view.frame.origin.y = 0
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object:nil)
    }
    
    func memeCGRect()-> CGRect{
        let xCoord:CGFloat = 0.0
        let yCoord:CGFloat = (imagePickerView.frame.height-newMemeHeight)*0.5
        print("yCoord:\(yCoord)")
        let cgRect = CGRect(x: xCoord, y: yCoord, width: newMemeWidth, height: newMemeHeight)
        return cgRect
    }
    
    func memeCGSize()-> CGSize{
        let cgSize = CGSize(width: newMemeWidth, height: newMemeHeight)
        return cgSize
    }
    
    func save(_ generatedMeme: UIImage) {
        //Create the meme
        let meme = Meme( topText: topText.text!,
                         bottomText: bottomText.text!,
                         originalImage: imagePickerView.image,
                         memedImage: generatedMeme)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    // Create a UIImage that combines the Image View and the Textfields
    //TODO: implement a method that detects the image's onscreen location and adjusts the position of the text fields accordingly. This way, the text will always be located in the correct position, regardless of the image size.
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        topNavbar.isHidden = true
        bottomToolbar.isHidden = true
        
        // Render view to an image
        //UIGraphicsBeginImageContext(self.view.frame.size)
        //self.view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        UIGraphicsBeginImageContext(self.memeCGSize())
        self.view.drawHierarchy(in: self.memeCGRect(), afterScreenUpdates: true)
        let renderedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        topNavbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return renderedImage
    }
    @IBAction func shareMeme(){
        let generatedMeme = generateMemedImage()
        let activityViewController = UIActivityViewController.init(activityItems: [generatedMeme], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = {
            (activity, completed, returned, error) in
            if(completed){
                self.save(generatedMeme)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func cancelMeme(){
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        imagePickerView.image = nil
        dismiss(animated: true, completion: nil)
    }
}

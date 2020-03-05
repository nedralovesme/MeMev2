//
//  MemeEditorViewController.swift
//  MeMeOG
//
//  Created by Nedra Mevoli on 2/6/20.
//  Copyright © 2020 Nedra Mevoli. All rights reserved.
//

import UIKit
import MobileCoreServices

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var pickImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let imagePicker = UIImagePickerController()
    var memes = [Meme]()

        override func viewDidLoad() {
            super.viewDidLoad()
            //Text formatting

            func configText(_ textField: UITextField) {
                // TODO:- code to configure the textField
                let memeTextAttributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.strokeColor: UIColor.black,
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
                    NSAttributedString.Key.strokeWidth:  -4.0,
                ]
                
                topText.defaultTextAttributes = memeTextAttributes
                topText.textAlignment = .center
                bottomText.defaultTextAttributes = memeTextAttributes
                bottomText.textAlignment = .center
                
            }
            configText(topText)
            configText(bottomText)

            //User touching somewhere else dismisses the keyboard
            view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
            // Set default state
            cancel()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
            subscribeToKeyboardNotifications()
        }
    
    //Keyboard Controls -- Sliding everything up to accomodate the keyboard when in landscape mode
        func subscribeToKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            //to hide keyboard and return view to normal
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        func unsubscribeFromKeyboardNotifications() {
            NotificationCenter.default.removeObserver(self)
        }
        
        @objc func keyboardWillShow(_ notification:Notification) {
            if (bottomText.isFirstResponder){
                view.frame.origin.y -= getKeyboardHeight(notification)
            }}
        
        @objc func keyboardWillHide(_ notification:Notification) {
            if (bottomText.isFirstResponder){
                view.frame.origin.y = 0
            }}
        
        func getKeyboardHeight(_ notification:Notification) -> CGFloat {
            guard let userInfo = notification.userInfo,
                let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                    return .zero;
            }
            return keyboardSize.cgRectValue.height
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            unsubscribeFromKeyboardNotifications()
        }
        

    // Image Controls
        func imagePick(){
            imagePicker.delegate = self
            imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
            shareButton.isEnabled = true
            imagePicker.allowsEditing = true
            present (imagePicker, animated: true, completion: nil)
        }

        @IBAction func pickImage (_ sender: Any){
            imagePicker.sourceType = .photoLibrary
            imagePick()
        }

        @IBAction func takePicture (_ sender: Any){
            imagePicker.sourceType = .camera
            imagePick()
        }
            
        func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            dismiss(animated: true, completion: nil)
            
            if let pickedImage = info[UIImagePickerController.InfoKey.editedImage]as? UIImage {
                pickImageView.contentMode = .scaleAspectFill
//                pickImageView.layer.masksToBounds = true
                pickImageView.image = pickedImage }
            }
    
    // Meme rendering logic
        var memedImage: UIImage?
 

    func generateMemedImage() -> UIImage{
            func hideToolbars(hidden: Bool){
                 bottomToolbar.isHidden = hidden
                 topToolbar.isHidden = hidden
             }
            hideToolbars(hidden: true)
            UIGraphicsBeginImageContext(self.view.bounds.size)
            view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
            let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            hideToolbars(hidden: false)
        
                        
            self.memedImage = memedImage
            return memedImage
        }
    
    //Function to save it
        func save(memedImage: UIImage?){
            guard let topTextValue = topText.text,
                let bottomTextValue = bottomText.text,
                let pickedImage = pickImageView.image,
                let memedImage = memedImage else {
                    return;
            }
            
            let meme = Meme (topTextField: topTextValue,
                      bottomTextField: bottomTextValue,
                      pickedImage: pickedImage,
                      memedImage: memedImage)
            
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
        }
    
    //Sharing Meme via Activity View
        @IBAction func shareMeme (_ sender: Any){
            let memedImage = generateMemedImage()
            let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    
            controller.completionWithItemsHandler = {
                (activityType, completed, returnedItems, activityError) in

                if completed {
                    self.save(memedImage: memedImage)
                    self.dismiss(animated: true, completion: nil)
                    }
            }
            present (controller, animated: true, completion: nil)

    }
    
    // Cancel button/default state logic
        @IBAction func cancel (){
            pickImageView.image = nil
            topText.text = "TOP TEXT"
            bottomText.text = "BOTTOM TEXT"
            shareButton.isEnabled = false
        }
}

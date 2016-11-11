//
//  ProfileViewController.swift
//  PeopleMon
//
//  Created by Riley Osborne on 11/11/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit
import MBProgressHUD

class ProfileViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = UserStore.shared.user {
        emailLabel.text = user.email
        nameField.text = user.fullName
            
        }
        if let image = user.image {
            imageView.image = image
            addGestureRecognizer()
        } else {
            imageView.isHidden =  true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func viewImage() {
        if let image = imageView.image {
            UserStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
        }
    }
    
    fileprivate func showPicker (_ type: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController ()
        imagePicker.delegate =  self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func updateAvatar(_ sender: Any) {
        let alert = UIAlertController(title: "Picture", message: "Choose a picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in self.showPicker(.camera) } ))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in self.showPicker(.photoLibrary) } ))
        present(alert, animated: true, completion: nil)
    }
   
    @IBAction func save(_ sender: Any) {
        guard let name = nameField.text, name != "" else {
            self.present(Utils.createAlert(message: "You must provide a name"), animated: true, completion: nil)
            return
        }
        
        let resizedImage = Utils.resizeImage(image: imageView.image!)
        let imageString = Utils.stringFromImage(image: resizedImage)
        let user = User(fullName: name, avatarBase64: imageString)
        
        MBProgressHUD.showAdded(to: view, animated: true)
        WebServices.shared.postObject(user) { (updatedUser, error) in
        MBProgressHUD.hide(for: self.view, animated: true)
           self.performSegue(withIdentifier: "backSegue", sender: self)
            if let error = error {
                self.present(Utils.createAlert(message: error), animated: true, completion: nil)
            } else {
                UserStore.shared.user?.fullName = name
                UserStore.shared.user?.avatarBase64 = imageString
              
            }
        }
    }
    }


extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: maxSize, height: newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            imageView.image = resizedImage
            
            imageView.isHidden = false
            if gestureRecognizer != nil {
                imageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
    }
}


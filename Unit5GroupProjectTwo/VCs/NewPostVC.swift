//
//  NewPostViewController.swift
//  Unit5GroupProjectTwo
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase

class NewPostVC: UIViewController {
    
    // Retain Reference to Main TabBar
//    var tabBarVCControllers = [UIViewController]()
    
    var newPostView = NewPostView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        newPostView.postButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        newPostView.addImageButton.addTarget(self, action: #selector(addImageButtonPressed), for: .touchUpInside)
        
        // TEST
        newPostView.backgroundColor = UIColor.darkGray
    }
    
    private func setupViews() {
        view.addSubview(newPostView)
        newPostView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    @objc private func postButtonPressed() {
        guard let title = newPostView.titleTextfield.text else {
            // TODO: handle nil titletextfield?
            return
        }
        guard !title.isEmpty else { // PlaceHolderImage
            let noTitleAlert = UIAlertController(title: "No Title", message: "Please pick a title for your post before posting", preferredStyle: .alert)
            noTitleAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(noTitleAlert, animated: true, completion: nil)
            return
        }
        
        guard  newPostView.postImageView.image != #imageLiteral(resourceName: "addImagePlaceholder") else {
            let noTitleAlert = UIAlertController(title: "No Image", message: "Please pick an image for your post before posting", preferredStyle: .alert)
            noTitleAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(noTitleAlert, animated: true, completion: nil)
            return
        }
        
        guard  let image = newPostView.postImageView.image else {
            let noTitleAlert = UIAlertController(title: "No Image", message: "Please pick an image for your post before posting", preferredStyle: .alert)
            noTitleAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(noTitleAlert, animated: true, completion: nil)
            return
        }
        //print(title)
        // TODO: Make new post and upload it
        // TODO: replace with PostService class
        PostService.manager.saveNewPost(content: title, title: title, image: image)
    }
    
    // TODO: remove function and let UserService class handle this
    private func getUser() -> DatabaseReference? {
        let currentUser = Auth.auth().currentUser
        let user = Database.database().reference().child("users").queryEqual(toValue: currentUser).value(forKey: "userRef") as? DatabaseReference
        return user
    }
    
    @objc private func addImageButtonPressed() {
        let addImageActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        UIAlertAction(title: "take a photo", style: .default, handler: nil)
        let openCamera = UIAlertAction.init(title: "take a photo", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }
        let openGallery = UIAlertAction(title: "take from library", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = false
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        addImageActionSheet.addAction(openCamera)
        addImageActionSheet.addAction(openGallery)
        addImageActionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil) )
        self.present(addImageActionSheet, animated: true, completion: nil)
        
        print("opened camera maybe?")
    }

}

extension NewPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.newPostView.postImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

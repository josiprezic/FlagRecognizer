//
//  ViewController.swift
//  FlagRecognizer
//
//  Created by Josip Rezic on 24/03/2019.
//  Copyright © 2019 Josip Rezic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    //
    // MARK: - OUTLETS
    //
    
    @IBOutlet private final var imgVwPhoto: UIImageView!
    @IBOutlet private final var lblPhotoTitle: UILabel!
    
    //
    // MARK: - VIEW METHODS
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //
    // MARK: - METHODS
    //
    
    private final func configureUI() {
        configureView()
        configureNavigationBar()
    }
    
    private final func configureView() {
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imgVwPhoto.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    private final func configureNavigationBar() {
        title = "Home"
        let btnCamera = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(openCamera))
        navigationItem.leftBarButtonItem = btnCamera
        let btnLibrary = UIBarButtonItem(title: "Library", style: .plain, target: self, action: #selector(openLibrary))
        navigationItem.rightBarButtonItem  = btnLibrary
    }
    
    private final func processImage(image: UIImage) {
        imgVwPhoto.backgroundColor = .clear
        imgVwPhoto.image = image
        lblPhotoTitle.text = "Analyzing Image..."
        
        DispatchQueue.global(qos: .background).async {
            guard let prediction = CoreMLHelper.predict(image: image) else { return }
            DispatchQueue.main.async {
                self.lblPhotoTitle.text = "I think this is a flag of \(prediction.classLabel)."
            }
        }
    }
    
    @objc private final func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        present(cameraPicker, animated: true)
    }
    
    @objc private final func openLibrary() {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
}

//
// MARK: - EXTENSION - UIImagePickerControllerDelegate
//

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        processImage(image: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

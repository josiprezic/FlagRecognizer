//
//  ViewController.swift
//  FlagRecognizer
//
//  Created by Korisnik on 24/03/2019.
//  Copyright © 2019 Josip Rezic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    //
    // MARK: - OUTLETS
    //
    
    @IBOutlet var imgVwPhoto: UIImageView!
    @IBOutlet var lblPhotoTitle: UILabel!
    
    //
    // MARK: - VIEW METHODS
    //
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    //
    // MARK: - METHODS
    //
    
    private final func configureUI() {
        configureView()
    }
    
    private final func configureView() {
        title = "Home"
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imgVwPhoto.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        addNavigationBarButtons()
    }
    
    private final func addNavigationBarButtons() {
        let btnCamera = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(openCamera))
        navigationItem.leftBarButtonItem = btnCamera
        
        let btnLibrary = UIBarButtonItem(title: "Library", style: .plain, target: self, action: #selector(openLibrary))
        navigationItem.rightBarButtonItem  = btnLibrary
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
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

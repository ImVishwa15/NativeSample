//
//  ImagePickerController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/3/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

 public let KAlertTitle           =      "Native Sample"
 public let KOk                   =      "Ok"
 public let KCancel               =      "Cancel"
 public let KYes                  =      "Yes"
 public let KSettings             =      "Settings"
 public let KGalleryPermission    =      "You need to provide permission from settings to access gallery."
 public let KCameraPermission     =      "You need to provide permission from settings to access camera."
 public let KDeviceNotSupport     =      "Your device doesn't support the selected source."

public typealias SelectionAction = (UIImage) -> Void

open class ImagePickerController: UIImagePickerController {
    
    private var selectedAction: SelectionAction?
    
    //MARK:  Initialization
    static func fetch(_ viewCotroller: UIViewController,_ imageSource: UIImagePickerController.SourceType = .photoLibrary, _ allowsEditing: Bool = false, _ tintColor: UIColor = .white, _ barTintColor: UIColor = .black, _ handler: @escaping SelectionAction) {
        let imagePicker = ImagePickerController()
        imagePicker.delegate = imagePicker
        if UIImagePickerController.isSourceTypeAvailable(imageSource) {
            imagePicker.sourceType = imageSource
        }
        else {
            let alert = UIAlertController(title: KAlertTitle, message: KDeviceNotSupport, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: KOk, style: UIAlertAction.Style.default, handler: nil))
            viewCotroller.present(alert, animated: true, completion: nil)
        }
        imagePicker.allowsEditing = allowsEditing
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = barTintColor
        imagePicker.navigationBar.tintColor = tintColor
        imagePicker.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
        
        if imageSource == .photoLibrary || imageSource == .savedPhotosAlbum {
            self.checkPhotoLibraryAuthorization({ authorized in
                if authorized {
                    viewCotroller.present(imagePicker, animated: true, completion:nil)
                }
                else {
                    self.accessPermission(viewCotroller, imageSource)
                }
            })
        }
        else {
            self.checkCameraAuthorization { authorized in
                if authorized {
                    viewCotroller.present(imagePicker, animated: true, completion:nil)
                }
                else {
                    self.accessPermission(viewCotroller, imageSource)
                }
            }
        }
        imagePicker.selectedAction = handler
    }
    
    //MARK:  check authorization permission
    public static func checkCameraAuthorization(_ completionHandler: @escaping ((_ authorized: Bool) -> Void)) {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            //The user has previously granted access to the camera.
            completionHandler(true)
        case .notDetermined:
            // The user has not yet been presented with the option to grant video access so request access.
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { success in
                completionHandler(success)
            })
        case .denied:
            // The user has previously denied access.
            completionHandler(false)
        case .restricted:
            // The user doesn't have the authority to request access e.g. parental restriction.
            completionHandler(false)
        }
    }
    
    public static func checkPhotoLibraryAuthorization(_ completionHandler: @escaping ((_ authorized: Bool) -> Void)) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            // The user has previously granted access to the photo library.
            completionHandler(true)
        case .notDetermined:
            // The user has not yet been presented with the option to grant photo library access so request access.
            PHPhotoLibrary.requestAuthorization({ status in
                completionHandler((status == .authorized))
            })
        case .denied:
            // The user has previously denied access.
            completionHandler(false)
        case .restricted:
            // The user doesn't have the authority to request access e.g. parental restriction.
            completionHandler(false)
        }
    }
    
    private static func accessPermission(_ viewCotroller: UIViewController, _ imageSource: UIImagePickerController.SourceType = .photoLibrary)  {
        let alert = UIAlertController(title: KAlertTitle, message: (imageSource == .photoLibrary || imageSource == .savedPhotosAlbum) ? KGalleryPermission : KCameraPermission, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: KCancel, style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: KSettings, style: UIAlertAction.Style.default, handler: { action in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        }))
        DispatchQueue.main.async {
            viewCotroller.present(alert, animated: true, completion: nil)
        }
    }
    
    private func fixImageOrientation(_ image: UIImage) -> UIImage {
        UIGraphicsBeginImageContext(image.size)
        image.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? image
    }
}

extension ImagePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:  UIImagePickerControllerDelegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = (info[picker.allowsEditing ? .editedImage : .originalImage] as? UIImage) {
            if let selectedAction = self.selectedAction {
                DispatchQueue.main.async {
                    selectedAction((picker.sourceType == .camera) ? (self.fixImageOrientation(originalImage)) : originalImage)
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}

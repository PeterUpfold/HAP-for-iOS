// The MIT License (MIT)
//
// Copyright (c) 2015-2017 zhangao0086
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//
//  UploadPopoverCustomCamera.swift
//  DKImagePickerControllerDemo
//
//  Created by ZhangAo on 03/01/2017.
//  Copyright © 2017 ZhangAo. All rights reserved.
//  From: https://github.com/zhangao0086/DKImagePickerController/tree/develop/DKImagePickerControllerDemo/CustomCameraUIDelegate
//

import UIKit
import MobileCoreServices
import DKImagePickerController

open class UploadPopoverCustomCamera: UIImagePickerController, DKImagePickerControllerCameraProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc var didCancel: (() -> Void)?
    @objc var didFinishCapturingImage: ((_ image: UIImage) -> Void)?
    @objc var didFinishCapturingVideo: ((_ videoURL: URL) -> Void)?
    
    public func setDidCancel(block: @escaping () -> Void) {
        self.didCancel = block
    }
    
    public func setDidFinishCapturingImage(block: @escaping (UIImage) -> Void) {
        self.didFinishCapturingImage = block
    }
    
    public func setDidFinishCapturingVideo(block: @escaping (URL) -> Void) {
        self.didFinishCapturingVideo = block
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.sourceType = .camera
        self.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
    }
    
    // MARK: - UIImagePickerControllerDelegate methods
    
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        let mediaType = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaType)] as! String
        
        if mediaType == kUTTypeImage as String {
            let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
            self.didFinishCapturingImage?(image)
        } else if mediaType == kUTTypeMovie as String {
            let videoURL = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaURL)] as! URL
            self.didFinishCapturingVideo?(videoURL)
        }
    }
    
    open func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.didCancel?()
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}

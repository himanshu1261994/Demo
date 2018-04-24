//
//  MasterDocumentProtocols.swift
//  LawyerApp
//
//  Created by indianic on 21/04/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import Foundation

enum DocumentPickerType {
    case iCloud
    case dropBox
    case googleDrive
}
enum DocumentPickerMode {
    case documentImport
    case documentExport
}
@objc public protocol UIButtonMasterDocumentUploaderDelegate {
    func shouldUploadDocument(uploaded : UIButtonMasterDocumentUploader) -> Bool
    func masterDocumentUploaded(uploader : UIButtonMasterDocumentUploader,fileURL : URL,fileExtension : String)
}

@objc public protocol UIButtonMasterDocumentPickerDelegate {
    func shouldOpenMasterDocumentPicker(picker : UIButtonMasterDocumentPicker) -> Bool
    func masterDocumentDidFinishPicking(picker : UIButtonMasterDocumentPicker,fileURL : URL,fileExtension : String)
}

//
//  MasterDocumentPicker.swift
//  LawyerApp
//
//  Created by indianic on 28/03/17.
//  Copyright © 2017 ImagePlus. All rights reserved.
//

import UIKit
import SwiftyDropbox

@objc protocol MasterDocumentPickerDelegate {
    func shouldOpenDocumentPicker() -> Bool
    func documentDidFinishPicking(fileURL : URL,fileExtension : String)
}
class MasterDocumentPicker: NSObject,UIDocumentPickerDelegate,DropBoxDocumentDelegate {

    private var pickerMode : DocumentPickerMode? // Default will be import
    private let icloudDocumentTypes : [String] = ["public.data"]
    private var arrAllowedFileTypes : [String]?
    private var pickerType : DocumentPickerType?
    var delegate: MasterDocumentPickerDelegate?
    private var exportFileURL : URL?
    private var viewController : UIViewController?
    let client = DropboxClientsManager.authorizedClient
    
    
    override func awakeFromNib() {
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.presentDropBoxPicker), name: NSNotification.Name(rawValue: "Dropboxlistrefresh"), object: nil)
    }
    init(type : DocumentPickerType,allowedFileTypes : [String],delegate : Any,viewController : UIViewController) {
        self.pickerType = type
        self.pickerMode = .documentImport
        self.arrAllowedFileTypes = allowedFileTypes
        self.delegate = delegate as? MasterDocumentPickerDelegate
        self.viewController = viewController
        
    }
    init(type : DocumentPickerType,url : URL,delegate : Any,viewController : UIViewController) {
        self.pickerType = type
        self.exportFileURL = url
        self.pickerMode = .documentExport
        self.delegate = delegate as? MasterDocumentPickerDelegate
        self.viewController = viewController
        
    }
    func open(){
        if delegate!.shouldOpenDocumentPicker() {
            self.presentMasterDocumentPicker()
        }
    }
    func presentMasterDocumentPicker() {
       
        if pickerMode == .documentImport {
            if pickerType == .iCloud {
                 self.presentICloudForImportWith(documentTypes: arrAllowedFileTypes!)
            }else if pickerType == .dropBox {
                self.presentDropBoxPicker()
            }else if pickerType == .googleDrive {
                self.presentGoogleDrivePicker()
            }
        }else if pickerMode == .documentExport{
        
            if pickerType == .iCloud {
                self.presentICloudForExportFileWith(fileURL: self.exportFileURL!)
            }else if pickerType == .dropBox {
                self.presentDropBoxPicker()
            }else if pickerType == .googleDrive {
//                self.presentGoogleDrivePicker()
            }
        }
    }
    func presentGoogleDrivePicker() {
       
        let gDriveVC : GoogleDriveContentViewController = GoogleDriveContentViewController(nibName: "GoogleDriveContentViewController", bundle: nil)
        self.viewController?.present(gDriveVC, animated: true, completion: nil)
    }
    
    
    func presentDropBoxPicker() {
        
        if (DropboxClientsManager.authorizedClient == nil) {
            
            DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                          controller: viewController!,
                                                          openURL: { (url: URL) -> Void in
                                                            UIApplication.shared.openURL(url)
            })
        }else {
            if pickerMode == .documentImport {
                self.presentDropBoxToImportFileWith(allowedFileTypes: self.arrAllowedFileTypes!)
            }else if pickerMode == .documentExport{
                self.presentDropBoxToExportFileWith(exportFileURL: self.exportFileURL!)
            }
        }
    }
    func presentDropBoxToImportFileWith(allowedFileTypes : [String]){
        let dbvc : DropBoxContentViewController = DropBoxContentViewController(nibName: "DropBoxContentViewController", bundle: nil)
        dbvc.allowedFileTypes = allowedFileTypes
        dbvc.documentMode = .documentImport
        self.presentDropBox(dropBoxVC: dbvc)
    }
    func presentDropBoxToExportFileWith(exportFileURL : URL) {
        let dbvc : DropBoxContentViewController = DropBoxContentViewController(nibName: "DropBoxContentViewController", bundle: nil)
        dbvc.exportFileURL = exportFileURL
        dbvc.documentMode = .documentExport
        self.presentDropBox(dropBoxVC: dbvc)
    }
  
    func presentDropBox(dropBoxVC : DropBoxContentViewController){
        dropBoxVC.delegate = self
        viewController?.present(dropBoxVC, animated: true, completion: nil)
    }
   
    func presentICloudForImportWith(documentTypes : [String]){
        let icloudPicker : UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: icloudDocumentTypes, in: .import)
        self.presentICloudPicker(picker: icloudPicker)
    }
    func presentICloudForExportFileWith(fileURL : URL){
        let icloudPicker : UIDocumentPickerViewController = UIDocumentPickerViewController(url: fileURL, in: .exportToService)
        self.presentICloudPicker(picker: icloudPicker)
    }
    func presentICloudPicker(picker : UIDocumentPickerViewController) {
        picker.delegate = self
        picker.modalPresentationStyle = .formSheet
        viewController!.present(picker, animated: true, completion: nil)
    }
    //MARK: DropBoxDocumentDelegate
    func dropBoxDidFinishPickingFileWith(url: URL) {
        delegate?.documentDidFinishPicking(fileURL: url, fileExtension: url.pathExtension.lowercased())
    }
    //MARK: UIDocumentPickerDelegate
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {

        if controller.documentPickerMode == .import {
            self.selectedDocumentWith(url: url)
        }else{
            
            delegate?.documentDidFinishPicking(fileURL: url, fileExtension: url.pathExtension.lowercased())
        }
        
    }
    //MARK: UTILITY
    func selectedDocumentWith(url: URL) {
        if MasterDocumentUtility.validateDocumentWith(url: url,allowedFileTypes: arrAllowedFileTypes!,viewController : viewController!){
            delegate?.documentDidFinishPicking(fileURL: url, fileExtension: url.pathExtension.lowercased())
        }else{
            print("invalid file")
        }
    }
        

}


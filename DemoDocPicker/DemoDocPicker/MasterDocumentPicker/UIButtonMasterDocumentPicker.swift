//
//  UIButtonMasterDocumentPicker.swift
//  LawyerApp
//
//  Created by indianic on 20/04/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit

@objc public class UIButtonMasterDocumentPicker: UIButton,MasterDocumentPickerDelegate {

    
    @IBOutlet open var delegate : Any? {
        get {return internalDelegate}
        set{internalDelegate = newValue as? UIButtonMasterDocumentPickerDelegate}
    
    }
    var internalDelegate : UIButtonMasterDocumentPickerDelegate?
    var docPicker : MasterDocumentPicker?
    var allowedFileTypes : [String] = ["pdf","doc","docx","txt","png"] // Default values
    override public func awakeFromNib() {
        self.addTarget(self, action: #selector(openOptions(_:)), for: .touchUpInside)
    }
    func shouldOpenDocumentPicker() -> Bool {
        return true
    }
    func documentDidFinishPicking(fileURL: URL, fileExtension: String) {
        internalDelegate?.masterDocumentDidFinishPicking(picker: self, fileURL: fileURL, fileExtension: fileExtension)
    }
    
    @IBAction func openOptions(_ sender: UIButton) {
        
        if internalDelegate!.shouldOpenMasterDocumentPicker(picker: self) {
            MasterDocumentUtility.showActionSheetWith(viewController: delegate as! UIViewController, message: "Choose Document", buttons: ["ICloud","DropBox"]) { (action,index) in
                if index == 0{
                    
                    self.docPicker = MasterDocumentPicker(type: .iCloud, allowedFileTypes: self.allowedFileTypes, delegate: self,viewController : self.delegate as! UIViewController)
                    self.docPicker?.open()
                    
                }else if index == 1{
                    self.docPicker = MasterDocumentPicker(type: .dropBox, allowedFileTypes: self.allowedFileTypes, delegate: self,viewController : self.delegate as! UIViewController)
                    self.docPicker?.open()
                }else if index == 2{
                    self.docPicker = MasterDocumentPicker(type: .googleDrive, allowedFileTypes: self.allowedFileTypes, delegate: self,viewController : self.delegate as! UIViewController)
                    self.docPicker?.open()
                    
                }
            }
            
        }
        
       
        
    }

}

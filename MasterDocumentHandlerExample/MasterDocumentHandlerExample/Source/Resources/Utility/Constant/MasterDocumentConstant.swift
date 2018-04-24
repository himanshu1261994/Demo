//
//  MasterDocumentConstant.swift
//  LawyerApp
//
//  Created by Adapting Social on 20/04/17.
//  Copyright © 2017 Adapting Social. All rights reserved.
//

import Foundation
import UIKit
enum UITableViewAnimationDirection {
    case left
    case right
    case down
    case up
}

public let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
let kDocumentCellIdentifier = "MasterDocumentContentCell"
let kAppTitle : String = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
let kImageNameFile = "MasterDocumentFile"
let kImageNameFolder = "MasterDocumentFolder"
let kDocumentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
var kAuthKeyChainName = "MasterDocPicker"
var kGoogleClientID = "668625562768-je8segcnci1rddqq4kg2v2cnkmrcap57.apps.googleusercontent.com"
//ERROR MESSAGES
let kErrorSomethingWentWrong = "Something went wrong please try again later"
let kErrorFileTypeNotAllowed = "Selected file type is not allowed please try again with other file type"
let kErrorFileSizeLimit = "Selected file should be less then 7 MB"
let kErrorFileNotExits = "File not exits"
let kErrorNetwork = "Please check your internet connection"
let kGoogleFolderMimeType : String = "application/vnd.google-apps.folder"
//SUCCESS MESSAGES

let kSuccessFileUpload = "File uploaded successfully"



public typealias kCompletionFileDownloadedHandler = (URL,String) -> Swift.Void
struct MasterDocumentConstant {
    
   
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
        static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    }
    
    
    struct AlertMessage {
        
        static let kAlertMsgNetworkError = "Ooops, some network error occurs."
        
        static let kAlertMsgNoInternetConnection = "Please check your internet connection and try again."
        
        static let kAlertMessageRequiredField : (String) -> String = {name in
            return "Please enter \(name)"
        }
        
        
        
        static let kAlertMsgSomeThingWentWrong = "Something went wrong please try again later"
        static let kAlertMsgFileUploadedSuccessFully = "File uploaded successfully"
        static let kAlertMsgRequestTimeOut = "Request time out please try again later"
    }
    
    // Date formatters
    static let kDateFormat_DDMMYYYY = "dd/MM/yyyy"
    static let kDateFormat_MMDDYYYY = "MM/dd/yyyy"
    static let kDateFormat_YYYYMMDD = "yyyy-MM-dd"
    
}
extension UIAlertController
{
    /**
     Display an Alert / Actionsheet
     
     - parameter controller:     Object of controller on which you need to display Alert/Actionsheet
     - parameter aStrMessage:    Message to display in Alert / Actionsheet
     - parameter style:          .Alert / .Actionshhet
     - parameter aCancelBtn:     Cancel button title
     - parameter aDistrutiveBtn: Distructive button title
     - parameter otherButtonArr: Array of other button title
     - parameter completion:     Completion block. Other Button Index Starting From - 0 | Destructive Index - (Last / 2nd Last Index) | Cancel Index - (Last / 2nd Last Index)
     */
    class func showAlert(_ controller : AnyObject ,
                         position : CGRect,
                         aStrMessage :String? ,
                         style : UIAlertControllerStyle ,
                         aCancelBtn :String? ,
                         aDistrutiveBtn : String?,
                         otherButtonArr : Array<String>?,
                         completion : ((Int, String) -> Void)?) -> Void {
        
        let strTitle = appName
        
        let alert = UIAlertController.init(title: strTitle, message: aStrMessage, preferredStyle: style)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let Vc =  controller as? UIViewController
            if Vc != nil{
                
                alert.popoverPresentationController?.sourceView = Vc!.view!
                alert.popoverPresentationController?.sourceRect = position
            }
        }
        
        if let strDistrutiveBtn = aDistrutiveBtn {
            
            let aStrDistrutiveBtn = strDistrutiveBtn
            
            alert.addAction(UIAlertAction.init(title: aStrDistrutiveBtn, style: .destructive, handler: { (UIAlertAction) in
                
                completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strDistrutiveBtn)
                
            }))
        }
        
        if let strCancelBtn = aCancelBtn {
            
            let aStrCancelBtn = strCancelBtn
            
            alert.addAction(UIAlertAction.init(title: aStrCancelBtn, style: .cancel, handler: { (UIAlertAction) in
                
                if ( aDistrutiveBtn != nil ) {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count + 1 : 1, strCancelBtn)
                } else {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strCancelBtn)
                }
                
            }))
        }
        
        if let arr = otherButtonArr {
            
            for (index, value) in arr.enumerated() {
                
                let aValue = value
                
                alert.addAction(UIAlertAction.init(title: aValue, style: .default, handler: { (UIAlertAction) in
                    
                    completion?(index, value)
                    
                }))
            }
        }
        
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    /**
     Display an Alert / Actionsheet
     
     - parameter controller:     Object of controller on which you need to display Alert/Actionsheet
     - parameter aStrMessage:    Message to display in Alert / Actionsheet
     - parameter style:          .Alert / .Actionshhet
     - parameter aCancelBtn:     Cancel button title
     - parameter aDistrutiveBtn: Distructive button title
     - parameter otherButtonArr: Array of other button title
     - parameter completion:     Completion block. Other Button Index Starting From - 0 | Destructive Index - (Last / 2nd Last Index) | Cancel Index - (Last / 2nd Last Index)
     */
    class func showAlert(_ controller : AnyObject ,
                         aStrMessage :String? ,
                         style : UIAlertControllerStyle ,
                         aCancelBtn :String? ,
                         aDistrutiveBtn : String?,
                         otherButtonArr : Array<String>?,
                         completion : ((Int, String) -> Void)?) -> Void {
        
        let strTitle = appName
        
        let alert = UIAlertController.init(title: strTitle, message: aStrMessage, preferredStyle: style)
        
        
        if let strDistrutiveBtn = aDistrutiveBtn {
            
            let aStrDistrutiveBtn = strDistrutiveBtn
            
            alert.addAction(UIAlertAction.init(title: aStrDistrutiveBtn, style: .destructive, handler: { (UIAlertAction) in
                
                completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strDistrutiveBtn)
                
            }))
        }
        
        if let strCancelBtn = aCancelBtn {
            
            let aStrCancelBtn = strCancelBtn
            
            alert.addAction(UIAlertAction.init(title: aStrCancelBtn, style: .cancel, handler: { (UIAlertAction) in
                
                if ( aDistrutiveBtn != nil ) {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count + 1 : 1, strCancelBtn)
                } else {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strCancelBtn)
                }
                
            }))
        }
        
        if let arr = otherButtonArr {
            
            for (index, value) in arr.enumerated() {
                
                let aValue = value
                
                alert.addAction(UIAlertAction.init(title: aValue, style: .default, handler: { (UIAlertAction) in
                    
                    completion?(index, value)
                    
                }))
            }
        }
        
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    /**
     Display an Alert With "Ok" Button
     
     - parameter controller:  Object of controller on which you need to display Alert
     - parameter aStrMessage: Message to display in Alert
     - parameter completion:  Completion block. Ok Index - 0
     */
    class func showAlertWithOkButton(_ controller : AnyObject ,
                                     aStrMessage :String? ,
                                     completion : ((Int, String) -> Void)?) -> Void {
        
        self.showAlert(controller, aStrMessage: aStrMessage, style: .alert, aCancelBtn: nil, aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: completion)
        
    }
    class func showAlertWithTextfield(_ controller : AnyObject ,
                                      aStrMessage :String? ,
                                      style : UIAlertControllerStyle ,
                                      aCancelBtn :String? ,
                                      aDistrutiveBtn : String?,
                                      otherButtonArr : Array<String>?,textFieldPlaceHolder : String,textFieldKeyBoardType : UIKeyboardType,text : String,
                                      completion : ((Int, String,UIAlertController) -> Void)?) -> Void{
        
        
        let alert : UIAlertController = UIAlertController.init(title: appName, message: aStrMessage, preferredStyle: style)
        
        
        if let strCancelBtn = aCancelBtn {
            
            let aStrCancelBtn = strCancelBtn
            
            alert.addAction(UIAlertAction.init(title: aStrCancelBtn, style: .cancel, handler: { (UIAlertAction) in
                
                if ( aDistrutiveBtn != nil ) {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count + 1 : 1, strCancelBtn, alert)
                } else {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strCancelBtn, alert)
                }
                
            }))
        }
        
        if let arr = otherButtonArr {
            
            for (index, value) in arr.enumerated() {
                
                let aValue = value
                
                alert.addAction(UIAlertAction.init(title: aValue, style: .default, handler: { (UIAlertAction) in
                    
                    completion?(index, value, alert)
                    
                }))
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = textFieldPlaceHolder
            textField.keyboardType = textFieldKeyBoardType
            textField.text = text
        }
        controller.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    /**
     Display an Alert With "Cancel" Button
     
     - parameter controller:  Object of controller on which you need to display Alert
     - parameter aStrMessage: Message to display in Alert
     - parameter completion:  Completion block. Cancel Index - 0
     */
    class func showAlertWithCancelButton(_ controller : AnyObject ,
                                         aStrMessage :String? ,
                                         completion : ((Int, String) -> Void)?) -> Void {
        
        self.showAlert(controller, aStrMessage: aStrMessage, style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: nil, completion: completion)
        
    }
    
    
    
    /**
     Display an Alert For Delete Confirmation
     
     - parameter controller:  Object of controller on which you need to display Alert
     - parameter aStrMessage: Message to display in Alert
     - parameter completion:  Completion block. Use Gallery Index - 0 | Use Camera Index - 1 | Cancel Index - 2
     */
    class func showDeleteAlert(_ controller : AnyObject ,
                               aStrMessage :String? ,
                               completion : ((Int, String) -> Void)?) -> Void {
        
        self.showAlert(controller, aStrMessage: aStrMessage, style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: "Delete", otherButtonArr: nil, completion: completion)
        
    }
    
    
    
    /**
     Display an Actionsheet For ImagePicker
     
     - parameter controller:  Object of controller on which you need to display Alert
     - parameter aStrMessage: Message to display in Actionsheet
     - parameter completion:  Completion block. Delete Button Index - 0 | Cancel Button Index - 1
     */
    class func showActionsheetForImagePicker(_ controller : AnyObject ,
                                             aStrMessage :String? ,
                                             completion : ((Int, String) -> Void)?) -> Void {
        
        self.showAlert(controller, aStrMessage: aStrMessage, style: .actionSheet, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["Use Gallery", "Use Camera"], completion: completion)
        
    }
    
    
    /**
     Display an Actionsheet For ImagePicker
     
     - parameter controller:  Object of controller on which you need to display Alert
     - parameter aStrMessage: Message to display in Actionsheet
     - parameter completion:  Completion block. Delete Button Index - 0 | Cancel Button Index - 1
     */
    class func showActionsheetForImagePicker(_ controller : AnyObject ,
                                             position : CGRect,
                                             aStrMessage :String? ,
                                             completion : ((Int, String) -> Void)?) -> Void {
        
        self.showAlert(controller, position : position ,aStrMessage: aStrMessage, style: .actionSheet, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["Use Gallery", "Use Camera"], completion: completion)
        
    }
}

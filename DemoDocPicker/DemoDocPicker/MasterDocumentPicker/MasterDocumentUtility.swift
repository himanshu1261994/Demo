//
//  MasterDocumentUtility.swift
//  LawyerApp
//
//  Created by indianic on 19/04/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit
import SystemConfiguration
class MasterDocumentUtility: NSObject {
    
    
    class func getTimeStamp() -> String{
    
        return "\(Date().timeIntervalSince1970 * 1000)"
    }
    class func validateDocumentWith(url : URL,allowedFileTypes : [String],viewController : UIViewController) -> Bool {
        print(url.pathExtension.lowercased())
        if !(allowedFileTypes.contains(url.pathExtension.lowercased()))  {
            
            MasterDocumentUtility.showAlertWith(viewController: viewController, message: kErrorFileTypeNotAllowed)
            
            return false
            
        } else {
            
            do{
                let fileData = try Data(contentsOf: url)
                print("Size of Document is : \(Double(fileData.count) / 1048576.0) MB")
                if ((Double(fileData.count) / 1048576.0) > 7.0) {
                    
                    MasterDocumentUtility.showAlertWith(viewController: viewController, message: kErrorFileSizeLimit)
                    
                    return false
                    
                }
            }catch{
                MasterDocumentUtility.showAlertWith(viewController: viewController, message: kErrorSomethingWentWrong)
                return false
            }
        }
        return true
        
    }
    class func validateDocumentWith(url : URL?,viewController : UIViewController) -> Bool{
    
        if url == nil {
            
            MasterDocumentUtility.showAlertWith(viewController: viewController, message: kErrorFileNotExits)
            return false
        }
        
        if !FileManager.default.fileExists(atPath: (url?.path)!) {
            
            MasterDocumentUtility.showAlertWith(viewController: viewController, message: kErrorFileNotExits)
            return false
        }
        
    
        return true
    }
    class func showActionSheetWith(viewController : UIViewController,message : String,buttons : Array<String>,actionHandler : ((UIAlertAction,Int) -> Swift.Void)? = nil){
        let alert = UIAlertController(title: kAlertTitle, message: message, preferredStyle: .actionSheet)
        for (index,btnname) in buttons.enumerated() {
            
            let action : UIAlertAction = UIAlertAction(title: btnname, style: .default, handler: { (action) in
                actionHandler!(action,index)
            })
            alert.addAction(action)
        }
        let cancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func showAlertWith(viewController : UIViewController,message : String){
        let alert = UIAlertController(title: kAlertTitle, message: message, preferredStyle: .alert)
        let okAction : UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
        
    }
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
        
    }

    

}
extension UITableView{
    func reloadAnimationWithDirection(direction : UITableViewAnimationDirection) {
        self.reloadData()
        
        let cells = self.visibleCells
        let tblViewWidth = self.frame.size.width
        let tblViewHeight = self.frame.size.height
        
        for cell in cells {
            if direction == .left {
                cell.transform = CGAffineTransform(translationX: -tblViewWidth, y: 0)
            }else if direction == .right{
                cell.transform = CGAffineTransform(translationX: tblViewWidth, y: 0)
                
            }else if direction == .down{
                cell.transform = CGAffineTransform(translationX: 0, y: tblViewHeight)
            }else if direction == .up{
                
                cell.transform = CGAffineTransform(translationX: 0, y: -tblViewHeight)
            }
            
        }
        
        var delay = 0
        
        for cell in cells {
            UIView.animate(withDuration : 0.5, delay: Double(delay) * 0.05 , usingSpringWithDamping: 0.8, initialSpringVelocity : 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
                
            }, completion: nil)
            delay += 1
        }
        
        
    }
}

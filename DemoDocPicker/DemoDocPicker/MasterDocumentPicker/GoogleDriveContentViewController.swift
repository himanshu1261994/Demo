//
//  GoogleDriveContentViewController.swift
//  LawyerApp
//
//  Created by indianic on 24/04/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST
import GTMOAuth2
class GoogleDriveContentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,GIDSignInDelegate,GIDSignInUIDelegate {

    @IBOutlet var uploadView: UIView!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var documentTableView: UITableView!
    var arrDocumentDataSource : [GTLRDrive_File] = []
    var driveService = GTLRDriveService()
    var documentPickerMode : DocumentPickerMode = .documentImport
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellnib : UINib = UINib(nibName: kDocumentCellIdentifier, bundle: nil)
        documentTableView.register(cellnib, forCellReuseIdentifier: kDocumentCellIdentifier)
        
        if !GIDSignIn.sharedInstance().hasAuthInKeychain() {
            self.googleLogin()
        }else{
            let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychain(forName: kAuthKeyChainName, clientID: kClientID, clientSecret: nil)
           
            self.driveService.authorizer = auth
            self.loadDriveData(withFolderId: "root")
            
        }
        
      
        // Do any additional setup after loading the view.
    }
    func googleLogin() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeDrive]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDocumentDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MasterDocumentContentCell = (tableView.dequeueReusableCell(withIdentifier: kDocumentCellIdentifier) as? MasterDocumentContentCell)!
        let file = arrDocumentDataSource[indexPath.row]
        cell.contentTitle.text = file.name
        if file.mimeType == "application/vnd.google-apps.folder" {
            
            cell.imageView?.image = UIImage(named: kImageNameFolder)
            
        }else{
            cell.imageView?.image = UIImage(named: kImageNameFile)
        
        
        }
        

        return cell
    }
    func executeQuery(queryString:String, folderId:String, isBack:Bool){
        
        
        let query = GTLRDriveQuery_FilesList.query()
        query.pageSize = 1000
        query.q = queryString
        
        
        self.driveService.executeQuery(query,
                                       delegate: self,
                                       didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
    }
    
    func displayResultWithTicket(ticket: GTLRServiceTicket,
                                 finishedWithObject result : GTLRDrive_FileList,
                                 error : NSError?) {
        
        if let error = error {
            MasterDocumentUtility.showAlertWith(viewController: self, message: error.localizedDescription)
            return
        }
        print(result.files)
        arrDocumentDataSource.append(contentsOf: result.files!)
        self.documentTableView.reloadAnimationWithDirection(direction: .right)

        
        
        
    }
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error)
            return
        }else{
            GTMOAuth2ViewControllerTouch.saveParamsToKeychain(forName: kAuthKeyChainName, authentication: user.authentication.fetcherAuthorizer() as! GTMOAuth2Authentication!)
            loadDriveData(withFolderId: "root")
            
        }
    }
    func loadDriveData(withFolderId : String) {
        executeQuery(queryString: "(mimeType = 'application/vnd.google-apps.folder' or mimeType = 'image/jpeg' or mimeType = 'image/png' or mimeType = 'text/plain' or mimeType = 'application/pdf' or mimeType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document') and trashed=false", folderId: withFolderId, isBack: false)
    }
    
    
    @IBAction func btnUploadAction(_ sender: UIButton) {
        
        
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
    }
    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

   
}

//
//  ViewController.swift
//  StripeDemo
//
//  Created by indianic on 27/05/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit
import Stripe
class ViewController: UIViewController,STPAddCardViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnPay(_ sender: UIButton) {
        self.buyButtonTapped()
    }
    func buyButtonTapped() {
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: STPAddCardViewControllerDelegate
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {

    }

}


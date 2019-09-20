//
//  ViewController.swift
//  AustinWeirdSocial
//
//  Created by Luis Santos on 9/18/19.
//  Copyright © 2019 Luis Santos. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func facbookButtonTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("LUIS: Unable to authenticate with Facebook")
                
            }else if result?.isCancelled == true {
                print ("LUIS: User Cancelled Facebook Authintication")
                
            }else {
                print ("LUIS: Successfully authenticated with Facebook")
                
                let credentials = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credentials)
                
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
            if error != nil {
                print("LUIS: Unable to Authenticate with Firebase - \(error)")
                
            }else {
                print("LUIS: Successfully Authenticated with Firebase")
            }
        })
        
        
    }
    
}


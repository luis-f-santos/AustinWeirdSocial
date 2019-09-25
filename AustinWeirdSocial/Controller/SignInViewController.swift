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
import SwiftKeychainWrapper


class SignInViewController: UIViewController {

    @IBOutlet weak var emailField: ShadowField!
    
    @IBOutlet weak var passwordField: ShadowField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            
            performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
        
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
                if let authData = user {
                    
                    self.completeSignIn(id: authData.user.uid)
                }
                
            }
        })
        
        
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    
                    //NO errors, email and password match with firebase
                    print("LUIS: Email user authenticated with Firebase")
                    
                    if let authData = user {
                        self.completeSignIn(id: authData.user.uid)
                    }
                    
                } else {
                    
                    //TODO: still need to check if error is due to a wrong password entered etc...
                    
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            
                            //Couldn't create a new user due to... badpassword, email doesn't exist, etc...
                            //TODO: check error and display them to user
                            
                            print("LUIS: Unable to Authinticate with FireBase")
                        } else {
                            print("LUIS: Successfully authenticated with Firebase")
                            
                            if let authData = user {
                                self.completeSignIn(id: authData.user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String){
        
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
}


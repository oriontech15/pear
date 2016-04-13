//
//  LoginViewController.swift
//  Pear
//
//  Created by youcef bouhafna on 4/12/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//
import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase


class LoginViewController: UIViewController {
    
    @IBOutlet weak var pearLabel: UILabel!
    @IBOutlet weak var pearImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // if user is already logged in then save and perform segue to main view
        
//        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil {
//            self.performSegueWithIdentifier("", sender: nil)
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookLoginButtonTapped(sender: UIButton) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult, facebookError) in
            if facebookError != nil {
                print("Facebook Login Failed . Error\(facebookError)")
            } else if facebookResult.isCancelled {
                print("facebook login was cancelled")
            } else {
                let accessToken  = FBSDKAccessToken.currentAccessToken().tokenString
                print("successfully logged in with Facebook. \(accessToken)")
                FirebaseController.base.authWithOAuthProvider("facebook", token : accessToken, withCompletionBlock: { error, authData in
                    if error != nil {
                        print("login failed. \(error)")
                    } else {
                        print("logged in! \(authData)")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                        print("100 % working")
                    }
                    
                    
                })
            }
            
        }
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}

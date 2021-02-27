//
//  LogInViewController.swift
//  Twitter
//
//  Created by Nancy Ng  on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            //run segway right away when logged in
            self.performSegue(withIdentifier: "StoryboardtoLogin", sender: self)
        }
    }
    //IBAction will print out that the button was pressed. i'm checking to see if the button works
    @IBAction func LoginButton(_ sender: Any) {
        print("button pressed")
        
        let twitter_token_url = "https://api.twitter.com/oauth/request_token"
        
        //redirects you to the link to log in to twitter and auth log in
        TwitterAPICaller.client?.login(
            url: twitter_token_url,
            success: {
                //allows users to stay logged in
                //user default allows app to remember when you opened the app
                UserDefaults.standard.setValue(
                    true,
                    forKey: "userLoggedIn")
                //remember Me key goes to viewDidAppear above
                
                self.performSegue(withIdentifier: "StoryboardtoLogin", sender: self)
            },
            failure: { (Error) in
                print("failed to log in.")
            })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

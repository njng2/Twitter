//
//  TweetViewController.swift
//  Twitter
//
//  Created by Nancy Ng  on 3/3/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController,UITextViewDelegate {
    //text field for tweet
    @IBOutlet weak var ComposeTweet: UITextView!
    @IBOutlet weak var CharacterCount: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ComposeTweet.becomeFirstResponder()
        ComposeTweet.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 280

        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)

        CharacterCount.text = "\(newText.count)/280"
        
        // TODO: Update Character Count Label

        // The new text should be allowed? True/False
        return newText.count < characterLimit
        
        
        
    }
    
    //cancel button to go back
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func TweetButton(_ sender: Any) {
        //checking if TweetztextView is empty
        if(!ComposeTweet.text.isEmpty){
            TwitterAPICaller.client?.postTweet(
                tweetString: ComposeTweet.text,
                success: {
                    //dismiss on completion of tweet
                    self.dismiss(animated: true, completion: nil)
                },
                failure: { (error) in
                    print("Unable to tweet message.\(error)")
                }
            )
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
        
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

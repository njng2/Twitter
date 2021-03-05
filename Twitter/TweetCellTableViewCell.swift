//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Nancy Ng  on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TweetTitle: UILabel!
    @IBOutlet weak var TweetBody: UILabel!
    @IBOutlet weak var TweetImage: UIImageView!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var RetweetButton: UIButton!
    var isLiked:Bool = false
    var TweetID:Int = -1
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func Retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(
            tweetId: TweetID,
            success: {
                self.setRetweeted(true)
            },
            failure: { (error) in
                print("Error in retweeting: \(error)")
            })
      
    }
    
    func setRetweeted(_ isRetweeted: Bool){
        //if it is retweeted set the retweet button to green
        if(isRetweeted){
        RetweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
        RetweetButton.isEnabled = false
        }
        else{
            RetweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            RetweetButton.isEnabled = true
            
        }
        
    }
    
    @IBAction func likedTweet(_ sender: Any) {
        let toBeFavorited = !isLiked
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(
                tweetId: TweetID,
                success: {
                    self.setFavorite(true)
                },
                failure: { (error) in
                    print("Favorite did not work")
                })
            
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(
                tweetId: TweetID,
                success: {
                    self.setFavorite(false)
                },
                failure: { (error) in
                    print("unfavorited did not work.\(error)")
                })
        }
    }
    
    func setFavorite(_ isFavorited: Bool){
        isLiked = isFavorited
        
        
        if(isLiked){
            LikeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
            
        }
        else{
            LikeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
            
        }
        
    }
    
}

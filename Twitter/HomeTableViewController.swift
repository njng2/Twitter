//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Nancy Ng  on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {


    var tweetDictionary = [NSDictionary]()
    var numberofTweets: Int!
    
    let UserRefreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()

        UserRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = UserRefreshControl;
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    @objc func loadTweets(){
        
        numberofTweets = 20
        let TwitterURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        let myParam = ["count": numberofTweets] //accesing count in our dictionary
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: TwitterURL, parameters:myParam,
                                                        success:
                                                            { (tweets:[NSDictionary]) in
                                                                self.tweetDictionary.removeAll()
                                                                for tweet in tweets{
                                                                    self.tweetDictionary.append(tweet)
                                                                }
                                                                self.tableView.reloadData()
                                                                self.UserRefreshControl.endRefreshing()
                                                                
                                                                
                                                            },
                                                        failure:
                                                            { (Error) in
                                                                print("could not retrieve tweet")
                                                            })
       
    }
    
    
    func infiniteScroll(){
        let TwitterURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberofTweets = numberofTweets + 20//increment by 20
        
        let myParam = ["count": numberofTweets] //accesing count in our dictionary
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: TwitterURL, parameters:myParam,
                                                        success:
                                                            { (tweets:[NSDictionary]) in
                                                                self.tweetDictionary.removeAll()
                                                                for tweet in tweets{
                                                                    self.tweetDictionary.append(tweet)
                                                                }
                                                                self.tableView.reloadData()
                                                                
                                                                
                                                                
                                                            },
                                                        failure:
                                                            { (Error) in
                                                                print("could not retrieve tweet")
                                                            })
        
    }
    
    //calls infinite scroll when they get to the end of the page
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetDictionary.count{
            infiniteScroll()
        }
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        print("logged out")
        //checks if user is already logged in
        UserDefaults.standard.setValue(false, forKey: "userLoggedIn")
        TwitterAPICaller.client?.logout()
        //calling method in API caller to call logout
        
        //screen is dismiss itself
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCellTableViewCell
        
        //calls the user key from our twitter dictionary
        let user = tweetDictionary[indexPath.row]["user"] as! NSDictionary
        
        
        //calls the user key and gets name from dictionary
        cell.TweetTitle.text = user["name"] as? String
        cell.TweetBody.text = tweetDictionary[indexPath.row]["text"] as? String
        
        //setting up the image
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data{
            cell.TweetImage.image = UIImage(data: imageData)
        }
        
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetDictionary.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

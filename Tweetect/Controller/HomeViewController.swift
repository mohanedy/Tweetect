//
//  ViewController.swift
//  Tweetect
//
//  Created by Mohaned Yossry on 5/5/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
class HomeViewController: UIViewController {
    @IBOutlet weak var feelImageView: UIImageView!
    
    let classifier = TweetectClassifier()
    
    var tweets:[TweetDatum]=[]
    var predictions:[TweetFeel]=[]
    
 
    @IBOutlet weak var tableView: UITableView!
    
    let swifter = Swifter(consumerKey:K.APIKey, consumerSecret: K.APISecretKey)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        tableView.dataSource = self
        
        
    }
    
    //MARK: - Load tweets from twitter API
    func loadTweets(keyword:String){
     
        var total = 0
        swifter.searchTweet(using: "\(keyword)", lang: "en",count: 300,tweetMode: .extended , success: { (results, metadata) in
            let decoder =  JSONDecoder()
            do{
                self.tweets = try decoder.decode([TweetDatum].self, from: Data(results.description.utf8))
                let textTweets = self.tweets.map { (tweet) -> TweetectClassifierInput in
                    return TweetectClassifierInput(text: tweet.text)
                }
                let classifierPredictions = try self.classifier.predictions(inputs: textTweets)
                self.predictions = classifierPredictions.map({ (predict) -> TweetFeel in
                    let feel = TweetFeel.initialize(stringValue: predict.label.capitalized)
                
                    switch(feel){
                    case .positive:
                        total += 1
                        break
                    case .negative:
                        total -= 1
                        break
                    case .neutral:
                        total += 0
                        break
                    }
                    return feel
                })
                
                self.tableView.reloadData()
                DispatchQueue.main.async {
                      print(total)
                    if total > 20{
                        self.feelImageView.image = UIImage(named: "love")
                    }else if total > 0{
                        self.feelImageView.image = UIImage(named: "Pos")
                    }else if total < 0 {
                      
                        self.feelImageView.image = UIImage(named: "Neg")
                    }else{
                        self.feelImageView.image = UIImage(named: "Neutral")
                    }
                }
            }catch{
                print(error)
            }
            
        }) { (error) in
            print(error)
        }
    }
    
    
}

//MARK: - TableView Delegate Methods

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        cell.feel = predictions[indexPath.row]
        
        return cell
    }
    
    
}
//MARK: - SearchBar Delegate
extension HomeViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text =  searchBar.text{
            if text != ""{
                      loadTweets(keyword: text)
            }
      
        }
    }
}

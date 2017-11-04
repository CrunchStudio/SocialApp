//
//  ProfileViewController.swift
//  SocialApp
//
//  Created by Crunch Cubes on 11/1/17.
//  Copyright © 2017 Crunch Cubes. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var profileImageURL: String!
    var profileName: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Keep
         /*self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)*/
        profileImage.image=UIImage(named: "loading")
        self.navigationController!.navigationBar.topItem!.title = "Back"
        self.navigationItem.title = "Profile"
        
        
        get_image(profileImageURL, profileImage)
        userNameLabel.text = profileName
    }
    
    public func setProfile(_ profileName:String, _ profileImageURL:String){
        self.profileName = profileName
        self.profileImageURL = profileImageURL
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func get_image(_ url_str:String, _ imageView:UIImageView)
    {
        let rand = String(arc4random_uniform(9999) + 999);
        let url:URL = URL(string: (url_str + "?" + rand))!
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            
            if data != nil
            {
                let image = UIImage(data: data!)
                
                if(image != nil)
                {
                    
                    DispatchQueue.main.async(execute: {
                        
                        imageView.image = image
                        imageView.alpha = 0
                        
                        UIView.animate(withDuration: 2.5, animations: {
                            imageView.alpha = 1.0
                        })
                        
                    })
                    
                }
                
            }
            
            
        })
        
        task.resume()
    }

}

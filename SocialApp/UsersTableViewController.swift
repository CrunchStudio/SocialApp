//
//  UsersTableViewController.swift
//  SocialApp
//
//  Created by Crunch Cubes on 10/8/17.
//  Copyright © 2017 Crunch Cubes. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    //@IBOutlet weak

    //@IBOutlet var SearchBar: UITableView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*var newUser = User(name: "Emerald Bay", filename: "emeraldbay", notes: "Emerald Bay, one of Lake Tahoe's most popular and photogenic locations.")
        users.append(newUser)
        
        newUser = User(name: "A Joshua Tree", filename: "joshuatree", notes: "A Joshua Tree in the Mojave Desert")
        users.append(newUser)
 */
        URLCache.shared.removeAllCachedResponses()
        geuUsers()
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentUser = users[indexPath.row]
        cell.textLabel?.text = currentUser.name
        cell.detailTextLabel?.text = currentUser.description
        cell.imageView?.image = UIImage(named:"profile")
        
        let imageLoader = ImageCacheLoader()
        
       imageLoader.obtainImageWithPath(imagePath: currentUser.thumbNailImageURL) { (image) in
            // Before assigning the image, check whether the current cell is visible
            if let updateCell = tableView.cellForRow(at: indexPath) {
                updateCell.imageView?.image = image
            }
        }


        return cell
    }
    
    func geuUsers () {
        User.forecast(withLocation: "", completion: { (results:[User]?) in
            
            if let weatherData = results {
                self.users = weatherData
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "ProfileViewController", sender:self)
        //self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")
        let currentUser = users[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"ProfileViewController") as! ProfileViewController
        viewController.setProfile(currentUser.name, currentUser.imageURL)
        
        //self.present(viewController, animated: true)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}

//
//  NoteController.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 19/06/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//

import UIKit

class NoteController: UITableViewController {
    var note: Note?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       textName.text = note?.name
       textDescription.text = note?.textDescription
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if textName.text == "" && textDescription.text == "" {
            CoreDataManager.sharedInstance.managedObjectContext.delete(note!)
            CoreDataManager.sharedInstance.saveContext()
            return
        }
        
        if note?.name != textName.text ||
            note?.textDescription != textDescription.text {
            note?.dateUpdate = NSDate()
        }
        note?.name = textName.text
        note?.textDescription = textDescription.text
        CoreDataManager.sharedInstance.saveContext()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 0 {
          let alertController = UIAlertController(title: "Edit Image", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            
            let a1Camera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default, handler: {(alert) in print("Camera")})
            
            let a2Photo = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default, handler: {(alert) in print("альбом")})
            
            let a3Delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: {(alert) in self.imageView.image = nil})
            
            let a4Cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {(alert) in })
            
            alertController.addAction(a1Camera)
            alertController.addAction(a2Photo)
            alertController.addAction(a3Delete)
            alertController.addAction(a4Cancel)
            
            present(alertController,animated: true, completion: nil)
        }
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

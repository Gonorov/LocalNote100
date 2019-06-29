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
    
    @IBOutlet weak var labelFolder: UILabel!
    @IBOutlet weak var labelFolderName: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       textName.text = note?.name
       textDescription.text = note?.textDescription
       imageView.image = note?.imageActual
        navigationItem.title = note?.name
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let folder = note?.folder {
            labelFolderName.text = folder.name
        } else {
                labelFolderName.text = "-"
             }
   }
    
    @IBAction func pushDoneAction(_ sender: AnyObject) {
        saveNote()
        _ = navigationController?.popViewController(animated: true)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        
//        
//    }

    func saveNote() {
        if textName.text == "" && textDescription.text == "" &&
            imageView.image == nil {
            CoreDataManager.sharedInstance.managedObjectContext.delete(note!)
            CoreDataManager.sharedInstance.saveContext()
            return
        }
        
        if note?.name != textName.text ||
            note?.textDescription != textDescription.text
            
        {
            note?.dateUpdate = NSDate()
        }
        note?.name = textName.text
        note?.textDescription = textDescription.text
        note?.imageActual = imageView.image
        
        CoreDataManager.sharedInstance.saveContext()
    }
    
    // MARK: - Table view data source
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 && indexPath.section == 0 {
          let alertController = UIAlertController(title: "Edit Image", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            
            let a1Camera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default, handler: {(alert) in
                //print("Camera")
                self.imagePicker.sourceType = .camera
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
                
            })
            alertController.addAction(a1Camera)
            
            let a2Photo = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default, handler: {(alert) in
                //print("альбом")
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(a2Photo)
            
            if self.imageView.image != nil {
                
                let a3Delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: {(alert) in self.imageView.image = nil})
                alertController.addAction(a3Delete)
            }
            
            let a4Cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {(alert) in })
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


extension NoteController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { // The info dictionary may contain multiple representations of the image. You want to use the original. guard let selectedImage = info[.originalImage] as? UIImage else { fatalError("Expected a dictionary containing an image, but was provided the following: \(info)") } // Set photoImageView to display the selected image. photoImageView.image = selectedImage // Dismiss the picker. dismiss(animated: true, completion: nil) }
        imageView.image = info[.originalImage] as? UIImage
         picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}

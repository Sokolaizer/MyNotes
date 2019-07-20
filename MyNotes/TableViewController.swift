//
//  NotepadTableViewController.swift
//  MyNotes
//
//  Created by Рома on 17/07/2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  
  
  private var notebook = FileNotebook()
  private let cellIdentifier = "Cell"
  private let toAddVCSegueIdentifier = "toAddViewController"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    notebook.load()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  @IBAction func addNoteButton(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: toAddVCSegueIdentifier, sender: self)
  }
  @IBAction func editNotesButton(_ sender: UIBarButtonItem) {
    tableView.isEditing = !tableView.isEditing
  }
  
  // MARK: - Table view data source
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return notebook.notes.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    let note = notebook.notes[indexPath.row]
    cell.textLabel?.text = note.title
    cell.detailTextLabel?.text = note.content
    cell.imageView?.backgroundColor = note.color
    
    return cell
  }
  
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
    let uid = notebook.notes[indexPath.row].uid
    notebook.remove(with: uid)
    notebook.save()
   tableView.deleteRows(at: [indexPath], with: .fade)
   }
  }
  
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
  
  
   // MARK: - Navigation
   

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == toAddVCSegueIdentifier else {return}
    let destination = segue.destination as? AddViewController
    destination!.notebook = notebook
  }
  
  
}

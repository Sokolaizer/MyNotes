//
//  ColorPickerViewController.swift
//  MyNotes
//
//  Created by Рома on 18/07/2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {
  var pickedColor: UIColor?
  @IBOutlet weak var colorPickerView: ColorPickerView! {
    didSet {
      colorPickerView.isHidden = false
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    colorPickerView.isHidden = false
    
    colorPickerView.delegate = self
    

        // Do any additional setup after loading the view.
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
extension ColorPickerViewController : ColorPickerDelegate {
  func doneButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  func colorPicked(sender: ColorPicker, color: UIColor) {
    pickedColor = color
  }
  
  
}


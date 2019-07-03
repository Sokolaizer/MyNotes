//
//  ViewController.swift
//  MyNotes
//
//  Created by Roman Kozlov on 27.06.2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBOutlet weak var contentTextView: UITextView!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBAction func useDestroyDate(_ sender: UISwitch) {
      datePicker.isHidden = !sender.isOn
  }
  
}


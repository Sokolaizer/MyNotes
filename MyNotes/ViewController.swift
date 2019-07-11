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
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  @objc func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    
    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    
    if notification.name == UIResponder.keyboardWillHideNotification {
      scrollView.contentInset = .zero
    } else {
      scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
    }
    
    scrollView.scrollIndicatorInsets = scrollView.contentInset
    
  }
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentTextView: UITextView!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBAction func useDestroyDate(_ sender: UISwitch) {
      datePicker.isHidden = !sender.isOn
  }
  @IBOutlet weak var whiteSample: ColorSampleView! {
    didSet {
      whiteSample.isMarked = true
    }
  }
  
}


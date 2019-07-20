
import UIKit

class AddViewController: UIViewController {
  private let colorPickerViewControllerSegue = "toColorPickerViewController"
  var notebook = FileNotebook()
  private var color = UIColor.white
  private var destroyDate: Date?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    colorPickerView.delegate = self
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
  @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
  @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    guard let title = titleTextField.text else {return}
    let note = Note(title: title,
                    content: contentTextView.text,
                    color: color,
                    importance: .regular,
                    selfDestructDate: destroyDate)
    notebook.add(note)
    notebook.save()
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func customSampleViewLongPressed(_ sender: UILongPressGestureRecognizer) {
//    colorPickerView.isHidden = false
//    let cpViewVC = ColorPickerViewController()
//    cpViewVC.colorPickerView = colorPickerView
//    navigationController?.pushViewController(cpViewVC, animated: true)
    performSegue(withIdentifier: colorPickerViewControllerSegue, sender: self)
  }
  @IBAction func whiteSampleViewTapped(_ sender: UITapGestureRecognizer) {
    markView(whiteSample)
  }

  @IBAction func redSampleViewTapped(_ sender: UITapGestureRecognizer) {
    markView(redSample)
  }
  @IBAction func greenSampleViewTapped(_ sender: UITapGestureRecognizer) {
    markView(greenSample)
  }
  @IBAction func customSampleViewTapped(_ sender: UITapGestureRecognizer) {
    if customSample.backgroungImage.isHidden {
      markView(customSample)
    }
  }
  private func markView(_ markedView: ColorSampleView) {
    sampleViews.forEach { $0.isMarked = false }
    markedView.isMarked = true
    sampleViews.forEach { $0.setNeedsDisplay() }
    guard let markedColor = markedView.backgroundColor else {return}
    color = markedColor
  }
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var colorPickerView: ColorPickerView!
  @IBOutlet var sampleViews: [ColorSampleView]!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentTextView: UITextView!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBAction func useDestroyDate(_ sender: UISwitch) {
      datePicker.isHidden = !sender.isOn
    guard sender.isOn else {return}
    destroyDate = datePicker.date
  }
  @IBOutlet weak var whiteSample: ColorSampleView! {
    didSet {
      whiteSample.isMarked = true
    }
  }
  @IBOutlet weak var redSample: ColorSampleView!
  @IBOutlet weak var greenSample: ColorSampleView!
  @IBOutlet weak var customSample: ColorSampleView! {
    didSet {
      customSample.setAsCustom()
    }
  }

}


extension AddViewController : ColorPickerDelegate {
  func doneButtonTapped() {
    print("TAPPED")
  }
  
  
  func colorPicked(sender: ColorPicker, color: UIColor) {
    customSample.backgroungImage.isHidden = true
    customSample.backgroundColor = color
    markView(customSample)
  }
}

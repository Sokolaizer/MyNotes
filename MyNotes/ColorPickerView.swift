
import UIKit

internal protocol ColorPickerDelegate {
  func colorPicked(sender:ColorPicker, color:UIColor)
  func doneButtonTapped()
}

class ColorPickerView: UIView {
  
  internal var delegate: ColorPickerDelegate?
  let saturationExponent:Float = 1.0
  let elementSize: CGFloat = 1.0
  var brightnessValue: CGFloat = 0.7
  var hue: CGFloat = 0.5
  var saturation: CGFloat = 0.5
  var chosenColor: UIColor? {
    didSet {
      currentColorView.backgroundColor = chosenColor
      hexValueLabel.text = chosenColor?.hexValue
      delegate?.colorPicked(sender: colorPeaker, color: chosenColor!)
    }
  }

  @IBOutlet weak var brightness: UISlider!
  @IBOutlet weak var sight: UIImageView!
  
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var hexValueLabel: UILabel!
  @IBOutlet weak var currentColorView: UIView! {
    didSet{
      currentColorView.layer.cornerRadius = 8.0
      currentColorView.layer.borderColor = UIColor.black.cgColor
      currentColorView.layer.borderWidth = 1.0
    }
  }
  
  @IBOutlet weak var colorPeaker: ColorPicker!
  
  func setup() {
    Bundle.main.loadNibNamed("ColorPickerView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    chosenColor = UIColor(hue: hue, saturation: saturation, brightness: brightnessValue, alpha: 1.0)
    let pan = UIPanGestureRecognizer(target: self, action: #selector(touchedColor(gestureRecognizer:)))
    let tap = UITapGestureRecognizer(target: self, action: #selector(tappedColor(gestureRecognizer:)))
    colorPeaker.addGestureRecognizer(pan)
    colorPeaker.addGestureRecognizer(tap)
    self.isHidden = true
  }
  
  
  @IBAction func brightnessAction(_ sender: UISlider) {
    if sender == brightness && !sender.isContinuous {
      brightnessValue = CGFloat(sender.value)
      chosenColor = UIColor(hue: hue, saturation: saturation, brightness: CGFloat(brightnessValue), alpha: 1.0)
    }
  }
  
  func getColorAtPoint(point:CGPoint) -> UIColor {
    let roundedPoint = CGPoint(x:elementSize * CGFloat(Int(point.x / elementSize)),
                               y:elementSize * CGFloat(Int(point.y / elementSize)))
    
    
    saturation = CGFloat(colorPeaker.bounds.height - roundedPoint.y) / colorPeaker.bounds.height
    saturation = CGFloat(powf(Float(saturation), saturationExponent))
    hue = roundedPoint.x / colorPeaker.bounds.width
    return UIColor(hue: hue, saturation: saturation, brightness: CGFloat(brightnessValue), alpha: 1.0)
  }
  
  @objc func touchedColor(gestureRecognizer: UIPanGestureRecognizer){
    let point = gestureRecognizer.location(in: colorPeaker)
    sight.center = point
    chosenColor = getColorAtPoint(point: point)
  }
  
  @objc func tappedColor(gestureRecognizer: UITapGestureRecognizer){
    let point = gestureRecognizer.location(in: colorPeaker)
    sight.center = point
    chosenColor = getColorAtPoint(point: point)
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  @IBAction func doneTapped(_ sender: UIButton) {
    delegate?.doneButtonTapped()
    
  }
  

}

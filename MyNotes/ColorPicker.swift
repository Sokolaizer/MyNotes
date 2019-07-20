

import UIKit



@IBDesignable
class ColorPicker : UIView {
  
  let saturationExponent:Float = 1.0
  let elementSize: CGFloat = 1.0
  
  
  private func setup() {
    self.clipsToBounds = true
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    
    for y in stride(from: (0 as CGFloat), to: rect.height, by: elementSize) {
      var saturation = CGFloat(rect.height - y) / rect.height
      saturation = CGFloat(powf(Float(saturation), saturationExponent))
      for x in stride(from: (0 as CGFloat), to: rect.width, by: elementSize) {
        let hue = x / rect.width
        let color = UIColor(hue: hue, saturation: saturation, brightness: 0.7, alpha: 1.0)
        context!.setFillColor(color.cgColor)
        context!.fill(CGRect(x:x, y:y, width:elementSize,height:elementSize))
      }
    }
  }
}

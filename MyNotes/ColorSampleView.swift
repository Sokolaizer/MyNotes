

import UIKit

class ColorSampleView: UIView, UIGestureRecognizerDelegate {
  var isMarked = false
  let backgroungImage = UIImageView(image: UIImage(named: "gradient"))
  
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    let markCenter = CGPoint(x: bounds.maxX - 18.0, y: bounds.minY + 18.0 )
    let path = UIBezierPath()
    path.addArc(withCenter: markCenter, radius: 12.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    path.move(to: CGPoint(x: bounds.maxX - 12.0 , y: bounds.minY + 10.0 ))
    path.addLine(to: CGPoint(x: bounds.maxX - 18.0, y:bounds.minY  + 24.0))
    path.addLine(to: CGPoint(x: bounds.maxX - 26.0, y: bounds.minY + 18.0))
    if isMarked {
      path.lineWidth = 3.8
      UIColor.white.setStroke()
      path.stroke()
      path.lineWidth = 3.0
      UIColor.black.setStroke()
      path.stroke()
    }
  }
  
  func setAsCustom() {
    addSubview(backgroungImage)
    let constraints = [
      backgroungImage.topAnchor.constraint(equalTo: self.topAnchor),
      backgroungImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      backgroungImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      backgroungImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
    backgroungImage.translatesAutoresizingMaskIntoConstraints = false

    
  }
  
  func setup() {
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 2.0
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  

}

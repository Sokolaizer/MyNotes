//
//  ColorSampleView.swift
//  MyNotes
//
//  Created by Roman Kozlov on 03.07.2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import UIKit

class ColorSampleView: UIView, UIGestureRecognizerDelegate {
  var isMarked = false
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    let markCenter = CGPoint(x: bounds.maxX - 18.0, y: bounds.minY + 18.0 )
    let path = UIBezierPath()
    path.addArc(withCenter: markCenter, radius: 12.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    path.move(to: CGPoint(x: bounds.maxX - 12.0 , y: bounds.minY + 10.0 ))
    path.addLine(to: CGPoint(x: bounds.maxX - 18.0, y:bounds.minY  + 24.0))
    path.addLine(to: CGPoint(x: bounds.maxX - 26.0, y: bounds.minY + 18.0))
    path.lineWidth = 3.0
    UIColor.black.setStroke()
    if isMarked {
    path.stroke()
    }
  }
  
  func setup() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
    tap.delegate = self
    self.addGestureRecognizer(tap)

    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 2.0
  }
  
  @objc func tap(sender: UITapGestureRecognizer) {
    isMarked = !isMarked
    setNeedsDisplay()
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

//
//  ColorSampleView.swift
//  MyNotes
//
//  Created by Roman Kozlov on 03.07.2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import UIKit

class ColorSampleView: UIView {
  let borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
  
  func setup(with color: UIColor, and marked: Bool) {
    self.layer.cornerRadius = 8.0
    self.layer.borderColor = borderColor.cgColor
    self.layer.borderWidth = 5.0
    self.backgroundColor = color
    
    let markCenter = CGPoint(x: -25.0, y: 25.0)
    let path = UIBezierPath()
    path.addArc(withCenter: markCenter, radius: 12.0, startAngle: 0, endAngle: .pi, clockwise: true)
    path.close()
    UIColor.green.setStroke()
  }
  

}

import UIKit
extension Note {
  static func parse(json: [String: Any]) -> Note? {
    let importanceValue = json["importance"] as? String ?? "regular"
    guard !json.isEmpty,
      let importance = Importance(rawValue: importanceValue),
      let uid = json["uid"] as? String,
      let title = json["title"] as? String,
      let content = json["content"] as? String else { return nil }
    let color = json["color"] as? String ?? UIColor.white.hexValue
    let selfDestructDate: Date?
    if let selfDestructDateValue = json["selfDestructDate"] as? Double {
      selfDestructDate = Date(timeIntervalSince1970: selfDestructDateValue)
    } else {
      selfDestructDate = nil
    }
    let note = Note(uid: uid,
                    title: title,
                    content: content,
                    color: UIColor(hex: color),
                    importance: importance,
                    selfDestructDate: selfDestructDate)
    return note
  }
  var json: [String: Any] {
    var dictionary = [String: Any]()
    dictionary["uid"] = uid
    dictionary["title"] = title
    dictionary["content"] = content
    if color.hexValue != UIColor.white.hexValue{
      dictionary["color"] = color.hexValue
    }
    if importance != .regular {
      dictionary["importance"] = importance.rawValue
    }
    guard let selfDestructDate = selfDestructDate else { return dictionary }
    dictionary["selfDestructDate"] = selfDestructDate.timeIntervalSince1970
    return dictionary
  }
}

extension UIColor {
  
  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
    let blue = CGFloat((hex & 0xFF)) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
  
  convenience init(hex string: String, alpha: CGFloat = 1.0) {
    var hex = string.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if hex.hasPrefix("#") {
      let index = hex.index(hex.startIndex, offsetBy: 1)
      hex = String(hex[index...])
    }
    
    if hex.count < 3 {
      hex = "\(hex)\(hex)\(hex)"
    }
    
    if hex.range(of: "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .regularExpression) != nil {
      if hex.count == 3 {
        
        let startIndex = hex.index(hex.startIndex, offsetBy: 1)
        let endIndex = hex.index(hex.startIndex, offsetBy: 2)
        
        let redHex = String(hex[..<startIndex])
        let greenHex = String(hex[startIndex..<endIndex])
        let blueHex = String(hex[endIndex...])
        
        hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
      }
      
      let startIndex = hex.index(hex.startIndex, offsetBy: 2)
      let endIndex = hex.index(hex.startIndex, offsetBy: 4)
      let redHex = String(hex[..<startIndex])
      let greenHex = String(hex[startIndex..<endIndex])
      let blueHex = String(hex[endIndex...])
      
      var redInt: CUnsignedInt = 0
      var greenInt: CUnsignedInt = 0
      var blueInt: CUnsignedInt = 0
      
      Scanner(string: redHex).scanHexInt32(&redInt)
      Scanner(string: greenHex).scanHexInt32(&greenInt)
      Scanner(string: blueHex).scanHexInt32(&blueInt)
      
      self.init(red: CGFloat(redInt) / 255.0,
                green: CGFloat(greenInt) / 255.0,
                blue: CGFloat(blueInt) / 255.0,
                alpha: CGFloat(alpha))
    }
    else {
      self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    }
  }
  
  var hexValue: String {
    var color = self
    
    if color.cgColor.numberOfComponents < 4 {
      let c = color.cgColor.components!
      color = UIColor(red: c[0], green: c[0], blue: c[0], alpha: c[1])
    }
    if color.cgColor.colorSpace!.model != .rgb {
      return "#FFFFFF"
    }
    let c = color.cgColor.components!
    return String(format: "#%02X%02X%02X", Int(c[0]*255.0), Int(c[1]*255.0), Int(c[2]*255.0))
  }
}

//
//  ViewController.swift
//  emkapustin@PW1
//
//  Created by Egor Kapustin on 01.10.2022.
//

import UIKit;

class ViewController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var colorsSet = CreateColorsSet()
        SetViewsBgColor(colors: &colorsSet, corenerRaduis: 16)
    }
    
    @IBAction func ChangeColorButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false

        var colorsSet = CreateColorsSet()
        
        UIView.animate(withDuration: 1, animations: {
            self.SetViewsBgColor(colors: &colorsSet, corenerRaduis: 16)
        }) { completion in
            button?.isEnabled = true
        }
    }
    
    private func CreateColorsSet() -> Set<UIColor> {
        var colorsSet = Set<UIColor>()
        while colorsSet.count < views.count {
            colorsSet.insert(GetRandomUIColor())
        }
        return colorsSet
    }
    
    private func SetViewsBgColor(colors: inout Set<UIColor>, corenerRaduis: CGFloat) {
        for view in self.views {
            view.layer.cornerRadius = corenerRaduis
            view.backgroundColor = colors.popFirst()
        }
    }
    
    private func GetRandomUIColor() -> UIColor {
        return UIColor(
            rgb: Int.random(in: 0x000000...0xffffff)
        )
    }
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

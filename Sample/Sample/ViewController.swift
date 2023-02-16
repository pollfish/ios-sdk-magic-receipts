//
//  ViewController.swift
//  Sample
//
//  Created by Fotis Mitropoulos on 16/2/23.
//

import UIKit
import MagicReceipts

class ViewController: UIViewController, MagicReceiptsDelegate {
    
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var incentiveModeSwitch: UISwitch!

    func disableButtons() {
        showButton.isEnabled = false
        hideButton.isEnabled = false
    }
    
    func enableButtons() {
        showButton.isEnabled = true
        hideButton.isEnabled = true
    }
    
    @IBAction func onInitializeClick(_ sender: Any) {
        MagicReceipts.initialize(with: Params("10").userId("pollfish-fotis").incentiveMode(incentiveModeSwitch.isOn), delegate: self)
        disableButtons()
    }
    
    @IBAction func onShowClick(_ sender: Any) {
        MagicReceipts.show()
    }
    
    @IBAction func isSdkReady(_ sender: Any) {
        showToast(message: "Is SDK ready: \(MagicReceipts.isReady())")
    }
    
    @IBAction func onHideClick(_ sender: Any) {
        MagicReceipts.hide()
    }
    
    func onWallDidLoad() {
        showToast(message: "Magic Receipts Wall loaded")
        enableButtons()
    }
    
    func onWallDidFailToLoad(error: MagicReceiptsLoadError) {
        showToast(message: "Magic Receipts Wall failed to load: \(error)")
    }
    
    func onWallDidFaildToShow(error: MagicReceiptsShowError) {
        showToast(message: "Magic Receipts Wall failed to show: \(error)")
    }
    
    func onWallDidShow() {
        showToast(message: "Magic Receipts Wall opened")
    }
    
    func onWallDidHide() {
        showToast(message: "Magic Receipts Wall closed")
    }
    
}

extension UIViewController {

    private var keyWindow: UIWindow? {
        get {
            if #available(iOS 15, *) {
                return UIApplication
                    .shared
                    .connectedScenes
                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                    .first
            } else {
                return UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }
            }
        }
    }
    
    func showToast(message: String, seconds: Int = 3) {
        guard let window = keyWindow else {
            return
        }
        if let toast = window.subviews.first(where: { $0 is UILabel && $0.tag == -1001 }) {
            toast.removeFromSuperview()
        }
        
        let toastView = UILabel()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.textColor = UIColor.white
        toastView.textAlignment = .center
        toastView.font = UIFont(name: "Font-name", size: 17)
        toastView.layer.cornerRadius = 25
        toastView.text = message
        toastView.numberOfLines = 0
        toastView.alpha = 0
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.tag = -1001
        
        window.addSubview(toastView)
        
        let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0)
        
        let widthContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: (self.view.frame.size.width - 25) )
        
        let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=200)-[toastView(==50)]-68-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["toastView": toastView])
        
        NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
        NSLayoutConstraint.activate(verticalContraint)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastView.alpha = 1
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds), execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 0
            }, completion: { finished in
                toastView.removeFromSuperview()
            })
        })
    }
    
}
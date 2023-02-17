//
//  ViewController.swift
//  Sample
//
//  Created by Fotis Mitropoulos on 16/2/23.
//

import UIKit
import MagicReceipts

class ViewController: UIViewController {
    
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var incentiveModeSwitch: UISwitch!
    @IBOutlet weak var headerBackgroundView: UIView!
    @IBOutlet weak var headerBackgroundCircleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerBackgroundCircleView.addGradientBackground(
            start: #colorLiteral(red: 0.682, green: 0.231, blue: 0.922, alpha: 1).cgColor,
            end: #colorLiteral(red: 0.384, green: 0.369, blue: 1.0, alpha: 1).cgColor,
            startPoint: CGPoint(x: 0, y: 1),
            endPoint: CGPoint(x: 1, y: 0)
        )
        headerBackgroundView.addGradientBackground(
            start: #colorLiteral(red: 0.227, green: 0.180, blue: 0.498, alpha: 1).cgColor,
            end: #colorLiteral(red: 0.055, green: 0.145, blue: 0.459, alpha: 1).cgColor,
            startPoint: CGPoint(x: 0.5, y: 1),
            endPoint: CGPoint(x: 0.5, y: 0))
    }
    
    override func viewDidLayoutSubviews() {
        headerBackgroundCircleView.layer.cornerRadius = headerBackgroundCircleView.layer.bounds.width / 2
    }
    
    func disableButtons() {
        showButton.isEnabled = false
        hideButton.isEnabled = false
    }
    
    func enableButtons() {
        showButton.isEnabled = true
        hideButton.isEnabled = true
    }
    
    @IBAction func onInitializeClick(_ sender: Any) {
        MagicReceipts.initialize(with: Params("API_KEY")
            .userId("YOUR_USER_ID")
            .incentiveMode(incentiveModeSwitch.isOn), delegate: self)
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
    
}

extension ViewController: MagicReceiptsDelegate {
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

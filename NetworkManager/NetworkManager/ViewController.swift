//
//  ViewController.swift
//  NetworkManager
//
//  Created by Александр Сибирцев on 25.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monitorButton: UIButton!
    
    @IBOutlet weak var monitorLabel: UILabel!
    @IBOutlet weak var monitorLabelType: UILabel!
    @IBOutlet weak var monitorLabelExpensive: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.monitorButton.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        NetworkManager.shared.didStartMonitoringHandler = { [unowned self] in
            self.monitorButton.setTitle("Stop Monitoring", for: .normal)
        }
        
        NetworkManager.shared.didStopMonitoringHandler = { [unowned self] in
            self.monitorButton.setTitle("Start Monitoring", for: .normal)
        }
        
        NetworkManager.shared.netStatusChangeHandler = {
            DispatchQueue.main.async { [unowned self] in
                
                self.monitorLabel.text = NetworkManager.shared.isConnected ? "Connected" : "Not Connected"
                
                self.monitorButton.backgroundColor = NetworkManager.shared.isConnected ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                
                for index in NetworkManager.shared.availableInterfacesTypes! {
                    self.monitorLabelType.text = "\(index)"
                }
                
                self.monitorLabelExpensive.text = NetworkManager.shared.isExpensive ? "Expensive" : "Not Expensive"
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func toggleMonitoring(_ sender: Any) {
        if !NetworkManager.shared.isMonitoring {
            NetworkManager.shared.startMonitoring()
        } else {
            NetworkManager.shared.stopMonitoring()
            
            self.monitorButton.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            
            monitorLabel.text = ""
            monitorLabelType.text = ""
            monitorLabelExpensive.text = ""
        }
    }


}


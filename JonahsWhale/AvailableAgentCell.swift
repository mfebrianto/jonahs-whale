//
//  AvailableAgentCell.swift
//  JonahsWhale
//
//  Created by michael febrianto on 28/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import UIKit
import XCGLogger

class AvailableAgentCell: UITableViewCell {
    
    @IBOutlet var agentName: UILabel!
    
    let log = XCGLogger.defaultInstance()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWithModel(_ agent: Agent) {
        self.agentName.text = agent.username
    }
    
    
}

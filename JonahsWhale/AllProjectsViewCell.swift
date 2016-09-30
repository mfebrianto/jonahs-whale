//
//  AllProjectsViewCellController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 23/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import UIKit
import XCGLogger

class AllProjectsViewCell: UITableViewCell {
    
    
    @IBOutlet var projectNameLabel: UILabel!
    
    @IBOutlet var monitoredSwitch: UISwitch!
    
    let log = XCGLogger.defaultInstance()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWithModel(_ project: Project) {
        self.projectNameLabel.text = project.name
    }
    
    
}

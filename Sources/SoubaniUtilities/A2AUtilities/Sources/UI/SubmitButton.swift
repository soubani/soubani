//
//  SubmitButton.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 18/11/2020.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

public final class SubmitButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public var enable: Bool = true {
        didSet { setup() }
    }
    
    func setup() {
        backgroundColor = enable ? #colorLiteral(red: 0, green: 0.6910219193, blue: 0.9000238776, alpha: 1) : #colorLiteral(red: 0.8725085855, green: 0.9066727757, blue: 0.9278151393, alpha: 1)
        isUserInteractionEnabled = enable
        isEnabled = enable
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        makeItCircle()
    }
}

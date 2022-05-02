//
//  UIStoryBoard.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import Foundation
import UIKit


// MARK: - Storyboards -

extension UIStoryboard {
    
    // MARK: - Class Properties
    
    private static var bundle: Bundle {
        Bundle.main
    }
    
    static var Finance: UIStoryboard {
        UIStoryboard(name: "Finance", bundle: bundle)
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Class Functions
    
    func controller<T: UIViewController>(withClass name: T.Type) -> T {
        instantiateViewController(withIdentifier: String(describing: name)) as? T ?? T()
    }
    
    // -----------------------------------------------------------------------------------------------
    
}

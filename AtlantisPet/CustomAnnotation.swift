//
//  CustomAnnotation.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 4.05.2023.
//

import Foundation
import MapKit

class CustomAnnotation: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        // Set a custom image for the annotation view
        image = UIImage(named: "placeholder")
        
        // Set the size of the annotation view
        frame.size = CGSize(width: 50, height: 50)
        
        // Enable dragging
        isDraggable = true
        
        // Set the center offset if needed
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
    }
}



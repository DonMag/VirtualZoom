//
//  SwiftyBird.swift
//  VirtualZoom
//
//  Created by Don Mag on 8/30/23.
//

import UIKit

class SwiftyBird: NSObject {
	func path(inRect: CGRect) -> UIBezierPath {
		
		let thisShape = UIBezierPath()
		
		thisShape.move(to: CGPoint(x: 0.31, y: 0.94))
		thisShape.addCurve(to: CGPoint(x: 0, y: 0.64), controlPoint1: CGPoint(x: 0.18, y: 0.87), controlPoint2: CGPoint(x: 0.07, y: 0.76))
		thisShape.addCurve(to: CGPoint(x: 0.12, y: 0.72), controlPoint1: CGPoint(x: 0.03, y: 0.67), controlPoint2: CGPoint(x: 0.07, y: 0.7))
		thisShape.addCurve(to: CGPoint(x: 0.57, y: 0.72), controlPoint1: CGPoint(x: 0.28, y: 0.81), controlPoint2: CGPoint(x: 0.45, y: 0.8))
		thisShape.addCurve(to: CGPoint(x: 0.57, y: 0.72), controlPoint1: CGPoint(x: 0.57, y: 0.72), controlPoint2: CGPoint(x: 0.57, y: 0.72))
		thisShape.addCurve(to: CGPoint(x: 0.15, y: 0.23), controlPoint1: CGPoint(x: 0.4, y: 0.57), controlPoint2: CGPoint(x: 0.26, y: 0.39))
		thisShape.addCurve(to: CGPoint(x: 0.1, y: 0.15), controlPoint1: CGPoint(x: 0.13, y: 0.21), controlPoint2: CGPoint(x: 0.11, y: 0.18))
		thisShape.addCurve(to: CGPoint(x: 0.5, y: 0.49), controlPoint1: CGPoint(x: 0.22, y: 0.28), controlPoint2: CGPoint(x: 0.43, y: 0.44))
		thisShape.addCurve(to: CGPoint(x: 0.22, y: 0.09), controlPoint1: CGPoint(x: 0.35, y: 0.31), controlPoint2: CGPoint(x: 0.21, y: 0.08))
		thisShape.addCurve(to: CGPoint(x: 0.69, y: 0.52), controlPoint1: CGPoint(x: 0.46, y: 0.37), controlPoint2: CGPoint(x: 0.69, y: 0.52))
		thisShape.addCurve(to: CGPoint(x: 0.71, y: 0.54), controlPoint1: CGPoint(x: 0.7, y: 0.53), controlPoint2: CGPoint(x: 0.7, y: 0.53))
		thisShape.addCurve(to: CGPoint(x: 0.61, y: 0), controlPoint1: CGPoint(x: 0.77, y: 0.35), controlPoint2: CGPoint(x: 0.71, y: 0.15))
		thisShape.addCurve(to: CGPoint(x: 0.92, y: 0.68), controlPoint1: CGPoint(x: 0.84, y: 0.15), controlPoint2: CGPoint(x: 0.98, y: 0.44))
		thisShape.addCurve(to: CGPoint(x: 0.92, y: 0.7), controlPoint1: CGPoint(x: 0.92, y: 0.69), controlPoint2: CGPoint(x: 0.92, y: 0.7))
		thisShape.addCurve(to: CGPoint(x: 0.92, y: 0.7), controlPoint1: CGPoint(x: 0.92, y: 0.7), controlPoint2: CGPoint(x: 0.92, y: 0.7))
		thisShape.addCurve(to: CGPoint(x: 0.99, y: 1), controlPoint1: CGPoint(x: 1.00, y: 0.86), controlPoint2: CGPoint(x: 1, y: 1.00))
		thisShape.addCurve(to: CGPoint(x: 0.75, y: 0.93), controlPoint1: CGPoint(x: 0.92, y: 0.86), controlPoint2: CGPoint(x: 0.81, y: 0.9))
		thisShape.addCurve(to: CGPoint(x: 0.31, y: 0.94), controlPoint1: CGPoint(x: 0.64, y: 1.01), controlPoint2: CGPoint(x: 0.47, y: 1.00))
		thisShape.close()
		
		let tr = CGAffineTransform(translationX: inRect.minX, y: inRect.minY)
			.scaledBy(x: inRect.width, y: inRect.height)
		thisShape.apply(tr)
		
		return thisShape
	}
}


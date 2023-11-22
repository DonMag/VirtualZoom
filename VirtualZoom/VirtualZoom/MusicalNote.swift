//
//  MusicalNote.swift
//  VirtualZoom
//
//  Created by Don Mag MBP on 11/21/23.
//

import UIKit

class MusicalNote: NSObject {

	func path(inRect: CGRect) -> UIBezierPath {
		
		let thisShape = UIBezierPath()
		thisShape.move(to: CGPoint(x: 0.62, y: 0.23))
		thisShape.addCurve(to: CGPoint(x: 0.61, y: 0.21), controlPoint1: CGPoint(x: 0.62, y: 0.22), controlPoint2: CGPoint(x: 0.61, y: 0.21))
		thisShape.addCurve(to: CGPoint(x: 0.41, y: 0.1), controlPoint1: CGPoint(x: 0.56, y: 0.16), controlPoint2: CGPoint(x: 0.49, y: 0.12))
		thisShape.addCurve(to: CGPoint(x: 0.28, y: 0.01), controlPoint1: CGPoint(x: 0.36, y: 0.09), controlPoint2: CGPoint(x: 0.3, y: 0.03))
		thisShape.addCurve(to: CGPoint(x: 0.23, y: 0.01), controlPoint1: CGPoint(x: 0.27, y: 0), controlPoint2: CGPoint(x: 0.24, y: 0))
		thisShape.addCurve(to: CGPoint(x: 0.22, y: 0.04), controlPoint1: CGPoint(x: 0.22, y: 0.01), controlPoint2: CGPoint(x: 0.22, y: 0.02))
		thisShape.addLine(to: CGPoint(x: 0.22, y: 0.08))
		thisShape.addLine(to: CGPoint(x: 0.22, y: 0.13))
		thisShape.addCurve(to: CGPoint(x: 0.22, y: 0.13), controlPoint1: CGPoint(x: 0.22, y: 0.13), controlPoint2: CGPoint(x: 0.22, y: 0.13))
		thisShape.addLine(to: CGPoint(x: 0.22, y: 0.7))
		thisShape.addCurve(to: CGPoint(x: 0.16, y: 0.68), controlPoint1: CGPoint(x: 0.2, y: 0.69), controlPoint2: CGPoint(x: 0.18, y: 0.68))
		thisShape.addCurve(to: CGPoint(x: 0, y: 0.84), controlPoint1: CGPoint(x: 0.07, y: 0.68), controlPoint2: CGPoint(x: 0, y: 0.75))
		thisShape.addCurve(to: CGPoint(x: 0.16, y: 1), controlPoint1: CGPoint(x: 0, y: 0.93), controlPoint2: CGPoint(x: 0.07, y: 1))
		thisShape.addCurve(to: CGPoint(x: 0.16, y: 1), controlPoint1: CGPoint(x: 0.16, y: 1), controlPoint2: CGPoint(x: 0.16, y: 1))
		thisShape.addCurve(to: CGPoint(x: 0.32, y: 0.84), controlPoint1: CGPoint(x: 0.25, y: 1), controlPoint2: CGPoint(x: 0.32, y: 0.93))
		thisShape.addLine(to: CGPoint(x: 0.32, y: 0.84))
		thisShape.addCurve(to: CGPoint(x: 0.32, y: 0.84), controlPoint1: CGPoint(x: 0.32, y: 0.84), controlPoint2: CGPoint(x: 0.32, y: 0.84))
		thisShape.addLine(to: CGPoint(x: 0.32, y: 0.33))
		thisShape.addCurve(to: CGPoint(x: 0.38, y: 0.34), controlPoint1: CGPoint(x: 0.33, y: 0.33), controlPoint2: CGPoint(x: 0.36, y: 0.34))
		thisShape.addCurve(to: CGPoint(x: 0.58, y: 0.4), controlPoint1: CGPoint(x: 0.47, y: 0.35), controlPoint2: CGPoint(x: 0.54, y: 0.37))
		thisShape.addCurve(to: CGPoint(x: 0.61, y: 0.44), controlPoint1: CGPoint(x: 0.61, y: 0.42), controlPoint2: CGPoint(x: 0.61, y: 0.44))
		thisShape.addCurve(to: CGPoint(x: 0.61, y: 0.44), controlPoint1: CGPoint(x: 0.61, y: 0.44), controlPoint2: CGPoint(x: 0.61, y: 0.44))
		thisShape.addCurve(to: CGPoint(x: 0.62, y: 0.45), controlPoint1: CGPoint(x: 0.61, y: 0.44), controlPoint2: CGPoint(x: 0.62, y: 0.45))
		thisShape.addLine(to: CGPoint(x: 0.65, y: 0.45))
		thisShape.addLine(to: CGPoint(x: 0.65, y: 0.45))
		thisShape.addLine(to: CGPoint(x: 0.65, y: 0.45))
		thisShape.addLine(to: CGPoint(x: 0.66, y: 0.45))
		thisShape.addCurve(to: CGPoint(x: 0.68, y: 0.42), controlPoint1: CGPoint(x: 0.67, y: 0.45), controlPoint2: CGPoint(x: 0.68, y: 0.44))
		thisShape.addLine(to: CGPoint(x: 0.68, y: 0.42))
		thisShape.addCurve(to: CGPoint(x: 0.62, y: 0.23), controlPoint1: CGPoint(x: 0.68, y: 0.35), controlPoint2: CGPoint(x: 0.66, y: 0.28))
		thisShape.close()
		
		let tr = CGAffineTransform(translationX: inRect.minX, y: inRect.minY)
			.scaledBy(x: inRect.width, y: inRect.height)
		thisShape.apply(tr)
		
		return thisShape
	}
}

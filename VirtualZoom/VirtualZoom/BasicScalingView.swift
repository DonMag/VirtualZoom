//
//  BasicScalingView.swift
//  VirtualZoom
//
//  Created by Don Mag on 8/30/23.
//

import UIKit

class BasicScalingView: UIView {
	
	public var zoomScale: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
	
	private var theLinePath: UIBezierPath!
	private var theOvalPath: UIBezierPath!
	private var theTextPoint: CGPoint!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		var someRect: CGRect = .zero
		
		// create a rect path
		someRect = .init(x: 4.0, y: 4.0, width: 80.0, height: 50.0)
		theLinePath = UIBezierPath()
		theLinePath.move(to: .init(x: someRect.maxX, y: someRect.minY))
		theLinePath.addLine(to: .init(x: someRect.minX, y: someRect.minY))
		theLinePath.addLine(to: .init(x: someRect.minX, y: someRect.maxY))
		
		//	create an oval path
		someRect = .init(x: 6.0, y: 8.0, width: 50.0, height: 30.0)
		theOvalPath = UIBezierPath(ovalIn: someRect)
		
		//	this will be the top-left-point of the text-bounds
		theTextPoint = .init(x: 8.0, y: 6.0)
		
	}
	
	override func draw(_ rect: CGRect) {
		
		// only draw if we've initialized the paths
		guard theLinePath != nil, theOvalPath != nil else { return }
		
		let tr = CGAffineTransform(scaleX: zoomScale, y: zoomScale)
		
		if let path = theLinePath.copy() as? UIBezierPath {
			//	transform a copy of the rect path
			path.apply(tr)
			
			UIColor.green.set()
			path.lineWidth = 2.0 * zoomScale
			path.stroke()
		}
		
		if let path = theOvalPath.copy() as? UIBezierPath {
			//	transform the path
			path.apply(tr)
			
			UIColor.systemBlue.set()
			UIColor(white: 0.95, alpha: 1.0).setFill()
			path.lineWidth = 2.0 * zoomScale
			path.fill()
			path.stroke()
		}
		
		// scale the font point-size
		let font: UIFont = .systemFont(ofSize: 30.0 * zoomScale)
		let attribs: [NSAttributedString.Key : Any] = [.font: font, .foregroundColor: UIColor.red]
		//	transform the point
		let trPT: CGPoint = theTextPoint.applying(tr)
		//	attributed string at zoomed point-size
		let string = NSAttributedString(string: "Sample", attributes: attribs)
		string.draw(at: trPT)
		
	}
	
}


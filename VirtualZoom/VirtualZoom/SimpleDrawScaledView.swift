//
//  SimpleDrawScaledView.swift
//  VirtualZoom
//
//  Created by Don Mag on 8/30/23.
//

import UIKit

class SimpleDrawScaledView: UIView {
	
	private var _virtualSize: CGSize = .zero
	
	public var virtualSize: CGSize {
		set {
			_virtualSize = newValue
			
			// let's use a 120x80 rect, centered in the view bounds
			var theRect: CGRect = .init(x: 4.0, y: 4.0, width: 120.0, height: 80.0)
			theRect.origin = .init(x: (_virtualSize.width - theRect.width) * 0.5, y: (_virtualSize.height - theRect.height) * 0.5)
			
			// create a rect path
			theRectPath = UIBezierPath(rect: theRect)
			//	create an oval path (slightly inset)
			theOvalPath = UIBezierPath(ovalIn: theRect.insetBy(dx: 12.0, dy: 12.0))
			// we want to center the text in the rects, so
			//	get the mid-point of the rect
			theTextPoint = .init(x: theRect.midX, y: theRect.midY)
			
			setNeedsDisplay()
		}
		get {
			return _virtualSize
		}
	}
	
	public var zoomScale: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
	public var contentOffset: CGPoint = .zero { didSet { setNeedsDisplay() } }
	
	private var theRectPath: UIBezierPath!
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
	}
	
	override func draw(_ rect: CGRect) {
		
		// only draw if we've initialized the paths
		guard theRectPath != nil, theOvalPath != nil else { return }
		
		let tr = CGAffineTransform(translationX: -contentOffset.x, y: -contentOffset.y)
			.scaledBy(x: zoomScale, y: zoomScale)
		
		drawRect(insideRect: rect, withTransform: tr)
		drawOval(insideRect: rect, withTransform: tr)
		drawString(insideRect: rect, withTransform: tr)
		
	}
	
	func drawRect(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		if let path = theRectPath.copy() as? UIBezierPath {
			//	transform a copy of the rect path
			path.apply(tr)
			
			// only draw if visible
			if path.bounds.intersects(insideRect) {
				UIColor.green.set()
				path.lineWidth = 2.0 * zoomScale
				path.stroke()
			}
			
		}
	}
	
	func drawOval(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		if let path = theOvalPath.copy() as? UIBezierPath {
			//	transform a copy of the oval path
			path.apply(tr)
			
			// only draw if visible
			if path.bounds.intersects(insideRect) {
				UIColor.systemBlue.set()
				UIColor(white: 0.95, alpha: 1.0).setFill()
				path.lineWidth = 3.0 * zoomScale
				path.fill()
				path.stroke()
			}
		}
	}
	
	func drawString(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		// scale the font point-size
		let font: UIFont = .systemFont(ofSize: 30.0 * zoomScale)
		let attribs: [NSAttributedString.Key : Any] = [.font: font, .foregroundColor: UIColor.red]
		//	transform the point
		let trPT: CGPoint = theTextPoint.applying(tr)
		//	attributed string at zoomed point-size
		let string = NSAttributedString(string: "Sample", attributes: attribs)
		//	calculate the text rect
		let sz: CGSize = string.size()
		let r: CGRect = .init(x: trPT.x - sz.width * 0.5, y: trPT.y - sz.height * 0.5, width: sz.width, height: sz.height)
		// only draw if visible
		if r.intersects(insideRect) {
			string.draw(at: r.origin)
		}
	}
	
}


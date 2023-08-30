//
//  ComplexDrawScaledView.swift
//  VirtualZoom
//
//  Created by Don Mag on 8/30/23.
//

import UIKit

class ComplexDrawScaledView: UIView {
	
	// this will be set by the "rects" layout in commonInit()
	public var virtualSize: CGSize = .zero
	
	public var zoomScale: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
	public var contentOffset: CGPoint = .zero { didSet { setNeedsDisplay() } }
	
	private let nCols: Int = 32
	private let nRows: Int = 40
	private let colWidth: CGFloat = 120.0
	private let rowHeight: CGFloat = 80.0
	private let colSpacing: CGFloat = 16.0
	private let rowSpacing: CGFloat = 16.0
	
	private let rectInset: CGSize = .init(width: 1.0, height: 1.0)
	private let ovalInset: CGSize = .init(width: 12.0, height: 12.0)
	
	private var theRectPaths: [UIBezierPath] = []
	private var theOvalPaths: [UIBezierPath] = []
	private var theTextPoints: [CGPoint] = []
	private var theBirdPaths: [UIBezierPath] = []
	private var theGradientBirdPaths: [UIBezierPath] = []

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		// let's create a "grid" of rects
		// every rect will be used to create a
		//	rect path - alternating between rect and roundedRect
		//	a centered oval path
		//	and a centered text point
		
		var r: CGRect = .init(x: 0.0, y: 0.0, width: colWidth, height: rowHeight)
		for row in 0..<nRows {
			for col in 0..<nCols {
				let rPath = (row + col) % 2 == 0
				? UIBezierPath(roundedRect: r.insetBy(dx: rectInset.width, dy: rectInset.height), cornerRadius: 12.0)
				: UIBezierPath(rect: r.insetBy(dx: rectInset.width, dy: rectInset.height))
				theRectPaths.append(rPath)
				let oPath = UIBezierPath(ovalIn: r.insetBy(dx: ovalInset.width, dy: ovalInset.height))
				theOvalPaths.append(oPath)
				let pt: CGPoint = .init(x: r.midX, y: r.midY)
				theTextPoints.append(pt)
				r.origin.x += colWidth + colSpacing
			}
			r.origin.x = 0.0
			r.origin.y += rowHeight + rowSpacing
		}
		
		// our "virtual size"
		let w: CGFloat = theRectPaths.compactMap( { $0.bounds.maxX }).max()!
		let h: CGFloat = theRectPaths.compactMap( { $0.bounds.maxY }).max()!
		
		let sz: CGSize = .init(width: w, height: h)
		
		// let's use 100x100 SwiftyBird paths, arranged:
		//	- one each at 50-points from the corners
		//	- one each at 25% from the corners
		//	- one centered
		// so about like this:
		//	+--------------------+
		//	| x                x |
		//	|                    |
		//	|    x          x    |
		//	|                    |
		//	|         x          |
		//	|                    |
		//	|    x          x    |
		//	|                    |
		//	| x                x |
		//	+--------------------+
		// the corners and center will be translucent fill
		// the other 4 will be gradient fill
		
		let v: CGFloat = 100.0
		r = .init(x: 0.0, y: 0.0, width: v, height: v)
		
		r.origin = .init(x: 50.0, y: 50.0)
		theBirdPaths.append(SwiftyBird().path(inRect: r))
		
		r.origin = .init(x: sz.width - (v + 50.0), y: 50.0)
		theBirdPaths.append(SwiftyBird().path(inRect: r))
		
		r.origin = .init(x: 50.0, y: sz.height - (v + 50.0))
		theBirdPaths.append(SwiftyBird().path(inRect: r))
		
		r.origin = .init(x: sz.width - (v + 50.0), y: sz.height - (v + 50.0))
		theBirdPaths.append(SwiftyBird().path(inRect: r))
		
		r.origin = .init(x: sz.width * 0.5 - v * 0.5, y: sz.height * 0.5 - v * 0.5)
		theBirdPaths.append(SwiftyBird().path(inRect: r))
		
		r.origin = .init(x: sz.width * 0.25 - v * 0.5, y: sz.height * 0.25 - v * 0.5)
		theGradientBirdPaths.append(SwiftyBird().path(inRect: r))
		
		r.origin = .init(x: sz.width * 0.75 - v * 0.5, y: sz.height * 0.25 - v * 0.5)
		theGradientBirdPaths.append(SwiftyBird().path(inRect: r))
		
		r.origin = .init(x: sz.width * 0.25 - v * 0.5, y: sz.height * 0.75 - v * 0.5)
		theGradientBirdPaths.append(SwiftyBird().path(inRect: r))
		
		r.origin = .init(x: sz.width * 0.75 - v * 0.5, y: sz.height * 0.75 - v * 0.5)
		theGradientBirdPaths.append(SwiftyBird().path(inRect: r))
		
		virtualSize = sz
		
	}
	
	override func draw(_ rect: CGRect) {
		
		let tr = CGAffineTransform(translationX: -contentOffset.x, y: -contentOffset.y)
			.scaledBy(x: zoomScale, y: zoomScale)
		
		drawRects(insideRect: rect, withTransform: tr)
		drawOvals(insideRect: rect, withTransform: tr)
		drawStrings(insideRect: rect, withTransform: tr)
		drawBirds(insideRect: rect, withTransform: tr)
		drawGradientBirds(insideRect: rect, withTransform: tr)
		
	}
	
	private func drawRects(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		UIColor.green.setStroke()
		theRectPaths.forEach { pth in
			if let path = pth.copy() as? UIBezierPath {
				//	transform a copy of the path
				path.apply(tr)
				// only draw if visible
				if path.bounds.intersects(insideRect) {
					path.lineWidth = 2.0 * zoomScale
					path.stroke()
				}
			}
		}
	}
	private func drawOvals(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		UIColor.systemBlue.setStroke()
		UIColor(white: 0.95, alpha: 1.0).setFill()
		theOvalPaths.forEach { pth in
			if let path = pth.copy() as? UIBezierPath {
				//	transform a copy of the path
				path.apply(tr)
				// only draw if visible
				if path.bounds.intersects(insideRect) {
					path.lineWidth = 3.0 * zoomScale
					path.fill()
					path.stroke()
				}
			}
		}
	}
	private func drawStrings(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		// scale the font point-size
		let font: UIFont = .systemFont(ofSize: 30.0 * zoomScale)
		let attribs: [NSAttributedString.Key : Any] = [.font: font, .foregroundColor: UIColor.red]
		for (i, pt) in theTextPoints.enumerated() {
			//	transform the point
			let trPT: CGPoint = pt.applying(tr)
			//	attributed string at zoomed point-size
			let string = NSAttributedString(string: "\(i+1)", attributes: attribs)
			//	calculate the text rect
			let sz: CGSize = string.size()
			let r: CGRect = .init(x: trPT.x - sz.width * 0.5, y: trPT.y - sz.height * 0.5, width: sz.width, height: sz.height)
			// only draw if visible
			if r.intersects(insideRect) {
				string.draw(at: r.origin)
			}
		}
	}
	private func drawBirds(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		UIColor.yellow.setStroke()
		UIColor(red: 1.0, green: 0.6, blue: 0.3, alpha: 0.8).setFill()
		theBirdPaths.forEach { pth in
			if let path = pth.copy() as? UIBezierPath {
				// transform the path
				path.apply(tr)
				// only draw if visible
				if path.bounds.intersects(insideRect) {
					path.lineWidth = 2.0 * zoomScale
					path.fill()
					path.stroke()
				}
			}
		}
	}
	private func drawGradientBirds(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		
		guard let ctx = UIGraphicsGetCurrentContext() else { return }
		
		UIColor.yellow.setStroke()
		
		theGradientBirdPaths.forEach { pth in
			if let path = pth.copy() as? UIBezierPath {
				// transform the path
				path.apply(tr)
				// only draw if visible
				if path.bounds.intersects(insideRect) {
					path.lineWidth = 2.0 * zoomScale
					
					
					let startColor: UIColor = .systemRed
					let endColor: UIColor = .systemYellow
					let locations : [CGFloat] = [0.25, 1.0]
					let colorspace = CGColorSpaceCreateDeviceRGB()
					let colors = [startColor.cgColor, endColor.cgColor]
					
					let gradient = CGGradient(colorsSpace: colorspace, colors: colors as CFArray, locations: locations)
					let startPoint: CGPoint = .init(x: path.bounds.minX, y: path.bounds.minY)
					let endPoint: CGPoint = .init(x: path.bounds.maxX, y: path.bounds.maxY)
					
					ctx.beginPath()
					ctx.addPath(path.cgPath)
					ctx.closePath()
					ctx.clip()
					ctx.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
					ctx.resetClip()
					
					path.stroke()
				}
			}
		}
		
	}
	
	var cw: CGFloat = -1
	override func layoutSubviews() {
		super.layoutSubviews()
		if cw != bounds.width {
			cw = bounds.width
			// trigger draw() when bounds changes
			setNeedsDisplay()
		}
	}
	
}


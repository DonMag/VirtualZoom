//
//  NotesGridScaledView.swift
//  VirtualZoom
//
//  Created by Don Mag MBP on 11/22/23.
//

import UIKit

class NotesGridScaledView: UIView {
	
	// this will be set by the "rects" layout in commonInit()
	public var virtualSize: CGSize = .zero
	
	public var zoomScale: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
	public var contentOffset: CGPoint = .zero { didSet { setNeedsDisplay() } }
	
	private let nCols: Int = 32
	private let nRows: Int = 128
	
	private let colWidth: CGFloat = 120.0
	private let rowHeight: CGFloat = 80.0
	private let colSpacing: CGFloat = 0.0
	private let rowSpacing: CGFloat = 0.0
	
	private let fontSize: CGFloat = 20.0
	
	private let rectInset: CGSize = .init(width: 0.0, height: 0.0)
	
	private var theRectPaths: [UIBezierPath] = []
	private var theTextPoints: [CGPoint] = []
	private var theNotePaths: [UIBezierPath] = []
	
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
		for _ in 0..<nRows {
			for _ in 0..<nCols {
				let rPath = UIBezierPath(rect: r.insetBy(dx: rectInset.width, dy: rectInset.height))
				theRectPaths.append(rPath)
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
		
		virtualSize = sz
		
	}
	
	override func draw(_ rect: CGRect) {
		
		let tr = CGAffineTransform(translationX: -contentOffset.x, y: -contentOffset.y)
			.scaledBy(x: zoomScale, y: zoomScale)
		
		drawRects(insideRect: rect, withTransform: tr)
		drawStrings(insideRect: rect, withTransform: tr)
		drawNotes(insideRect: rect, withTransform: tr)
		
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
	private func drawStrings(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		// scale the font point-size
		let font: UIFont = .systemFont(ofSize: fontSize * zoomScale)
		let attribs: [NSAttributedString.Key : Any] = [.font: font, .foregroundColor: UIColor.red]
		for (i, pt) in theTextPoints.enumerated() {
			//	transform the point
			let trPT: CGPoint = pt.applying(tr)
			//	attributed string at zoomed point-size
			let row: Int = i / nCols
			let col: Int = i % nCols
			let string = NSAttributedString(string: "\(row)-\(col)", attributes: attribs)
			//	calculate the text rect
			let sz: CGSize = string.size()
			let r: CGRect = .init(x: trPT.x - sz.width * 0.5, y: trPT.y - sz.height * 0.5, width: sz.width, height: sz.height)
			// only draw if visible
			if r.intersects(insideRect) {
				string.draw(at: r.origin)
			}
		}
	}
	private func drawNotes(insideRect: CGRect, withTransform tr: CGAffineTransform) {
		UIColor.yellow.setStroke()
		UIColor(red: 1.0, green: 0.6, blue: 0.3, alpha: 1.0).setFill()
		
		theNotePaths.forEach { pth in
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
	
	var cw: CGFloat = -1
	override func layoutSubviews() {
		super.layoutSubviews()
		if cw != bounds.width {
			cw = bounds.width
			// trigger draw() when bounds changes
			setNeedsDisplay()
		}
	}
	
	public func gotTap(at: CGPoint) {
		let col: CGFloat = floor(at.x / colWidth)
		let row: CGFloat = floor(at.y / rowHeight)
		
		let h: CGFloat = rowHeight - 24.0
		let w: CGFloat = h * 0.46
		let r: CGRect = .init(x: colWidth * col + ((colWidth - w) * 0.5),
							  y: rowHeight * row + ((rowHeight - h) * 0.5),
							  width: w,
							  height: h)
		
		let path = MusicalNote().path(inRect: r)
		
		if let idx = theNotePaths.firstIndex(of: path) {
			theNotePaths.remove(at: idx)
		} else {
			theNotePaths.append(path)
		}
		
		setNeedsDisplay()
	}
	
}

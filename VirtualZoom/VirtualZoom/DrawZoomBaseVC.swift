//
//  DrawZoomBaseVC.swift
//  VirtualZoom
//
//  Created by Don Mag on 8/30/23.
//

import UIKit

class DrawZoomBaseVC: UIViewController {
	
	let scrollView: UIScrollView = UIScrollView()
	
	// this will be a plain, clear UIView that we will use
	//	as the viewForZooming
	let zoomView = UIView()
	
	// this will be placed *behind* the scrollView
	//	in our subclasses, we'll set it to either
	//		Simple or Complex
	//	and we'll set its zoomScale and contentOffset
	//	to match the scrollView
	var drawView: UIView!
	
	// a label to put at the top to show the current zoomScale
	let infoLabel: UILabel = {
		let v = UILabel()
		v.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
		v.textAlignment = .center
		v.numberOfLines = 0
		v.text = "\n\n\n"
		return v
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemYellow
		
		[infoLabel, drawView, scrollView].forEach { v in
			v.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(v)
		}
		zoomView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(zoomView)
		
		drawView.backgroundColor = .black
		scrollView.backgroundColor = .clear
		zoomView.backgroundColor = .clear
		
		let g = view.safeAreaLayoutGuide
		let cg = scrollView.contentLayoutGuide
		
		NSLayoutConstraint.activate([
			
			// info label at the top
			infoLabel.topAnchor.constraint(equalTo: g.topAnchor, constant: 8.0),
			infoLabel.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			infoLabel.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			
			scrollView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20.0),
			scrollView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			scrollView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			scrollView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -20.0),
			
			zoomView.topAnchor.constraint(equalTo: cg.topAnchor, constant: 0.0),
			zoomView.leadingAnchor.constraint(equalTo: cg.leadingAnchor, constant: 0.0),
			zoomView.trailingAnchor.constraint(equalTo: cg.trailingAnchor, constant: 0.0),
			zoomView.bottomAnchor.constraint(equalTo: cg.bottomAnchor, constant: 0.0),
			
			drawView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0.0),
			drawView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0.0),
			drawView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0.0),
			drawView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0.0),
			
		])
		
		scrollView.maximumZoomScale = 60.0
		scrollView.minimumZoomScale = 0.1
		scrollView.zoomScale = 1.0
		
		scrollView.indicatorStyle = .white
		
		scrollView.delegate = self
		
		//infoLabel.isHidden = true
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// if we're using the ComplexDrawScaledView
		//	we *get* its size that was determined by
		//	it laying out its elements in its commonInit()
		
		// if we're using the SimpleDrawScaledView
		//	we set its size to the scroll view's frame size
		if let dv = drawView as? SimpleDrawScaledView {
			dv.virtualSize = scrollView.frame.size
			zoomView.widthAnchor.constraint(equalToConstant: dv.virtualSize.width).isActive = true
			zoomView.heightAnchor.constraint(equalToConstant: dv.virtualSize.height).isActive = true
		}
		else
		if let dv = drawView as? ComplexDrawScaledView {
			zoomView.widthAnchor.constraint(equalToConstant: dv.virtualSize.width).isActive = true
			zoomView.heightAnchor.constraint(equalToConstant: dv.virtualSize.height).isActive = true
		}
		
		// let auto-layout size the view before we update the info label
		DispatchQueue.main.async {
			self.updateInfoLabel()
		}
	}
	
	func updateInfoLabel() {
		infoLabel.text = String(format: "\nzoomView size: (%0.0f, %0.0f)\nzoomScale: %0.3f\n", zoomView.frame.width, zoomView.frame.height, scrollView.zoomScale)
	}
	
}

extension DrawZoomBaseVC: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if let dv = drawView as? SimpleDrawScaledView {
			dv.contentOffset = scrollView.contentOffset
		}
		else
		if let dv = drawView as? ComplexDrawScaledView {
			dv.contentOffset = scrollView.contentOffset
		}
	}
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		updateInfoLabel()
		if let dv = drawView as? SimpleDrawScaledView {
			dv.zoomScale = scrollView.zoomScale
		}
		else
		if let dv = drawView as? ComplexDrawScaledView {
			dv.zoomScale = scrollView.zoomScale
		}
	}
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return zoomView
	}
}


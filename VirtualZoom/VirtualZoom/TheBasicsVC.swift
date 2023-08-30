//
//  TheBasicsVC.swift
//  VirtualZoom
//
//  Created by Don Mag on 8/30/23.
//

import UIKit

class TheBasicsVC: UIViewController {
	
	let drawView = BasicScalingView()
	
	// a label to put at the top to show the current zoomScale
	let infoLabel: UILabel = {
		let v = UILabel()
		v.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
		v.textAlignment = .center
		v.text = " "
		return v
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemYellow
		title = "The Basics"
		
		let slider = UISlider()
		
		drawView.backgroundColor = .black
		
		[slider, infoLabel, drawView].forEach { v in
			v.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(v)
		}
		
		let g = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			
			// slider at the top
			slider.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			slider.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			slider.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			
			// info label
			infoLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20.0),
			infoLabel.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			infoLabel.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			
			drawView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20.0),
			drawView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			drawView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			drawView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -20.0),
			
		])
		
		slider.minimumValue = 1.0
		slider.maximumValue = 20.0
		
		slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
		
		updateInfo()
	}
	
	func updateInfo() {
		infoLabel.text = String(format: "zoomScale: %0.3f", drawView.zoomScale)
		
	}
	@objc func sliderChanged(_ sender: UISlider) {
		drawView.zoomScale = CGFloat(sender.value)
		updateInfo()
	}
	
}


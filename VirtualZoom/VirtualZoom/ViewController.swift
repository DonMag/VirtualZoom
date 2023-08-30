//
//  ViewController.swift
//  VirtualZoom
//
//  Created by Don Mag on 3/27/23.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 20.0
		
		["The Basics", "Simple Scaled View", "Complex Scaled View"].forEach { str in
			let btn = UIButton()
			btn.setTitle(str, for: [])
			btn.setTitleColor(.white, for: .normal)
			btn.setTitleColor(.lightGray, for: .highlighted)
			btn.backgroundColor = .systemBlue
			btn.layer.cornerRadius = 8.0
			btn.addTarget(self, action: #selector(btnTap(_:)), for: .touchUpInside)
			stackView.addArrangedSubview(btn)
		}
		
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		label.text = "Please Note:\n\nthis is\nEXAMPLE CODE ONLY!\n\nIt is not intended to be and should not be considered to be\n\"production ready.\""
		stackView.addArrangedSubview(label)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stackView)
		let g = view.safeAreaLayoutGuide
		let w = stackView.widthAnchor.constraint(equalToConstant: 600.0)
		w.priority = .required - 1
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(greaterThanOrEqualTo: g.leadingAnchor, constant: 40.0),
			stackView.trailingAnchor.constraint(lessThanOrEqualTo: g.trailingAnchor, constant: -40.0),
			stackView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
		])
		
	}

	@objc func btnTap(_ sender: UIButton) {
		guard let sv = sender.superview as? UIStackView,
			  let idx = sv.arrangedSubviews.firstIndex(of: sender)
		else { return }
		
		switch idx {
		case 0:
			let vc = TheBasicsVC()
			self.navigationController?.pushViewController(vc, animated: true)
		case 1:
			let vc = SimpleVC()
			self.navigationController?.pushViewController(vc, animated: true)
		case 2:
			let vc = ComplexVC()
			self.navigationController?.pushViewController(vc, animated: true)
		default:
			()
		}
	}

}


class SimpleVC: DrawZoomBaseVC {
	
	override func viewDidLoad() {
		title = "Simple Scaled View"
		drawView = SimpleDrawScaledView()
		super.viewDidLoad()
	}
	
}

class ComplexVC: DrawZoomBaseVC {
	
	override func viewDidLoad() {
		title = "Complex Scaled View"
		drawView = ComplexDrawScaledView()
		super.viewDidLoad()
	}
	
}


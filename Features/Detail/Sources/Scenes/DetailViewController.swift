//
//  DetailViewController.swift
//  Detail
//
//  Created by Ronan on 12/09/2021.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import UIKit

public class DetailViewController: UIViewController {
    let label = UILabel()
    public override init(nibName nib: String?, bundle: Bundle?) {
        super.init(nibName: nib, bundle: bundle)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        title = "Detail"
        view.backgroundColor = .white

        label.text = title
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

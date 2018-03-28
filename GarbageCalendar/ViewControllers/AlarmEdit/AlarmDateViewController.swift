//
//  AlarmDateViewController.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/09.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit

protocol AlarmEditViewControllerDelegate: class {
    func didOKButtonTapped(date: Date)
}

class AlarmDateViewController: UIViewController {
    private let tag = 9999
    internal var date: Date!
    internal weak var delegate: AlarmEditViewControllerDelegate?
    
    @IBOutlet private weak var picker: UIDatePicker!
    @IBOutlet private weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.tag = tag
        view.isUserInteractionEnabled = true
        picker.setDate(date, animated: false)
        picker.minuteInterval = 10
        backgroundView.drawCorneredRect()
    }
    
    @IBAction func didOKButtonTapped(_ sender: Any) {
        self.delegate?.didOKButtonTapped(date: self.picker.date)
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view?.tag == tag {
            dismiss(animated: true, completion: nil)
        }
    }
}

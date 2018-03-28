//
//  AlarmPickerViewController.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/09.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import GarbageCalendarModel
import GarbageCalendarPresenter

protocol AlarmPickerViewControllerDelegate: class {
    func didOKButtonTapped(type: Alarm.DayIntervalType)
}

class DayIntervalPickerViewController: UIViewController {
    private let tag = 8888
    private var presenter: DayIntervalPickerPresenter!
    
    internal weak var delegate: AlarmPickerViewControllerDelegate?
    internal var currentType: Alarm.DayIntervalType?
    private var selecterdType: Alarm.DayIntervalType!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var picker: UIPickerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DayIntervalPickerPresenter(self)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.tag = tag
        view.isUserInteractionEnabled = true
        backgroundView.drawCorneredRect()
    }
    
    @IBAction func didOKButtonTapped(_ sender: Any) {
        guard let selecterdType = selecterdType else { return }
        delegate?.didOKButtonTapped(type: selecterdType)
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view?.tag == tag {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension DayIntervalPickerViewController: DayIntervalPickerView {
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func showDataPicker(types: [Alarm.DayIntervalType]) {
        if let currentType = currentType {
            guard let index = types.index(where: { (type) -> Bool in
                return type == currentType
            }) else { return }
            picker.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    func setDayIntervalType(type: Alarm.DayIntervalType) {
        selecterdType = type
    }
}

extension DayIntervalPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = presenter.getDayIntervalType(index: row)
        return Alarm.DayIntervalType.getLabel(type: type)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.getDayIntervalTypeCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.setType(index: row)
    }
}

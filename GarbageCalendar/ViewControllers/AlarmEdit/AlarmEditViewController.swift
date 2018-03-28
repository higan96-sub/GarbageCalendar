//
//  AlarmEditViewController.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/09.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import CoreActionSheetPicker
import GarbageCalendarPresenter
import GarbageCalendarModel

class AlarmEditViewController: UITableViewController {
    private var presenter: AlarmEditPresenter!
    private var date: Date?
    private var type: Alarm.DayIntervalType!
    private let formatter = DateFormatter()
    private var garbageTypes = [String]()
    private var dayIntervalTypes = [Alarm.DayIntervalType]()
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayIntervalLabel: UILabel!
    @IBOutlet weak var garbageTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.setTemplate(.time)
        presenter = AlarmEditPresenter(view: self, alarm: nil)
    }
    
    @IBAction func onCancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presenter.didGarbageTypeCellTapped()
        case 1:
            presenter.didDayIntervalCellTapped()
        case 2:
            presenter.didTimeCellTapped()
        default:
            print("hoge")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        switch segueIdentifier {
        case "showDatePicker" :
            let vc = segue.destination as? AlarmDateViewController
            vc?.date = date
            vc?.delegate = self
        case "showDayIntervalPicker" :
            let vc = segue.destination as? DayIntervalPickerViewController
            vc?.currentType = type
            vc?.delegate = self
        case "showGarbageTypePicker" :
            let vc = segue.destination as? AlarmDateViewController
            vc?.delegate = self
        default:
            return
        }
    }
}

extension AlarmEditViewController: AlarmEditViewControllerDelegate, AlarmPickerViewControllerDelegate {
    func didOKButtonTapped(type: Alarm.DayIntervalType) {
        self.type = type
        dayIntervalLabel.text = Alarm.DayIntervalType.getLabel(type: type)
    }
    
    func didOKButtonTapped(date: Date) {
        self.date = date
        dateLabel.text = formatter.string(from: date)
    }
    
    func didOKButtonTapped(value: String) {
        print(value)
    }
}

extension AlarmEditViewController: AlarmEditView {
    func showDayIntervalPicker(types: [Alarm.DayIntervalType]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.performSegue(withIdentifier: "showDayIntervalPicker", sender: self)
        }
    }
    
    func showGarbageTypePicker(types: [String]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.performSegue(withIdentifier: "showGarbageTypePicker", sender: self)
        }
    }
    
    func showTimePicker(date: Date) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.date = date
            self.performSegue(withIdentifier: "showDatePicker", sender: self)
        }
    }
}

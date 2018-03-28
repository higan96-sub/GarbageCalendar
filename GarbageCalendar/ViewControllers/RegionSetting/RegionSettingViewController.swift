//
//  RegionSettingViewController.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/06.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import DropDown
import GarbageCalendarPresenter

class RegionSettingViewController: UIViewController {
    @IBOutlet weak var selectAreaButton: UIButton!
    @IBOutlet weak var selectRegionButton: UIButton!
    
    private let regionDropDown = DropDown()
    private let areaDropDown = DropDown()
    private var presenter: StartSettingPresenter!
    private var areas = [Int: String]()
    private var regions = [Int: String]()
    private var selectedAreaName: String?
    private var selectedRegionName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "setting-menu-kind_region".localized
        presenter = StartSettingPresenter(self, municipalityId: 999999999)
        selectAreaButton.drawCorneredBorder()
        selectRegionButton.drawCorneredBorder(borderColor: .accent)
        areaDropDownInit()
        regionDropDownInit()
        presenter.getAreas()
        presenter.getRegions()
    }
    
    @IBAction func didSelectAreaButtonTapped(_ sender: Any) {
        areaDropDown.show()
    }
    
    @IBAction func didSelectRegionButtonTapped(_ sender: Any) {
        regionDropDown.show()
    }
    
    @IBAction func didCancelButtonTapped(_ sender: Any) {
        dismiss()
    }
    
    @IBAction func didUpdateButtonTapped(_ sender: Any) {
        if let selectedRegionName = selectedRegionName {
            presenter.setMyRegion(selectedRegionName)
        }
    }
    
    private func areaDropDownInit() {
        areaDropDown.anchorView = selectAreaButton
        areaDropDown.bottomOffset = CGPoint(x: 0, y: selectAreaButton.bounds.height)
        areaDropDown.selectionAction = {[unowned self] (index: Int, item: String) in
            self.selectedAreaName = item
            self.selectAreaButton.setTitle(item, for: .normal)
            self.presenter.getRegions(for: item)
        }
    }
    
    private func regionDropDownInit() {
        regionDropDown.anchorView = selectRegionButton
        regionDropDown.bottomOffset = CGPoint(x: 0, y: selectRegionButton.bounds.height)
        regionDropDown.selectionAction = {[unowned self] (index: Int, item: String) in
            self.selectedRegionName = item
            self.selectRegionButton.setTitle(item, for: .normal)
            self.selectRegionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: (self.selectRegionButton.titleLabel?.font.pointSize)!)
            self.selectRegionButton.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
}

extension RegionSettingViewController: StartSettingView {
    func setRegionTitle(title: String){
        selectRegionButton.setTitle(title, for: .normal)
    }
    
    func setAreaLabels(labels: [String]){
        areaDropDown.dataSource = labels
    }
    
    func setRegionLabels(labels: [String]){
        regionDropDown.dataSource = labels
    }
    
    func dismiss(){
        dismiss(animated: true, completion: nil)
    }
}

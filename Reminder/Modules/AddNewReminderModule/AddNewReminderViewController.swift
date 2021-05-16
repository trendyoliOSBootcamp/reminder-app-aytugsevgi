import UIKit

protocol AddNewReminderViewInterface: AnyObject {
    func configure()
    func openPicker()
    func closePicker(completion: @escaping (Bool) -> Void)
    func setListLabelText(text: String?)
    func setPriorityLabelText(text: String?)
    func setPickerViewNameLabelText(text: String?)
}

final class AddNewReminderViewController: UIViewController {
    var presenter: AddNewReminderPresenterInterface!
    @IBOutlet weak private var listColorView: UIView!
    @IBOutlet weak private var listBackgroundView: UIView!
    @IBOutlet weak private var flagImageView: UIImageView!
    @IBOutlet weak private var textsStackView: UIStackView!
    @IBOutlet weak private var flagBackgroundView: UIView!
    @IBOutlet weak private var priorityBackgroundView: UIView!
    @IBOutlet weak private var pickerView: UIPickerView!
    @IBOutlet weak private var pickerViewBackgroundView: UIView!
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var notesTextView: UITextView!
    @IBOutlet weak private var flagSwitch: UISwitch!
    @IBOutlet weak private var listViewLabel: UILabel!
    @IBOutlet weak private var priorityViewLabel: UILabel!
    @IBOutlet weak private var pickerViewNameLabel: UILabel!
    
    private lazy var picker = PickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction private func priorityButtonTapped() {
        presenter.priorityButtonTapped()
    }
    
    @IBAction private func listButtonTapped() {
        presenter.listButtonTapped()
    }
    
    @IBAction private func cancelButtonTapped() {
        presenter.cancelButtonTapped()
    }
    
    @IBAction private func addButtonTapped() {
        presenter.addButtonTapped(title: titleTextField.text, content: notesTextView.text, isFlag: flagSwitch.isOn)
    }
    
    @IBAction private func pickerDoneButtonTapped(_ sender: Any) {
        presenter.pickerDoneButtonTapped()
    }
}

extension AddNewReminderViewController: AddNewReminderViewInterface {
    
    func configure() {
        listColorView.makeCircle
        listBackgroundView.layer.cornerRadius = 10
        flagBackgroundView.layer.cornerRadius = 10
        priorityBackgroundView.layer.cornerRadius = 10
        textsStackView.layer.cornerRadius = 10
        flagImageView.layer.cornerRadius = 5
        pickerViewBackgroundView.transform.ty = self.view.frame.maxY - self.pickerViewBackgroundView.frame.minY
        definesPresentationContext = true
    }
    
    func openPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadComponent(0)
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerViewBackgroundView.transform.ty = self.pickerViewBackgroundView.frame.minY - self.view.frame.maxY
        })

    }
    
    func closePicker(completion: @escaping (Bool) -> Void) {
        pickerView.delegate = nil
        pickerView.dataSource = nil
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerViewBackgroundView.transform.ty = self.view.frame.maxY - self.pickerViewBackgroundView.frame.minY
        }, completion: completion )
    }
    
    func setListLabelText(text: String?) {
        listViewLabel.text = text
    }
    
    func setPriorityLabelText(text: String?) {
        priorityViewLabel.text = text
    }
    
    func setPickerViewNameLabelText(text: String?) {
        pickerViewNameLabel.text = text
    }
    
    
}

extension AddNewReminderViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        presenter.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter.numberOfRowsInComponent
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter.titleForRow(at: row)
    }
    
    
}

extension AddNewReminderViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.didSelectRow(row: row)
    }
}

//
//  AddPetViewController.swift
//  PetsTask
//
//  Created by Abdullah Bin Essa on 3/4/24.
//

import UIKit
import Eureka

class AddPetViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupEureka()
    }
    
    func setupEureka(){
        form +++ Section("Pet Details")
        <<< TextRow(){
            $0.title = "Name"
            $0.placeholder = "Add pet name"
            $0.tag = tag.NAME.rawValue
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChange
            $0.cellUpdate { cell, row in
                  if !row.isValid {
                      cell.titleLabel?.textColor = .red
                  }
              }
        }
        <<< TextRow(){
            $0.title = "Adopted"
            $0.placeholder = "is it adopted?"
            $0.tag = tag.ADOPTED.rawValue
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChange
            $0.cellUpdate { cell, row in
                  if !row.isValid {
                      cell.titleLabel?.textColor = .red
                  }
              }

            
        }
        <<< TextRow(){
            $0.title = "Image"
            $0.placeholder = "Image URL"
            $0.tag = tag.IMAGE.rawValue
            

        }
        <<< TextRow(){
            $0.title = "Age"
            $0.placeholder = "Age"
            $0.tag = tag.AGE.rawValue
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChange
            $0.cellUpdate { cell, row in
                  if !row.isValid {
                      cell.titleLabel?.textColor = .red
                  }
              }

        }
        <<< TextRow(){ 
            $0.title = "Gender"
            $0.placeholder = "Gender"
            $0.tag = tag.GENDER.rawValue
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChange
            $0.cellUpdate { cell, row in
                  if !row.isValid {
                      cell.titleLabel?.textColor = .red
                  }
              }

            
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submitTapped))
        
    }
    
    @objc func submitTapped() {
        let errors = form.validate()
        
        guard errors.isEmpty else{
            print(errors)
            presentAlertWithTitle(title: "😩", message: "no submission in textfield")
            return
        }
        
        let nameRow: TextRow? = form.rowBy(tag: tag.NAME.rawValue)
        let adoptedRow: TextRow? = form.rowBy(tag: tag.ADOPTED.rawValue)
        let imageUrlRow: TextRow? = form.rowBy(tag: tag.IMAGE.rawValue)
        let ageRow: TextRow? = form.rowBy(tag: tag.AGE.rawValue)
        let genderRow: TextRow? = form.rowBy(tag: tag.GENDER.rawValue)
        
        let name = nameRow?.value ?? ""
        let adopted = adoptedRow?.value ?? ""
        let imageUrl = imageUrlRow?.value ?? ""
        let age = ageRow?.value ?? ""
        let gender = genderRow?.value ?? ""
        
        let pet = Pet(id: nil , name: name, adopted: Bool(adopted) ?? true, image: imageUrl, age: Int(age) ?? 0, gender: gender)
        
        NetworkManager.shared.addPet(pet: pet) { success in

        // Handling Network Request
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // Handle submission error, e.g., show an error alert
                }
            }

        }

    }
    
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    enum tag: String{
        case NAME
        case ADOPTED
        case IMAGE
        case AGE
        case GENDER
    }
    
}





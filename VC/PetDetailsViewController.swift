//
//  PetDetailsViewController.swift
//  PetsTask
//
//  Created by Abdullah Bin Essa on 3/4/24.
//

import Foundation
import UIKit
import Kingfisher

class PetDetailsViewController: UIViewController {
    
    var pets: Pet?
    


    // UI Components
        private let petNameLabel = UILabel()
        private let petadoptedLabel = UILabel()
        private let petImageView = UIImageView()
        private let petAgeLabel = UILabel()
        private let petGenderLabel = UILabel()


    

        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            setupUI()
            setupLayout()
            configureWithPet()
        }

        private func setupViews() {
            // Configure UI components here
            view.backgroundColor = .white

                petNameLabel.font = .systemFont(ofSize: 16, weight: .medium)
                petAgeLabel.font = .systemFont(ofSize: 16, weight: .medium)

                // Add the views to the hierarchy
                view.addSubview(petNameLabel)
                view.addSubview(petAgeLabel)
                view.addSubview(petImageView)
                view.addSubview(petadoptedLabel)
                view.addSubview(petGenderLabel)
        }

        private func setupLayout() {
            // Use SnapKit to define the layout
            petImageView.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                    make.centerX.equalToSuperview()
                    make.width.height.equalTo(300)
                }

                petNameLabel.snp.makeConstraints { make in
                    make.top.equalTo(petImageView.snp.bottom).offset(50)
                    make.centerX.equalToSuperview()
                }

                petAgeLabel.snp.makeConstraints { make in
                    make.top.equalTo(petNameLabel.snp.bottom).offset(50)
                    make.centerX.equalToSuperview()
                }
            petadoptedLabel.snp.makeConstraints { make in
                make.top.equalTo(petAgeLabel.snp.bottom).offset(50)
                make.centerX.equalToSuperview()
            }
            petGenderLabel.snp.makeConstraints { make in
                make.top.equalTo(petadoptedLabel.snp.bottom).offset(50)
                make.centerX.equalToSuperview()

                
            }
        }

        private func configureWithPet() {
            petNameLabel.text = "\(pets?.name ?? "N/A")"
            petAgeLabel.text = "\(pets?.age ?? 0) year(s) old"
            petImageView.image = UIImage(named: pets?.image ?? "")
            petadoptedLabel.text = pets?.adopted == true ? "Adopted" : "Not Adopted"
            petGenderLabel.text = "\(pets?.gender ?? "NONBINARY")"
            petImageView.kf.setImage(with: URL(string: pets?.image ?? ""))
        }
    
    func setupUI(){
        view.backgroundColor = .black
        // Set fonts
            petNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            petAgeLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            petadoptedLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            petGenderLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)

            // Set image view properties
            petImageView.contentMode = .scaleAspectFill
            petImageView.layer.cornerRadius = 50
            petImageView.clipsToBounds = true


            // Set label properties
            petNameLabel.textColor = UIColor.white
            petAgeLabel.textColor = UIColor.white
            petadoptedLabel.textColor = UIColor.white
            petGenderLabel.textColor = UIColor.white

            // Additional configurations for petadoptedLabel
            petadoptedLabel.textAlignment = .center
            petadoptedLabel.text = pets?.adopted == true ? "Adopted" : "Available"
            petadoptedLabel.layer.cornerRadius = 8
            petadoptedLabel.clipsToBounds = true
        
            
    }
    }






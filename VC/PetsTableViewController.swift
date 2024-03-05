//
//  ViewController.swift
//  PetsTask
//
//  Created by Abdullah Bin Essa on 3/4/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class PetsTableViewController: UITableViewController {
    
    
    var pets: [Pet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            fetchPetsData()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPetTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(             image: UIImage(systemName: "gobackward"), style: .plain, target: self, action: #selector(reloadButtonPress))
        
    }
    
    private func fetchPetsData() {
        NetworkManager.shared.fetchPets { fetchedPets in
            DispatchQueue.main.async {
                self.pets = fetchedPets ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pet = pets[indexPath.row]
        cell.textLabel?.text = pet.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petDetailsVC = PetDetailsViewController()
        let pet = pets[indexPath.row]
        petDetailsVC.pets = pet
        
        navigationController?.pushViewController(petDetailsVC, animated: true)

    }
    

    @objc private func addPetTapped() {
        let navigationController = UINavigationController(rootViewController: AddPetViewController())
        present(navigationController, animated: true, completion: nil)
    }
    @objc func reloadButtonPress(){
                fetchPetsData()
                tableView.reloadData()
                print("Refreshed")
            }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let petToDelete = pets[indexPath.row]  // Get the book to delete
            NetworkManager.shared.deletePet(petID: petToDelete.id!) { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        // Remove the book from the data source
                        self?.pets.remove(at: indexPath.row)

                        // Delete the table view row
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        // Handle the case where the book couldn't be deleted (e.g., show an alert)
                    }
                }
            }
        }
    }
    
    
    


}


//
//  ProductListViewController.swift
//  Youtube MVVM Product
//
//  Created by aamer sayyed on 05/05/24.
//

import UIKit



class ProductListViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var productTableView: UITableView!
    
    //MARK: - Variables
    private var producViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    @IBAction func addProductButtonTaped(_ sender: UIBarButtonItem) {
        let parameter = AddProduct(title: "BMW")
        producViewModel.addProducts(parameter: parameter)
    }
}

extension ProductListViewController{
    func configuration(){
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel(){
        producViewModel.fetchProducts()
    }
    
    func observeEvent(){
        producViewModel.eventHandler = {
            [weak self] event in
            guard let self else { return }
            switch event{
            case .loading : break
            case .stopLoading : break
            case .dataLoaded :
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error) : print(error!)
            case .newProductAdded(addProduct: let addProduct):
                print(addProduct)
            }
        }
    }
}

extension ProductListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        producViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = producViewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}

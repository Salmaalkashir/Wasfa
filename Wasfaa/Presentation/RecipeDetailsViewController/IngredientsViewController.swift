//
//  IngredientsViewController.swift
//  Wasfaa
//
//  Created by Salma on 10/05/2024.
//

import UIKit

class IngredientsViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var moreLabel: UILabel!
  var id: Int?
  var viewModel = RecipeDetailsViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    print("ddd:\(id)")
  }
  
}

//MARK: -IBActions
private extension IngredientsViewController{
  @IBAction func dismissView(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
}

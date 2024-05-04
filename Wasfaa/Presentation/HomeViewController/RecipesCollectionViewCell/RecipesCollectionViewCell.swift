//
//  RecipesCollectionViewCell.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import UIKit
import SDWebImage

class RecipesCollectionViewCell: UICollectionViewCell {
  //MARK: -IBoutlets
  @IBOutlet weak var recipeImage: UIImageView!
  @IBOutlet weak var recipeName: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    recipeImage.layer.cornerRadius = 25
  }
  
  //MARK: -Configurations
  func configureCell(image: String, name: String){
    recipeImage.sd_setImage(with: URL(string: image),placeholderImage: UIImage(named: "noImage"))
    recipeName.text = name
  }
}

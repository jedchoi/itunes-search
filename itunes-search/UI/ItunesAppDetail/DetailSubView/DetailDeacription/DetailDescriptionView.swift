//
//  DetailDescriptionView.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/23.
//


import UIKit

protocol DetailDescriptionHeightUpdateDelegate: AnyObject {
    func updateDescriptionHeight(height: CGFloat)
}

class DetailDescriptionView: UIView {
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var moreButton: UIButton!

    var delegate: DetailDescriptionHeightUpdateDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        guard let view = UINib(nibName: "DetailDescriptionView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            Logger.track("fail to load xib")
            return
        }
        
        view.frame = bounds
        addSubview(view)
    }
    
    func setup(data: String, delegate: DetailDescriptionHeightUpdateDelegate) {
        guard let appData = try? JSONDecoder().decode(DetailDescriptionViewModel.self, from: data.data(using: .utf8)!) else {
            Logger.track("Decode Error : \(data)")
            return
        }
        self.delegate = delegate
        descriptionTextView.text = appData.description
        updateUI()
    }
    
    private func updateUI() {
        let textViewHeight = descriptionTextView.estimatedHeight
        if textViewHeight > DETAIL_NEW_FEATURE_VIEW_TEXT_VIEW_DEFAULT_HEIGHT {
            moreButton.isHidden = false
        } else {
            moreButton.isHidden = true
            delegate?.updateDescriptionHeight(height: textViewHeight)
        }
    }

    @IBAction func moreButtonPressed(_ sender: Any) {
        moreButton.isHidden = true
        delegate?.updateDescriptionHeight(height: descriptionTextView.estimatedHeight)
    }
}

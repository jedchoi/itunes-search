//
//  DetailNewFeatureView.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/23.
//

import UIKit

protocol DetailNewFeatureHeightUpdateDelegate: AnyObject {
    func updateHeight(height: CGFloat)
}

public let DETAIL_NEW_FEATURE_VIEW_TEXT_VIEW_DEFAULT_HEIGHT: CGFloat = 65.0
public let DETAIL_NEW_FEATURE_VIEW_DEFAULT_HEIGHT: CGFloat = 150.0


class DetailNewFeatureView: UIView {
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var releaseNote: UITextView!
    
    var delegate: DetailNewFeatureHeightUpdateDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        guard let view = UINib(nibName: "DetailNewFeatureView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            Logger.track("fail to load xib")
            return
        }
        
        view.frame = bounds
        addSubview(view)
    }
    
    func setup(data: String, delegate: DetailNewFeatureHeightUpdateDelegate) {
        guard let appData = try? JSONDecoder().decode(ItunesDetailNewFeatureViewModel.self, from: data.data(using: .utf8)!) else {
            Logger.track("Decode Error : \(data)")
            return
        }
        self.delegate = delegate
        
        version.text = appData.appVersion
        releaseDate.text = appData.currentVersionReleaseDate
        releaseNote.text = appData.releaseNotes
        updateUI()
    }
    
    private func updateUI() {
        let textViewHeight = getTextViewHeight()
        if textViewHeight > DETAIL_NEW_FEATURE_VIEW_TEXT_VIEW_DEFAULT_HEIGHT {
            moreButton.isHidden = false
        } else {
            moreButton.isHidden = true
            delegate?.updateHeight(height: textViewHeight)
        }
    }

    private func getTextViewHeight() -> CGFloat {
        let size = CGSize(width: releaseNote.frame.width, height: .infinity)
        let estimatedSize = releaseNote.sizeThatFits(size)
        Logger.track("estimatedSize \(estimatedSize)")
        return estimatedSize.height
    }
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        moreButton.isHidden = true
        delegate?.updateHeight(height: getTextViewHeight())
    }
}

struct ItunesDetailNewFeatureViewModel: Codable {
    var appVersion: String
    var releaseNotes: String
    var currentVersionReleaseDate: String

    enum CodingKeys: String, CodingKey {
        case appVersion = "version"
        case releaseNotes = "releaseNotes"
        case currentVersionReleaseDate = "currentVersionReleaseDate"
    }
}
    

import UIKit

final class StartButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setTitleColor(.systemBackground, for: .normal)
        backgroundColor = .systemBlue
        layer.cornerRadius = 18
    }
    }

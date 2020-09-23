//
//  EmojiArtDocument.swift
//  Emoji natural art
//
//  Created by ahmed alfrash on 21/9/2020.
//

import SwiftUI

class EmojiArtDocument: ObservableObject{
    static let palette = "🐥🐣🦆🦅🐝🐛🦋🐌🐞🕸🕷🐢🐑🐏🐓🦢🦃🐇🌳🌲🌴🌾🌞"
    
    @Published private var emojiArt: EmojiArt = EmojiArt()
    
    //private(set) make our ViewModel (EmojiArtDocument) the only one who can grabe image from internet
    @Published private(set) var backgroundImage: UIImage?
    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis}
    
    //MARK:- Intent(s)
    //access func addEmoji in model EmojiArt
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize){
        if let index = emojiArt.emojis.firstIndex(matching: emoji){
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat){
        if let index = emojiArt.emojis.firstIndex(matching: emoji){
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    func setBackgroundURL(_ url: URL?){
        emojiArt.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }
    
    private func fetchBackgroundImageData(){
        backgroundImage = nil
        if let url = emojiArt.backgroundURL{
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let imageData = try? Data(contentsOf: url){
                    DispatchQueue.main.async { [weak self] in
                        if url == self?.emojiArt.backgroundURL {
                            self?.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
            }
            
        }
    }
}


extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size)}
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y))}
}













































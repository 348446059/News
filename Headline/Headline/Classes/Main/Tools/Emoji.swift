//
//  Emoji.swift
//  Headline
//
//  Created by libo on 2018/6/11.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

struct Emoji {
    var id = ""
    var name = ""
    var png = ""
    var isDelete = false
    var isEmpty = false
    
    init(id:String = "",name:String = "",png:String = "",isDelete:Bool = false,isEmpty:Bool = false) {
        self.name = name
        self.id = id
        self.png = png
        self.isEmpty = isEmpty
        self.isDelete = isDelete
    }
    
}

struct EmojiManager {
    var emojis = [Emoji]()
    
    init() {
        let arrayPath = Bundle.main.path(forResource: "emoji_sort.plist", ofType: nil)
        let emojiSorts = NSArray(contentsOfFile: arrayPath!) as! [String]
        let mappingPath = Bundle.main.path(forResource: "emoji_mapping.plist", ofType: nil)
        let emojiMapping = NSDictionary(contentsOfFile: mappingPath!) as! [String:String]
        
        var temps = [Emoji]()
        //遍历
        for (index,id) in emojiSorts.enumerated() {
            if index != 0 && index % 20 == 0{
                temps.append(Emoji(isEmpty: true))
            }
            temps.append(Emoji(id: id, png: "emoji_\(id)_32X32_"))
        }
        
        for temp in temps {
            var emoji = temp
            for(key,value) in emojiMapping{
                if emoji.id == value{
                    emoji.name = "\(key)"
                    emojis.append(emoji)
                }
            }
            if emoji.isDelete{emojis.append(emoji)}
        }
        //判断分页是否有剩余
        let count = emojis.count % 21
        guard count != 0 else { return }
        //添加空白表情
        
        for index in count..<21 {
            emojis.append(index == 20 ? Emoji(isDelete:true) : Emoji(isEmpty: true))
        }
    }
    
    func showEmoji(content:String,font:UIFont) -> NSMutableAttributedString {
        //将content转成 attriubutedString
        let attributedString = NSMutableAttributedString(string: content)
        //emoji 表情的正则表达式
        let emojiPattern = "\\[.*?\\]"
        //创建正则表达式对象、匹配 emji 表情
        let regex = try! NSRegularExpression(pattern: emojiPattern, options: [])
        //开始匹配 返回结果
        let results = regex.matches(in: content, options: [], range: NSRange(location: 0, length: content.count))
        if results.count != 0 {
            // 倒序遍历，从最后一个开始替换，如果说从第一个旧替换的话，字符串的长度就发生变化了
            for index in stride(from: results.count - 1, through: 0, by: -1) {
                // 取出结果的范围
                let result = results[index]
                // 取出 emoji 的名字
                let emojiName = (content as NSString).substring(with: result.range)
                let attachment = NSTextAttachment()
                // 取出对应的 emoji 模型
                guard let emoji = emojis.filter({ $0.name == emojiName }).first else { return attributedString}
                // 设置图片
                attachment.image = UIImage(named: emoji.png)
                attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
                let attributedImageStr = NSAttributedString(attachment: attachment)
                // 将图片替换为文字
                attributedString.replaceCharacters(in: result.range, with: attributedImageStr)
            }
        }
        return attributedString
        
    }
    
}





















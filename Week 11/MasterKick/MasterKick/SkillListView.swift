//
//  SkillListView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 21/11/2024.
//


import SwiftUI

let skills = [
    Skill(
        title: "Basic Shot-Stopping Techniques",
        youtubeURL: "https://www.youtube.com/watch?v=qSdvcaqUMXc&pp=ygUnYmFzaWMgc2hvdC1zdG9wcGluZyB0ZWNobmlxdWVzIGZvb3RiYWxs",
        explanation: """
        Master the art of basic shot-stopping as a goalkeeper. Learn how to:
        1. Position yourself to cover the goal effectively.
        2. React quickly to shots aimed at different corners.
        3. Use proper hand placement and footwork to block or catch the ball.
        """
    ),
    Skill(
        title: "Diving and Saving Penalties",
        youtubeURL: "https://www.youtube.com/watch?v=254hoD_Wjes&pp=ygUtRGl2aW5nIGFuZCBTYXZpbmcgUGVuYWx0aWVzIHR1dG9yaWFsIGZvb3RiYWxs",
        explanation: """
        Improve your diving technique and master saving penalties. This tutorial covers:
        1. How to predict the direction of penalty shots.
        2. Diving with control and confidence to both sides.
        3. Techniques to maximize your reach while maintaining safety.
        """
    ),
    Skill(
        title: "1v1 Tackling",
        youtubeURL: "https://www.youtube.com/watch?v=7i-N9aw6d9Y&pp=ygUeMXYxIFRhY2tsaW5nIHR1dG9yaWFsIGZvb3RiYWxs",
        explanation: """
        Learn how to win 1v1 battles as a defender. Key points include:
        1. Maintaining the right body position to control the attacker.
        2. Timing your tackles to avoid fouls.
        3. Closing down space effectively to prevent attacks.
        """
    ),
    Skill(
        title: "Positioning and Marking",
        youtubeURL: "https://www.youtube.com/watch?v=KXZaP0niM3g&pp=ygUpUG9zaXRpb25pbmcgYW5kIE1hcmtpbmcgdHV0b3JpYWwgZm9vdGJhbGw%3D",
        explanation: """
        Develop your defensive awareness by mastering positioning and marking. This video teaches:
        1. How to anticipate attacking moves and stay one step ahead.
        2. Techniques for man-to-man and zonal marking.
        3. Positioning to intercept passes and clear the ball under pressure.
        """
    ),
    Skill(
        title: "Vision and Decision-Making",
        youtubeURL: "https://www.youtube.com/watch?v=k2HApTobThw&pp=ygUrVmlzaW9uIGFuZCBEZWNpc2lvbi1NYWtpbmd0dXRvcmlhbCBmb290YmFsbA%3D%3D",
        explanation: """
        Improve your vision and decision-making as a midfielder. Learn how to:
        1. Identify passing options and choose the best one.
        2. Keep your head up to scan the field under pressure.
        3. Make quick decisions to transition between attack and defense.
        """
    ),
    Skill(
        title: "Ball Control and Dribbling",
        youtubeURL: "https://www.youtube.com/watch?v=naEccnjzLxM&pp=ygUsQmFsbCBDb250cm9sIGFuZCBEcmliYmxpbmcgdHV0b3JpYWwgZm9vdGJhbGw%3D",
        explanation: """
        Enhance your ball control and dribbling skills to dominate the midfield. This tutorial shows:
        1. Techniques for tight ball control in confined spaces.
        2. Dribbling moves like step-overs and feints to beat defenders.
        3. Maintaining balance while dribbling at speed.
        """
    ),
    Skill(
        title: "Finishing and Scoring Goals",
        youtubeURL: "https://www.youtube.com/watch?v=eOnAvWc0au4&pp=ygUtRmluaXNoaW5nIGFuZCBTY29yaW5nIEdvYWxzIHR1dG9yaWFsIGZvb3RiYWxs",
        explanation: """
        Become a lethal striker by mastering finishing techniques. This video covers:
        1. Shooting with precision and power using both feet.
        2. Finishing in one-on-one situations with the goalkeeper.
        3. Timing your runs to get into scoring positions.
        """
    ),
    Skill(
        title: "Headers and Volleys",
        youtubeURL: "https://www.youtube.com/watch?v=Fyp4M70M6Hw&pp=ygUlSGVhZGVycyBhbmQgVm9sbGV5cyB0dXRvcmlhbCBmb290YmFsbA%3D%3D",
        explanation: """
        Perfect your headers and volleys to finish chances. Learn:
        1. Timing your jumps to connect with crosses accurately.
        2. Controlling volleys for power and placement.
        3. Positioning yourself to anticipate and react to aerial balls.
        """
    )
]

struct SkillListView: View {
    let skills: [Skill]
    
    var body: some View {
        NavigationView {
            List(skills) { skill in
                NavigationLink(destination: SkillTutorialView(
                    title: skill.title,
                    youtubeURL: skill.youtubeURL,
                    explanation: skill.explanation
                )) {
                    Text(skill.title)
                }
            }
            .navigationTitle("Football Skills")
        }
    }
}

struct SkillListView_Previews: PreviewProvider {
    static var previews: some View {
        SkillListView(skills: skills)
    }
}

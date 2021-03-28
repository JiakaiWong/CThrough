# CThrough
#  

# ***\*1项目初衷：\****

在2020年5月参加程序设计比赛时，这个项目的名字是CThrough- 一款移动端个人决策辅助系统。主要功能是通过帮助用户在提示下理性思考，制定出自己的目标并且对目标进行障碍分析和计划制定、执行情况记录，并提供分享功能让用户可以看到别人的目标和对目标的分析。并且把目标按照标签进行分类，变成如（保研、考研、留学等板块方便用户参考和借鉴）。同时又提供了原则的记录和分享功能（原则就是一种个人奉行的规则如“使用行为的长远后果来制定决策而不是只看短期结果”）。具体内容可以看[原来设计稿的主要功能部分](#_4_主要功能和使用场景:)

# ***\*附：软件设计大赛时的设计稿：\****

## ***\*1 项目初衷:\**** 

史铁生说:“人与人的交往多半肤浅，或只有在较为肤浅的层面上，交往才是容易的，一旦走进深处，人与人 就是相互的迷宫。” 

在 CThrough,我们谦卑而真诚地提供用户反思自己头脑深处迷宫的契机，并试图使广泛观察对比别人的迷宫成 为可能，我们想要帮助用户成为尼采所构思的 Übermensch。这，便是 CThrough,一款移动端个人决策辅助系统的存在价值。 

CThrough 的意思是 See Through，即 not be deceived by and detect the true nature of something.
我们的 slogan 是 evolution incited,意即我们希望这款应用能够促进用 户的自我成长。 

CThrough 的 logo 是一扇微微开启的门，门内黑暗、门外为光明 


![img](file:/photos/图片1.png)

我们希望用户在 CThrough 能够深思熟虑地思考自己所追寻地目标究竟是什么，并且一旦认清目标，不遗余力地去实现它，赢得自己向往的人生。 



## ***\*2 市场需求分析:\****

在互联网的后下沉阶段，社群对网上内容价值贡献的降低、社交媒体对个人成长促进作用愈 加模糊，在如今的社会经济内部矛盾愈发显著、广大青年一代队前途愈发迷茫的今天、对未来有所谋划的年轻人迫 切需要一个高质量的、非 KOL 主导的人生经历、乃至人生见解分享展示平台。 

## ***\*3 服务提供和目标用户:\****

下至面对极大高考和人生压力的高中生、上至刚进入职场、对未来仍感到迷茫、需要 朋辈沟通交流的年轻人。 

## ***\*4 主要功能和使用场景:\**** 

1 总体介绍:在 Ray Dalio2017 年书 Principles: Life and Work,中提到了实现 一个目标哲学上的分解:1 设定目标 2 失败 3 学习原则 4 提高(实现目标)5 更 大胆的目标。 

在 CThrough 中，我们采取类似的方法论指导，将目标的实现过程分解为 5 步:制定目标、分析目标实现的障碍、分析造成障碍根本原因、制定消除障碍的 计划、执行计划。用户在应用中每创建一个目标，都会在反复的提醒下进行这个 步骤中的前四步、当有所行动后，可以返回 CThrough 记录。 

![img](file:////private/var/folders/2c/2g3m4k617790hd75mb87pyf40000gn/T/com.kingsoft.wpsoffice.mac/wps-karhoi/ksohtml/wpsVwl74K.png)

![img](file:////private/var/folders/2c/2g3m4k617790hd75mb87pyf40000gn/T/com.kingsoft.wpsoffice.mac/wps-karhoi/ksohtml/wpshnnPGG.jpg)

其次，在 Principles 一书中，作者提到人应该使用原则来简化决策步骤、将从以往经验中获得的原则直接运用于今后的决策中、为此，CThrough 提供了原则记录和分享功能，可以创建自己的原则，查看自己的原则列表，看到别人的原则: 

![img](file:////private/var/folders/2c/2g3m4k617790hd75mb87pyf40000gn/T/com.kingsoft.wpsoffice.mac/wps-karhoi/ksohtml/wpsH9oyzA.png) 

![img](file:////private/var/folders/2c/2g3m4k617790hd75mb87pyf40000gn/T/com.kingsoft.wpsoffice.mac/wps-karhoi/ksohtml/wpsnzxOQO.jpg)
特色功能:
1 每个设定的目标都对应了一个标签，可以用于搜索，而“留学”、“保研”、“考研”三个标签由于最受关注，所以会自动显示在发现页面:

![img](file:////private/var/folders/2c/2g3m4k617790hd75mb87pyf40000gn/T/com.kingsoft.wpsoffice.mac/wps-karhoi/ksohtml/wpsjpAKRw.png) 

通过发现页面顶部的搜索按钮可进进入搜索页面，服务器会返回所有此标签下的目标。点击某个目标，可以查看详情（并且阅读评论、添加评论（未实现）) 

如果对某个用户特别有兴趣， 可以使用关注功能。被关注的用户会显示在发现页上。 

![img](file:////private/var/folders/2c/2g3m4k617790hd75mb87pyf40000gn/T/com.kingsoft.wpsoffice.mac/wps-karhoi/ksohtml/wpsUQkt6e.png) 

(1)发现界面:用户可以在发现界面查看最新的其他用户制定的目标 

![img](file:////private/var/folders/2c/2g3m4k617790hd75mb87pyf40000gn/T/com.kingsoft.wpsoffice.mac/wps-karhoi/ksohtml/wps3ItYVj.png) 

(2) 用户个人信息界面:用户可以更改自己的昵称和身份来让大家更好地认识就自己。 

其他界面:
CThrough 目前采用邮箱验证方式注册用户 

 

 

***\*6 盈利模式展望:\**** 

(1)通过在平台上的用户互动积累人气，推送其他人同类别相似目标是如何被分析、制定计划、完成的。将平台打造成带有 C2C 付费/免费目标导向的咨询属性的范社交平台。 


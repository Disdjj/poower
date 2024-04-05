# poower_flutter

a trace monitor for poop

我很喜欢陶喆的 [soul power](https://music.douban.com/subject/5966149/) , 每次听到陶喆的转音都让我觉得非常酣畅淋漓, 但是不那么酣畅淋漓的是我的排便.

为了关注我的健康问题, 我决定开始关注如厕时长.

但是市面上鲜有人愿意提供一个简洁的App, 于是我决定自己做一个.

# 基本功能

## APP

现在还是移动互联网的时代, 所以当然需要一个移动端的设备.

1. 初始化时输入用户姓名
2. 整个屏幕分为两部分, 上半边是💩 , 下半边是🧻. (点击💩进入答辩状态, 点击🧻结束. 弹出统计时间, 并将该条记录统计下来.)

APP可以单独使用, 在不使用Server的情况下也能够有良好的体验, 能够提供基本的查询能力: 时间, 次数.

其次UI要足够美观, 不能丑陋, 丑陋是万恶之源 (悲)

除了基本的存储 / 联网 之外, 不能涉及任何设备权限 (拉屎还要什么权限?)

## Server

Server的主要作用是收集信息, 并做持久化处理, 提供更加复杂的查询, 并且能够统计**多位家庭成员**的使用情况.

1. user
2. duration
3. start_time
4. end_time

# 技术栈

前端选择使用`flutter`, 因为我不想因为适配的原因去写kotlin + swift + js, 我希望一份代码能够跑在所有的端上.

后端的选择是`Go`, 因为打出的包足够小, 而且我对他足够熟系.

# 架构
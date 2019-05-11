#!/bin/bash
# 参考https://segmentfault.com/a/1190000002502526
# 详细命令见http://www.cnblogs.com/frost-yen/p/5848781.html
#375M--->122M 效果不错，用时28min
ffmpeg -i 1.mp4 -vcodec libx264 -preset fast -crf 20 -y -vf "scale=1920:-1" -acodec libmp3lame -ab 128k 2_ffmpeg.mp4

#ffmpeg -threads 2 -crf 20 -y -i ML-02.avi -strict experimental ML-02.mp4

'''
-preset：指定编码的配置。x264编码算法有很多可供配置的参数，不同的参数值会导致编码的速度大相径庭，甚至可能影响质量。为了免去用户了解算法，然后手工配置参数的麻烦。x264提供了一些预设值，而这些预设值可以通过preset指定。这些预设值有包括：ultrafast，superfast，veryfast，faster，fast，medium，slow，slower，veryslow和placebo。ultrafast编码速度最快，但压缩率低，生成的文件更大，placebo则正好相反。x264所取的默认值为medium。需要说明的是，preset主要是影响编码的速度，并不会很大的影响编码出来的结果的质量。压缩高清电影时，我一般用slow或者slower，当你的机器性能很好时也可以使用veryslow，不过一般并不会带来很大的好处。

-crf：这是最重要的一个选项，用于指定输出视频的质量，取值范围是0-51，默认值为23，数字越小输出视频的质量越高。这个选项会直接影响到输出视频的码率。一般来说，压制480p我会用20左右，压制720p我会用16-18，1080p我没尝试过。个人觉得，一般情况下没有必要低于16。最好的办法是大家可以多尝试几个值，每个都压几分钟，看看最后的输出质量和文件大小，自己再按需选择。
-s 设置输出文件的分辨率,wxh
-y 覆盖输出文件
1920:-1表示按照原始比例缩放
'''

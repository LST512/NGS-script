#!/bin/bash
#SoftClip与HardClip的区别
#lst
#2019-4-3

Clip 作为名词讲，有剪下来的东西的意义，在SAM/BAM 比对文件里面，用于描述那些一条序列上，在序列两端，比对不上的碱基序列.与clipped alignment对应的是spliced alignment，即read的中间没有比对到而两段比对上了

Clip 分为Soft Clip和Hard Clip。

Soft Clip，是指虽然比对不到基因组，但是还是存在于SEQ (segment SEQuence)中的序列，此时CIGAR列对应的S(Soft)的符号。直白点说，就是虽然比对不上参考基因组，但是在BAM/SAM文件中的reads上还是存在的序列（并没有被截断扔掉的序列）。即只要一条序列上，两端有比对不上的序列部分，就是Soft Clip，这个一条序列上有比对不上的部分的现象是必然存在的（比如结构变异的断点的部分），这种两端比对不上的read的特殊的表示方法，就是Soft Clip。

Hard Clip，同样的，就表示比对不上并且不会存在于SAM/BAM文件中的序列（被截断扔掉了的序列，此时CIGAR列会留下H(Hard)的符号，但是序列的那一列却没有对应的序列了）。而Hard Clip，相对来说更特殊一点，是依赖于Soft Clip存在的。也就是有Soft Clip不一定有Hard Clip，而有Hard Clip则一定有Soft Clip。Hard Clip存在的本意，是减少BAM文件序列的冗余度，比如有一条read，它能比对到A，B两个地方，在A地方，是60M90S，在B地方是60H90M，此时一条read其实已经在A位置有了完整的序列信息，在B位置的信息其实是冗余的，所以在B位置可以引入Hard Clip这样一个标记形式，就能把B位置的序列标记为secondary。常用的是BWA MEM -H 参数，能讲刚刚说的B位置的比对，进行Hard Clip标记
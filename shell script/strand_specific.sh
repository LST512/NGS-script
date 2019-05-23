#!/bin/bash
# strand-specific 

# insert size: https://www.jianshu.com/p/96cd37fecf20

# https://www.jianshu.com/p/a63595a41bed

# oligo-dT作为RT的引物，但是用它有两个问题，第一个是只能反转录那些有A尾巴的RNA，第二个问题是RT不是一个高度持续性的聚合酶，可能让转录提前发生终止，造成的结果就是3'端要比5'端reads富集，这样就会使得后续定量分析带来bias。 

# 随机引物的好处是没有A尾巴的诸如ncRNA也被留下了，而且不会存在明显的3'端偏差。但是很多研究也发现，所谓的随机引物根本就不随机，这也是测序结果中，通常前6个碱基的GC含量分布特别不均匀的原因。这几个碱基GC含量均匀很可能不是接头或者barcode那些东西，其实是Illumina 测序RT这一步的random hexamer priming 造成的bias，很多人在处理数据的时候会把这几个碱基去掉，其实很多时候真多RNA-seq数据去不去掉基本什么影响，不过开头如果有低质量的碱基倒是应该去掉。

# 序列两端加上加接头一方面是为了让机器可以识别这些序列，把这些序列固定；二是为了让多个样品可以同时上机，平摊每个样品的测序价格。双端测序为了让read从两边开始延伸，也需要在两端有所需的引物。

# 对于illumina数据，有一条5-3的universal adaptor；还有一条是3-5的indexed adatpor，这条引物含有特异的barcode。需要说明的是，在双端测序中，如果insert 不是足够长，那么R1可能就会测到R2的引物，同时R2可能会测到R1引物的反向互补序列。

# dUTP 测序方式的名字是fr-firstrand，也是RF。首先利用随机引物合成RNA的一条cDNA链，在合成第二条链的时候用dUTP代替dTTP，加adaptor后用UDGase处理，将有U的第二条cDNA降解掉。最后的insert DNA fragment都是来自于第一条cDNA，也就是dUTP叫fr-firststrand的原因。对于dUTP数据，tophat的参数应该为 –library-type fr-firststrand。这里的first-strand cDNA可不是RNA strand，在使用htseq-count 时，真正的正义链应该是使用参数 -s reverse 得到的结果。

# DNA 的正链（plus +）和负链(minus -)，就是那两条反向互补的链。参考基因组给出的那个链就是所谓的正链（forword），另一条链是反链（reverse）

# 两条互补的DNA链其中一条携带编码蛋白质信息的链称为正义链，另一条与之互补的称为反义链。

# 携带编码信息的正义链不是模板，只是因为它的序列和RNA相同，正义链也是编码链。而反义链虽然和RNA反向互补，但它可是真正给RNA当模板的链，因此反义链也是模板链。

# 要注意的是：在一条包含有若干基因的双链DNA分子中，各个基因的正义链并不都是在同一条链上。也就是说，有的基因的正义链是正链（forword strand），有的基因的正义链是反链（reverse strand）。所以，DNA双链中的一条链对某些基因来说是正义链，对另一些基因来说则是反义链

'''
克里克链/有义链/正义链(sense strand) = 编码链(coding strand) = 非模板链　　与mRNA序列相同
沃森链/反义链(anti-sense strand) = 非编码链　＝　模板链　　与mRNA序列反向互补
'''
# igv 颜色选项中的read strand 方向进行区分，可以看到所有红色read都是在正链方向（注意正链不是正义链），而所有蓝色的read都是负链方向。

# 如果dUTP链特异性测序，看基因表达量应该 counts for the 2nd read strand aligned with RNA(htseq-count option -s reverse, STAR ReadsPerGene.out.tab column 3 )如果想看反义链是否有转录本（比如NAT）应该用 the 1st read strand aligned with RNA ( htseq-count option -s yes，STAR ReadsPerGene.out.tab column 4)








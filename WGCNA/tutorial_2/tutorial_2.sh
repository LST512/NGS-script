#!/bin/bash
# lst @ 2018-11-21
# II. Consensus analysis of female and male liver expression data
# The second tutorial introduces consensus module analysis that closely parallels the single data set analysis presented in Tutorial I, but contains the extra ingredient of analyzing the consensus of two related but different sets.
# 0 data
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/MaleLiver-Data.zip
# 1 Data input and cleaning, including re-formatting the data for consensus analysis
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-DataInput.pdf
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-DataInput.R
# 2 Network construction and consensus module detection
# a Automatic, one-step network construction and consensus module detection: 
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-NetworkConstruction-auto.pdf
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-NetworkConstruction-auto.R
# b Step-by-step network construction and module detection, including scaling of Topological Overlap Matrices
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-NetworkConstruction-man.pdf
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-NetworkConstruction-man.R
# c Dealing with large datasets: block-wise network construction and consensus module detection, including comparing the block-wise approach to the standard single-block method
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-NetworkConstruction-blockwise.pdf
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-NetworkConstruction-blockwise.R
# 3 Relating the consensus modules to female set-specific modules (this section requires the results of Section 2.a of the female turorial)
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-RelateToFemMods.pdf
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-RelateToFemMods.R
# 4 Relating consensus module to external microarray sample traits and exporting the results of network analysis:
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-RelateModsToTraits.pdf
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-RelateModsToTraits.R
# 5 Studying and comparing the relationships among modules and traits between the two data sets, including the visualization of consensus eigengene networks and the results of the differential analysis
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-EigengeneNetworks.pdf
wget https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Consensus-EigengeneNetworks.R



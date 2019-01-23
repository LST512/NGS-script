#!/usr/bin/perl

##########
# Author: Jack MIN @copyright.
# Program: OrfPredictor.pl  - standalone version
# Version 3.0  output 6 frame-translation
# Program description:
# Usage: OrfPredictor.pl fastaFile blastx flag strand e-value Outputfile
# OrfPredictor.pl '$dir/$newUser/dna' '$dir/$newUser/blast' $bFlag  $strand '$dir/$newUser/$output'

# Input: a multiple-sequences file in fasta format
# Optional: blastx output
# Output: fasta format predicted proteins including frame, start postion, stop position
#################################################################################
if ($#ARGV != 5)
{
	print "Usage: OrfPredictor.pl fastaFile BLASTX bFlag strand E-value output\n";
	print "\tfastaFile: a multiple-sequence file in fasta format\n";
	print "\tBLASTX: optional, blastx output of submitted sequences\n";
	print "\tbFlag: 1 or 0\n";
	print "\tstrand: +, - or both\n";
	print "\tE-value: used in blastx\n";
	print "\toutput: predicted peptide after removing 5' and 3' -UTR in fasta format with frame, start and stop values\n";
	exit;
}

########## variables to catch user's input ########
$seqFile = $ARGV[0];
$blastFile = $ARGV[1];
$bFlag = $ARGV[2];#blastx flag, if 1, there is a blast, 0, no blast
$strandDefault = $ARGV[3];
$e = $ARGV[4];
$output = $ARGV[5];
############## store squences in harse ##########
%seqH = (); # a hash for storing seqID (key) and seq (value)
@seqA = ();
$line =();
@outA4 = ();
push (@outA4, "Sequence IDs without an ORF\n");
#
######## store the sequence in a hash table ###########
#
open (INPUT, $seqFile); # || die ("Cannot open file $seqFile\n\n");
#print "In progress ...\n";
$seqFlag =0; #to indicate the line is header or seqs, used for seq in multiple lines
$value ='';
$key = '';
$count =0; #to indicate the first ">"
while (<INPUT>)
{
	$line = $_; #$_, default input variable
	chomp ($line);

	$line =~ s/[\n\f\r]//;

	if ($line =~ /^>/)
	{
		$count++;
		if ($count >1)
		{
			$value =~ s/\s//g;	
			$value = uc($value);
			$seqH{$key} = $value;
			$value ='';
			$key ='';
		}
		$seqFlag = 1;
		@tmpA = split(/\s+/, $line);
		$key = substr($tmpA[0], 1);
		push (@seqA, $key); ## save all seqId in an array
	}
	else
	{
		if ($seqFlag ==1)
		{
			$value .= $line;
		}
	}
}
$value =~ s/\s//g;
$value = uc($value);
$seqH{$key} = $value;
close (INPUT);
#################
# If the bFlag is true, that means there's a blastx file privided by a user, so parse the blastx and store the frame value
#
# To store the frame value of each seqeunces in blastx report
#####

$originalFrame = 0;
$frame = 0;
%frameH = (); # a hash for storing seqID (key) and frame (value)
$sCount = 0;
#parameters for alignment position
$queryStartPos = 0;
$queryEndPos = 0;
$sbjctStartPos = 0;
$sbjctEndPos = 0;
%posH =(); #hash for saving the alignment parameters, the key is the queryID and the value include queryStartPos, queryEndPos,
	# sbjctStartPos, sbjctEndPos
$fsFlag = ''; #for frameShift flag, for seqs with a frame shift in blastx
$fFlag = 0; # to remember 1st frame value saved
if ($bFlag == 1)
{#a
	$originalFrame = 0; # this value will be used to check the original frame value
			#since negative value will be changed positive for $frame
	open (IN, $blastFile);# || die ("Cannot open file $blastFile\n\n");
	$offSet = tell(IN);
	$summaryStart = 0;
	$hFlag = 1;  # to assume 'hypothetical protein' flag is ON.
	$fFlag = 0;
	$fsFlag = '';

	while ($record = get_next_record(IN))
	{
		@recordA = split(/\n/, $record);
		$summaryStart = 0;
		$sCount = 0;
		$fFlag = 0;
		$fsFlag = '';
		$hit = 0;
		$hitS = 0; # number of hit sbjct (>)
		foreach $BlastContent (@recordA) #foreach start
		{#foreachloop #1
			chomp ($BlastContent);
			$BlastContent =~ s/[\f\r]//;
			@array1 = split (" ", $BlastContent);

		if ($array1[0] eq   "Query=")
		{
			$hFlag = 1;
			$query = $array1[1];
                	$queryCount++; $qLine = 1;
			#print $queryCount."\n".$query."\n";;
		}
		if (($qLine == 1) &&($BlastContent =~ /^Length=/))
		{
			@tL= split(/\=/, $BlastContent);
			$qLength = $tL[1]; $qLine = 0;
		}
		if ($summaryStart ==1)
		{
			$line = lc ($BlastContent);
			if (($line !~ /hypothetical/) && ($line =~ /\d/))
			{
				$hFlag = 0;
			}
			elsif ($line =~ /hypothetical/)
			{
				$sCount++;
			}
		}

		if ($BlastContent =~ /letters\)/)
		{
			@tmp = split(/\(/, $BlastContent);
			@tmp1 = split(/ /, $tmp[1]);
			$qLength = $tmp1[0];
	#	print $query."\t",$qLength."\n";
                next;
		}

		elsif ($BlastContent =~ /No hits found/)
		{
	        	$frameH{$query} = 0;
			$query = "";
                	next;
		}

       		elsif ($BlastContent =~ /^Sequences/)
		{
			$hit = 1; # there is a hit at least
			$summaryStart = 1;
		}

	       	elsif ($BlastContent =~ /^>/)
       		{
         		$summaryStart = 0;
	 		if ($hit ==1)
	 		{
             			$proteinName = lc($BlastContent);
				
	     			$hitS++; #hit subjec number
				if ($hitS ==1)
				{
					$firstHit = 1;
				}
				else
				{
					$firstHit = 0;
				}
	 		}
		}

        	else
        	{ # else - OUT1
	    		if ($hit ==1 && $firstHit ==1)
	    		{# if$hit and $firstHit both true)
			   if ($fFlag == 0)   #newly added
			   {
				if ($BlastContent =~ /Expect/)
				{
                        		$hitInfo = $hitInfo.$BlastContent;
					@expectLine = split(/,/, $BlastContent);
					$eString = $expectLine[1];
					@subString = split (/ /, $eString);
					$expect = $subString[3];
					$expect = lc($expect);
					if ($expect > $e)
					{
						$frameH{$query} = 0;
	  					$hit = 0;
						$firstHit = 0;
					}
				}

				elsif ($BlastContent =~ /Frame/)
	        		{
	              			$frame = $array1[2];
				}
				######newly added#######
				elsif ($BlastContent =~ /Identities/)
	        	{
	             			$idt = $array1[2];
							@tmpIdt = split (/\//, $idt);
							$alignP = $tmpIdt[1];
									#print "length 266 ".$alignP."\n";
				}
				#########
				elsif ($BlastContent=~ /Query/)
				{
               	   $queryStartPos = $array1[1];
				    if ($frame > 0)
		     	    {
					$queryEndPos = $queryStartPos + $alignP *3 -1;
				    }
				    elsif ($frame <0)
				    {
					$queryStartPos = $qLength - $queryStartPos +1;
                        		$queryEndPos = $queryStartPos + $alignP *3 -1;
				    }
				    if ($queryEndPos >$qLength)
				    {
					$queryEndPos = $qLength -3;
				    }
		    	}
					elsif ($BlastContent=~ /Sbjct/) #elsif -1
           			{
           				$sbjctStartPos = $array1[1];
		    	#		$sbjctEndPos = $array1[3];

					$d = (($sbjctStartPos*3) - $queryStartPos);

					if ($d < 30)
					{
						$posFlag = 1; #might be a full-length if there is a in-frame ATG
					}
					else
					{
						$posFlag = 0;
					}
					$p = $queryEndPos;
										
					if ($p =~ /\./)
					{
						@t = split (/\./, $p);
						$p = $t[0];
					}
					$frameH{$query} = $frame."\t".$posFlag."\t".$p;
					$fFlag = 1;
				#	print $query."\tframe".$frame."\t".$posFlag."\t".$p."\n";
				#	last;
				}

                } #newly added

			     else # $fFlag == 1, there is a frame shift
			     {
			     	if ($BlastContent =~ /Frame/)
	        		{
	              	$frame = $array1[2];
					$fsFlag = 'FS';  #there is a frame shift
					#print "there is a frame shift \n";
					$value = $frameH{$query};
					$frameH{$query} = $value."\t".$fsFlag;
					# print $query." ".$value."\t".$fsFlag."\n";  #!!!!!!!!!!!!!!!!!
					$hit = 0;
                    $firstHit = 0;
					$fsFlag = '';
					$fFlag = 0; 
					last;
					}
		        }
			}
		}
		}#end of foreach
		$offSet = tell(IN);
	}#end of while
close (IN);
} #end of a

$seq = '';
$proSeq = '';
$orf = '';
@tmpA = ();
$longest = 0;
$longestP = '';
@outA1 = ();
@outA2 = ();
$f = 0;
$strand = $strandDefault;
$flag5 = 0; #5 end stop
$qPos = '';
foreach $id (@seqA)
{ #foreach loop
	chomp $id;
	$strand = $strandDefault;
    $seqT = $seqH{$id};
#	print $id."\n".$seqT."\n";
	$seq = uc($seqT);
#newly added to show 6-frame translation

	$proSeq1 = dna2protein($seq); push (@rawA, ">".$id."\t+1"."\n".$proSeq1."\n");
	$seq2 = substr($seq, 1); $proSeq2 = dna2protein($seq2); push (@rawA, ">".$id."\t+2"."\n".$proSeq2."\n");
	$seq3 = substr($seq, 2); $proSeq3 = dna2protein($seq3); push (@rawA, ">".$id."\t+3"."\n".$proSeq3."\n");
	$revS = reverse $seq;
    $revS =~ tr/ACGTacgt/TGCAtgca/;
	$proR1 = dna2protein($revS); push (@rawA, ">".$id."\t-1"."\n".$proR1."\n");
	$revS2 = substr($revS, 1); $proR2 = dna2protein($revS2); push (@rawA, ">".$id."\t-2"."\n".$proR2."\n");
	$revS3 = substr($revS, 2); $proR3 = dna2protein($revS3); push (@rawA, ">".$id."\t-3"."\n".$proR3."\n");
####

	$pFlag = 0; #position flag to show possible full-length
	$qEnd = 0;#query end position
	$fsFlag = '';
	if ($bFlag ==1)
	{
		$strand = 'both'; #if there is a blastx provided, strand sets to both, as there may be negative frame values.
		$tmp= $frameH{$id};
		#print $tmp." line 348\n";
		if ($tmp eq '')
		{
			$f = 0;
		}
		else
		{
			@tA = split(/\t/, $tmp); #the tmp contains frame and other values, between frame and others '\t' used
			$f = $tA[0]; #frame value
			$pFlag = $tA[1];
			$qEnd = $tA[2];
			$fsFlag = $tA[3];
			#print "f: ".$f."\t"."pFlag ".$pFlag."\tpos:".$qEnd."\tfsFlag:".$fsFlag."\n";

		}
		#print "id".$id."\t"."frame:".$f."\n";
	}
	else
	{
		$f = 0;
	}

	#print "frame:".$f."\n";
	$strand = lc($strand);
	$sub1 = substr($seq, 0, 150); #checking both ends of an EST sequence
	$sub1a = substr($seq, 0, 80);
	$sub2a = substr ($seq, -80);
	$sub2 = substr($seq, -150);

	if ($strand eq 'both')
	{
		if ($f >0)
		{
			$strand = '+';
		}
		elsif ($f < 0)
		{
			$strand = '-';
		}
	}

if ($f == 0)
{
	if ($seq =~ /AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/ || $sub2 =~ /AAAAAAAAAAAAAAAAAAAAA/ || $sub2a =~ /AAAAAAAAAAAAAAAAAA/)
	 #30 As anywhere or 21 As in the end
	{

		$strand = '+';
		#print "AAAAA".$id."\n";

	}
	elsif ($sub1 =~ /TTTTTTTTTTTTTTTTTTTTT/  || $seq =~ /TTTTTTTTTTTTTTTTTTTTTTTTTTTTTT/ || $sub1a =~ /TTTTTTTTTTTTTTTTTT/)
	 #30 Ts any where, or 21 Ts at the begining
	{
		$strand = '-';
		#print "TTTTTTTT".$id."\n";
	}
}
# six frame translation ########
#print $id."   strand ".$strand."\n";

	if ($strand eq '+')
        {

                #print $id."\t".$strand."\t".$f."\n";
                if (($f == 0) || ($f == +1))
                {
        ####### frame 1 #######
                $proSeq =dna2protein($seq);
        #       print "frame 1:".$proSeq."\n";
                @orf = longPep($proSeq, $strand, $pFlag, $qEnd);
                $orf1 = $orf[0];
                $flag5 = $orf[1];
                push (@tmpA, $id."\t"."+1\t".$proSeq."\t".$orf1."\t".$flag5);
        #       print $id."\t"."+1\t".$proSeq."\t".$orf1."\n";
                }
                if (($f ==0) || ($f == +2))
                {
        ########## frame 2 ######
                $seq2 = substr($seq, 1);
                $proSeq = dna2protein($seq2);
                @orf = longPep($proSeq, $strand, $pFlag, $qEnd);
                $orf2 = $orf[0];
                $flag5 = $orf[1];
                push (@tmpA, $id."\t"."+2\t".$proSeq."\t".$orf2."\t".$flag5);
        #       print $id."\t"."+2\t".$proSeq."\t".$orf2."\n";

                }
        ########## frame 3 ########
                if (($f == 0) || ($f== +3))
                {
                $seq3 = substr($seq, 2);
                $proSeq = dna2protein($seq3);
                @orf = longPep($proSeq, $strand, $pFlag, $qEnd);
                $orf3 = $orf[0];
                $flag5 = $orf[1];
                push (@tmpA, $id."\t"."+3\t".$proSeq."\t".$orf3."\t".$flag5);
        #       print $id."\t"."+3\t".$proSeq."\t".$orf3."\n";
                }
        }
	elsif ($strand eq '-')
        {
                $revComSeq = reverse $seq;
                $revComSeq =~ tr/ACGTacgt/TGCAtgca/;
        #       print $seq."\n";
        #       print $revComSeq."\n";

                if (($f == 0) || ($f== -1))
                {
                ####### frame 1 #######
                $proSeq =dna2protein($revComSeq);
                @orf = longPep($proSeq, $strand, $pFlag, $qEnd);
                $orf_1 = $orf[0];
                $flag5 = $orf[1];
                push (@tmpA, $id."\t"."-1\t".$proSeq."\t".$orf_1."\t".$flag5);
        #       print $id."\t"."-1\t".$proSeq."\t".$orf_1."\n";
                }
                if (($f == 0) || ($f== -2))
                {
        ########## frame 2 ######
                $seq_2 = substr($revComSeq, 1);
                $proSeq = dna2protein($seq_2);
                @orf = longPep($proSeq, $strand, $pFlag, $qEnd);
                $orf_2 = $orf[0];
                $flag5 = $orf[1];
                push (@tmpA, $id."\t"."-2\t".$proSeq."\t".$orf_2."\t".$flag5);
        #       print $id."\t"."-2\t".$proSeq."\t".$orf_2."\n";
                }
                if (($f == 0) || ($f== -3))
        ########## frame 3 ########
                {
                $seq_3 = substr($revComSeq, 2);
                $proSeq = dna2protein($seq_3);
                @orf = longPep($proSeq, $strand, $pFlag, $qEnd);
                $orf_3 = $orf[0];
                $flag5 = $orf[1];
                push (@tmpA, $id."\t"."-3\t".$proSeq."\t".$orf_3."\t".$flag5);
        #       print $id."\t"."-3\t".$proSeq."\t".$orf_3."\n";
                }
        }

	elsif ($strand eq 'both')
	{

		#print $id."\t".$strand."\t".$f."\n";
		if (($f == 0) || ($f == +1))
		{
	####### frame 1 #######
		$proSeq =dna2protein($seq);
	#	print "frame 1:".$proSeq."\n";
		@orf = longPep($proSeq, $strand, $pFlag, $qEnd);
		$orf1 = $orf[0];
		$flag5 = $orf[1];
		push (@tmpA, $id."\t"."+1\t".$proSeq."\t".$orf1."\t".$flag5);
	#	print $id."\t"."+1\t".$proSeq."\t".$orf1."\n";
		}
		if (($f ==0) || ($f == +2))
		{
	########## frame 2 ######
		$seq2 = substr($seq, 1);
		$proSeq = dna2protein($seq2);
		@orf = longPep($proSeq, $strand, $pFlag, $qEnd);
		$orf2 = $orf[0];
		$flag5 = $orf[1];
		push (@tmpA, $id."\t"."+2\t".$proSeq."\t".$orf2."\t".$flag5);
	#	print $id."\t"."+2\t".$proSeq."\t".$orf2."\n";

		}
	########## frame 3 ########
		if (($f == 0) || ($f== +3))
		{
		$seq3 = substr($seq, 2);
		$proSeq = dna2protein($seq3);
		@orf = longPep($proSeq, $strand, $pFlag, $qEnd);
		$orf3 = $orf[0];
		$flag5 = $orf[1];
		push (@tmpA, $id."\t"."+3\t".$proSeq."\t".$orf3."\t".$flag5);
	#	print $id."\t"."+3\t".$proSeq."\t".$orf3."\n";
		}
 		$revComSeq = reverse $seq;
                $revComSeq =~ tr/ACGTacgt/TGCAtgca/;
	#	print $seq."\n";
	#	print $revComSeq."\n";

		if (($f == 0) || ($f== -1))
		{
		####### frame 1 #######
		$proSeq =dna2protein($revComSeq);
		@orf = longPep($proSeq, $strand, $pFlag, $qEnd);
		$orf_1 = $orf[0];
		$flag5 = $orf[1];
		push (@tmpA, $id."\t"."-1\t".$proSeq."\t".$orf_1."\t".$flag5);
	#	print $id."\t"."-1\t".$proSeq."\t".$orf_1."\n";
		}
		if (($f == 0) || ($f== -2))
		{
	########## frame 2 ######
		$seq_2 = substr($revComSeq, 1);
		$proSeq = dna2protein($seq_2);
		@orf = longPep($proSeq, $strand, $pFlag, $qEnd);
		$orf_2 = $orf[0];
		$flag5 = $orf[1];
		push (@tmpA, $id."\t"."-2\t".$proSeq."\t".$orf_2."\t".$flag5);
	#	print $id."\t"."-2\t".$proSeq."\t".$orf_2."\n";
		}
		if (($f == 0) || ($f== -3))
	########## frame 3 ########
		{
		$seq_3 = substr($revComSeq, 2);
		$proSeq = dna2protein($seq_3);
		@orf = longPep($proSeq, $strand, $pFlag, $qEnd);
		$orf_3 = $orf[0];
		$flag5 = $orf[1];
		push (@tmpA, $id."\t"."-3\t".$proSeq."\t".$orf_3."\t".$flag5);
	#	print $id."\t"."-3\t".$proSeq."\t".$orf_3."\n";
		}
	}
	$size = @tmpA;
	$flagT = 0; #middle exon (there is a stop codon at 5' end)

########### only one frame (frome BLASTX) ##########
if ($size == 1)
{
	@tmpB = split(/\t/, $tmpA[0]);
	$id = $tmpB[0];
	$f = $tmpB[1];
	$proSeq = $tmpB[2];
	$longestP = $tmpB[3];
	$flagT = $tmpB[4];
	if ($flagT ==1 || $flagT ==2)
	{
		if ($longestP =~ /M/)
		{
			$posM = index ($longestP, 'M');
			$pLength = length ($lonestP);
			if ($pLength - $posM > 20)
			{
				$pep = substr($longestP, $posM);
				$longestP = $pep;
			}
		}
	}
}

############# finding the mostly likely frame and most likely coding region ###############

########## check mid-flag: the region is between two stop codons ###########
else
{
	foreach $entry (@tmpA)
	{
		chomp ($entry);
	#	print $entry;
		@tmp = split (/\t/, $entry);
		$flagT = $tmp[4];
		if ($flagT == 1 || $flagT ==2 )
		{
			last;
		}
	}
	$iFlag = 0;
	###############
	foreach $entry (@tmpA)
	{
		chomp ($entry);
#		print "in the long P array:".$entry."\n";
		@tmp2 = split(/\t/, $entry);
		$pep = $tmp2[3];
		$length = length ($tmp2[3]);
		$flagT2 = $tmp2[4];

		if ($flagT == 1 || $flagT ==2)
		{
		 	if ($flagT2 ==1 )
			{
				if ($pep =~ /M/)
				{
					$posM = index ($pep, 'M');
					$pep1 = substr($pep, $posM);
					$length = length ($pep1);
					if ($length < 30)
					{
						 $length = 0;
						 $pep = '';
					}
					else
					{
						$pep = $pep1;
						if ($length > 100)
						{
							$iFlag= 1;
						} 
					}
				}
				else
				{
					if ($bFlag == 0) #if not frome blast
					{
						$length = 0;
						$pep = '';
					}
				}
			}
			elsif ($flagT2 ==2)
			{
				if ($pep =~ /M/)
				{
					$posM = index ($pep, 'M');
					$pep = substr($pep, $posM);
					$length = length($pep);
				}
				else
				{
					$pep = '';
					$length = 0;
				}
			}
			elsif ($flagT2 ==3 && $iFlag ==1) #in this frame, not the mid_peptide
			{
			#check if there is 'M', maybe a potential start codon
				if ($pep =~ /M/)
				{
					$posM = index ($pep, 'M');
					$pep = substr($pep, $posM);
					$length = length($pep);
				}
				else
				{
					$pep = '';
					$length = 0;
				}
			}
			else
			{
				$length = length($pep);
			}
		}


		else #in this frame, not the mid_peptide
		{
				$length = length($pep);
		}

		if ($longest < $length)
		{
			$longest = $length;
			$longestP = $pep;
			$f = $tmp2[1];
			$proSeq = $tmp2[2];
		}
		elsif ($longest == $length) ##handle the coding region is same, then used start codon to check.
		{
			$posM1 = index ($pep, 'M');
			$posM2 = index ($longestP, 'M');
			if ($posM1 < $posM2)
			{
				$longestP = $pep;
				$f = $tmp2[1];
				$proSeq = $tmp2[2];
			}
		}
	}
}

#if ($size >1 && length($longestP) > 90 && $longestP =~ /M/)
if (length($longestP) > 300 && $longestP =~ /M/)
{
	$subSeq = substr($longestP, 0, 100);
	if ($subSeq =~ /M/)
	{
		$posM = index ($subSeq, 'M');
		$pep = substr($longestP, $posM);
		$length = length($pep);
		if (length($pep) > 70)
		{
			$longestP = $pep;
		}
	}
}
elsif (length($longestP) > 100 && $longestP =~ /M/)
{
	$subSeq = substr($longestP, 0, 70);
	if ($subSeq =~ /M/)
	{
		$posM = index ($subSeq, 'M');
		$pep = substr($longestP, $posM);
		$length = length($pep);

		if (length($pep) >= 50)
		{
			$longestP = $pep;
		}
	}
}
elsif (length($longestP) > 70 && $longestP =~ /M/)
{
	$subSeq = substr($longestP, 0, 20);
	if ($subSeq =~ /M/)
	{
		$posM = index ($subSeq, 'M');
		$pep = substr($longestP, $posM);
		$length = length($pep);

		if (length($pep) >= 50)
		{
			$longestP = $pep;
		}
	}
}
	$pepMass = getMass($longestP);

	$posS = index ($proSeq, $longestP);
	$startP = abs($f) + $posS*3;
	$stopP = $startP + 3* length($longestP) -1;
	$orfLength = length($longestP);
	$f1 = 1;
	if ($longestP !~ /^M/ && $orfLength < 20)
	{
		$f1 = 0;
	}
	elsif ($longestP =~ /M/ && $orfLength <10)
	{
		$f1 = 0;
	}
	
	$lPep = $longestP;
	$longestP = '';
	for ($i = 0; $i < length($lPep); $i += 80)
	{
		$tmpS = substr($lPep, $i, 80);
		$longestP .= $tmpS."\n"; 
	}
		
	if ($size == 1)
	{
		push (@outA1, $id."\t".$f."\t".$pepMass."\t".$proSeq."\n");
		push (@outA3, $id."\t".$f."\n"); $longsestP =~ s/\*//g;
		if ($fsFlag ne '')
		{
			push (@outA2, ">".$id."\t".$f."\t$startP"."\t".$stopP."\t".$fsFlag."\n".$longestP);#.$proSeq."\n");
		}
		else
		{
			push (@outA2, ">".$id."\t".$f."\t$startP"."\t".$stopP."\n".$longestP);#.$proSeq."\n");
		}
	}
		
	else
	{
		if ($f1 != 0)
		{
			push (@outA1, $id."\t".$f."\t".$pepMass."\t".$proSeq."\n");
			push (@outA3, $id."\t".$f."\n"); $longsestP =~ s/\*//g;
			if ($fsFlag ne '')
			{
				push (@outA2, ">".$id."\t".$f."\t$startP"."\t".$stopP."\t".$fsFlag."\n".$longestP);#.$proSeq."\n");
		 	}
			else
			{
				push (@outA2, ">".$id."\t".$f."\t$startP"."\t".$stopP."\n".$longestP);#.$proSeq."\n");
			}
		}
		else
		{
			push (@outA4, $id."\t"."No ORF found"."\n");
		}	
	}
	#print $f."\t".$longestP."\n";
	@tmpA = ();
	$longest = 0;
	$proSeq = '';
	$longestP = '';
	$frame = $oriFrame;
	$startP = 0;
	$stopP = 0;
} #foreach loop


####################################!!!!!!!!!!! code Solaris #############
#open (FILE, "$output");
#@text =<FILE>;
#close (FILE);
#$message = "OrfPredictor";
#open MAIL, "| mail -s $message $Email" ;#|| die "Error running sending email";
#print MAIL "@text";
#close (MAIL);
#print "The work is done!!\n";

########## linux code #############
# $output = $ARGV[6];
#@tmp = split (/\//, $url);
#$usr = pop (@tmp);
#$saveDir = "/var/www/html/tools/user_results"."/$usr";
##############
open (OUT, ">$output"); # || die ("can not open for writting");
print OUT (@outA2);
close (OUT);

$noOrf = "noOrf.txt";
open (OUT, ">$noOrf");
print OUT (@outA4);
close OUT;

$orf6 = "ORF6frame.txt";
open (OUT, ">$orf6");
print OUT (@rawA);
close OUT;

#if ($Email ne 'NO')
#{
#        $subject = "OrfPredictor_results";
#        $msg = "Please note: do not reply to this message.\n\nPlease download your results of OrfPredictor at\n";
#        $msg .= $url."\nYour file will be kept for 3 days only and then removed.\n\n";
#        open MAIL, "| mail -s $subject $Email ";
#        print MAIL "$msg\n";
#       close (MAIL);
#}


exit;


#######################sub routine #############
sub codon2aa
{
	use strict;
	my ($codon) = @_;

        if ( $codon =~ /GC./i)        { return 'A' }    # Alanine
     elsif ( $codon =~ /TG[TC]/i)     { return 'C' }    # Cysteine
     elsif ( $codon =~ /GA[TC]/i)     { return 'D' }    # Aspartic Acid
     elsif ( $codon =~ /GA[AG]/i)     { return 'E' }    # Glutamic Acid
     elsif ( $codon =~ /TT[TC]/i)     { return 'F' }    # Phenylalanine
     elsif ( $codon =~ /GG./i)        { return 'G' }    # Glycine
     elsif ( $codon =~ /CA[TC]/i)     { return 'H' }    # Histidine
     elsif ( $codon =~ /AT[TCA]/i)    { return 'I' }    # Isoleucine
     elsif ( $codon =~ /AA[AG]/i)     { return 'K' }    # Lysine
     elsif ( $codon =~ /TT[AG]|CT./i) { return 'L' }    # Leucine
     elsif ( $codon =~ /ATG/i)        { return 'M' }    # Methionine
     elsif ( $codon =~ /AA[TC]/i)     { return 'N' }    # Asparagine
     elsif ( $codon =~ /CC./i)        { return 'P' }    # Proline
     elsif ( $codon =~ /CA[AG]/i)     { return 'Q' }    # Glutamine
     elsif ( $codon =~ /CG.|AG[AG]/i) { return 'R' }    # Arginine
     elsif ( $codon =~ /TC.|AG[TC]/i) { return 'S' }    # Serine
     elsif ( $codon =~ /AC./i)        { return 'T' }    # Threonine
     elsif ( $codon =~ /GT./i)        { return 'V' }    # Valine
     elsif ( $codon =~ /TGG/i)        { return 'W' }    # Tryptophan
     elsif ( $codon =~ /TA[TC]/i)     { return 'Y' }    # Tyrosine
     elsif ( $codon =~ /TA[AG]|TGA/i) { return '*' }    # Stop
     else { return 'X'} # for nucleotide as 'N' or n or others not 'AGCT'

 }


############################################
# A subroutine to translate DNA sequence int a protein
#
# the code is adapted by Jack Min from the same source as above, on Page 165
###############################################
sub dna2protein
{
	my ($dna) = @_;
	use strict;

	my ($protein) = '';
for (my $i =0; $i < (length($dna) -2); $i +=3)
{
	$protein .=codon2aa (substr($dna, $i, 3));
}


	return $protein;
}

##########################
# A subroutine to find the longest peptide without an internal stop codon
# sub longPep
# this subroutine is re-coded on Oct 18, 2008, the query end position information is not used
#############################
sub longPep
{
	my (@proA) = @_;
	use strict;
	my ($pro) = $proA[0];
	my ($strand) = $proA[1]; #strand
	my ($pFlag) = $proA[2]; #possible full-length or not
	my ($qEnd) = $proA[3]; #query alignment position
	my (@a) = (); #to save start and end position
	my (@tmp) = (); # to save tmp
	my ($start) = 0;
	my ($end) = 0;
	my ($seqLength) = length ($pro);
	my ($size) = 0;
	my ($longP) = '';
	my ($tmpP) = '';
	my ($longest) = 0;
	my ($tLength) = 0;
	my ($flag) = 0;
	my @pArray = ();
	if ($pro !~ /\*/)
	{
		$longP = $pro;
		$flag = 0; #no stop codon in the frame
	}
	else
	{
			@tmp = split (/\*/, $pro);
			$size = @tmp;
			if (($size == 1) && $pro !~ /^\*/)
			{			
				$pro =~ s/\*//g;
				$longP = $pro;
				$flag = 0;
			}			

		else
		{
			for (my $int = 0; $int < $size; $int++)
			{
				$tmpP = $tmp[$int]; #tmp peptide
				$tLength = length ($tmpP);
			   if ($int == $size -1)
				{	
					my $sub = substr($tmpP, -50);
					if (($tmpP =~ /KKKKKKK/) || ($sub =~ /KKKKK/))  #5 Ks for the polyA site, 'AAA' means 'K'
					{
						$tLength = 0;
					}
				}
				if (($int < $size -1) && ($int > 0))
				{
					if  ($tmpP !~ /M/)
					{
						$tLength = 0; #peptide within stop codons, if no 'M', no coding
					}
					else
					{
						my $pos = index ($tmpP, 'M');

						if (($tLength - $pos) < 20) #predicted protein less than 30 is not used
									    #this is an experience parameter (?)
						{
							$tLength = 0;
						}
					}
				}
				if ($int == $size -1)
				{
					if ($tmpP !~ /M/ && $qEnd == 0) #not from blast, there should have a M to be a coding region
					{
						$tLength = 0;
					}
				}
				if ($tLength > $longest)
				{
					$longest = $tLength;
					$longP = $tmpP;
				}
			}
		}
			if ($longP ne $tmp[0] && $longP ne $tmp[$size -1])
			{
				$flag = 1; #peptide located between 5' stop codon and 3' stop codon
			}

			if ($longP eq $tmp[$size -1])
			{
				$flag = 2; # 5' stop codon
			}
			if ($longP eq $tmp[0])
			{
				$flag = 3; #there is a 3' codon
			}
				
	}

# possible full-length in a blastx, to retrieve from 'potential start codon'
	if ($pFlag == 1) #possible full-length
	{
		my $s = substr($longP, 0, $qEnd/3);

		if ($s =~ /M/)
		{
			my $mPos = index ($s, 'M');
			$longP = substr($longP, $mPos);
		}
	}
	push (@pArray, $longP);
	push (@pArray, $flag);
	return @pArray;
}

sub get_next_record
{
	my($fh) = @_;
	use strict;
	my($offSet);
	my($record);
	my($seperator) = $/;
	$/ = "BLASTX";
#	$/ = "Matrix";
	$record =<$fh>;
	$/ =$seperator;
	return $record;
}

sub AAMass
{
	use strict;
	my ($AA) = @_;
	if ($AA eq 'A') {return 71.1}
	elsif ($AA eq 'R') {return 156.2}
	elsif ($AA eq 'N') {return 114.1}
	elsif ($AA eq 'D') {return 115.1}
	elsif ($AA eq 'C') {return 103.1}
	elsif ($AA eq 'Q') {return 128.1}
	elsif ($AA eq 'E') {return 129.1}
	elsif ($AA eq 'G') {return 57.1}
	elsif ($AA eq 'H') {return 137.2}
	elsif ($AA eq 'I') {return 113.2}
	elsif ($AA eq 'L') {return 113.2}
	elsif ($AA eq 'K') {return 128.2}
	elsif ($AA eq 'M') {return 131.2}
	elsif ($AA eq 'F') {return 147.2}
	elsif ($AA eq 'P') {return 97.1}
	elsif ($AA eq 'S') {return 87.1}
	elsif ($AA eq 'T') {return 101.1}
	elsif ($AA eq 'W') {return 186.2}
	elsif ($AA eq 'Y') {return 163.2}
	elsif ($AA eq 'V') {return 99.1}
	elsif ($AA eq 'X') {return 0.0}
}

sub getMass
{
	use strict;
	my ($peptide) = @_;
	my ($mass) = 0;
	my ($aa) = '';
	my ($length) = 0;
	$length = length($peptide);
	for (my ($i) = 0; $i < (length($peptide)); $i++)
	{
		$aa = substr($peptide, $i, 1);
		$mass += AAMass($aa);
	}
	if ($mass =~ /\./)
	{
		my @tmp = split (/\./, $mass);

                if ($tmp[1] >= 0.5)
                {
                        $mass = $tmp[0]+1;
                }
                else
                {
                        $mass = $tmp[0];
                }

	}
	return $mass;
}



#!/usr/bin/perl

##########
# Author: Jack MIN
# this program is to extract cds based on the orfpredictor's output
# 
#################################################################################
if ($#ARGV != 2)
{
	print "Usage: extractCDS.pl estFile orfPredictor.out output\n";
	exit;
}
########## variables to catch user's input ########
$seqF = $ARGV[0];
$orfF = $ARGV[1];
$outF = $ARGV[2];
#$url = $ARGV[3];
############## store squences in harse ##########
%seqH = (); # a hash for storing seqID (key) and seq (value)
@seqA = ();
$line =();
@outA = ();
######## store the sequence in a hash table ###########
open (IN, $seqF) || die ("Cannot open file $seqFile\n\n");
$value ='';
$key = '';
$count =0; #to indicate the first ">"
$seqFlag = 0;
while (<IN>)
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
		#	print $key."\t".$value."\n";
			$value ='';
			$key ='';
		}
		@tmpA = split(/[\s+\t]/, $line);
		$key = substr($tmpA[0], 1);
	}
	else
	{
		$value .= $line;
	}
}
$value =~ s/\s//g;
$value = uc($value);
$seqH{$key} = $value;
close (IN);
#################
$frame = 0;
open (IN, $orfF) || die ("Cannot open file $seqFile\n\n");
$value ='';
$key = '';
$count =0; #to indicate the first ">"
$seqFlag = 0;
while (<IN>)
{
	$line = $_; #$_, default input variable
	chomp ($line);
	if ($line =~ /^>/)
	{
		@tmp = split(/\t/, $line);
		$id = substr($tmp[0], 1);
		$frame = $tmp[1];
		$start = $tmp[2];
		$end = $tmp[3];
		#print $id."\t".$frame." ".$start." ".$end."\n";
		$seq = lc($seqH{$id});
		#print $seq."\n";
		$len = $end-$start+1;
		if ($frame > 0)
		{
			$cds = substr($seq, $start-1, $len);
		}
		else
		{
			 $revSeq = reverse ($seq);
             $revSeq =~ tr/acgt/tgca/; 
			$cds = substr($revSeq, $start-1, $len); 
		}
		push (@outA, ">".$id."\n");
		push (@outA, $cds."\n");
     }
}
close (IN);
open (OUT, ">$outF");
print OUT (@outA);
close (OUT);
exit;

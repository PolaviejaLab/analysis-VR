#!/usr/bin/perl
$dirVR= 'V:\Data\05. Experiment2_PilotsOfNoise';
#$dirVR='K:\VR';
#mkdir "$dirVR\\res";
$dirUnity= 'Unity_Files';



opendir(my $dh, $dirVR) || die;
while(readdir $dh)
{
	if ($_ =~ /^Sub/)
	{

# print "\n\n\n";
		$part=$_;
		#print "$part\n";
		opendir(my $dh2, "$dirVR\\$part\\Unity_Files");
		$fileout = "$dirVR\\$part\\Unity_Files\\protocol_code.txt";
		open($out, '>', $fileout);
		
		@fileset=();
		while (readdir $dh2) 
		{
#print "$dirVR\\$part\\Unity_Files\n";
			if ($_ =~ /.bin/)
			{
				$filebit = "$dirVR\\$part\\Unity_Files\\$_";
			}	
			elsif ($_ =~ /.csv/)
			{
				$filefra = "$dirVR\\$part\\Unity_Files\\$_";
			}		
			elsif ($_ =~ /.log/)
			{
				$filelog = "$dirVR\\$part\\Unity_Files\\$_";
			}
		}
		closedir $dh2;
#print "$filelog\n";

		open(INFO, $filelog);
		@lines=<INFO>;
		close(INFO);




foreach $lines (@lines)
{

	chomp $lines;
	if ($lines =~ /NoiseLevel/)
	{

		if ($lines =~ /0$/)
		{
			$noise = 0;
		}
		else
		{
			$noise = 1;
			#print $OUT4 "NO\n";
		}
	}

	elsif ($lines =~ /Gap/)
	{

		if ($lines =~ /Inactive$/)
		{
			$gap = 0;
		}
		else
		{
			$gap = 1;
		}
	}

	elsif ($lines =~ /HandOffset/)
	{
		if ($lines =~ /10$/)
		{
			$offset = 1;
		}
		else
		{
			$offset = 0;
		}
	}
	elsif ($lines =~ /RealTrue/)
	{
		$real = 1;
	}
	elsif ($lines =~ /Starting trial/)
	{

		$noise=0;
		$offset=0;
		$gap=0;
		$real=0;
		#print "$trial\n";
	}
	elsif ($lines =~ /Falling/)
	{
	chomp $lines;
	@prerow=split(/\, /,$lines);
	@row=split(/T/, $prerow[0]);
	#print "$row[0]\n";
	@set=split(/Z/, $row[1]);
	#print "$set[0]\n";
	@row2=split(/\./, $set[0]);
	$micro=$row2[1];
	@set2=split(/\:/, $row2[0]);
	$hour=$set2[0];
	$min=$set2[1];
	$seg=$set2[2];
	}
	elsif ($lines =~ /Questionnaires/)
	{
		
		$suffix[0]=0;
		$suffix[1]=0;
		$suffix[2]=0;
		$suffix[3]=0;
		if ($offset == 1)
		{
			$suffix[3]=1;
			if ($real==1)
			{
				$suffix[0]=1;
			}
			if ($gap==1)
			{
				$suffix[1]=1;
			}
			if ($noise==1)
			{
				$suffix[2]=1;
			}
			
			$code = $suffix[0] . $suffix[1] . $suffix[2] . $suffix[3];
			
			print $out "$code\n";
		
				

				
		}
		else
		{
			$suffix[3]=0;
			if ($real==1)
			{
				$suffix[0]=1;
			}
			if ($gap==1)
			{
				$suffix[1]=1;
			}
			if ($noise==1)
			{
				$suffix[2]=1;
			}
			
			$code = $suffix[0] . $suffix[1] . $suffix[2] . $suffix[3];
			print $out "$code\n";
		
				

				
		}
			
	}

}
}
close $out;
}
close $OUT1;
close $OUT2;
close $OUT3;
close $OUT4;




closedir $dh;
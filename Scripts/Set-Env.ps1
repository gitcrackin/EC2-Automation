<# 
  Title:   Set-Env.ps1
  Purpose: Set the environment for the EC2 API tools.
  
  Microsoft Build Version Reference:
  Windows 8					6.2
  Windows Server 2012		6.2
  Windows 7					6.1
  Windows Server 2008 R2	6.1
  Windows Server 2008		6.0
  Windows Vista				6.0
  Windows Server 2003 R2	5.2
  Windows Server 2003		5.2
  Windows XP 64-Bit Edition	5.2
  Windows XP				5.1
#>


# Determine the Windows version
$buildVersion = [System.Environment]::OSVersion.Version
$winVersion = [string]$buildVersion.Major + '.' + [string]$buildVersion.Minor

# Search for JRE in Program Files (x86)
if($buildVersion.Major -ge 6){
	<# Loop through installed JREs and find the latest version.
	   Could use to find the latest version:  
	   gwmi -class Win32_Product | select Name, Version | where {$_.Name -cmatch "Java"}
	   But, the WMI Win32_Product class is insanely slow.  May be better to just check the dir 
	#>
	
	# Initialize $latestVer variable
	$latestVer = 0
	ls 'C:\Program Files (x86)\Java' | %{
		#$jreVer = ($_.Name).split('e')
		#$varLenth = ($_.Name).length
		#$jreVer = ($_.Name).Chars($varLenth-1)
		#[string]$jreVer
		$jreDir = $_.Name
		$index = [int]"$($jreDir[-1])"
		#[System.Convert]::ToInt32($jreVer)
		if($index -gt $latestVer){
			$latestVer = $index
		}
	}
	$env:JAVA_HOME='C:\Program Files (x86)\Java\jre'+[string]$latestVer
	$JAVA_HOME='C:\Program Files (x86)\Java\jre'+[string]$latestVer
}
else{
	$latestVer = 0
	ls 'C:\Program Files\Java' | %{
		$jreDir = $_.Name
		$index = [int]"$($jreDir[-1])"
		if($index -gt $latestVer){
			$latestVer = $index
		}
	}
	$env:JAVA_HOME='C:\Program Files\Java\jre'+[string]$latestVer
	$JAVA_HOME='C:\Program Files\Java\jre'+[string]$latestVer
}

# Search for JRE in Program Files

# Set PoSH environment
$EC2_HOME="C:\Program Files (x86)\ec2-api-tools-1.6.5.2"

# Set CMD environment
$env:JAVA_HOME='C:\Program Files (x86)\Java\jre'+[string]$latestVer
$env:EC2_HOME="C:\Program Files (x86)\ec2-api-tools-1.6.5.2"
$env:Path = $env:EC2_HOME + "\bin;" + $env:JAVA_HOME + "\bin;" + $env:Path
#java -version

# -O and -W defaults to $env:AWS_ACCESS_KEY and $env:AWS_SECRET_KEY
# if set.  
# ex. ec2-describe-regions 
$env:AWS_ACCESS_KEY = Read-Host "Enter your AWS Access Key ID "
$env:AWS_SECRET_KEY = Read-Host "Enter your AWS Secret Access Key "

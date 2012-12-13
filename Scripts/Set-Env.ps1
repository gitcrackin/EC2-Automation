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
}
else{
	$latestVer = 0
	ls 'C:\Program Files (x86)\Java' | %{
		$jreDir = $_.Name
		$index = [int]"$($jreDir[-1])"
		if($index -gt $latestVer){
			$latestVer = $index
		}
	}
	$env:JAVA_HOME='C:\Program Files (x86)\Java\jre'+[string]$latestVer
}

# Search for JRE in Program Files

# Set PoSH environment
$JAVA_HOME='C:\Program Files (x86)\Java\jre'+[string]$latestVer
$EC2_HOME="C:\Program Files (x86)\ec2-api-tools-1.6.5.2"

# Set CMD environment
$env:JAVA_HOME='C:\Program Files (x86)\Java\jre'+[string]$latestVer
$env:EC2_HOME="C:\Program Files (x86)\ec2-api-tools-1.6.5.2"
$env:Path = $env:EC2_HOME + "\bin;" + $env:JAVA_HOME + "\bin;" + $env:Path
#java -version

# Secure variables
# AWS_ACCESS_KEY with the -O option of the EC2 API tools.
# AWS_SECRET_KEY with the -W option of the EC2 API tools. 
# ex. ec2-describe-regions -O $AWS_ACCESS_KEY -W $AWS_SECRET_KEY
$global:awsaccess = Read-Host "Enter your AWS Access Key ID: "
$global:awssecret = Read-Host "Enter your AWS Secret Access Key: "
Write-Host "To use the Access Key and Secret Key variables supply them with the -O and -W args."
Write-Host "Usage Example: ec2-describe-regions -O $awsacces -W $awssecret"

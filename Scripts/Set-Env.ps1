<# 
  Title:   Set-Env.ps1
  Purpose: Set the environment for the EC2 API tools.
#>

# Determine the Windows version
$osVerArray = [System.Environment]::OSVersion.Version

# Set PoSH environment
$JAVA_HOME="C:\Program Files (x86)\Java\jre7"
$EC2_HOME="C:\Program Files (x86)\ec2-api-tools-1.6.5.2"

# Set CMD environment
$env:JAVA_HOME="C:\Program Files (x86)\Java\jre7"
$env:EC2_HOME="C:\Program Files (x86)\ec2-api-tools-1.6.5.2"
$env:Path = $env:EC2_HOME + "\bin;" + $env:JAVA_HOME + "\bin;" + $env:Path
#java -version

# Secure variables
# AWS_ACCESS_KEY with the -O option of the EC2 API tools.
# AWS_SECRET_KEY with the -W option of the EC2 API tools. 
# ex. ec2-describe-regions -O $AWS_ACCESS_KEY -W $AWS_SECRET_KEY
$AWS_ACCESS_KEY = Read-Host -AsSecureString "Enter your AWS Access Key ID: "
$AWS_SECRET_KEY = Read-Host -AsSecureString "Enter your AWS Secret Access Key: "
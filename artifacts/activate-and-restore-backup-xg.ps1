Param
(
  [Parameter (Mandatory= $true)]
  [String] $password,
  [Parameter (Mandatory= $true)]
  [String] $portagw,
  [Parameter (Mandatory= $true)]
  [String] $portbgw,
  [Parameter (Mandatory= $true)]
  [String] $hostname,
  [Parameter (Mandatory= $true)]
  [String] $licensea,
  [Parameter (Mandatory= $true)]
  [String] $licenseb,
  [Parameter (Mandatory= $true)]
  [String] $sshport,
  [Parameter (Mandatory= $true)]
  [String] $sfmip
)
$secpassword = ConvertTo-SecureString $password -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ("admin", $secpassword)
$session = New-SSHSession -ComputerName $hostname -Credential $creds -AcceptKey -Port $sshport
$SSHStream = New-SSHShellStream -SessionId $session.SessionId
$licenseblock = @"
opcode lic_doactivate -s nosync -t json -b '{"serialkey": "$licenseb"}'
"@
$sfmblock = @"
opcode update_central_management -s nosync -t json -b '{"cmtype":"1","___serverport":4444,"heartbeatprotocolport":"443","heartbeatprotocol":"https","centralselection":"sfm","CCCAsAppMgt":"1","chkSecureHBIC":"true","icprotocol":"https","___serverprotocol":"HTTP","adslprotocol":"https","enableccc":"yes","adslport":"443","icprotocolport":"443","cccipaddress":"$sfmip","behindadsl":"no"}'
"@
If ($session.Connected) {
    Start-Sleep -s 10
	$SSHStream.WriteLine("a")
    Start-Sleep -s 5
	$SSHStream.WriteLine(" ")
	$SSHStream.WriteLine(" ")
	Start-Sleep -s 5
	$SSHStream.WriteLine("5")
    Start-Sleep -s 5
    $SSHStream.WriteLine("3")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$licenseblock")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$sfmblock")
    Start-Sleep -s 5
    $SSHStream.WriteLine("telnet localhost zebra")
    Start-Sleep -s 5
    $SSHStream.WriteLine("enable")
    Start-Sleep -s 5
	$SSHStream.WriteLine("configure terminal")
    Start-Sleep -s 5
    $SSHStream.WriteLine("ip route 168.63.129.16/32 $portagw PortA")
    Start-Sleep -s 3
	$SSHStream.WriteLine("ip route 168.63.129.16/32 $portbgw PortB")
    Start-Sleep -s 3
	$SSHStream.WriteLine("write")
    Start-Sleep -s 5
    $SSHStream.WriteLine("reboot")
    Start-Sleep -s 2
    $SSHStream.Read()  
    Remove-SSHSession -SessionId $session.SessionId > $null
}
Else {
    "Could not connect to XG"
    Get-SSHSession | Remove-SSHSession > $null
}
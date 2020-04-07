function testHost-Maphost
{
	if (Test-Connection -ComputerName $targetHostname -Quiet)
	{
		New-PSDrive -Name "TargetHostComputer" -PSProvider "FileSystem" -Root "\\$targetHostName\c$" -Credential $targetHostCredSet
		$targetHostPSDriveBoolTest = Test-Path -Path "TargetHostComputer:" -IsValid
		Write-Host -ForegroundColor Blue "The PSDrive for $targetHostName C:\ drive is connected to this tool = $targetHostPSDriveBoolTest"
	}
	else
	{
		Write-Host -ForegroundColor Red "The Test-Connection cmdlet had issues communicating with $targetHostname, verify network connectivity and try again."
		$repeatNetTest = Read-Host -Prompt "Press Q to quit OR press T to test connection to $targetHostname again."
		if ($repeatNetTest -eq "t")
		{
			testHost-Maphost
		}
		else
		{
			Exit 
		}
	}
}

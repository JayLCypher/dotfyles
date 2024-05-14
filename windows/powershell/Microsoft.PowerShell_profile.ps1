fastfetch.exe
oh-my-posh init pwsh | Invoke-Expression
Import-Module Terminal-Icons

Set-Alias node bun
Set-Alias npm bun
Set-Alias wget wget2

# Set-Alias -name . -value cd .
# Set-Alias -name .. -value cd ..

# Function . { Set-Location -Path . }
Function .. { Set-Location -Path .. }
function Admin {Start-Process PowerShell -Verb RunAs}

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Enter -BriefDescription 'Custom OhMyPoshEnterKeyHandler' -ScriptBlock {
	try {
		$executingCommand = Set-TransientPrompt;
		[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine();
		# Write FTCS_COMMAND_EXECUTED after accepting the input - it should still happen before execution
		if (("::FTCS_MARKS::" -eq "true") -and $executingCommand) {
			Write-Host "$([char]0x1b)]133;C`a" -NoNewline;
		}
	}
	catch [System.Management.Automation.CommandNotFoundException] {
		$path = $cursor = $null
		[Microsoft.Powershell.PSConsoleReadline]::GetBufferState([ref]$path, [ref]$cursor);
		if (Test-Path -LiteralPath $path) {
			# Write-Host "$($path) is Path"
			[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine();
			Set-Location -Path $path;
		}
		else {
			# Write-Host "$($path) is not Path"
		}
		[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine();
	}
	finally {}
}

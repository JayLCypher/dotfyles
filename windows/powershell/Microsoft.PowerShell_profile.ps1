Clear-Host # Clean the screen
fastfetch.exe # Run FastFetch
oh-my-posh init pwsh | Invoke-Expression # Initialize OhMyPosh
Import-Module Terminal-Icons # Import Terminal Icons

# Set aliases.
Set-Alias -name node -value bun
Set-Alias -name npm -value bun
Set-Alias -name wget -value wget2

# Create functions available in Powershell.
# function . { Set-Location -Path . } # . is a keyword in Powershell.
# function .. { Set-Location -Path .. } # Not needed with my beautiful EnterKeyHandler :)
function Admin {Start-Process PowerShell -Verb RunAs}
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue | 
		Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue;
}

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
if ($ExecutionContext.SessionState.LanguageMode -ne "ConstrainedLanguage") {
	Set-PSReadLineKeyHandler -Key Enter -ScriptBlock {
		try {
			$parseErrors = $null;
			[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$null, [ref]$null, [ref]$parseErrors, [ref]$null);
			$executingCommand = $parseErrors.Count -eq 0;
		}
		finally {
			$path = $null;
			[Microsoft.Powershell.PSConsoleReadline]::GetBufferState([ref]$path, [ref]$null);
			if (Test-Path -LiteralPath $path) {
				Set-Location -Path $path;
				[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine();
			}
			[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine();
			# Write FTCS_COMMAND_EXECUTED after accepting the input - it should still happen before execution
			if ($executingCommand) { Write-Host "$([char]0x1b)]133;C`a" -NoNewline; }
		}
	}
}

Write-Host "Finished loading profile.";

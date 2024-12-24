
#
# Powershell stuff
#
# - All of this assumes powershell 5.
# - This config file is should be located at: "$Profile.CurrentUserAllHosts"

# Aliases
Set-Alias -name 'npp' -value 'C:\Program Files\Notepad++\notepad++.exe'
Set-Alias -name 'ex' -value 'explorer'

# Show powershell version
Function psver {
	echo $PSVersionTable
	echo "`r`n"
	echo $profile | select *
}

# Edit profile
Function ep {
    npp $Profile.CurrentUserAllHosts
}

# Edit local profile
Function elp {
    npp $Profile.CurrentUserCurrentHost
}

# Reload profile
# TODO: Fix bug where functions are cached, which prevents rapid iteration
Function reload {
	# Since we're using profile.ps1, just doing . $PROFILE won't work. By default
	# $PROFILE points to $Profile.CurrentUserCurrentHost. The following snippet 
	# reloads all files.
	# https://stackoverflow.com/a/5501909
	@(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | % {
        if(Test-Path $_){
            . $_ -Force
        }
    }
}

# Reload environment variables
Function refreshenv {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Linux equivalent of touch
Function touch {
    $filePath = $args[0]
    if($filePath -eq $null) {
        throw "No filename supplied"
    }

    if(Test-Path $filePath)
    {
        (Get-ChildItem $filePath).LastWriteTime = Get-Date
    }
    else
    {
		$directoryPath = [IO.Path]::GetFullPath($filePath) | Split-Path
		$null = New-Item -ItemType Directory -Path $directoryPath -Force
        echo $null > $filePath
    }
}

#
# Starship
#

$env:STARSHIP_CACHE  = "$env:localappdata\Temp"
$env:STARSHIP_CONFIG = "$env:localappdata\starship\starship.toml"
Invoke-Expression (&starship init powershell)

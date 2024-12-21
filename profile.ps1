
#
# Powershell stuff
#
# NOTE: All of this assumes powershell 5.


# Aliases
Set-Alias -name 'npp' -value 'C:\Program Files\Notepad++\notepad++.exe'

# Show powershell version
Function psver {
	echo $PSVersionTable
	echo "`r`n"
	echo $profile | select *
}

# Edit profile
Function ep {
    Invoke-Expression (&npp $profile)
}

# Reload profile
# TODO: Fix bug where functions are cached, which prevents rapid iteration
Function reload {
	# Since we're using profile.ps1, just doing . $PROFILE won't work. By default
	# $PROFILE points to some whacky filepath ($Profile.CurrentUserAllHosts). The following
	# snippet reloads them all.
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
		$directoryPath = Split-Path -Path $filePath
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

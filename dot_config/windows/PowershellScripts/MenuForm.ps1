# Load necessary assembly for creating a GUI
Add-Type -AssemblyName System.Windows.Forms

#TODO: make ExecutablePath deduction automatic without hardcoding the Paths
$applications = @(
    @{ Name = 'Discord'; ProcessName = 'Discord'; ExecutablePath = 'C:\Users\dylan\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\discord.lnk' },
    @{ Name = 'Edge'; ProcessName = 'msedge'; ExecutablePath = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe' },
    @{ Name = 'Teams'; ProcessName = 'Teams'; ExecutablePath = 'C:\Users\dylan\AppData\Local\Microsoft\Teams\Update.exe' },
    @{ Name = 'LeagueOfLegends'; ProcessName = 'LeagueClientUx'; ExecutablePath = 'C:\Riot Games\Riot Client\RiotClientServices.exe' },
    @{ Name = 'mRemoteNG'; ProcessName = 'mRemoteNG'; ExecutablePath = 'C:\Program Files (x86)\mRemoteNG\mRemoteNG.exe' },
    @{ Name = 'Obsidian'; ProcessName = 'obsidian'; ExecutablePath = 'C:\Users\dylan\AppData\Local\Obsidian\Obsidian.exe' },
    @{ Name = 'WSL Debian'; ProcessName = 'debian'; ExecutablePath = 'C:\Program Files\WindowsApps\TheDebianProject.DebianGNULinux_1.15.0.0_x64__76v4gfsz19hv4\debian.exe' },
    @{ Name = 'KeePassXC'; ProcessName = 'KeePassXC'; ExecutablePath = 'C:\Program Files\KeePassXC\KeePassXC.exe' },  
    @{ Name = 'GitHub Desktop'; ProcessName = 'GitHubDesktop'; ExecutablePath = 'C:\Users\dylan\AppData\Local\GitHubDesktop\GitHubDesktop.exe' },  
    @{ Name = 'Linphone'; ProcessName = 'Linphone'; ExecutablePath = 'C:\Program Files\Linphone\bin\linphone.exe' }  
)

function Start-MultiChoiceMenu {
    param (
        [string]$windowTitle,
        [string[]]$options
    )

    # Create a new instance of the CheckedListBox class
    $checkedListBox = New-Object System.Windows.Forms.CheckedListBox

    # Set the properties of the checkedListBox object
    $checkedListBox.Height = 200
    $checkedListBox.Width = 300

    # Add items to the checkedListBox object
    foreach ($option in $options) {
        $checkedListBox.Items.Add($option, $false) | Out-Null
    }

    # Create a new instance of the Form class
    $form = New-Object System.Windows.Forms.Form

    # Set the properties of the form object
    $form.Text = $windowTitle
    $form.Size = New-Object System.Drawing.Size(350,300)

    # Add the checkedListBox object to the form object
    $form.Controls.Add($checkedListBox)

    # Create a new instance of the Button class
    $button = New-Object System.Windows.Forms.Button

    # Set the properties of the button object
    $button.Text = 'Submit'
    $button.Top = 220
    $button.Left = 125

    # Define a function to update the selected items and close the form
    $updateAndClose = {
        $script:selectedItems = $checkedListBox.CheckedItems | ForEach-Object { $_.ToString() }
        $form.Close()
    }

    # Add an event handler for the Click event of the button object
    $button.Add_Click($updateAndClose)

    # Add the button object to the form object
    $form.Controls.Add($button)

    # Add an event handler for the KeyDown event of the checkedListBox object
    $checkedListBox.Add_KeyDown({
        if ($_.KeyCode -eq 'Enter') {
            & $updateAndClose
        } elseif ($_.KeyCode -eq 'Escape') {
            $form.Close()
        }
    })

    # Display the form
    $form.ShowDialog() | Out-Null

    # Return the selected items
    return $script:selectedItems
}

function Start-Applications {
    param (
        [Hashtable[]]$applications,
        [string[]]$selectedApplicationNames
    )

    # Filter the applications to include only the selected applications
    $selectedApplications = $applications | Where-Object { $selectedApplicationNames -contains $_.Name }

    foreach ($application in $selectedApplications) {
        $processName = $application.ProcessName

        # Try to resolve the path to the executable
        $executablePath = (Get-Command -Name $processName -ErrorAction SilentlyContinue).Source

        if ($executablePath) {
            # Check if the application is already running
            $existingProcess = Get-Process | Where-Object { $_.ProcessName -eq $processName }

            # If the application is not running, start it
            if (-not $existingProcess) {
                Start-Process $executablePath
            }
        }
        else {
            Write-Warning "Could not find executable for $processName"
        }
    }
}
function Start-Applications {
    param (
        [Hashtable[]]$applications,
        [string[]]$selectedApplicationNames
    )

    # Filter the applications to include only the selected applications
    $selectedApplications = $applications | Where-Object { $selectedApplicationNames -contains $_.Name }

    foreach ($application in $selectedApplications) {
        $processName = $application.ProcessName
        $executablePath = $application.ExecutablePath

        # Check if the application is already running
        $existingProcess = Get-Process | Where-Object { $_.ProcessName -eq $processName } | Select-Object -First 1

        # If the application is not running, start it
        if (-not $existingProcess) {
            Start-Process $executablePath
        }
    }
}
# Extract the application names to display in the menu
$applicationNames = $applications.Name

# Prompt the user to select applications to launch
# Window title is usefull for glazeVM 
$selectedApplicationNames = Start-MultiChoiceMenu -windowTitle 'MenuList' -options $applicationNames

# Launch the selected applications
Start-Applications -applications $applications -selectedApplicationNames $selectedApplicationNames


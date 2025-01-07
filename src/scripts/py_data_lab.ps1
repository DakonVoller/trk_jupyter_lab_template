param (
    [switch]$tools,
    [switch]$poetry,
    [switch]$py_in_vsce,
    [switch]$jupyter,
    [switch]$test,
    [switch]$help
)
if ($help) {
    Write-Output "Usage: py_data_lab.ps1 [-tools] [-poetry] [-vsce] [-jupyter] [-test] [-help]"
    Write-Output "  -tools: Install tools like vscode get etc"
    Write-Output "  -poetry: Install Python Poetry"
    Write-Output "  -py_in_vsce: Install Python extenions for Visual Studio Code "
    Write-Output "  -jupyter: Install Jupyter Lab, and data wrangler Visual Studio Code Extensions"
    Write-Output "  -test: Test mode see list of things any option installs."
    Write-Output "  -help: Show this help"
    exit
}

if ($tools) {
    # START: Install tools
    $toolkit_winget= @"
Python.Python.3.12
Git.Git
Microsoft.Powershell
Microsoft.VisualStudioCode
UB-Mannheim.TesseractOCR
"@
    foreach ($tool in $toolkit_winget -split "`n") {
        if ($test) {
            Write-Output "winget install --id $tool"
        } else {
            & winget install --id $tool
        }
    }
    # END: Install tools
}

if ($poetry) {
    # Install Python Poetry
    if ($test) {
        Write-Output "pip install pipx`npipx install poetry"
    } else {
        pip install pipx
        pipx install poetry
    }
}

if ($py_in_vsce) {
    $py_in_vsce_list = @"
donjayamanne.githistory
ms-python.debugpy
ms-python.python
ms-python.vscode-pylance
ms-vscode.powershell
zeshuaro.vscode-python-poetry
"@

    foreach ($extension in $py_in_vsce_list -split "`n") {
        if ($test) {
            Write-Output "code --install-extension $extension"
        } else {
            & code --install-extension $extension
        }
    }
}

if ($jupyter) {
    $jupyter_vsce_list = @"
ms-toolsai.jupyter
ms-toolsai.jupyter-keymap
ms-toolsai.jupyter-renderers
ms-toolsai.python-ds-extension-pack
"@

    foreach ($extension in $jupyter_vsce_list -split "`n") {
        if ($test) {
            Write-Output "code --install-extension $extension"
        } else {
            & code --install-extension $extension
        }
    }
}

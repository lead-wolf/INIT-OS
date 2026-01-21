oh-my-posh init pwsh --config "~\Documents\WindowsPowerShell\easy-term.omp.json" | Invoke-Expression

Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource History

clear-host

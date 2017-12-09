function Update-ITGlueModule {
    Remove-Module ITGlueAPI
    iex (New-Object Net.WebClient).DownloadString("https://bit.ly/ITGluePoSh")
}
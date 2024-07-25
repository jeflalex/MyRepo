


function Get-FileName($initialDirectory) {
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.initialDirectory = $initialDirectory
$OpenFileDialog.filter = "CSV Files (*.csv)|*.csv|All Files (*.*)|*.*"
$OpenFileDialog.ShowDialog() | Out-Null
$OpenFileDialog.filename
}

function Get-Folder($initialDirectory) {
[System.Reflection.Assembly]::LoadWithPartialName("system.windows.forms") | Out-Null
$foldername = New-Object System.Windows.Forms.FolderBrowserDialog
$foldername.Description = "Select a folder"
$foldername.SelectedPath = $initialDirectory
if($foldername.ShowDialog() -eq "OK") {
$folder += $foldername.SelectedPath
}
return $folder
}

$pickerpath = "C:\wrkspc"

$filepath = Get-FileName -initialDirectory $pickerpath
if (!$filepath) { 
Write-Host "No file selected or seletion interrupted. Press any key to exit."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
$Host.UI.RawUI.Flushinputbuffer()
Exit
}

$file = $filepath

$delimiter = ","
$numberOfColumns = Get-Content $file -head 1 | 
    ForEach-Object{($_.split($delimiter)).Count} | 
    Measure-Object -Maximum | 
    Select-Object -ExpandProperty Maximum


Function MsgBox($Message, $Title)
{
   [void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
   [Microsoft.VisualBasic.Interaction]::MsgBox($Message, "SystemModal,Information", $Title)
}
 
MsgBox "This file has $($numberOfColumns) columns." "This CVS File "




foreach ($line in Get-Content $file){
  $arr = $file -split ','
  [array]$OutputFile += $line  
}
$OutputFile | out-file -filepath "C:\wrkspc\399808new_VALID.csv" -Encoding "ascii" -append 
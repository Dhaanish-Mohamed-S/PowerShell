#Read text files inside zip files without extracting it using powershell

#importing the module required for reading zip files
Add-Type "sytem.io.compression.filesystem"

#Name of the file you want to read from zip
$fileName = "myFile.log"

#Give the path of your zip file
$zipFilePath = "D:\Zip Files\MyZipFile.zip"

#Open the zip file
$zipFileContents = ([System.IO.Compression.ZipArchive]([System.IO.Compression.ZipFile]::OpenRead($zipFilePath)))

#Get the required file to read inside the zip
$fileNameToRead =  $zipFileContents.GetEntry($fileName)

#Using streamreader to read the file contents fast
$reader = New-Object -TypeName System.IO.StreamReader -ArgumentList $fileNameToRead.Open()

#There are two methods to iterate through the log files read using streamreader inside a zip file
##### Note: You should use either one of the methods ######

#Method-1:Iterate through the lines in the log file
while(-not $reader.EndOfStream){
  #Get the current line
  $reader.ReadLine()
  
  #"You can do the operation you want you want"
}

#Method-2:Iterate through the lines in the log file
#Get all the contents in a sinle string

$AllContentsOfFileAsString = $reader.ReadToEnd()

foreach($line in $AllContentsOfFileAsString.Split('`n')){
  echo $line
  #"You can do the operation you want you want"
}

#Close the streareader to free up the memory and the file
$reader.close()



$Url = "http://127.0.0.1:8080/api/info/list"

$web = Invoke-WebRequest -Uri $Url -Headers @{
    "Pragma"          = "no-cache"
    "Cache-Control"   = "no-cache"
    "Accept"          = "application/json, text/plain,*/*"
    "User-Agent"      = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36"
    "Referer"         = "http://127.0.0.1:8080/app/"
    "Accept-Encoding" = "gzip, deflate"
    "Accept-Language" = "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7"
} -UseBasicParsing; 
                           
$DateContent = $web.RawContent;
if ($args[0] -eq "UTMversion"){                            
    
        $parsed = [Regex]::Matches($DateContent,'{"version":"(.+)","contour":"prod","rsaError":(.+),"checkInfo":(.+),"ownerId":"(.+)","db":{"createDate":"(.+)","ownerId":"(.+)"},"rsa":{"certType":"RSA","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"pki.fsrar.ru"},"gost":{"certType":"GOST","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"(.+)"},"license":(.+)}')     
       
        write-output $parsed[0].Groups[1].Value #version
}#Версия УТМ
if ($args[0] -eq "EGAISrsaError"){                            
    
        $parsed = [Regex]::Matches($DateContent,'{"version":"(.+)","contour":"prod","rsaError":(.+),"checkInfo":(.+),"ownerId":"(.+)","db":{"createDate":"(.+)","ownerId":"(.+)"},"rsa":{"certType":"RSA","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"pki.fsrar.ru"},"gost":{"certType":"GOST","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"(.+)"},"license":(.+)}')     
        if("null" -eq [String]$parsed[0].Groups[2].Value){
        write-output "0"
        }
        else{
                write-output $parsed[0].Groups[2].Value #rsaError
        }
}#Ошибки RSA
if ($args[0] -eq "EGAIScheckInfo"){                            
    
        $parsed = [Regex]::Matches($DateContent,'{"version":"(.+)","contour":"prod","rsaError":(.+),"checkInfo":(.+),"ownerId":"(.+)","db":{"createDate":"(.+)","ownerId":"(.+)"},"rsa":{"certType":"RSA","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"pki.fsrar.ru"},"gost":{"certType":"GOST","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"(.+)"},"license":(.+)}')     
       
        write-output $parsed[0].Groups[3].Value #checkInfo
}#Неотправленные чек
if ($args[0] -eq "EGAISownerId"){                            
    
        $parsed = [Regex]::Matches($DateContent,'{"version":"(.+)","contour":"prod","rsaError":(.+),"checkInfo":(.+),"ownerId":"(.+)","db":{"createDate":"(.+)","ownerId":"(.+)"},"rsa":{"certType":"RSA","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"pki.fsrar.ru"},"gost":{"certType":"GOST","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"(.+)"},"license":(.+)}')     
       
        write-output $parsed[0].Groups[4].Value #ownerId
}#RSA ID
if ($args[0] -eq "EGAISRSADate"){                            
    
        $parsed = [Regex]::Matches($DateContent,'{"version":"(.+)","contour":"prod","rsaError":(.+),"checkInfo":(.+),"ownerId":"(.+)","db":{"createDate":"(.+)","ownerId":"(.+)"},"rsa":{"certType":"RSA","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"pki.fsrar.ru"},"gost":{"certType":"GOST","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"(.+)"},"license":(.+)}')     
        
        $CurrentDate = Get-Date
    
        $data1 =  $parsed[0].Groups[8].Value
        $data3 = $data1.Remove(19)
    
        $DataEnd = $data3.Split(" ")[0]
        
        $dataYea = $DataEnd.Remove(4)
        
        $DataMounty1 = $DataEnd.Remove(0,5)
        $DataMounty = $DataMounty1.Remove(2) 
    
        $DataDay = $DataEnd.Remove(0,8)
    
        $dataHol = "."
    
        $DataEndGOST = $DataDay +$dataHol +$DataMounty +$dataHol +$dataYea   
        $TimeEndGOST = $data3.Split(" ")[1]

        $DataTimeGOSTEnd = $DataEndGOST +" " +$TimeEndGOST

        $date = Get-Date -Date $DataTimeGOSTEnd #$parsed[0].Groups[1].Value
        $unixtime = [math]::Round((New-TimeSpan -Start $CurrentDate -End $date).TotalDays)
        write-output $unixtime

}#Дней до окончания RSA
if ($args[0] -eq "EGAISGOSTDate"){                            
    
        $parsed = [Regex]::Matches($DateContent,'{"version":"(.+)","contour":"prod","rsaError":(.+),"checkInfo":(.+),"ownerId":"(.+)","db":{"createDate":"(.+)","ownerId":"(.+)"},"rsa":{"certType":"RSA","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"pki.fsrar.ru"},"gost":{"certType":"GOST","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"(.+)"},"license":(.+)}')     
        
        $CurrentDate = Get-Date
    
        $data1 =  $parsed[0].Groups[10].Value
        $data3 = $data1.Remove(19)
    
        $DataEnd = $data3.Split(" ")[0]
        
        $dataYea = $DataEnd.Remove(4)
        
        $DataMounty1 = $DataEnd.Remove(0,5)
        $DataMounty = $DataMounty1.Remove(2) 
    
        $DataDay = $DataEnd.Remove(0,8)
    
        $dataHol = "."
    
        $DataEndGOST = $DataDay +$dataHol +$DataMounty +$dataHol +$dataYea   
        $TimeEndGOST = $data3.Split(" ")[1]

        $DataTimeGOSTEnd = $DataEndGOST +" " +$TimeEndGOST

        $date = Get-Date -Date $DataTimeGOSTEnd #$parsed[0].Groups[1].Value
        $unixtime = [math]::Round((New-TimeSpan -Start $CurrentDate -End $date).TotalDays)
        write-output $unixtime

}#Дней до окончания GOST
if ($args[0] -eq "EGAISlicense"){                            
    
        $parsed = [Regex]::Matches($DateContent,'{"version":"(.+)","contour":"prod","rsaError":(.+),"checkInfo":(.+),"ownerId":"(.+)","db":{"createDate":"(.+)","ownerId":"(.+)"},"rsa":{"certType":"RSA","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"pki.fsrar.ru"},"gost":{"certType":"GOST","startDate":"(.+)","expireDate":"(.+)","isValid":"valid","issuer":"(.+)"},"license":(.+)}')     
       
        write-output $parsed[0].Groups[12].Value #license
}#Действие лицензии
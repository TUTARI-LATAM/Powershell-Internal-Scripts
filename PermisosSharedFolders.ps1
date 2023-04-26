Get-WmiObject -Class Win32_Share | Where-Object {$_.Name -like "*$*"} | ForEach-Object {
    $share = [WMIClass]($_.__CLASS)
    $params = @{
        Name = $_.Name
        Path = $_.Path
        Type = $_.Type
        Description = $_.Description
    }
    $params["MaximumAllowed"] = $_.MaximumAllowed
    $params["Password"] = $_.Password
    $params["Caption"] = $_.Caption
    $params["AllowMaximum"] = $_.AllowMaximum
    $params["AccessMask"] = 2032127
    $params["Account"] = "DELOROCR\Domain Admins"
    $share.psbase.InvokeMethod("SetShareInfo", @($params.Name, $params.Path, $params.Type, $params.Description, $params.Password, $null, $params.MaximumAllowed))
}

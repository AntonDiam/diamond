connect-VIServer -server vcenter.pt.playtech.corp -User vsphere.local\Administrator -Password XXXXXXXXXXX

$oldntpservers='kiev-dc1.ee.playtech.corp','kiev-dc2.ee.playtech.corp','ntp1.ukraine.ptec','ntp2.ukraine.ptec','ntp2.infra.ptec'
$newntpservers='kie-dc001.pt.playtech.corp','kie-dc002.pt.playtech.corp'
foreach($vmhost in (get-vmhost -name ukr0*)){
#stop ntpd service
$vmhost|Get-VMHostService |?{$_.key -eq 'ntpd'}|Stop-VMHostService -Confirm:$false
#remove ntpservers 
$vmhost|Remove-VMHostNtpServer -NtpServer $oldntpservers -Confirm:$false
#add new ntpservers
$vmhost|Add-VmHostNtpServer -NtpServer $newntpservers
#start ntpd service
$vmhost|Get-VMHostService |?{$_.key -eq 'ntpd'}|Start-VMHostService
}



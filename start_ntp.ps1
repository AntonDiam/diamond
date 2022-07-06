connect-VIServer -server vcenter.pt.playtech.corp -User vsphere.local\Administrator -Password XXXXXXXXXXXX


foreach($vmhost in (get-vmhost -name ukr0*)){

#start ntpd service
$vmhost|Get-VMHostService |?{$_.key -eq 'ntpd'}|Start-VMHostService
}



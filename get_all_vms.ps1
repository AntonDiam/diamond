#Install-Module -Name VMware.PowerCLI -Scope CurrentUser

Install-Module -Name VMware.PowerCLI

connect-VIServer -server vcenter.pt.playtech.corp -User vsphere.local\Administrator -Password XXXXXXXXXX

Get-VM | Select -Property Name | Set-Content C:\_VMware\VMs\allVMs.csv

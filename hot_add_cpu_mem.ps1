Function Enable-MemHotAdd($vm){
    $vmview = Get-vm $vm | Get-View 
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec

    $extra = New-Object VMware.Vim.optionvalue
    $extra.Key="mem.hotadd"
    $extra.Value="true"
    $vmConfigSpec.extraconfig += $extra

    $vmview.ReconfigVM($vmConfigSpec)
}
 
 
connect-VIServer -server vcenter.pt.playtech.corp -User vsphere.local\Administrator -Password XXXXXX
Get-Content  "c:\_VMware\VMs\hot_add.txt" | %{ 
   $vm = Get-VM -Name $_ 
   Enable-MemHotAdd $vm
}
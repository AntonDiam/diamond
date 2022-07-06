Function Set-VMOvfProperty {
    param(
        [Parameter(Mandatory=$true)]$VM,
        [Parameter(Mandatory=$true)]$ovfChanges
    )

    # Retrieve existing OVF properties from VM
    $vappProperties = $VM.ExtensionData.Config.VAppConfig.Property

    # Create a new Update spec based on the # of OVF properties to update
    $spec = New-Object VMware.Vim.VirtualMachineConfigSpec
    $spec.vAppConfig = New-Object VMware.Vim.VmConfigSpec
    $propertySpec = New-Object VMware.Vim.VAppPropertySpec[]($ovfChanges.count)

    # Find OVF property Id and update the Update Spec
    foreach ($vappProperty in $vappProperties) {
        if($ovfChanges.ContainsKey($vappProperty.Id)) {
            $tmp = New-Object VMware.Vim.VAppPropertySpec
            $tmp.Operation = "edit"
            $tmp.Info = New-Object VMware.Vim.VAppPropertyInfo
            $tmp.Info.Key = $vappProperty.Key
            $tmp.Info.value = $ovfChanges[$vappProperty.Id]
            $propertySpec+=($tmp)
        }
    }
    $spec.VAppConfig.Property = $propertySpec

    Write-Host "Updating OVF Properties ..."
    $task = $vm.ExtensionData.ReconfigVM_Task($spec)
    $task1 = Get-Task -Id ("Task-$($task.value)")
    $task1 | Wait-Task
}

Function Get-VMOvfProperty {
    param(
        [Parameter(Mandatory=$true)]$VM
    )
    $vappProperties = $VM.ExtensionData.Config.VAppConfig.Property

    $results = @()
    foreach ($vappProperty in $vappProperties | Sort-Object -Property Id) {
        $tmp = [pscustomobject] @{
            Id = $vappProperty.Id;
            Label = $vappProperty.Label;
            Value = $vappProperty.Value;
            Description = $vappProperty.Description;
        }
        $results+=$tmp
    }
    $results
}
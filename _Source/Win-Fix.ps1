# === Unlock ALL registry (brute-force). Run in 64-bit PowerShell as Administrator. ===

# 0) Relaunch as Admin + x64 if needed
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
            ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $IsAdmin) {
  $ps = (Get-Process -Id $PID).Path
  Start-Process $ps -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
  exit
}
if ($env:PROCESSOR_ARCHITECTURE -ne 'AMD64') {
  $x64 = "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe"
  Start-Process $x64 -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
  exit
}

# 1) Mount HKCR: in PS7 it might be missing
if (-not (Get-PSDrive HKCR -ErrorAction SilentlyContinue)) {
  New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
}

# 2) Enable takeover privileges
Add-Type -Namespace Win32 -Name Native -MemberDefinition @'
using System;
using System.Runtime.InteropServices;
public class Tok {
  [DllImport("advapi32.dll", ExactSpelling=true, SetLastError=true)]
  public static extern bool OpenProcessToken(IntPtr ProcessHandle, UInt32 DesiredAccess, out IntPtr TokenHandle);
  [DllImport("advapi32.dll", SetLastError=true)]
  public static extern bool LookupPrivilegeValue(string lpSystemName, string lpName, out LUID lpLuid);
  [DllImport("advapi32.dll", SetLastError=true)]
  public static extern bool AdjustTokenPrivileges(IntPtr TokenHandle, bool DisableAllPrivileges,
    ref TOKEN_PRIVILEGES NewState, UInt32 Zero, IntPtr Null1, IntPtr Null2);

  public const UInt32 TOKEN_ADJUST_PRIVILEGES = 0x20;
  public const UInt32 TOKEN_QUERY = 0x08;
  public const UInt32 SE_PRIVILEGE_ENABLED = 0x02;

  [StructLayout(LayoutKind.Sequential)] public struct LUID { public UInt32 LowPart; public Int32 HighPart; }
  [StructLayout(LayoutKind.Sequential)] public struct LUID_AND_ATTRIBUTES { public LUID Luid; public UInt32 Attributes; }
  [StructLayout(LayoutKind.Sequential)] public struct TOKEN_PRIVILEGES { public UInt32 PrivilegeCount; public LUID_AND_ATTRIBUTES Privileges; }
}
'@
function Enable-Privilege([string]$Name) {
  $proc = [System.Diagnostics.Process]::GetCurrentProcess()
  $tok  = [IntPtr]::Zero
  [Win32.Tok]::OpenProcessToken($proc.Handle,[Win32.Tok]::TOKEN_ADJUST_PRIVILEGES -bor [Win32.Tok]::TOKEN_QUERY,[ref]$tok) | Out-Null
  $luid = New-Object Win32.Tok+LUID
  [Win32.Tok]::LookupPrivilegeValue($null,$Name,[ref]$luid) | Out-Null
  $tp = New-Object Win32.Tok+TOKEN_PRIVILEGES
  $tp.PrivilegeCount = 1
  $tp.Privileges = New-Object Win32.Tok+LUID_AND_ATTRIBUTES
  $tp.Privileges.Luid = $luid
  $tp.Privileges.Attributes = [Win32.Tok]::SE_PRIVILEGE_ENABLED
  [Win32.Tok]::AdjustTokenPrivileges($tok,$false,[ref]$tp,0,[IntPtr]::Zero,[IntPtr]::Zero) | Out-Null
}
Enable-Privilege SeTakeOwnershipPrivilege
Enable-Privilege SeRestorePrivilege
Enable-Privilege SeBackupPrivilege

# 3) Build ACL we want to stamp
$admins = New-Object System.Security.Principal.NTAccount('BUILTIN','Administrators')
$system = New-Object System.Security.Principal.NTAccount('NT AUTHORITY','SYSTEM')
$user   = New-Object System.Security.Principal.NTAccount("$env:USERDOMAIN","$env:USERNAME")

$ruleAdmins = New-Object System.Security.AccessControl.RegistryAccessRule($admins,'FullControl',
  [System.Security.AccessControl.InheritanceFlags]::ContainerInherit,
  [System.Security.AccessControl.PropagationFlags]::None,
  [System.Security.AccessControl.AccessControlType]::Allow)
$ruleSystem = New-Object System.Security.AccessControl.RegistryAccessRule($system,'FullControl',
  [System.Security.AccessControl.InheritanceFlags]::ContainerInherit,
  [System.Security.AccessControl.PropagationFlags]::None,
  [System.Security.AccessControl.AccessControlType]::Allow)
$ruleUser = New-Object System.Security.AccessControl.RegistryAccessRule($user,'FullControl',
  [System.Security.AccessControl.InheritanceFlags]::ContainerInherit,
  [System.Security.AccessControl.PropagationFlags]::None,
  [System.Security.AccessControl.AccessControlType]::Allow)

function Grant-Key($p) {
  try {
    $acl = Get-Acl -Path $p
    # Owner -> Administrators (so we can change DACL even if locked)
    $acl.SetOwner($admins)
    # Protect from inheriting previous junk, keep only our rules explicit
    $acl.SetAccessRuleProtection($true, $false)
    # Purge and set explicit rules for SYSTEM/Admins/User
    $acl.ResetAccessRule($ruleAdmins) | Out-Null
    $acl.AddAccessRule($ruleSystem)   | Out-Null
    $acl.AddAccessRule($ruleUser)     | Out-Null
    Set-Acl -Path $p -AclObject $acl
    return $true
  } catch {
    return $false
  }
}

function Unlock-Tree($root) {
  # BFS to avoid deep recursion; swallow errors, keep going
  if (-not (Test-Path $root)) { return }
  $stack = New-Object System.Collections.Generic.Stack[System.String]
  $stack.Push($root)
  $n=0; $ok=0
  while ($stack.Count -gt 0) {
    $p = $stack.Pop()
    $n++
    if (Grant-Key $p) { $ok++ }
    try {
      # enumerate children; -Force to include hidden, -EA SilentlyContinue to survive denials
      $kids = Get-ChildItem -Path $p -Force -ErrorAction SilentlyContinue
      foreach ($k in $kids) {
        $stack.Push($k.PSPath)
      }
    } catch {}
    if (($n % 1000) -eq 0) {
      # tiny heartbeat (optional)
      Write-Host ("… {0} keys processed ({1} OK)" -f $n,$ok)
    }
  }
}

Write-Host "[1/4] HKLM:\SOFTWARE and WOW6432Node"
Unlock-Tree 'HKLM:\SOFTWARE'
if (Test-Path 'HKLM:\SOFTWARE\WOW6432Node') { Unlock-Tree 'HKLM:\SOFTWARE\WOW6432Node' }

Write-Host "[2/4] HKLM:\SYSTEM (may skip some protected branches)"
Unlock-Tree 'HKLM:\SYSTEM'

Write-Host "[3/4] Other HKLM hives (HARDWARE, SAM, SECURITY, DRIVERS) — best effort"
foreach ($h in 'HKLM:\HARDWARE','HKLM:\SAM','HKLM:\SECURITY','HKLM:\DRIVERS') {
  if (Test-Path $h) { Unlock-Tree $h }
}

Write-Host "[4/4] HKCU and HKCR"
Unlock-Tree 'HKCU:\'
Unlock-Tree 'HKCR:\'

Write-Host "DONE. Registry ownership + FullControl pushed (best-effort)."

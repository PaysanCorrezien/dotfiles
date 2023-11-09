Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class User32 {
        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

        [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern int GetClassName(IntPtr hWnd, System.Text.StringBuilder lpClassName, int nMaxCount);
    }
"@

$windowTitle = "ChatGPT"  # Replace with the title of your Edge window
$hWnd = [User32]::FindWindow([NullString]::Value, $windowTitle)

if ($hWnd -eq [IntPtr]::Zero) {
    Write-Host "Window not found."
    exit 1
}

$classNameBuilder = New-Object System.Text.StringBuilder 256
$length = [User32]::GetClassName($hWnd, $classNameBuilder, $classNameBuilder.Capacity)

if ($length -eq 0) {
    Write-Host "Failed to get class name."
    exit 1
}

Write-Host "Class Name: $($classNameBuilder.ToString())"


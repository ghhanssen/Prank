<#
    1. Take ScreenShoot of Desktop and save to file. Win + PrintScreen --> This saves a image to C:\users\$env:username\Pictures\Screenshots
    2. Run script. Will get the latest image from Screenshots folder. 
    3. Exit fullscreen by pressing Q 
#>
Add-Type -AssemblyName 'System.Windows.Forms'
$file = ((Get-ChildItem -path "C:\users\$env:username\Pictures\Screenshots\*") | Sort-Object -Descending | Select-Object -First 1)
$img = [System.Drawing.Image]::Fromfile((get-item $file))

[System.Windows.Forms.Application]::EnableVisualStyles()
$form = new-object Windows.Forms.Form
$form.Text = "Image Viewer"
$form.Width = $img.Size.Width;
$form.Height = $img.Size.Height;
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width = $img.Size.Width;
$pictureBox.Height = $img.Size.Height;

$pictureBox.Image = $img;
$form.controls.add($pictureBox)
$form.Add_KeyDown({
        if ($_.KeyCode -eq "Q") {
            $form.Close()
        }
    })
$form.WindowState = 'Maximized'
$form.FormBorderStyle = 'None'
$form.Add_Shown( { $form.Activate() } )
$form.ShowDialog()
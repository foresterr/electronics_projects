$boards = @("main_board","fan_controller")
$sides = @("front","rear")
$scale = "1.003,0.997"

foreach ($file in $boards) {
    foreach ($side in $sides) {
        inkscape --pdf-poppler --export-filename="tmp.svg" --export-type=svg --export-overwrite "$file.$side.pdf"
        $inkscape_actions = "select-all:all; selection-group"
        if ($side -eq "front") {
            $inkscape_actions = "org.inkscape.color.black-and-white.noprefs; org.inkscape.color.negative.noprefs; $inkscape_actions"
        }
        inkscape --batch-process --actions=$inkscape_actions --export-filename="$file.$side.svg" --export-type=svg --export-overwrite "tmp.svg"
        Remove-Item "tmp.svg"
        $svgfile = Get-Item "$file.$side.svg"
        [xml]$svgxml = Get-Content $svgfile
        $svgxml.svg.g.SetAttribute("transform","scale($scale)")
        $svgxml.Save("$($svgfile.fullName)")
    }
}

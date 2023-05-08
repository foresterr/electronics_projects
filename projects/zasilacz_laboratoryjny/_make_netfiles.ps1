$boards = @("main_board","fan_controller")

foreach ($file in $boards) {
    kicad-cli sch export netlist --format orcadpcb2 "$file.kicad_sch"
}
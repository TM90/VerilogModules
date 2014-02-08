package require Tk
package require Img

proc canvas_save {} {
	update
    set im [image create photo -format window -data .can]
    set filename [tk_getSaveFile -defaultextension .jpg \
                      -filetypes {{JPEG .jpg} {"All files" *}}]
    if {$filename ne ""} {
        $im write $filename -format JPEG
    }
    image delete $im
 }

proc drawOutline {xpos ypos width heigth} \
{
	.can create rect $xpos $ypos [expr $xpos+$width] [expr $ypos+$heigth] -outline #000 -width 3
}

proc drawText {xpos ypos text anchor} \
{
	.can create text $xpos $ypos -anchor $anchor -font Arial -text $text
}

proc maxStringlength {element_list} \
{
	set helper_string ""
	foreach element $element_list {
		if {[string length $element] > [string length $helper_string]} {
			set helper_string $element
		}
	}
	return [string length §$helper_string]
}

if {$argc != 1} {
	error "Please add a file path..."
}

set parameter_count 0
set parameter_list {}
set input_count 0
set input_list {}
set output_count 0
set output_list {}
set start 0

set xpos 100
set ypos 50

set file [lindex $argv 0]
set fp [open $file r]
set file_data [read $fp]
close $fp
set file_data [split $file_data "\n"]
foreach line $file_data {
	if {[string match "*module *" $line]} {
			set start 1
	}
	if {$start == 1} {
		if {[string match "*parameter*" $line]} {
			incr parameter_count 1
			set line [string trim $line]
			set line [string trimleft $line parameter]
			set line [string trim $line]
			set line [string trim $line ,]
			lappend parameter_list $line
		}
		if {[string match "*input*" $line]} {
			incr input_count 1
			set line [string trim $line]
			set line [string trimleft $line input]
			set line [string trim $line]
			set line [string trim $line ,]
			if {[string match "*wire*" $line]} {
				set line [string trimleft $line wire]
			} else {
				if {[string match "*reg*" $line]} {
					set line [string trimleft $line reg]
				}
			}
			set line [string trim $line]
			lappend input_list $line
		}
		if {[string match "*output*" $line]} {
			incr output_count 1
			set line [string trim $line]
			set line [string trimleft $line output]
			set line [string trim $line]
			set line [string trim $line ,]
			if {[string match "*wire*" $line]} {
				set line [string trimleft $line wire]
			} else {
				if {[string match "*reg*" $line]} {
					set line [string trimleft $line reg]
				}
			}
			set line [string trim $line]
			lappend output_list $line
		}
		if {[string match "*);*" $line]} {
			break
		}
	}
}

puts "parameter_count: $parameter_count"
puts "input_count: $input_count"
puts "output_count: $output_count"

foreach it $parameter_list {
	puts $it
}
puts ""
foreach it $input_list {
	puts $it
}
puts ""
foreach it $output_list {
	puts $it
}

wm title . "[file tail $file]"
canvas .can -width 600 -height 600 -bg white
button .b -text "Save" -command canvas_save

set width [maxStringlength $input_list]
if {$width < [maxStringlength $output_list]} {
	set width [maxStringlength $output_list]	
}
puts "Width: $width"
if {$input_count < $output_count} {
	drawOutline $xpos $ypos [expr $width*20] [expr $output_count*30+30] 
} else {
	drawOutline $xpos $ypos [expr $width*20] [expr $input_count*30+30] 
}

set pos [expr $ypos+20]

foreach input_element $input_list {
	drawText [expr $xpos+10] $pos $input_element nw
	.can create line $xpos [expr $pos+10] [expr $xpos-50] [expr $pos+10] -width 3
	incr pos 30
}

set pos [expr $ypos+20]

foreach output_element $output_list {
	drawText [expr $width*20-10+$xpos] $pos $output_element ne
	.can create line [expr $width*20+$xpos] [expr $pos+10] [expr $width*20+$xpos+50] [expr $pos+10] -width 3
	incr pos 30 
}

set pos [expr $ypos+20]

foreach parameter_element $parameter_list {
	if {$input_count > $output_count} {
		drawText [expr $xpos+10] [expr $input_count*30+30+$pos] $parameter_element nw
	} else {
		drawText [expr $xpos+10] [expr $output_count*30+30+$pos] $parameter_element nw
	}
	
	incr pos 30 
}
.can configure -width [expr $width*20-10+[expr 2*$xpos]]
if {$input_count > $output_count} {
	.can configure -height [expr $input_count*30+30+$pos+30]
} else {
	.can configure -height [expr $output_count*30+30+$pos+30]
}
pack .can
pack .b


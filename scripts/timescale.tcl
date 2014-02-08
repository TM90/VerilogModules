#Author: Tobias Markus
#Description: 
#A little script to delete all timescale directives within the given files in the filelist

#searches the files in the file list for timescale directives and deletes them 

proc write_error_msg {} \
{
	error "\n\nWrong number of arguments\nUse the tool like this:\n\
			tclsh timescale -d|-a|-da /file/path (timescale)\n\
			-d to delete all timescale directives do not add a timescale\n\
			-a to add timescale directives do add timescale\n\
			-da to delete first and than add a timescale here is also a timescale needed\n\
			\n \"tclsh timescale -da /path/to/filelist 1ns/1ns\"\n\n"
}

proc timescale_delete {file_list} \
{
	foreach file $file_list {
		set linenr 0
		set fp [open $file r+]
		set file_data [read $fp]
		close $fp
		#puts $file_data
		set file_data [split $file_data "\n"]
		set fp [open $file w+]
		foreach line $file_data {
			if {[string match *`timescale* $line]} {
				puts "Found timescale in [file tail $file]..."
			} else {
				puts $fp $line
				if {[string match *endmodule* $line]} {
					break
				}
			}
		}
		close $fp
	}
}

#goes through the files in the file list and adds a timescale directives
proc timescale_add {file_list timescale} \
{
	foreach file $file_list {
		set linenr 0
		set fp [open $file r+]
		set file_data [read $fp]
		close $fp
		#puts $file_data
		set file_data [split $file_data "\n"]
		set fp [open $file w+]
		set first_line 0
		foreach line $file_data {
			if {$first_line == 0} {
				puts "Added timescale in [file tail $file]..."
				puts $fp "`timescale $timescale"
				puts $fp $line
				set first_line 1
			} else {
				puts $fp $line
				if {[string match *endmodule* $line]} {
					break
				}
			}
		}
		close $fp
	}	
}

if {$argc < 2} {
	write_error_msg
}
set flag [lindex $argv 0]
set file_list_path  [lindex $argv 1]
set fp [open $file_list_path r]
set directory [file dirname $file_list_path]
set file_data [read $fp]
close $fp
set file_list {}
	
#set final paths
foreach line $file_data {
	lappend file_list "$directory/$line"
}
if {$flag == "-d"} {
	timescale_delete $file_list			
} elseif {$flag == "-a"} {
	if {$argc != 3} {
		write_error_msg
	}
	set timescale [lindex $argv 2]
	timescale_add $file_list $timescale
} elseif {$flag == "-da"} {
	if {$argc != 3} {
		write_error_msg
	}
	set timescale [lindex $argv 2]
	timescale_delete $file_list
	timescale_add $file_list $timescale
} else {
	puts "\n$flag is not a valid flag\n"
}

#Author: Tobias Markus
#Description: 
#A little script to delete all timescale directives within the given files in the filelist

if {$argc != 1} {
	error "Wrong arguments"
} else {
	
	set file_list_path $argv
	set fp [open $file_list_path r]
	set directory [file dirname $file_list_path]
	set file_data [read $fp]
	close $fp
	set file_list {}
	
	#set final paths
	foreach line $file_data {
		lappend file_list "$directory/$line"
	}
	
	# go through the files
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
				puts $fp ""
			} else {
				#puts $fp $line
				puts $fp $line
				if {[string match *endmodule* $line]} {
					break
				}
			}
		}
		close $fp
	}
}

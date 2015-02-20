require 'rubygems'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "~/.irb_history"
IRB.conf[:EVAL_HISTORY] = 200

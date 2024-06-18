crash.log <- file(paste0(SAVE.DIR,"crash.log"),open="wt") # <logfile>
sink(crash.log, append=TRUE, type="message") # <logfile>
sink(crash.log, append=TRUE, type="output") # <logfile>

closeAllConnections() # <logfile>

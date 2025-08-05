### Future ####################################################################

library(future)
library(future.apply)

future::plan(multisession)
future::availableCores()

### Async #####################################################################
library(foreach)
library(parallel)
library(doParallel)

n.cores    <- parallel::detectCores() - 1
my.cluster <- parallel::makeCluster(spec=n.cores, type="PSOCK")
doParallel::registerDoParallel(my.cluster)
foreach::getDoParRegistered()
foreach::getDoParWorkers()

# parallel::stopCluster(cl = my.cluster)

###############################################################################

library(RSelenium)

driver <- remoteDriver(remoteServerAddr = "localhost",
                       port = 4445L,
                       browserName = "firefox")
driver$open()

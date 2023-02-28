data <- GET() %>% content("text", encoding="utf-8") %>% fromJSON()

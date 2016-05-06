# Subset data where columns start by "I"
subset_train <- training[,grep("^[I]", names(training), value=TRUE)]

# Subset data where columns start by "IL"
subset_tr <- training[,grepl("^IL", names(training))]
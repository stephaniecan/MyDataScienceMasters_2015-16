# Keeping the 10 most important variables
trainlast <- trainproc[,grepl("yaw_belt|total_accel_belt|gyros_belt_x|gyros_belt_y|gyros_belt_z|magnet_belt_x|magnet_belt_y|magnet_belt_z|roll_arm|pitch_arm|user_name|classe", names(trainproc))]
names(trainlast)
modfit2 <- train(classe ~ ., data = trainlast[,2:12], method = "rf", prox=TRUE)
modfit3 <- randomForest(x=trainlast[,2:11],y=trainlast$classe, importance = FALSE)
modfit2 ; modfit3

# Keep only 10 variables on the testing set = not interesting?
testlast <- testproc[,grepl("yaw_belt|total_accel_belt|gyros_belt_x|gyros_belt_y|gyros_belt_z|magnet_belt_x|magnet_belt_y|magnet_belt_z|roll_arm|pitch_arm|user_name|classe", names(testproc))]
names(testlast)

pred2 <- predict(modfit3,testlast); 
table(pred2,testlast$classe)

## previous highly correlated
10,1,9,36,8,2,34,21,25,18
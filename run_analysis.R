test<-read.table("test/X_test.txt")
train<-read.table("./train/X_train.txt")
data1<-rbind(train,test)

#create activity joint column
test_activity<-read.table("test/y_test.txt")
train_activity<-read.table("train/y_train.txt")
activity_col<-rbind(train_activity,test_activity)

#add activity_col to data1
data2<-cbind(data1,activity_col)

#create joint tester column
test_performer<-read.table("test/subject_test.txt")
train_performer<-read.table("train/subject_train.txt")
performer_col<-rbind(train_performer,test_performer)

#add activity_col to data1
data3<-cbind(data2,performer_col)


########################################################################

#copy and paste manually relevant variables from "features.txt" into a new 
#txt file, called "relevant_var.txt"
#then extract the column with the var number

relevant_var<-read.table("relevant_var.txt", sep=" ")
#add 2last 2 cols
relevant_var_index<-relevant_var[,1]
a<-c(562,563)
relevant_var_index2<-c(relevant_var_index,a)


#extract relevant columns from data1

data4<-data3[,relevant_var_index2]

##########################################################################
#rename activities column with relevant name

labels<-read.table("activity_labels.txt", sep=" ")
count<-nrow(data4)
data5<-data4

i<-1
while(i<=count){
        if(data4[i,67]==1){
                data4[i,67]<-"WALKING"
                next
        }
        if(data4[i,67]==2){
                data4[i,67]<-"WALKING_UPSTAIRS"
                next
        }
        if(data4[i,67]==3){
                data4[i,67]<-"WALKING_DOWNSTAIRS"
                next
        }
        if(data4[i,67]==4){
                data4[i,67]<-"SITTING"
                next
        }
        if(data4[i,67]==5){
                data4[i,67]<-"STANDING"
                next
        }
        if(data4[i,67]==6){
                data4[i,67]<-"LAYING"
                next
        }
        
        i<-i+1
        
}

#bring lat 2 column in front
#data4<-data4[,c(68:67,1:(ncol(data4)-2))]




##########################################################################
#rename columns
tmp<-as.character(relevant_var[,2])
tmp1<-c("activity","tester_id")
cn<-c(tmp,tmp1)
colnames(data4)<-cn


#####################################################################
#Create new dataset with average values for each activity for each test performer




u<-1
res<-data.frame(matrix(0,ncol=68, nrow=0))
colnames(res)<-cn

while(u<=30){
        
        tmpdf<-subset(data4,data4[,68]==u)
        
        v<-1
        while(v<= 6){
                
                
                tmpdf1<-subset(tmpdf,data5[,67]==labels[v,2])
                #tmpdf1<-tmpdf1[complete.cases(tmpdf1),]
                tmp_res<-apply(tmpdf[,1:66],2,mean)
                
                tmp_res<-c(tmp_res,labels[v,2],u)
                
                res<-rbind(res,tmp_res)
                
                
                v<-v+1
        }
        
        
        u<-u+1
        colnames(res)<-cn
}


#order results by tester and activity

res<-res[with(res, order(tester_id,activity)), ]





##########################################################################
#rename activity column with relevant name

labels<-read.table("activity_labels.txt", sep=" ")
count<-nrow(res)


i<-1
while(i<=count){
        if(res[i,67]==1){
                res[i,67]<-"WALKING"
                next
        }
        if(res[i,67]==2){
                res[i,67]<-"WALKING_UPSTAIRS"
                next
        }
        if(res[i,67]==3){
                res[i,67]<-"WALKING_DOWNSTAIRS"
                next
        }
        if(res[i,67]==4){
                res[i,67]<-"SITTING"
                next
        }
        if(res[i,67]==5){
                res[i,67]<-"STANDING"
                next
        }
        if(res[i,67]==6){
                res[i,67]<-"LAYING"
                next
        }
        
        i<-i+1
        
}


#bring lat 2 column in front
res<-res[,c(68:67,1:(ncol(res)-2))]


# export result to txt file
write.table(res,"tidyDataSet.txt", sep="        ")




ActivityIdx = reshape(1:2,1,2);
StartTimes = rand(1,2);
StopTimes = StartTimes+rand(1,2);

plot([StartTimes;StopTimes],[1;1]*ActivityIdx)
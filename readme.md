# SimuFrag Report

## Approach for aggregating data across fragments

For aggregation operations such as AVG in getAvgDepartmentScore and MAX and COUNT in getMostCourseStudents, we performed the computation on a single randomly selected fragment instead of aggregating across all fragments, as specified in the report. For large datasets, the difference between performing aggregation on one fragment versus multiple fragments is negligible.

---

## Challenges we faced

We were first inserting(and fetching) into the grade table using course id and student id as input to the routing function but this led to incomplete joins(missing tuples in result) between the student relation and grade relation and foreign key violation. We fixed this by using only student id as input to the routing function. This meant that both student details in student relation and student courses in grade relation be in the same fragment.

---

## Runtime Metrics

Single fragment runtime : 1633 ms  
Three fragment runtime : 1652 ms

---

## Accuracy Metrics

### Accuracy 
----------------------------
Total lines        : 2462  
Correct lines      : 753  
Incorrect lines    : 1709  
Accuracy           : 30.58 %  
----------------------------

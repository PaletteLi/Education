SELECT distinct 
	query1.YearID
	,query1.Term
	,query1.StudentID
	,query1.Grade
	--,query1.[Algebra I EOC]
	--,query1.[English I EOC]
	--,query1.[English II EOC]
	--,query1.[US History EOC]
	--,query1.[Biology EOC]
	--,query1.[Math EPAS]
	--,query1.[Reading EPAS]
	--,query1.[English EPAS] 
	,query1.[Science EPAS] 
	--,query1.[Reading MAP]
	--,query1.[Science MAP]
	--,query1.[Math MAP]
	--,query1.[Language Usage MAP]
	--,query1.[Math STAAR]
	--,query1.[Reading STAAR]
	--,query1.[Science STAAR]
	--,query1.[Social Studies STAAR]
	--,query1.[Writing STAAR]
	--,query2.StudentID
	,query2.Grade as 'PostTest Grade'
	--,query2.[Algebra I EOC Goal] 
	--,query2.[English I EOC Goal] 
	--,query2.[English II EOC Goal]
	--,query2.[US History EOC Goal]
	,query2.[Biology EOC Goal] 
	--,query2.[Math STAAR Goal]
	--,query2.[Reading STAAR Goal]
	--,query2.[Science STAAR Goal]
	--,query2.[Social Studies STAAR Goal]
	--,query2.[Writing STAAR Goal]
 FROM
(SELECT YearID
	,term
	,StudentID
	,Grade
	--,TestVersion1
	,pvt.[Algebra I EOC] 
	,pvt.[English I EOC] 
	,pvt.[English II EOC]
	,pvt.[US History EOC]
	,pvt.[Biology EOC] 
	,pvt.[Math EPAS] 
	,pvt.[Reading EPAS] 
	,pvt.[English EPAS] 
	,pvt.[Science EPAS] 
	,pvt.[Reading MAP]
	,pvt.[Science MAP]
	,pvt.[Math MAP]
	,pvt.[Language Usage MAP]
	,pvt.[Math STAAR]
	,pvt.[Reading STAAR]
	,pvt.[Science STAAR]
	,pvt.[Social Studies STAAR]
	,pvt.[Writing STAAR]
  FROM 
  (SELECT DISTINCT termname + ' ' + SchoolYear as		
	Term, StudentID,[TestScoreType]
      ,[TestScore]
      ,CASE WHEN Test in ('Explore','Plan','ACT','PreACT 10','PreACT 9','PreACT') THEN [Subject] + ' EPAS' ELSE [Subject] + ' ' + [Test] END as Test
	  ,YearID
	  ,CASE WHEN Test = 'Explore' THEN 9 WHEN Test = 'Plan' THEN 10 WHEN Test = 'ACT' THEN 11 ELSE WhenAssessedGradeLevel END as Grade
	  --,CASE WHEN Test in ('STAAR','EOC') THEN TestVersion ELSE NULL END as TestVersion1
  FROM[ODS_CPS].[RPT].[vStudentAssessment]
   where TestScoreType = 'Scale Score'
   and ((TestVersion in ('S','O','U')) OR (TestVersion IS NULL))
  and Test in ('EOC','Explore','Plan','ACT','PreACT 10','PreACT 9','PreACT','MAP','STAAR')
  and TermName = 'Fall'
  
  --and studentid = 803100723
  --and StudentID = 803100003
  )a
  PIVOT
  (
  MAX([TestScore]) FOR Test 
  IN ([Algebra I EOC], [English I EOC], [English II EOC], [US History EOC], [Biology EOC], 
  [Math EPAS],[English EPAS],[Reading EPAS],[Science EPAS],
  [Reading MAP],[Science MAP],[Math MAP],[Language Usage MAP],
  [Math STAAR],[Reading STAAR],[Science STAAR],[Social Studies STAAR],[Writing STAAR]
  ) 
  )as pvt
)query1
LEFT JOIN
(
SELECT 
YearID 
	--,term
	--,TestVersion2
	,StudentID
	,Grade
	,pvt2.[Algebra I EOC Goal] 
	,pvt2.[English I EOC Goal] 
	,pvt2.[English II EOC Goal]
	,pvt2.[US History EOC Goal]
	,pvt2.[Biology EOC Goal] 
	,pvt2.[Math STAAR Goal]
	,pvt2.[Reading STAAR Goal]
	,pvt2.[Science STAAR Goal]
	,pvt2.[Social Studies STAAR Goal]
	,pvt2.[Writing STAAR Goal]
  FROM 
  (SELECT DISTINCT termname + ' ' + SchoolYear as		
	Term, StudentID,[TestScoreType]
      ,[TestScore]
      ,[Subject] + ' ' + [Test] + ' Goal' as Test
	  ,YearID
	  , WhenAssessedGradeLevel as Grade
	 -- ,CASE WHEN Test in ('STAAR','EOC') THEN TestVersion ELSE NULL END as TestVersion2
  FROM[ODS_CPS].[RPT].[vStudentAssessment]
   where TestScoreType = 'Scale Score'
   and ((TestVersion in ('S','O','U')) OR (TestVersion IS Null))
  and Test in ('EOC','STAAR')
  and TermName = 'Spring'
  --and studentid = 803100723
  --and StudentID = 803100003
  )b
  PIVOT
  (
  MAX([TestScore]) FOR Test 
  IN ([Algebra I EOC Goal], [English I EOC Goal], [English II EOC Goal], [US History EOC Goal], [Biology EOC Goal], 
  [Math STAAR Goal],[Reading STAAR Goal],[Science STAAR Goal],[Social Studies STAAR Goal],[Writing STAAR Goal]
  ) 
  )as pvt2
)QUERY2
ON query1.studentID = query2.studentID
AND query1.yearID = query2.yearid
AND query1.Grade = query2.Grade
-------------------------------------------
-- Specify which grade and test to pull here
-------------------------------------------

WHERE query2.[Biology EOC Goal] is not null
AND query1.YearID in (24,25,26) -- Fall and testing YEARID
AND query1.[Science EPAS] is not null
AND query2.grade = 9
--AND query1.Grade = 9

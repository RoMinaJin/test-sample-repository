select * from ALL_TABLES 
where table_name like '%_FLAG%';
--where table_name like 'T125_%';

select * from T023_CLIENT_FLAG
where flag_id = 283;

select * from T009_FLAG;

select * from T125_PROD_PRICE;

select * from T917_JOB_LOG
where client_no = 306
and job_id = 5
order by LAST_UPDATE_TST DESC;

select * from T916_JOBS;

select * from T921_FEED_LOG
where client_no = 306
order by last_update_tst desc;

select * from ALL_TAB_COLUMNS
where column_name = 'CLIENT_NO'
and (table_name like 'T%_%CLIENT%' OR table_name like 'T%_%CUSTOMER%');

select * from T060_CUSTOMER
where customer_name = 'HIGHLAND FARMS';

select * from T003_FLAGCLIENT
--where client_no = 301;
where (UPPER(client_name) like 'CANADA%' or UPPER(description) like 'CANADA%');

select * from TT060_CUSTOMER;

SELECT DISTINCT DAY,
  JOB_DESCRIPTION,
  CLIENT_NAME,
  TO_CHAR(JOB_START, 'MM/DD/YYYY HH24:MI:SS') AS DATE_RCVD,
  TO_CHAR(JOB_END, 'MM/DD/YYYY HH24:MI:SS')   AS DATE_PROCESSED,
  DECODE(JOB_END, NULL,'RUNNING', 'DONE')     AS STATUS
FROM T917_JOB_LOG a,
  (SELECT DAY,
    JOB_DESCRIPTION,
    JOB_ID
  FROM T916_JOBS,
    (SELECT TO_CHAR(level+TRUNC(sysdate,'D'),'DAY') AS DAY
    FROM dual
      CONNECT BY level <= 7
    )
  )b,
  T003_CLIENT c
WHERE a.job_id  = b.job_id
AND a.client_no = c.client_no
ORDER BY DAY,
  JOB_DESCRIPTION;

select TO_CHAR(SYSDATE, 'DAY') AS DAY from dual;

desc T917_JOB_LOG;

SELECT DAY,
  JOB_DESCRIPTION,
  JOB_ID
FROM T916_JOBS,
  (SELECT TO_CHAR(level+TRUNC(sysdate,'D'),'DAY') AS DAY
  FROM dual
    CONNECT BY level <= 7
  ) ;
  
SELECT TO_CHAR (JOB_START,'DAY') AS DAY,
  JOB_DESCRIPTION,
  TO_CHAR(JOB_START, 'MM/DD/YYYY HH24:MI:SS') AS DATE_RCVD,
  TO_CHAR(JOB_END, 'MM/DD/YYYY HH24:MI:SS')   AS DATE_PROCESSED,
  DECODE(JOB_END, NULL,'RUNNING', 'DONE')     AS STATUS
FROM T917_JOB_LOG a,
  T916_JOBS b
WHERE a.job_id                      = b.job_id
--AND a.job_id                        = 1
AND TRIM(TO_CHAR (JOB_START,'DY')) = 'FRI'
--GROUP BY TO_CHAR (JOB_START,'DAY')
ORDER BY JOB_START desc,
  JOB_DESCRIPTION;
  
SELECT TO_CHAR (JOB_START,'DY') AS DAY,
  JOB_DESCRIPTION,
  TO_CHAR(JOB_START, 'MM/DD/YYYY HH24:MI:SS') AS DATE_RCVD,
  TO_CHAR(JOB_END, 'MM/DD/YYYY HH24:MI:SS')   AS DATE_PROCESSED,
  DECODE(JOB_END, NULL,'RUNNING', 'DONE')     AS STATUS
FROM T917_JOB_LOG a,
  T916_JOBS b
WHERE a.job_id                     = b.job_id
AND a.job_id                       = '1'
AND TRIM(TO_CHAR (JOB_START,'DY')) = UPPER('thu')
AND rownum = 1
ORDER BY JOB_START DESC,
  JOB_DESCRIPTION;

desc T917_JOB_LOG;

SELECT TO_CHAR (JOB_START,'DAY') AS DAY,
  JOB_DESCRIPTION,
  TO_CHAR(JOB_START, 'MM/DD/YYYY HH24:MI:SS') AS DATE_RCVD,
  TO_CHAR(JOB_END, 'MM/DD/YYYY HH24:MI:SS')   AS DATE_PROCESSED,
  DECODE(JOB_END, NULL,'RUNNING', 'DONE')     AS STATUS
FROM T917_JOB_LOG a,
  T916_JOBS b
WHERE a.job_id                     = b.job_id
AND a.job_id                       = 1
AND TRIM(TO_CHAR (JOB_START,'DY')) = UPPER('sun')
ORDER BY JOB_START desc,
  JOB_DESCRIPTION;

SELECT to_date('2015-05-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
select * from T100_PRODUCT PARTITION(dataObj_to_partition("T100_PRODUCT", '114837')) T100;

 WITH subsegmenttype_tab AS
  (SELECT subSegment,
    subSegmentType
  FROM
    ( SELECT DISTINCT CAST('subBrand' AS VARCHAR2(12)) AS subSegment,
      MAP.ATTRIBUTE_VALUE                              AS subSegmentType
    FROM T178_CATEGORY_ATTRIB_MAP MAP
    WHERE MAP.CLIENT_NO    = 301
    AND MAP.ATTRIBUTE_NAME = 'SUB_BRAND'
    AND MAP.CATEGORY_ID   IN
      (SELECT * FROM TABLE( ? )
      )
    UNION ALL
    SELECT DISTINCT CAST('globalForm' AS VARCHAR2(12)) AS subSegment,
      MAP.ATTRIBUTE_VALUE                              AS subSegmentType
    FROM T178_CATEGORY_ATTRIB_MAP MAP
    WHERE MAP.CLIENT_NO    = ?
    AND MAP.ATTRIBUTE_NAME = 'FORM_GLOBL'
    AND MAP.CATEGORY_ID   IN
      (SELECT * FROM TABLE( ? )
      )
    UNION ALL
    SELECT DISTINCT CAST('CB1' AS VARCHAR2(12)) AS subSegment,
      MAP.ATTRIBUTE_VALUE                       AS subSegmentType
    FROM T178_CATEGORY_ATTRIB_MAP MAP
    WHERE MAP.CLIENT_NO    = ?
    AND MAP.ATTRIBUTE_NAME = 'CB1'
    AND MAP.CATEGORY_ID   IN
      (SELECT * FROM TABLE( ? )
      )
    UNION ALL
    SELECT DISTINCT CAST('CB3' AS VARCHAR2(12)) AS subSegment,
      MAP.ATTRIBUTE_VALUE                       AS subSegmentType
    FROM T178_CATEGORY_ATTRIB_MAP MAP
    WHERE MAP.CLIENT_NO    = ?
    AND MAP.ATTRIBUTE_NAME = 'CB3'
    AND MAP.CATEGORY_ID   IN
      (SELECT * FROM TABLE( ? )
      )
    UNION ALL
    SELECT DISTINCT CAST('productForm' AS VARCHAR2(12)) AS subSegment,
      MAP.ATTRIBUTE_VALUE                               AS subSegmentType
    FROM T178_CATEGORY_ATTRIB_MAP MAP
    WHERE MAP.CLIENT_NO    = ?
    AND MAP.ATTRIBUTE_NAME = 'FORM_DET'
    AND MAP.CATEGORY_ID   IN
      (SELECT * FROM TABLE( ? )
      )
    ) Result
  )
SELECT subSegmentType,
  to_string(CAST(collect(subSegment) AS varchar2_ntt)) AS subSegment
FROM subsegmenttype_tab
WHERE NOT EXISTS
  (SELECT 1
  FROM T914_SUBSEGMENT_EXCLUDE T914
  WHERE T914.CLIENT_NO      = ?
  AND UPPER(subSegmentType) = T914.ATTRIBUTE_VALUE
  )
GROUP BY subSegmentType
ORDER BY subSegmentType

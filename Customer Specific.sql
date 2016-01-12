SELECT T100.PRODUCT_ID AS productId ,
  (SELECT T126.EXCEPTION_TYPE
  FROM T126_CUST_PROD_EXCEPTION T126,
    T060_CUSTOMER T060
  WHERE T126.PRODUCT_ID   = T100.PRODUCT_ID
  AND T126.CUSTOMER_ID    = '12897'
  AND T126.EXCEPTION_TYPE = 'C'
  AND T126.CUSTOMER_ID    = T060.CUSTOMER_ID
  AND T060.EXCEPTION_TYPE = 'C'
  )                                       AS excepType ,
  NVL(T106.CLIENT_DESC, T106.DESCRIPTION) AS description ,
  T106.SDC_FULL_DESC                      AS fullDescription ,
  T100.PRODUCT_CODE                       AS productCode ,
  T100.ITEM_UPC                           AS itemUPC ,
  T100.ITEM_BARCODE_PREFIX                AS itemBarcodePrefix ,
  T100.ITEM_BARCODE_CHECK_DIGIT           AS itemBarcodeCheckDigit ,
  T100.CASE_UPC                           AS caseUPC ,
  T100.CASE_BARCODE_PREFIX                AS caseBarcodePrefix ,
  T100.CASE_BARCODE_CHECK_DIGIT           AS caseBarcodeCheckDigit ,
  (T100.CASE_BARCODE_PREFIX
  || T100.CASE_UPC
  || T100.CASE_BARCODE_CHECK_DIGIT) AS caseUPCBarcodeSource ,
  (T100.ITEM_BARCODE_PREFIX
  || T100.ITEM_UPC
  || T100.ITEM_BARCODE_CHECK_DIGIT)                            AS itemUPCBarcodeSource ,
  T100.IS_DELETED                                              AS isDeleted ,
  T100.ITEMS_PER_CASE                                          AS itemsPerCase ,
  T100.CASE_SIZE                                               AS innerPacksPerCase ,
  T100.ITEM_SIZE                                               AS itemSize ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.ITEM_SIZE_UOM_CODE)      AS itemSizeUOM ,
  T100.PACK_SIZE                                               AS itemsPerInnerPack ,
  T100.CASE_WEIGHT                                             AS caseWeight ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.CASE_WEIGHT_UOM_CODE)    AS caseWeightUOM ,
  T100.PALLET_NET_WEIGHT                                       AS unitNetWeight ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.PALLET_WEIGHT_UOM_CODE)  AS unitNetWeightUOM ,
  T100.CASE_CUBE_SIZE                                          AS caseCube ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.CASE_CUBE_UOM_CODE)      AS caseCubeUOM ,
  T100.STAT_RATE                                               AS statRate ,
  T100.CASE_CUBE_ORDER_FACTOR                                  AS caseCOF ,
  T100.ITEM_HEIGHT                                             AS itemHeight ,
  T100.ITEM_WIDTH                                              AS itemWidth ,
  T100.ITEM_LENGTH                                             AS itemLength ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.ITEM_DIM_UOM_CODE)       AS itemDimensionsUOM ,
  T100.CASE_HEIGHT                                             AS caseHeight ,
  T100.CASE_WIDTH                                              AS caseWidth ,
  T100.CASE_LENGTH                                             AS caseLength ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.CASE_DIM_UOM_CODE)       AS caseDimensionsUOM ,
  T100.PALLET_HEIGHT                                           AS palletHeight ,
  T100.PALLET_WIDTH                                            AS palletWidth ,
  T100.PALLET_LENGTH                                           AS palletLength ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.PALLET_DIM_UOM_CODE)     AS unitLoadDimensionsUOM ,
  T100.SHELF_PACK_LENGTH                                       AS shelfPackLength ,
  T100.SHELF_PACK_WIDTH                                        AS shelfPackWidth ,
  T100.SHELF_PACK_HEIGHT                                       AS shelfPackHeight ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.SHELF_PACK_UOM_CODE)     AS shelfPackDimensionsUOM ,
  T100.PALLET_CONV_FACTOR                                      AS palletConversionFactor ,
  T100.PALLET_WEIGHT                                           AS unitLoadWeight ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.PALLET_WEIGHT_UOM_CODE)  AS unitLoadWeightUOM ,
  T100.STACK_HEIGHT                                            AS stackHeight ,
  T100.LAYERS_PER_PALLET                                       AS noOfLayers ,
  T100.CASES_PER_LAYER                                         AS casesPerLayer ,
  T100.CASES_PER_PALLET                                        AS casesPerUnitLoad ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.MIN_PLANT_UOM_CODE)      AS minimumUnitFromPlant ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.MIN_DC_UOM_CODE)         AS minimumUnitFromOther ,
  T100.FULL_TRUCK_PALLETS                                      AS fullTruckUnitLoad ,
  T100.FULL_TRUCK_CASES                                        AS fullTruckCases ,
  T100.BTN                                                     AS btn ,
  T005.COUNTRY_NAME                                            AS countryOfOrigin ,
  T100.ALCOHOL_VOLUME                                          AS alcoholInLiters ,
  T100.ALCOHOL_PCT                                             AS alcoholInPercentage ,
  T100.PALLET_HEIGHT                                           AS unitHeight ,
  T100.CATEGORY_ID                                             AS categoryId ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.DISPLAY_VOLUME_UOM_CODE) AS displayVolumeUOMCode ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.DISPLAY_WEIGHT_UOM_CODE) AS displayWeightUOMCode ,
  PKG_LABEL.GET_LABEL_NAME('UOM',T100.DISPLAY_DIM_UOM_CODE)    AS displayDimUOMCode ,
  T100.SHELF_TAG_20                                            AS shelfTag20 ,
  T100.SHELF_TAG_25                                            AS shelfTag25 ,
  T100.SHELF_TAG_30                                            AS shelfTag30 ,
  T100.ORIG_COUNTRY_CODE                                       AS countryCodeOfOrigin ,
  T100.MINIMUM_SELLING_UNIT                                    AS minSellingUnit ,
  T100.DISPLAY_CONVERSION_FACTOR                               AS displayConversionFactor ,
  T100.SELLING_UNITS_PER_CASE                                  AS sellingUnitPerCase ,
  vspDetails.contentId                                         AS vspId ,
  T100.VALID_DATE_FROM_TYPE                                    AS validDateFromType ,
  (SELECT T142.FPM
  FROM T142_FPM T142,
    T100_PRODUCT T100
  WHERE T142.PRODUCT_CODE=T100.PRODUCT_CODE
  AND T142.CLIENT_NO     =T100.CLIENT_NO
  AND T100.PRODUCT_ID    ='2036758'
  )                                           AS floorPriceMinimum ,
  T100.BEGIN_DATE                             AS firstOrderDate ,
  TO_CHAR(T100.BEGIN_DATE,'MM/dd/yyyy')       AS firstOrderDateStr ,
  TO_CHAR(T100.END_DATE ,'MM/dd/yyyy')        AS lastOrderDateStr ,
  TO_CHAR(T100.first_ship_date ,'MM/dd/yyyy') AS firstShipDateStr ,
  T100.END_DATE                               AS lastOrderDate ,
  T100.first_ship_date                        AS firstShipDate ,
  DECODE(
  (SELECT COUNT(1) FROM T105_PRODUCT_IMAGE T105 WHERE T105.RESOLUTION = 'H'
  AND T105.CLIENT_NO                                                  = 301
  AND T105.PRODUCT_ID                                                 = T100.PRODUCT_ID
  ),0,'false','true') AS hasHighResImage ,
  DECODE(
  (SELECT COUNT(1) FROM T105_PRODUCT_IMAGE T105 WHERE T105.RESOLUTION = 'L'
  AND T105.CLIENT_NO                                                  = 301
  AND T105.PRODUCT_ID                                                 = T100.PRODUCT_ID
  ),0,'false','true') AS hasLowResImage ,
  (
  CASE
    WHEN to_date('2015-05-29 11:19:25', 'YYYY-MM-DD HH24:MI:SS') < T100.BEGIN_DATE
    THEN 'true'
    ELSE 'false'
  END) AS newProd ,
  (
  CASE
    WHEN to_date('2015-05-29 11:19:25', 'YYYY-MM-DD HH24:MI:SS')  > T100.END_DATE
    THEN 'true'
    ELSE 'false'
  END) AS discontinued ,
  (
  CASE
    WHEN T100.IS_REMNANT = 'Y'
    THEN 'true'
    ELSE 'false'
  END)          AS remnant ,
  T100.BRAND_ID AS brandId ,
  (SELECT T190.ORDER_GUIDE_CODE_DISPLAY
  FROM T190_ORDER_GUIDE_NOTES T190
  WHERE T190.ORDER_GUIDE_CODE = T100.ORDER_GUIDE_CODE
  ) AS orderGuideNote ,
  (SELECT T127.REORDER_CODE
  FROM T127_PDL T127
  WHERE T127.PRODUCT_ID = '2036758'
  AND T127.CUSTOMER_ID  = '56873'
  ) AS customerCode ,
  (SELECT MIN(DECODE(PKG_CLIENT_ADMIN.IS_FLAG_SET_C(301,'GE_USE_BRAND_CLIENT_DESC'),'Y',T117.CLIENT_DESC,T117.DESCRIPTION))
  FROM T117_BRAND_DESC T117
  WHERE T117.BRAND_ID = T100.BRAND_ID
  )                                                            AS brandName ,
  PKG_CLIENT_ADMIN.IS_FLAG_SET_C(301,'PC_CONVERT_TO_DISPLAYUOM') AS convertToDisplayUOM ,
  T100.IS_MIXED                                                AS isMixed ,
  T100.END_DATE                                                AS endDate ,
  discontinuedContent.REPLACEMENT_UPC                          AS relatedUPC ,
  discontinuedContent.NATL_LAST_SHIP_DATE                      AS lastShipDate ,
  (
  CASE
    WHEN to_date('2015-05-29 11:19:25', 'YYYY-MM-DD HH24:MI:SS')  > T100.END_DATE
    THEN 'Y'
    ELSE 'N'
  END)                  AS discontinuedStr ,
  T100.CASE_CONV_FACTOR AS standardShipCase ,
  T100.PRODUCT_ALLOC    AS productOnAllocation
FROM T100_PRODUCT /*PARTITION (dataObj_to_partition("T100_PRODUCT",?))*/ T100 ,
  T106_PRODUCT_DESC T106 ,
  T005_COUNTRY T005 ,
  (SELECT MIN(T700.CONTENT_ID)             AS contentId ,
    MIN (t705.fast_start_first_ship_date)  AS faststartfirstshipdate ,
    MAX (t705.fast_start_last_ship_date)   AS faststartlastshipdate ,
    MIN (t705.fast_start_first_order_date) AS faststartfirstorderdate ,
    MAX (t705.fast_start_last_order_date)  AS faststartlastorderdate ,
    MIN (t705.natl_first_ship_date)        AS natlfirstshipdate ,
    MAX (t705.natl_last_ship_date)         AS natllastshipdate ,
    MIN (t705.natl_first_order_date)       AS natlfirstorderdate ,
    MAX (t705.natl_last_order_date)        AS natllastorderdate
  FROM T705_CONTENT_PRODUCT T705,
    T700_CONTENT T700,
    T701_CONTENT_TYPE T701,
    T703_CONTENT_BLOCK T703
  WHERE T705.CONTENT_ID         = T700.CONTENT_ID
  AND T700.CONTENT_TYPE_ID      = T701.CONTENT_TYPE_ID
  AND T705.NATL_LAST_SHIP_DATE IS NOT NULL
  AND T703.CONTENT_BLOCK_ID     = T705.CONTENT_BLOCK_ID
  AND T703.BLOCK_TYPE           = 'P'
  AND to_date('2015-05-29 11:19:25', 'YYYY-MM-DD HH24:MI:SS') BETWEEN T700.PUBLISH_START AND T700.PUBLISH_END
  AND T701.CONTENT_TYPE_NAME = 'VSP'
  AND T700.STATUS            = 'A'
  AND EXISTS
    (SELECT 1
    FROM T720_CONTENT_LANGUAGE T720
    WHERE T720.CONTENT_ID  = T700.CONTENT_ID
    AND T720.LANGUAGE_CODE ='en_US'
    )
  AND EXISTS
    (SELECT 1
    FROM T725_CONTENT_CATEGORY T725
    WHERE T700.CONTENT_ID = T725.CONTENT_ID
    AND T725.CATEGORY_ID  =
      (SELECT CATEGORY_ID FROM T100_PRODUCT WHERE PRODUCT_ID = '2036758'
      )
    )
  AND ( EXISTS
    (SELECT 1
    FROM T722_CONTENT_CUST T722
    WHERE T722.CONTENT_ID = T700.CONTENT_ID
    AND T722.CUSTOMER_ID  = '56873'
    )
  OR EXISTS
    (SELECT 1
    FROM T723_CONTENT_CUSTGRP T723
    WHERE T723.CONTENT_ID   = T700.CONTENT_ID
    AND T723.CUST_GROUP_ID IN
      (SELECT CUST_GROUP_ID FROM T064_CUST_CUSTGRP WHERE CUSTOMER_ID = '56873'
      )
    )
  OR ( NOT EXISTS
    (SELECT 1 FROM T722_CONTENT_CUST T722 WHERE T722.CONTENT_ID = T700.CONTENT_ID
    )
  AND NOT EXISTS
    (SELECT 1
    FROM T723_CONTENT_CUSTGRP T723
    WHERE T723.CONTENT_ID = T700.CONTENT_ID
    ) ) )
  AND T705.PRODUCT_ID = '2036758'
  ) vspDetails ,
  (SELECT T705.PRODUCT_ID ,
    T705.REPLACEMENT_UPC ,
    T705.NATL_LAST_SHIP_DATE ,
    T701.CONTENT_TYPE_NAME
  FROM T705_CONTENT_PRODUCT T705,
    T700_CONTENT /*PARTITION(dataObj_to_partition("T700_CONTENT",?))*/ T700,
    T701_CONTENT_TYPE T701,
    T703_CONTENT_BLOCK T703
  WHERE T705.CONTENT_ID     = T700.CONTENT_ID
  AND T700.CONTENT_TYPE_ID  = T701.CONTENT_TYPE_ID
  AND T703.CONTENT_BLOCK_ID = T705.CONTENT_BLOCK_ID
  AND T703.BLOCK_TYPE       = 'P'
  AND to_date('2015-05-29 11:19:25', 'YYYY-MM-DD HH24:MI:SS')  BETWEEN T700.PUBLISH_START AND T700.PUBLISH_END
  AND T701.CONTENT_TYPE_NAME IN ('DISCONTINUED')
  AND T700.STATUS             = 'A'
  AND EXISTS
    (SELECT 1
    FROM T720_CONTENT_LANGUAGE T720
    WHERE T720.CONTENT_ID  = T700.CONTENT_ID
    AND T720.LANGUAGE_CODE ='en_US'
    )
  AND ( EXISTS
    (SELECT 1
    FROM T722_CONTENT_CUST T722
    WHERE T722.CONTENT_ID = T700.CONTENT_ID
    AND T722.CUSTOMER_ID  ='56873'
    )
  OR EXISTS
    (SELECT 1
    FROM T723_CONTENT_CUSTGRP T723
    WHERE T723.CONTENT_ID   = T700.CONTENT_ID
    AND T723.CUST_GROUP_ID IN
      (SELECT CUST_GROUP_ID FROM T064_CUST_CUSTGRP WHERE CUSTOMER_ID = 56873
      )
    )
  OR ( NOT EXISTS
    (SELECT 1 FROM T722_CONTENT_CUST T722 WHERE T722.CONTENT_ID = T700.CONTENT_ID
    )
  AND NOT EXISTS
    (SELECT 1
    FROM T723_CONTENT_CUSTGRP T723
    WHERE T723.CONTENT_ID = T700.CONTENT_ID
    ) ) )
  ) discontinuedContent
WHERE T106.PRODUCT_ID                 = T100.PRODUCT_ID
AND discontinuedContent.PRODUCT_ID(+) = T100.PRODUCT_ID
AND T005.COUNTRY_CODE (+)             = T100.ORIG_COUNTRY_CODE
AND T100.PRODUCT_ID                   = '2036758'
AND T106.LANGUAGE_CODE                = 'en_US' ;

SELECT MAX(T124.BEGIN_DATE)
  FROM T100_PRODUCT /*PARTITION (dataObj_to_partition("T100_PRODUCT",?))*/ T100 ,
    T121_BRACKET T121a ,
    T124_PROD_BRACKET T124
  WHERE T124.PRODUCT_ID                                          = T100.PRODUCT_ID
  AND T121a.BRACKET_ID                                           = T124.BRACKET_ID
  --AND T121a.BRACKET_ID                                           = T121.BRACKET_ID
  AND T121a.CLIENT_NO                                            = '301'
  AND T100.PRODUCT_ID                                            = '2036758'
  AND T124.BEGIN_DATE                                           <= to_date('2015-05-29 11:19:25', 'YYYY-MM-DD HH24:MI:SS')
  AND T124.END_DATE                                             >= to_date('2015-05-29 11:19:25', 'YYYY-MM-DD HH24:MI:SS')
  AND T121a.BRACKET_GROUP                                        = 0
  AND (T124.CASE_PRICE                                          IS NOT NULL
  OR T124.ITEM_PRICE                                            IS NOT NULL)
  AND NVL(T124.RELEASE_DATE,TO_DATE('01/01/1900', 'MM/DD/YYYY')) < = SYSDATE
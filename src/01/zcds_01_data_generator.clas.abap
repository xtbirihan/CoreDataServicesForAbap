CLASS zcds_01_data_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
INTERFACES if_oo_adt_classrun.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcds_01_data_generator IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lv_ts TYPE timestampl,
          lt_salesorg TYPE TABLE OF zsalesorg,
          lt_customer TYPE TABLE of zcustomer.

    GET TIME STAMP FIELD lv_ts.

        SELECT
            k~mandt   as client    ,
            k~vbeln   as SALESORDER,
            k~auart   as SALESORDERTYPE,
            k~vkorg   as SALESORGANIZATION,
            k~kunnr   as SOLDTOPARTY,
            k~vtweg   as DISTRIBUTIONCHANNEL,
            k~spart   as ORGANIZATIONDIVISION,
            k~LFSTK   as DELIVERYSTATUS,
            ' '       as DELETIONINDICATOR,
            k~ernam   as CREATEDBYUSER,
            @lv_ts    as CREATIONDATETIME,
            @sy-uname as LASTCHANGEDBYUSER,
            @lv_ts    as LASTCHANGEDATETIME
         FROM vbak as k
         INNER JOIN vbap as p on p~vbeln = k~vbeln
         INNER JOIN vbep as b on b~vbeln = p~vbeln
                             AND b~posnr = p~posnr
         INNER JOIN mara as m on p~matnr = m~matnr
         INNER JOIN makt as t on t~matnr = p~matnr
                             AND t~spras = @sy-langu
         into TABLE @DATA(lt_salesorder)
         UP TO 250 ROWS.
         if sy-subrc ne 0.
           RETURN.
         endif.

         SORT lt_salesorder by SALESORDER.
         DELETE ADJACENT DUPLICATES FROM lt_salesorder COMPARING SALESORDER.


    LOOP AT lt_salesorder INTO DATA(ls_salesorder)
        GROUP BY ( SALESORGANIZATION = ls_salesorder-SALESORGANIZATION )
        ASCENDING
        ASSIGNING FIELD-SYMBOL(<fs_salesorganization>).
        APPEND VALUE #( client = sy-mandt
                        salesorganization = <fs_salesorganization>-salesorganization ) to lt_salesorg.
   ENDLOOP.

   LOOP AT lt_salesorder INTO ls_salesorder
        GROUP BY ( SOLDTOPARTY = ls_salesorder-SOLDTOPARTY )
        ASCENDING
        ASSIGNING FIELD-SYMBOL(<fs_SOLDTOPARTY>).
        APPEND VALUE #( client = sy-mandt
                        customer = <fs_SOLDTOPARTY>-SOLDTOPARTY ) to lt_customer.
   ENDLOOP.

  SELECT  p~mandt   as client    ,
          p~vbeln   as salesorder   ,
          p~posnr   as salesorderitem,
          p~matnr   as product,
          p~kwmeng  as orderquantity,
          p~vrkme   as orderquantityunit,
          p~netwr   as netamount,
          p~waerk   as transactioncurrency,
          p~erdat   as creationdate,
          p~ernam   as createdbyuser,
          @lv_ts    as creation_date_time,
          @sy-uname as lastchangedbyuser,
          @lv_ts    as lastchangedatetime
          FROM vbap as p
          INNER JOIN @lt_salesorder as o on o~salesorder = p~vbeln
          INTO TABLE @DATA(lt_salesorderitem).

  SELECT  m~mandt   as client    ,
          m~matnr   as product   ,
          m~mtart   as product_type,
          @lv_ts    as creation_date_time
          FROM mara as m
          INNER JOIN @lt_salesorderitem as i on m~matnr = i~product
          INTO TABLE @DATA(lt_product).

    SELECT m~mandt   as client    ,
           m~spras   as language  ,
           m~matnr   as product   ,
           m~maktx   as product_name
          FROM makt as m
          INNER JOIN @lt_product as i on m~matnr = i~product
          where m~spras = @sy-langu
          INTO TABLE @DATA(lt_producttext).


  SELECT  p~mandt   as client    ,
          p~vbeln   as salesorder   ,
          p~posnr   as salesorderitem,
          p~etenr   as salesorderscheduleline,
          p~wmeng   as orderquantity,
          p~vrkme   as orderquantityunit,
          p~edatu   as deliverydate,
          @sy-uname as createdbyuser,
          @lv_ts    as creationdatetime,
          @sy-uname as lastchangedbyuser,
          @lv_ts    as lastchangedatetime
          FROM vbep as p
          INNER JOIN @lt_salesorder as o on o~salesorder = p~vbeln
          INTO TABLE @DATA(lt_salesorderschedule).

    DELETE FROM: zsalesorder, zsalesorderitem, zsalesordersline, zcustomer, zsalesorg, zproduct, zproducttext.
    commit WORK AND WAIT.

    MODIFY zsalesorder      FROM TABLE lt_salesorder.
    MODIFY zsalesorderitem  FROM TABLE lt_salesorderitem.
    MODIFY zsalesordersline FROM TABLE lt_salesorderschedule.
    INSERT zcustomer        FROM TABLE lt_customer.
    INSERT zsalesorg        FROM TABLE lt_salesorg.
    MODIFY zproduct         FROM TABLE lt_product.
    MODIFY zproducttext     FROM TABLE lt_producttext.
    COMMIT WORK AND WAIT.
  ENDMETHOD.

ENDCLASS.

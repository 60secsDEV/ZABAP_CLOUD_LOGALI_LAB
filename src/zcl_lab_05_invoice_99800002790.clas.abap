CLASS zcl_lab_05_invoice_99800002790 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_05_invoice_99800002790 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "--! 1. Concatenación .

    DATA mv_exercise     TYPE n LENGTH 4.
    DATA mv_invoice_no   TYPE n LENGTH 8.
    DATA mv_invoice_code TYPE string.

    mv_exercise = '0150'.
    mv_invoice_no = '99800027'.
    mv_invoice_code = mv_exercise && mv_invoice_no.

    out->write( mv_invoice_code ).

    "--! 2. Concatenaciones líneas de Tablas

    SELECT FROM /dmo/c_employeetp_hd
      FIELDS firstname
      INTO TABLE @DATA(lt_logali).

    DATA(lv_line) = CONCAT_LINES_OF(  TABLE = lt_logali sep = ` ` ).
    out->write( lv_line ).

    "--! 3. Condensación
    DATA(MV_CASE1) = `Sales invoice with    status in process`.
    DATA(MV_CASE2) = '***ABAP*Cloud***'.

    out->write( condense( val  = mv_case1
                          from = `    `
                          to   = ` ` )  ).
    out->write( condense( val  = mv_case2
                          del  = `*`
                          from = `*`
                          to   = ` ` )  ).
    "--! 4. SPLIT
    DATA: MV_DATA TYPE STRING VALUE '0001111111;LOGALIGROUP;2024'.
    DATA: MV_ID_CUSTOMER TYPE STRING.
    DATA: MV_CUSTOMER TYPE STRING.
    DATA: MV_YEAR TYPE STRING.

    SPLIT MV_DATA AT ';' INTO MV_ID_CUSTOMER MV_CUSTOMER MV_YEAR.

    out->write( MV_ID_CUSTOMER ).
    out->write( MV_CUSTOMER ).
    out->write( MV_YEAR ).

    " 5. SHIFT
    DATA: MV_INVOICE_NUM TYPE STRING VALUE '2015ABCD'.

    SHIFT MV_INVOICE_NUM  RIGHT DELETING TRAILING 'CD'.
    SHIFT MV_INVOICE_NUM BY 4 PLACES left  .
    OUT->WRITE( MV_INVOICE_NUM ).

    " 6. Funciones STRLEN y NUMOFCHAR
    DATA: MV_RESPONSE TYPE STRING VALUE ` Generating Invoice `.
    DATA: MV_COUNT TYPE i.

    MV_COUNT = STRLEN( MV_RESPONSE ).
    OUT->WRITE( MV_COUNT ).

    MV_COUNT = NUMOFCHAR( MV_RESPONSE ).
    OUT->WRITE( MV_COUNT ).

    " 7. Funciones TO_LOWER y TO_UPPER
    DATA: MV_TRANSLATE_INVOICE TYPE STRING VALUE 'Report the issuance of this invoice'.

    TRANSLATE MV_TRANSLATE_INVOICE TO UPPER CASE.
    out->write( MV_TRANSLATE_INVOICE ).

    trANSLATE MV_TRANSLATE_INVOICE TO LOWER CASE.
    out->write( MV_TRANSLATE_INVOICE ).

    "8. Función INSERT y REVERSE

    mv_translate_invoice = insert( val = mv_translate_invoice
                                   sub = ' to client'
                                   OFF = 35 ).

    out->write( MV_TRANSLATE_INVOICE ).

    mv_translate_invoice = reverse( val = mv_translate_invoice ).
    out->write( MV_TRANSLATE_INVOICE ).

  ENDMETHOD.
ENDCLASS.

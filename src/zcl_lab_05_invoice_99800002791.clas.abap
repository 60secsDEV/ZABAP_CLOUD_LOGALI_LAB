CLASS zcl_lab_05_invoice_99800002791 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_05_invoice_99800002791 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " 1. OVERLAY
    DATA lv_sale        TYPE string VALUE 'Purchase Completed'.
    DATA lv_sale_status TYPE string VALUE 'Invoice'.

    OVERLAY lv_sale_status WITH lv_sale.
    out->write( |{ lv_sale_status }| ).

    " 2. Función SUBSTRING

    DATA lv_result TYPE string VALUE 'SAP-ABAP-32-PE'.

    lv_result = substring( val = lv_result
                           off = 9
                           len = 5 ).
    out->write( |{ lv_result }| ).

    lv_result = 'SAP-ABAP-32-PE'.

    out->write( |Antes de ABAP: { substring( val = lv_result
                                             off = 0
                                             len = 4 ) } | ).
    out->write( |Despues de ABAP: {  substring( val = lv_result
                                                off = 8
                                                len = 6 )  } | ).
    " 3. FIND
    DATA lv_status TYPE string VALUE 'INVOICE GENERATED SUCCESSFULLY'.
    DATA lv_count  TYPE i.

    lv_count = FIND_ANY_OF( val = lv_status sub = 'GEN' ).
    out->write( |Posición de GEN en la cadena: { lv_count }| ).

    lv_count = count( val = lv_status sub = 'A' ).
    out->write( |Número de veces que aparece A: { lv_count }| ).

    " 4. REPLACE
    DATA LV_REQUEST TYPE STRING VALUE 'SAP-ABAP-32-PE'.
    out->write( |{ lv_request }| ).

    REPLACE ALL OCCURRENCES OF '-' IN LV_REQUEST WITH ` `.
    out->write( |Reemplaza - con espacio: { LV_REQUEST }| ).

    " 5. PCRE Regex
    DATA LV_REGEX TYPE STRING VALUE '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$'.
    DATA lv_email TYPE STRING VALUE 'correo123@email.com'.

    FIND PCRE lv_regex IN lv_email.
    IF sy-subrc = 0.
      out->write( |El correo { lv_email } es válido.| ).
    ELSE.
      out->write( |El correo { lv_email } no es válido.| ).
    ENDIF.

    " 6. Expresiones regulares
    DATA LV_IDCUSTOME TYPE STRING VALUE '0000012345'.
    LV_REGEX = '0*'.

    LV_IDCUSTOME = REPLACE( val = LV_IDCUSTOME PCRE = LV_REGEX WITH = '' ).
    out->write( |ID Cliente sin ceros a la izquierda: { LV_IDCUSTOME }| ).

    " 7. Repetición de string

    lv_idcustome = REPEAT( val = LV_IDCUSTOME occ = 3 ).
    out->write( |ID Cliente repetido 3 veces: { lv_idcustome }| ).

    " 8. Función ESCAPE
    DATA lv_format TYPE string VALUE 'Send payment data via Internet'.

    out->write( |Formato original: { lv_format }| ).
    out->write( |Formato escapado URL: { escape( val = lv_format format  = CL_ABAP_FORMAT=>e_url_full ) }| ).
    out->write( |Formato escapado JSON: { escape( val = lv_format format  = CL_ABAP_FORMAT=>e_json_string ) }| ).
    out->write( |Formato escapado String Template: { escape( val = lv_format format  = CL_ABAP_FORMAT=>e_string_tpl ) }| ).



  ENDMETHOD.
ENDCLASS.

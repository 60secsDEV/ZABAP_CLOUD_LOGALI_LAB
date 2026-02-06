CLASS zcl_lab_06_condition_800002791 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS get_conditional_text
      ImporTING
        iv_string TYPE string
      RETURNING
        VALUE(rv_string) TYPE string.
    CLASS-METHODS get_conditional_text2
      ImporTING
        iv_string TYPE string
      RETURNING
        VALUE(rv_string) TYPE string.
ENDCLASS.

CLASS zcl_lab_06_condition_800002791 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    "1. IF / ENDIF
    DATA(lv_conditional) = 7.

    IF lv_conditional = 7.
      out->write( |The number { lv_conditional } is equal 7| ).
    ELSE.
      out->write( |The number { lv_conditional } is not equal 7| ).
    ENDIF.

    "2. CASE / ENDCASE

    out->write( get_conditional_text( `LOGALY` ) ).
    out->write( get_conditional_text( `SAP` ) ).
    out->write( get_conditional_text( `ABAP` ) ).

    "3. DO / ENDDO
    DATA(lv_counter) = 1.

    DO.
      IF sy-index > 10.
        EXIT.
      ENDIF.
      out->write( |Counter value: { lv_counter }| ).
      lv_counter += 1.
    ENDDO.

    "4. CHECK
    LV_COUNTER = 1.
    DO.
      out->write( |Counter value: { lv_counter }| ).
      lv_counter += 1.
      CHECK sy-index >= 7.
        EXIT.
    ENDDO.

    "5. SWITCH
    out->write( get_conditional_text2( `LOGALI` ) ).
    out->write( get_conditional_text2( `SAP` ) ).
    out->write( get_conditional_text2( `MOVISTAR` ) ).
    out->write( get_conditional_text2( `TEST` ) ).

    "6. COND

    DATA(LV_TIME) = cl_abap_context_info=>get_system_time( ).
    DATA(lv_noon) = CONV T( '120000' ).

    out->write( |The current system time is { COND #( WHEN lv_time < lv_noon THEN
                                                        |{ lv_time TIME = USER } AM |
                                                      WHEN lv_time > lv_noon THEN
                                                        |{ CONV t( lv_time - lv_noon ) TIME = USER } PM |
                                                      ELSE
                                                        |{ lv_time TIME = USER } High Noon |   ) }| ).
    "7. WHILE / ENDWHILE
    DATA(lv_counter2) = 1.

    WHILE lv_counter2 < 20.
      out->write( |Counter2 value: { lv_counter2 }| ).
      lv_counter2 = COND #(  WHEN lv_counter2 < 10 THEN lv_counter2 + 1
                             ELSE 20 ).

    ENDWHILE.

    "8. LOOP / ENDLOOP
    SELECT FROM zemp_logali
    FIELDS *
    INTO TABLE @DATA(lt_employees).

    LOOP AT lt_employees ASSIGNING FIELD-SYMBOL(<ls_employee>) WHERE APE2 = 'Jimenez'.
      out->write( |Employee: { <ls_employee>-name } { <ls_employee>-ape1 } { <ls_employee>-ape2 } Email: { <ls_employee>-email } | ).
    ENDLOOP.

    "9. TRY / ENDTRY
    DATA: LV_EXCEPTION TYPE F VALUE 5.

    lv_counter = 5.

    DO 5 TIMES.
      lv_counter -= 1.
      TRY.
          out->write( |Division: { lv_exception / lv_counter }| ).
        CATCH cx_sy_zerodivide.
          out->write( |Division by zero error when counter is { lv_counter }| ).
      ENDTRY.
    ENDDO.


  ENDMETHOD.


  METHOD get_conditional_text2.
    rv_string = SWITCH string( iv_string
                               WHEN `LOGALI`   THEN `SAP Academy`
                               WHEN `SAP`      THEN `Enterprise software`
                               WHEN `MOVISTAR` THEN `Telephony`
                               ELSE                 `Unknown` ).


  ENDMETHOD.

  METHOD get_conditional_text.
    CASE iv_string.
      WHEN `LOGALI`.
        rv_string = `Academy`.
      WHEN `SAP`.
        rv_string = `Enterprise software`.
      WHEN OTHERS.
        rv_string = `Unknown`.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

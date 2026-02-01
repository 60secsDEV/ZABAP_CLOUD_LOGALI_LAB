CLASS zcl_lab_04_message_99800002790 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_04_message_99800002790 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "--! 1. Símbolos de texto
    out->write( TEXT-001 ). "--! Test with text symbols

    "--! 2. Funciones de descripción
    DATA lv_order_status TYPE string VALUE 'Purchase Completed Successfully'.
    DATA lv_char_number  TYPE i.

    "--! Contar la longitud de caracteres
    lv_char_number = strlen( lv_order_status ).
    out->write( |The length of the status message is: { lv_char_number } characters.| ).

    lv_char_number = numofchar( lv_order_status ).
    out->write( |The number of characters in the status message is: { lv_char_number }.| ).

    "--! Contar la cantidad de los caracteres “A”
    lv_char_number = count( val = lv_order_status
                            sub = 'A'
                            case = abap_false ). "--! Redundate, case insensitive

    out->write( |The number of character 'A' in the status message is: { lv_char_number }.| ).

    "--! Contar la cantidad de los caracteres “A”
    lv_char_number = find( val = lv_order_status
                            sub = 'Exit'
                            case = abap_false ). "--! Redundate, case insensitive

    out->write( |The position of substring 'Exit' in the status message is: { lv_char_number }.| ).

    "--! 3. Funciones de procesamiento

    "--! Cambiar el formato del contenido de la variable a mayúsculas,  y a un mixto entre los 2 formatos.
    out->write( |The status message in upper case is: { to_upper( lv_order_status ) }.| ).

    out->write( |The status message in lower case is: { to_lower( lv_order_status ) }.| ).

    out->write( |The status message in mixed case is: { to_mixed( val = FROM_mixed( VAL = lv_order_status ) )  } | ).

    "--! Desplazar los 9 primeros caracteres al final de la variable.
    out->write( |The status message after circular left shift by 9 is: { shift_left( val = lv_order_status CIRCULAR = 9 ) }.| ).

    "--! Extraer la palabra “Completed” de la variable
    out->write( |The first 10 characters of the status message are: { lv_order_status+9(10) }.| ).

    "--! Revertir el orden de los caracteres de la variable
    out->write( |The status message reversed is: { reverse( val = lv_order_status ) } .| ).

    "--! 4. Funciones de contenido

    DATA: lv_patter TYPE string VALUE '\d{3}-\d{3}-\d{4}'.
    DATA: lv_phone  TYPE string VALUE '041-456-7890'.

    IF contains( val = lv_phone pcre = lv_patter  ).
      out->write( |The phone number { lv_phone } matches the pattern { lv_patter }.| ).
    ELSE.
      out->write( |The phone number { lv_phone } does not match the pattern { lv_patter }.| ).
    ENDIF.

    "--! 5. Funciones con expresiones regulares
    DATA: LV_EMAIL TYPE STRING VALUE 'cualquier_mail@gmail.com'.

    lv_patter = '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'.

    IF CONTAINS( VAL = LV_EMAIL PCRE = LV_PATTER ).
      out->write( |The email { LV_EMAIL } is valid according to the pattern { LV_PATTER }.| ).
    ELSE.
      out->write( |The email { LV_EMAIL } is not valid according to the pattern { LV_PATTER }.| ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.

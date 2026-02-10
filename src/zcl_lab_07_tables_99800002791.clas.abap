CLASS zcl_lab_07_tables_99800002791 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_lab_07_tables_99800002791 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    CONSTANTS lh TYPE string VALUE 'LH' ##NO_TEXT.
    CONSTANTS km TYPE string VALUE 'KM' ##NO_TEXT.
    CONSTANTS fra TYPE string VALUE 'FRA' ##NO_TEXT.

    " 1. Añadir registros
    DATA: mt_employees TYPE TABLE OF ZEMP_LOGALI.
    DATA: ms_employees TYPE ZEMP_LOGALI.

    APPEND VALUE #( id     = '00000001'
                    email  = 'prueba@email.com '
                    name   = 'Juan'
                    fechan = '20240101'
                    fechaa = '20240131'
                    ape1   = 'Perez'
                    ape2   = 'Gomez' ) TO mt_employees.
    APPEND VALUE #( id     = '00000002'
                    email  = 'prueba2@email.com'
                    name   = 'Maria'
                    fechan = '20240201'
                    fechaa = '20240228'
                    ape1   = 'Lopez'
                    ape2   = 'Diaz' ) TO mt_employees.

    " 2. Insertar registros
    INSERT VALUE #( id     = '00000003'
                    email  = 'prueba3@email.com '
                    name   = 'Carlos'
                    fechan = '20240301'
                    fechaa = '20240331'
                    ape1   = 'Garcia'
                    ape2   = 'Martinez' ) INTO TABLE mt_employees.

    " 3. Añadir registros con APPEND
    DATA: mt_employees_2 TYPE TABLE OF ZEMP_LOGALI.

    ms_employees = VALUE #( id     = '00000004'
                            email  = 'prueba4@email.com'
                            name   = 'Ana'
                            fechan = '20240401'
                            fechaa = '20240430'
                            ape1   = 'Sanchez'
                            ape2   = 'Rodriguez' ).

    APPEND ms_employees TO mt_employees_2.

    append value #( id     = '00000005'
                    email  = 'prueba5@gmail.com'
                    name   = 'Luis'
                    fechan = '20240501'
                    fechaa = '20240531'
                    ape1   = 'Fernandez'
                    ape2   = 'Gonzalez' ) to mt_employees_2.

    APPEND LINES OF mt_employees FROM 2 TO 3 TO mt_employees_2.

    " 4. CORRESPONDING
    DATA: MT_SPFLI TYPE TABLE OF /dmo/connection,
          ms_spfli TYPE /dmo/connection,
          mt_spfli_2 TYPE /dmo/connection.

    SELECT FROM /dmo/connection
      FIELDS *
      WHERE carrier_id = @lh
      INTO TABLE @mt_spfli.

    READ TABLE mt_spfli INTO ms_spfli INDEX 1.
    IF sy-subrc = 0.
      mt_spfli_2 = CORRESPONDING #( ms_spfli ).
    ENDIF.

    " 5. READ TABLE con índice
    READ TABLE MT_SPFLI INTO ms_spfli INDEX 1.
    IF sy-subrc = 0.
      out->write( data = ms_spfli
                  name = 'ms_spfli' ).
    ENDIF.

    " 6. READ TABLE con clave
    READ TABLE mt_spfli INTO ms_spfli WITH KEY airport_to_id = fra.
    IF sy-subrc = 0.

      SELECT SINGLE FROM /dmo/airport
        FIELDS city
        WHERE airport_id = @ms_spfli-airport_from_id
        INTO @DATA(mv_from_city).

      out->write( data = mv_from_city
                  name = 'Ciudad departida del Aeropuerto' ).
    ENDIF.

    " 7. Chequeo de registros
    SELECT FROM /dmo/connection
      FIELDS *
      WHERE connection_id > '0400'
      INTO TABLE @mt_spfli.
    out->write( data = mt_spfli
                name = 'Vuelos con ID mayor a 0400' ).
    IF sy-subrc EQ 0.
      out->write(
          |El vuelo 0407{ COND #( WHEN NOT line_exists( mt_spfli[ connection_id = '0407' ] ) THEN ` no` ELSE ` si` ) } existe en los registros.| ).
    ENDIF.

    " 8. Índice de un registro
    out->write(
          |El vuelo 0407 existe en el indice { line_index( mt_spfli[ connection_id = '0407' ] ) } | ).

    " 9. Sentencia LOOP

    SELECT FROM /dmo/connection
      FIELDS *
      INTO TABLE @mt_spfli.

    LOOP AT  mt_spfli ASSIGNING FIELD-SYMBOL(<fs_spfli>) WHERE distance_unit = km.
      out->write( data = <fs_spfli>
                  name = |Registro { sy-tabix }| ).
    ENDLOOP.


  ENDMETHOD.



ENDCLASS.

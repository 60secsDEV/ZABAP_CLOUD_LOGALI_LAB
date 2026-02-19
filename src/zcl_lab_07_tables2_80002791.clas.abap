CLASS zcl_lab_07_tables2_80002791 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_lab_07_tables2_80002791 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " 1. FOR
    TYPES: BEGIN OF ty_flight,
             iduser     TYPE c LENGTH 40,
             aircode    TYPE /dmo/carrier_id,
             flightnum  TYPE /dmo/connection_id,
             key        TYPE land1,
             seat       TYPE /dmo/plane_seats_occupied,
             flightdate TYPE /dmo/flight_date,
           END OF ty_flight,
           tty_flight TYPE TABLE OF ty_flight.

    DATA lt_flight      TYPE TABLE OF ty_flight.
    DATA lt_flight_info TYPE TABLE OF ty_flight.

    lt_flight = VALUE #( FOR i = 0 UNTIL i >= 5
                         ( iduser     = |1234{ i }-USER|
                           aircode    = |SQ|
                           flightnum  = |0000{ i }|
                           key        = |US|
                           seat       = |0{ i }|
                           flightdate = ( cl_abap_context_info=>get_system_date( ) + i ) ) ).

    lt_flight_info = VALUE #( FOR ls_flight IN lt_flight
                              ( iduser     = ls_flight-iduser
                                aircode    = 'CL'
                                flightnum  = ls_flight-flightnum + 10
                                key        = 'COP'
                                seat       = ls_flight-seat
                                flightdate = ls_flight-flightdate ) ).

    out->write( name = '1 - FOR LT_FLIGHT'
                data = lt_flight ).

    out->write( name = '1 - FOR LT_FLIGHT_INFO'
                data = lt_flight_info ).

    " 2. FOR Anidado

    DATA mt_flights_type TYPE TABLE OF /dmo/flight.
    DATA mt_airline      TYPE TABLE OF /dmo/connection.
    DATA lt_final        TYPE SORTED TABLE OF ty_flight WITH NON-UNIQUE KEY aircode.

    SELECT FROM /dmo/flight
      FIELDS *
      INTO TABLE @mt_flights_type.

    SELECT FROM /dmo/connection
      FIELDS *
      " WHERE carrier_id = 'SQ'
      INTO TABLE @mt_airline.

    lt_final = VALUE #( FOR wa_flight IN mt_flights_type WHERE ( carrier_id = 'SQ' )
                        FOR wa_airline IN mt_airline
                        WHERE ( connection_id = wa_flight-connection_id )
                        ( iduser     = wa_flight-client
                          aircode    = wa_flight-carrier_id
                          flightnum  = wa_airline-connection_id
                          key        = wa_airline-airport_from_id
                          seat       = wa_flight-seats_occupied
                          flightdate = wa_flight-flight_date ) ).

    out->write( name = '2. FOR Anidado'
                data = lt_final ).

    " 3. Añadir múltiples líneas (SELECT)

    TYPES: BEGIN OF ty_airelines,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
           END OF ty_airelines.
    DATA mt_airlines TYPE TABLE OF ty_airelines.

    SELECT carrier_id,
           connection_id,
           airport_from_id,
           airport_to_id
      FROM @mt_airline AS airline
      WHERE airport_from_id = 'FRA'
      INTO TABLE @mt_airlines.

    out->write( name = '3. Añadir múltiples líneas (SELECT)'
                data = mt_airlines ).

    " 4. Ordenar registros
    SORT mt_airlines BY connection_id DESCENDING.

    out->write( name = '4. Ordenar registros'
                data = mt_airlines ).

    " 5. Modificar registros
    LOOP AT mt_airline INTO DATA(ls_airline) WHERE departure_time > '120000'.
      ls_airline-departure_time = cl_abap_context_info=>get_system_time( ).
      MODIFY mt_airline FROM ls_airline.
    ENDLOOP.

    out->write( name = '5. Modificar registros'
                data = mt_airline ).

    " 6. Eliminar registros
    DELETE mt_airline WHERE airport_to_id = 'FRA'.
    out->write( name = '6. Eliminar registros'
                data = mt_airline ).

    "7. CLEAR / FREE
    FREE MT_AIRLINES.
    out->write( name = '7. CLEAR / FREE'
                data = mt_airlines ).

    " 8. Instrucción COLLECT
    TYPES: BEGIN OF ty_seats,
             carrier_id    TYPE /dmo/carrier_id,
             connection_id TYPE /dmo/connection_id,
             seats         TYPE /dmo/plane_seats_occupied,
             bookings      TYPE /dmo/flight_price,
           END OF ty_seats.

    DATA lt_seats  TYPE HASHED TABLE OF ty_seats WITH UNIQUE KEY carrier_id connection_id.
    DATA lt_seats2 TYPE TABLE OF ty_seats.

    SELECT FROM /dmo/flight
      FIELDS carrier_id,
             connection_id,
             seats_occupied,
             price
      WHERE seats_max = '140'
      INTO TABLE @lt_seats.

    SELECT FROM /dmo/flight
      FIELDS carrier_id,
             connection_id,
             seats_occupied,
             price
      INTO TABLE @lt_seats2.

    LOOP AT LT_seats2 ASSIGNING FIELD-SYMBOL(<fs_seats2>).
      COLLECT <fs_seats2> INTO lt_seats.
    ENDLOOP.

    out->write( name = '8. Instrucción COLLECT'
                data = lt_seats ).

    " 9. Instrucción LET

    DATA: mt_scarr TYPE TABLE OF /dmo/carrier.

    SELECT FROM /dmo/carrier
      FIELDS *
      INTO TABLE @mt_scarr.

    FINAL(v_price)      = CONV string( LET s_flight_type = mt_flights_type[ 1 ] IN s_flight_type-price ).
    FINAL(v_carrier_id) = CONV string( LET s_scarr = mt_scarr[ 1 ] IN s_scarr-carrier_id ).

    out->write( name = '9. Instrucción LET'
                data = |Price: { v_price }, Carrier ID: { v_carrier_id }| ).

    " 10. Instrucción BASE
    DATA: LT_FLIGHTS_BASE TYPE TABLE OF /dmo/flight.

    LT_FLIGHTS_BASE = VALUE #( BASE mt_flights_type ( )  ).

    out->write( name = '10. Instrucción BASE'
                data = LT_FLIGHTS_BASE ).

    " 11. Agrupación de registros

    SELECT FROM /dmo/connection
    FIELDS *
    INTO TABLE @DATA(mt_spfli).

    out->write( data = |11. Agrupación de registros| ).

    LOOP AT mt_spfli ASSIGNING FIELD-SYMBOL(<fs_spfli>) GROUP BY ( airport_from_id = <fs_spfli>-airport_from_id ) WITHOUT MEMBERS ASSIGNING FIELD-SYMBOL(<fs_key>).

      out->write( data = |Airport From ID: { <fs_key>-airport_from_id }| ).

    ENDLOOP.

    "12. Agrupar por clave / FOR GROUPS

    LOOP AT mt_spfli ASSIGNING FIELD-SYMBOL(<t_group>) GROUP BY ( airport_from_id = <t_group>-airport_from_id
                                                                  "airport_to_id  = <t_group>-airport_to_id
                                                                   ).

      out->write( data = |Airport From ID: { <t_group>-airport_from_id } | ). ", Airport To ID: { <t_group>-airport_to_id }| ).

      LOOP AT GROUP <t_group> ASSIGNING FIELD-SYMBOL(<fs_group>).
        " Aquí puedes acceder a los registros del grupo utilizando <fs_group>
        out->write( data = <fs_group> ).
      ENDLOOP.
    ENDLOOP.

    " 14. Tablas de rangos

    DATA lt_range TYPE RANGE OF /dmo/plane_seats_occupied.

    lt_range[] = VALUE #( ( sign = 'I' option = 'BT' low = '200' high = '400' ) ).

    SELECT FROM /dmo/flight
      FIELDS *
      WHERE seats_occupied IN @lt_range
      INTO TABLE @MT_FLIGHTS_TYPE.

    out->write( name = '14. Tablas de rangos'
                data = lt_range ).

    " 15. Enumeraciones

    TYPES lty_currency TYPE C LENGTH 3.

    TYPES BEGIN OF ENUM mty_currency BASE TYPE lty_currency.
        TYPES   c_initial VALUE IS INITIAL.
        TYPES   c_usd     VALUE 'USD'.
        TYPES   c_euros   VALUE 'EUR'.
        TYPES   c_colpeso VALUE 'COP'.
        TYPES   c_mexpeso VALUE 'MEX'.
    TYPES END OF ENUM mty_currency.

    DATA(lv_currency) = c_usd.
    out->write( name = '15. Enumeraciones'
                data = |Currency: { lv_currency }| ).

    lv_currency = C_mexpeso.

    out->write( data = |Currency: { lv_currency }| ).

 "
  ENDMETHOD.
ENDCLASS.

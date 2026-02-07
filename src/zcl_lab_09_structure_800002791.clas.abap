CLASS zcl_lab_09_structure_800002791 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_lab_09_structure_800002791 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. Declaración estructuras
    TYPES: BEGIN OF ty_flights,
             iduser     TYPE c LENGTH 40,
             aircode    TYPE /dmo/carrier_id,
             flightnum  TYPE /dmo/connection_id,
             key        TYPE land1,
             seat       TYPE /dmo/plane_seats_occupied,
             flightdate TYPE /dmo/flight_date,
           END OF ty_flights.

    TYPES: BEGIN OF ty_airlines,
             carrid    TYPE /dmo/carrier_id,
             connid    TYPE /dmo/connection_id,
             countryfr TYPE land1,
             cityfrom  TYPE /dmo/city,
             airpfrom  TYPE /dmo/airport_id,
             countryto TYPE land1,
           END OF ty_airlines.

    " 2. Estructuras anidadas (NESTED)
    TYPES: BEGIN OF ty_nested,
             flights  TYPE ty_flights,
             airlines TYPE ty_airlines,
           END OF ty_nested.

    " 3. Estructuras complejas (DEEP)
    DATA: BEGIN OF ty_deep,
             carrid  TYPE /dmo/carrier_id,
             connid  TYPE /dmo/connection_id,
             flights TYPE TABLE OF ty_flights,
           END OF ty_deep.
    " 4. Añadir datos
    DATA: ls_deep LIKE ty_deep.
    ls_deep = VALUE #( carrid  = 'LH'
                       connid  = '0400'
                       flights = VALUE #( aircode    = 'LH'
                                          flightnum  = '0400'
                                          key        = 'DE'
                                          flightdate = '20240701'
                                          ( iduser = 'User1' seat = 150 )
                                          ( iduser = 'User2' seat = 151 ) ) ).

    DATA ls_nested TYPE ty_nested.
    ls_nested = VALUE #( flights  = VALUE #( aircode    = 'LH'
                                             flightnum  = '0400'
                                             key        = 'DE'
                                             seat       = 150
                                             flightdate = '20240701' )
                         airlines = VALUE #( carrid    = 'LH'
                                             connid    = '0400'
                                             countryfr = 'DE'
                                             cityfrom  = 'Frankfurt'
                                             airpfrom  = 'FRA'
                                             countryto = 'US' ) ).


    out->write( data = ls_deep
                name = 'Deep' ).

    out->write( data = ls_nested
                name = 'Nested' ).


    " 5. Estructura INCLUDE
    TYPES BEGIN OF ty_include_flights.
            INCLUDE TYPE ty_flights  AS flights.
            INCLUDE TYPE ty_airlines AS airlines.
    TYPES END OF ty_include_flights.

    DATA ls_nested_flights TYPE ty_include_flights.

    ls_nested_flights = VALUE #( flights  = VALUE #( aircode    = 'LH'
                                                     flightnum  = '0400'
                                                     key        = 'DE'
                                                     seat       = 150
                                                     flightdate = '20240701' )
                                 airlines = VALUE #( carrid    = 'LH'
                                                     connid    = '0400'
                                                     countryfr = 'DE'
                                                     cityfrom  = 'Frankfurt'
                                                     airpfrom  = 'FRA'
                                                     countryto = 'US' ) ).
    out->write( data = ls_nested_flights
                name = 'Include' ).

    "6. Eliminar datos
    CLEAR ls_deep.
    CLEAR ls_nested.

    out->write( data = ls_deep
                name = 'Deep' ).

    out->write( data = ls_nested
                name = 'Nested' ).

  ENDMETHOD.



ENDCLASS.

CLASS zcl_lab_03_datatypes_980002790 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_lab_03_datatypes_980002790 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " 1. Conversiones de Tipo
    DATA mv_char  TYPE c LENGTH 10 VALUE '12345'.
    DATA mv_num   TYPE i.
    DATA mv_float TYPE f.

    mv_num   = mv_char.
    mv_float = mv_char.

    out->write( |Integer value: { mv_num }| ).
    out->write( |Floating-point value: { mv_float }| ).

    " 2. Truncamiento y Redondeo
    DATA mv_trunc TYPE i.
    DATA mv_round TYPE i.

    mv_float = '123.45'.
    mv_trunc = mv_float.
    mv_round = mv_float + '0.5'.

    out->write( |Truncated integer value: { mv_trunc }| ).
    out->write( |Rounded integer value: { mv_round }| ).

    " 3. Tipos en declaraciones en línea
    DATA(v_abap) = 'ABAP'.
    out->write( |Char value: { v_abap }| ).

    " 4. Conversiones del Tipo Forzado
    mv_num = CONV i( mv_char ).
    out->write( |Forced conversion to integer: { mv_num }| ).

    " 5. Cálculo de Fecha y Hora
    DATA mv_date_1 TYPE d.
    DATA mv_date_2 TYPE d.
    DATA mv_days   TYPE i.
    DATA mv_time   TYPE t.

    mv_date_1 = '20240101'.
    mv_date_2 = cl_abap_context_info=>get_system_date( ).

    mv_days = mv_date_2 - mv_date_1.
    out->write( |Days between { mv_date_1 DATE = USER } and { mv_date_2 DATE = USER }: { mv_days }| ).
    out->write( |Date format DDMMAAAA: { mv_date_1+6(2) }{ mv_date_1+4(2) }{ mv_date_1(4) }| ).

    " 6. Campos Timestamp
    DATA mv_timestamp TYPE utclong.

    mv_timestamp = utclong_current( ).
    out->write( |Current UTC Timestamp: { mv_timestamp }| ).

    TRY.
        CONVERT UTCLONG mv_timestamp TIME ZONE cl_abap_context_info=>get_user_time_zone( )
                INTO DATE mv_date_2 TIME mv_time.
      CATCH cx_abap_context_info_error.
        out->write( 'Error converting UTC timestamp to local date and time.'  ).
    ENDTRY.

    out->write( |Local Date/Time: { mv_date_2 DATE = USER } / { mv_time TIME = USER } |  ).

    mv_timestamp = utclong_add( val = mv_timestamp days = -2 ).
    out->write( |UTC Timestamp two days ago: { mv_timestamp }| ).

  ENDMETHOD.
ENDCLASS.

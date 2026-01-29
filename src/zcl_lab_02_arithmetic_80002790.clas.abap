CLASS zcl_lab_02_arithmetic_80002790 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_02_arithmetic_80002790 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " 1. Suma / Sentencia ADD
    DATA lv_base_rate            TYPE i VALUE 20.
    DATA lv_corp_area_rate       TYPE i VALUE 10.
    DATA lv_medical_service_rate TYPE i VALUE 15.
    DATA lv_total_rate           TYPE i.

    lv_total_rate = lv_base_rate + lv_corp_area_rate + lv_medical_service_rate.
    OUT->write( lv_total_rate ).
    ADD 5 TO lv_total_rate.
    OUT->write( lv_total_rate ).

    "2. Resta / Sentencia SUBTRACT

    DATA lv_maintenance_rate TYPE i VALUE 30.
    DATA lv_margin_rate      TYPE i VALUE 10.
    DATA LV_BASE_RATE2 TYPE i .

    LV_BASE_RATE2 = lv_maintenance_rate - lv_margin_rate.
    out->write( LV_BASE_RATE2 ).
    SUBTRACT 4 FROM LV_BASE_RATE2.
    out->write( LV_BASE_RATE2 ).

    " 3. Multiplicación / Sentencia MULTIPLY
    DATA lv_package_weight TYPE i VALUE 2.
    DATA lv_cost_per_kg    TYPE i VALUE 3.
    DATA lv_multi_rate     TYPE i.

    lv_multi_rate = LV_PACKAGE_WEIGHT * LV_COST_PER_KG.
    out->write( lv_multi_rate ).
    MULTIPLY lv_multi_rate BY 2.
    out->write( lv_multi_rate ).

    " 4. División / Sentencia DIVIDE
    DATA lv_total_weight TYPE i                     VALUE 38.
    DATA lv_num_packages TYPE i                     VALUE 4.
    DATA lv_applied_rate TYPE p LENGTH 8 DECIMALS 2.

    lv_applied_rate = lv_total_weight / lv_num_packages.
    out->write( lv_applied_rate ).
    DIVIDE lv_applied_rate BY 3.
    out->write( lv_applied_rate ).

    " 5. División sin resto / Sentencia DIV

    DATA lv_total_cost         TYPE i                     VALUE 17.
    DATA lv_discount_threshold TYPE i                     VALUE 4.
    DATA lv_result             TYPE p LENGTH 4 DECIMALS 2.

    lv_result = lv_total_cost DIV lv_discount_threshold.
    out->write( lv_result ).
    DIVIDE lv_result BY 2.
    out->write( lv_result ).

    " 6. Resto (residuo) de división / Sentencia MOD

    DATA lv_total_cost2         TYPE i                     VALUE 19.
    DATA lv_discount_threshold2 TYPE i                     VALUE 4.
    DATA lv_remainder           TYPE p LENGTH 4 DECIMALS 2.

    lv_remainder = lv_total_cost2 MOD lv_discount_threshold2.
    out->write( lv_remainder ).

    " 7. Exponenciación
    DATA lv_weight TYPE i VALUE 5.
    DATA lv_expo   TYPE i.

    lv_expo = IPOW( base = LV_WEIGHT exp = 2 ).
    out->write( lv_expo ).

    " 8. Raíz cuadrada
    DATA: LV_SQUARE_ROOT TYPE i.

    LV_SQUARE_ROOT = SQRT( lv_expo ).
    out->write( LV_SQUARE_ROOT ).

  ENDMETHOD.
ENDCLASS.

CLASS zcl_lab_01_var_cb9980002790 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_lab_01_var_cb9980002790 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    "--! 1. Tipo de datos elementales

    DATA mv_purchase_date TYPE d.
    DATA mv_purchase_time TYPE t.

    mv_purchase_date = cl_abap_context_info=>get_system_date( ).
    mv_purchase_time = cl_abap_context_info=>get_system_time( ).

    out->write( |Fecha: { mv_purchase_date DATE = USER } Hora: { mv_purchase_time TIME = USER } | ).

    DATA mv_price TYPE f VALUE '10.5'.
    DATA mv_tax   TYPE i VALUE 16.

    out->write( |Precio: { mv_price } Impuesto: { mv_tax }%| ).

    DATA mv_increase TYPE decfloat16 VALUE '20.5'.
    DATA mv_discount TYPE decfloat34 VALUE '10.5'.

    out->write( |Incremento: { mv_increase } Descuento: { mv_discount }| ).

    DATA mv_type     TYPE c LENGTH 10           VALUE 'PC'.
    DATA mv_shipping TYPE p LENGTH 8 DECIMALS 2 VALUE '40.36'.

    out->write( |Tipo: { mv_type } Envío: { mv_shipping }| ).

    DATA mv_id_code TYPE n LENGTH 4 VALUE 1110.
    DATA mv_qr_code TYPE x LENGTH 5 VALUE 'F5CF'.

    out->write( |ID Código: { mv_id_code } Código QR: { mv_qr_code }| ).

    "--! 2. Tipo de datos complejos

    TYPES: BEGIN OF mty_customer,
             id       TYPE i,
             customer TYPE c LENGTH 15,
             age      TYPE i,
           END OF mty_customer.

    DATA ms_customer TYPE mty_customer.

    ms_customer = VALUE #( id       = 1
                           customer = 'Pedro Perez'
                           age      = 30 ).

    out->write( |ID: { ms_customer-id } Nombre { ms_customer-customer } Edad { ms_customer-age }| ).

    "--! 3. Tipo de datos de referencia

    DATA ms_employees TYPE REF TO /dmo/employee_hr.

    ms_employees = NEW #( employee        = '00000001'
                          first_name      = 'Pedro'
                          last_name       = 'Perez'
                          salary          = '1000.00'
                          salary_currency = 'USD'
                          manager         = '20000015'  ).

    out->write( |ID Empleado: { ms_employees->employee }| ).
    out->write( |Nombre Completo: { ms_employees->first_name } { ms_employees->last_name }| ).
    out->write( |Salario: { ms_employees->salary_currency } { ms_employees->salary CURRENCY = ms_employees->salary_currency }| ).
    out->write( |ID Gerente: { ms_employees->manager } |  ).

    "--! 4. Objetos de datos

    DATA mv_product  TYPE string  VALUE `Laptop`.
    DATA mv_bar_code TYPE xstring VALUE '121210121211'.

    "--! 5 Constantes

    CONSTANTS mc_price    TYPE f                     VALUE '10.5'.
    CONSTANTS mc_tax      TYPE i                     VALUE 16.
    CONSTANTS mc_increase TYPE decfloat16            VALUE '20.5'.
    CONSTANTS mc_discount TYPE decfloat34            VALUE '10.5'.
    CONSTANTS mc_type     TYPE c LENGTH 10           VALUE 'PC'.
    CONSTANTS mc_shipping TYPE p LENGTH 8 DECIMALS 2 VALUE '40.36'.
    CONSTANTS mc_id_code  TYPE n LENGTH 4            VALUE 1110.
    CONSTANTS mc_qr_code  TYPE x LENGTH 5            VALUE 'F5CF'.
    CONSTANTS mc_product  TYPE string                VALUE `Laptop`.
    CONSTANTS mc_bar_code TYPE xstring               VALUE '121210121211'.
    CONSTANTS: BEGIN OF mc_customer,
                 id       TYPE i           VALUE 1,
                 customer TYPE c LENGTH 15 VALUE 'Pedro Perez',
                 age      TYPE i           VALUE 30,
               END OF mc_customer.

    mv_price    = mc_price.
    mv_tax      = mc_tax.
    mv_increase = mc_increase.
    mv_discount = mc_discount.
    mv_type     = mc_type.
    mv_shipping = mc_shipping.
    mv_id_code  = mc_id_code.
    mv_qr_code  = mc_qr_code.
    mv_product  = mc_product.
    mv_bar_code = mc_bar_code.
    ms_customer = mc_customer.

    "--! 6. Declaraciones en Línea

    DATA(lv_product)  = mv_product.
    DATA(lv_bar_code) = mv_bar_code.
  ENDMETHOD.
ENDCLASS.

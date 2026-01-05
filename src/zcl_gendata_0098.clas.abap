CLASS zcl_gendata_0098 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gendata_0098 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


*    DATA lt_Orders_VH          TYPE TABLE OF zorderstavh_0098.
*
*    " Inserción de datos en la tabla ztb_acc_cat_c161.
*
*    lt_Orders_VH = VALUE #( ( orderstatus = '1' description = 'Error' )
*                            ( orderstatus = '2' description = 'Open' )
*                            ( orderstatus = '3' description = 'Success' ) ).
*
*    " Eliminamos posibles partidas y instertamos las nuevas.
*    DELETE FROM zorderstavh_0098.                       "#EC CI_NOWHERE
*    INSERT zorderstavh_0098 FROM TABLE @lt_Orders_VH.
*
*    IF sy-subrc = 0.
*      out->write( |Acceso Categorias: { sy-dbcnt } registros insertados| ).
*    ENDIF.



  ENDMETHOD.
ENDCLASS.

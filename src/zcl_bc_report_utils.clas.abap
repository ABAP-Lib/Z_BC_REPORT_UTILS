CLASS zcl_bc_report_utils DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-METHODS read_list_from_memory
      EXPORTING
        !et_list TYPE stringtab
      RAISING
        zcx_bc_report_utils.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_bc_report_utils IMPLEMENTATION.

  METHOD read_list_from_memory.

    DATA: lt_list         TYPE STANDARD TABLE OF abaplist,
          lt_listout      TYPE STANDARD TABLE OF char255,
          lv_tmp_message  TYPE string.

    " Obter lista da memória
    CALL FUNCTION 'LIST_FROM_MEMORY'
      TABLES
        listobject = lt_list
      EXCEPTIONS
        OTHERS     = 2.

    IF sy-subrc <> 0.
      " Erro ao ler lista da memória com função LIST_FROM_MEMORY
      MESSAGE e001(z_bc_report_utils) WITH 'LIST_FROM_MEMORY' INTO lv_tmp_message.
      RAISE EXCEPTION TYPE zcx_bc_report_utils.
    ENDIF.

    " Converter lista para ASCII
    CALL FUNCTION 'LIST_TO_ASCI'
      TABLES
        listasci   = lt_listout
        listobject = lt_list
      EXCEPTIONS
        empty_list         = 1
        list_index_invalid = 2
        OTHERS             = 3.

    IF sy-subrc <> 0.
      " Erro ao converter lista para ASCII com função LIST_TO_ASCI
      MESSAGE e002(z_bc_report_utils) WITH 'LIST_TO_ASCI' INTO lv_tmp_message.
      RAISE EXCEPTION TYPE zcx_bc_report_utils.
    ENDIF.

    " Liberar memória da lista
    CALL FUNCTION 'LIST_FREE_MEMORY'.

    " Preencher tabela de saída
    LOOP AT lt_listout INTO DATA(lv_line).
      APPEND |{ lv_line }| TO et_list.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
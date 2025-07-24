*"* use this source file for your ABAP unit test classes

CLASS ltcl_bc_report_utils_test DEFINITION DEFERRED.
CLASS zcl_bc_report_utils DEFINITION LOCAL FRIENDS ltcl_bc_report_utils_test.

CLASS ltcl_bc_report_utils_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS: test_read_list_from_memory FOR TESTING.

ENDCLASS.

CLASS ltcl_bc_report_utils_test IMPLEMENTATION.

  METHOD test_read_list_from_memory.

    DATA: lt_resultado TYPE stringtab.

    " Executar programa mock e capturar saída
    SUBMIT zr_bc_report_utils_mock
      EXPORTING LIST TO MEMORY
      AND RETURN.

    " Chamar método sob teste
    TRY.
        zcl_bc_report_utils=>read_list_from_memory(
          IMPORTING
            et_list = lt_resultado
        ).

        " Verificar se foi retornado conteúdo
        cl_abap_unit_assert=>assert_not_initial(
          act = lt_resultado
          msg = 'Lista retornada não deveria estar vazia'
        ).

        " Verificar se contém todas as linhas esperadas do programa mock
        DATA(lv_found_line1) = abap_false.
        DATA(lv_found_line2) = abap_false.
        DATA(lv_found_line3) = abap_false.
        DATA(lv_found_line4) = abap_false.
        DATA(lv_found_line5) = abap_false.
        DATA(lv_found_numeros) = abap_false.
        DATA(lv_found_especiais) = abap_false.
        DATA(lv_found_espacos) = abap_false.
        DATA(lv_found_final) = abap_false.

        LOOP AT lt_resultado INTO DATA(lv_line).
          IF lv_line CS 'Linha 1: Teste de saída do relatório'.
            lv_found_line1 = abap_true.
          ENDIF.
          IF lv_line CS 'Linha 2: Conteúdo para validação'.
            lv_found_line2 = abap_true.
          ENDIF.
          IF lv_line CS 'Linha 3: Teste do método READ_LIST_FROM_MEMORY'.
            lv_found_line3 = abap_true.
          ENDIF.
          IF lv_line CS 'Linha 4: Dados para verificação'.
            lv_found_line4 = abap_true.
          ENDIF.
          IF lv_line CS 'Linha 5: Final do teste mock'.
            lv_found_line5 = abap_true.
          ENDIF.
          IF lv_line CS 'Teste com números: 12345'.
            lv_found_numeros = abap_true.
          ENDIF.
          IF lv_line CS 'Teste com caracteres especiais: @#$%'.
            lv_found_especiais = abap_true.
          ENDIF.
          IF lv_line CS 'Teste com espaços:     espaçamento'.
            lv_found_espacos = abap_true.
          ENDIF.
          IF lv_line CS 'Teste final do programa mock'.
            lv_found_final = abap_true.
          ENDIF.
        ENDLOOP.

        " Verificar se todas as linhas esperadas foram encontradas
        cl_abap_unit_assert=>assert_equals(
          act = lv_found_line1
          exp = abap_true
          msg = 'Linha 1 não foi encontrada na saída'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_found_line2
          exp = abap_true
          msg = 'Linha 2 não foi encontrada na saída'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_found_line3
          exp = abap_true
          msg = 'Linha 3 não foi encontrada na saída'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_found_line4
          exp = abap_true
          msg = 'Linha 4 não foi encontrada na saída'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_found_line5
          exp = abap_true
          msg = 'Linha 5 não foi encontrada na saída'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_found_numeros
          exp = abap_true
          msg = 'Linha com números não foi encontrada na saída'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_found_especiais
          exp = abap_true
          msg = 'Linha com caracteres especiais não foi encontrada na saída'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_found_espacos
          exp = abap_true
          msg = 'Linha com espaços não foi encontrada na saída'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_found_final
          exp = abap_true
          msg = 'Linha final não foi encontrada na saída'
        ).

      CATCH zcx_bc_report_utils INTO DATA(lx_exception).
        cl_abap_unit_assert=>fail(
          msg = |Exceção inesperada: { lx_exception->get_text( ) }|
        ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
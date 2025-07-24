*&---------------------------------------------------------------------*
*& Report ZR_BC_REPORT_UTILS_MOCK
*&---------------------------------------------------------------------*
*& Programa mock para teste da classe ZCL_BC_REPORT_UTILS
*& Gera saída na tela para testar o método READ_LIST_FROM_MEMORY
*&---------------------------------------------------------------------*
REPORT zr_bc_report_utils_mock.

START-OF-SELECTION.

  " Gerar conteúdo de teste na tela
  WRITE: / 'Linha 1: Teste de saída do relatório'.
  WRITE: / 'Linha 2: Conteúdo para validação'.
  WRITE: / 'Linha 3: Teste do método READ_LIST_FROM_MEMORY'.
  WRITE: / 'Linha 4: Dados para verificação'.
  WRITE: / 'Linha 5: Final do teste mock'.

  " Adicionar linha em branco
  WRITE: /.

  " Mais conteúdo de teste
  WRITE: / 'Teste com números: 12345'.
  WRITE: / 'Teste com caracteres especiais: @#$%'.
  WRITE: / 'Teste com espaços:     espaçamento    '.
  WRITE: / 'Teste final do programa mock'.